package com.example;

import java.nio.file.Files;
import java.nio.file.Path;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import io.modelcontextprotocol.server.McpServer;
import io.modelcontextprotocol.server.McpServerFeatures;
import io.modelcontextprotocol.server.McpSyncServer;
import io.modelcontextprotocol.server.transport.WebFluxSseServerTransportProvider;
import io.modelcontextprotocol.spec.McpSchema;
import io.modelcontextprotocol.spec.McpSchema.CallToolResult;
import io.modelcontextprotocol.spec.McpSchema.ServerCapabilities;
import io.modelcontextprotocol.spec.McpSchema.Tool;

/**
 * MCP server exposing a single synchronous tool – <code>query_sql_view</code> – that
 * (1) boots the SQL views contained in <b>/mnt/data/Views.sql</b>, (2) lets an LLM
 * list and query those views at run‑time, and (3) returns the result‑set as JSON.
 * <p>
 * Required environment variables:
 * <ul>
 *   <li><b>MSSQL_URL</b> &nbsp;– full JDBC URL, e.g. <code>jdbc:sqlserver://localhost:1433;databaseName=mydb</code></li>
 *   <li><b>MSSQL_USER</b> – database user</li>
 *   <li><b>MSSQL_PASSWORD</b> – database password</li>
 * </ul>
 */
public class SqlViewToolServer {

    private static final ObjectMapper MAPPER = new ObjectMapper();

    /** <view name> → example SELECT line (may be empty). */
    private static final Map<String, String> VIEWS = new LinkedHashMap<>();

    // ─────────────────────── static boot logic ───────────────────────────────
    static {
        try {
            // Load the whole Views.sql script
            Path sqlPath = Path.of("/mnt/data/Views.sql");
            String script = Files.readString(sqlPath);

            // Parse examples + view names (example line immediately precedes CREATE VIEW)
            Pattern p = Pattern.compile(
                    "(?m)^--\\s*Example:\\s*(.*?)\\R\\s*CREATE\\s+VIEW\\s+([\\w.]+)",
                    Pattern.CASE_INSENSITIVE);
            Matcher m = p.matcher(script);
            while (m.find()) {
                String example = m.group(1).trim();
                String view    = m.group(2).trim();
                VIEWS.put(view, example);
            }

            // Execute the script so the views actually exist
            try (Connection c = DriverManager.getConnection(
                    System.getenv("MSSQL_URL"),
                    System.getenv("MSSQL_USER"),
                    System.getenv("MSSQL_PASSWORD"));
                 Statement s = c.createStatement()) {

                // crude split on GO batch separators
                for (String batch : script.split("(?mi)^\\s*GO\\s*$")) {
                    if (!batch.isBlank()) {
                        s.execute(batch);
                    }
                }
            }
        } catch (Exception e) {
            throw new RuntimeException("Failed to load/execute Views.sql", e);
        }
    }
    // ─────────────────────────────────────────────────────────────────────────

    public McpSyncServer mcpSqliteServer(WebFluxSseServerTransportProvider transportProvider) {

        McpSyncServer server = McpServer.sync(transportProvider)
                .serverInfo("sql-view-server", "1.1.0")
                .capabilities(ServerCapabilities.builder()
                    .tools(true)
                    .logging()
                    .build())
                .tools(createQueryTool())
                .build();


                Runtime.getRuntime().addShutdownHook(new Thread(() -> {
                    System.err.println("Shutting down server...");
                    server.close();
                }));

        return server;
    }

    /**
     * Build the <code>query_sql_view</code> tool definition + handler.
     */
    private static McpServerFeatures.SyncToolSpecification createQueryTool() {

        // Build JSON Schema enum from discovered views
        StringBuilder enumArr = new StringBuilder("[ ");
        StringBuilder examplesTxt = new StringBuilder();
        Iterator<Map.Entry<String, String>> it = VIEWS.entrySet().iterator();
        while (it.hasNext()) {
            var e = it.next();
            enumArr.append('\"').append(e.getKey()).append('\"');
            if (it.hasNext()) enumArr.append(", ");
            if (!e.getValue().isBlank()) {
                examplesTxt.append("• ").append(e.getKey()).append(" → ")
                          .append(e.getValue()).append("\n");
            }
        }
        enumArr.append(" ]");

        String schema = """
                {
                  "type": "object",
                  "properties": {
                    "viewName": {
                      "type": "string",
                      "enum": %s,
                      "description": "One of the pre‑installed SQL views"
                    },
                    "filter": {
                      "type": "string",
                      "description": "Optional SQL predicate WITHOUT the word WHERE"
                    },
                    "limit": {
                      "type": "integer",
                      "description": "Max rows to return (TOP N)",
                      "default": 100
                    }
                  },
                  "required": ["viewName"]
                }
                """.formatted(enumArr);

        Tool toolDef = new Tool(
                "query_sql_view",
                """
                Query a SQL‑Server view and return the rows as JSON.
                Available views: 

                vw_course_min_grade – Minimum passing grade required for each course

                vw_major_concentrations – Lists every concentration offered within each major

                vw_major_completion – For each student, shows credit‑hours completed vs. required and hours remaining for the major

                vw_student_classes – Full class history (past + present) for every student, with grades

                vw_current_hours – Current‑term credit‑hour load per student

                vw_student_department – Maps students to the department that hosts their declared major

                vw_course_professors – All professors who have ever taught each course code

                vw_student_majors – One row per student–major link (supports double‑majors/minors)

                vw_remaining_major_courses – Required courses a student has not yet passed

                vw_department_enrollment_count – Head‑count of students currently enrolled in courses offered by each department

                vw_department_professors – Directory of professors in every department

                vw_major_semester_courses – Ideal semester‑by‑semester plan for every major

                vw_course_offerings – Each scheduled class section with term, capacity, seats remaining, meeting times

                vw_major_required_courses_count – Count of distinct courses required in each major

                vw_transferable_courses – Courses a student has completed that could satisfy remaining degree requirements but have not yet been applied

                vw_student_class_rooms – Physical room/building for each class a student is enrolled in

                vw_major_professors – Majors paired with all professors in the hosting department

                vw_required_gpa_calc – GPA calculated only over courses marked as “required” for a student’s major

                vw_student_current_class_schedule – Student’s active weekly schedule with day‑of‑week, start/end times, room and building

                
                %s
                """.formatted(examplesTxt.isEmpty() ? "(none)" : examplesTxt),
                schema);

        return new McpServerFeatures.SyncToolSpecification(toolDef, (exchange, args) -> {
            String view   = (String) args.get("viewName");
            String filter = (String) args.getOrDefault("filter", "");
            int    limit  = (int)    args.getOrDefault("limit", 100);

            if (!VIEWS.containsKey(view)) {
                return new CallToolResult(
                        List.of(new McpSchema.TextContent("Unknown or disallowed view: " + view)), true);
            }

            String sql = "SELECT TOP ? * FROM " + view + (filter.isBlank() ? "" : " WHERE " + filter);

            try (Connection c = DriverManager.getConnection(
                        System.getenv("MSSQL_URL"),
                        System.getenv("MSSQL_USER"),
                        System.getenv("MSSQL_PASSWORD"));
                 PreparedStatement ps = c.prepareStatement(sql)) {

                ps.setInt(1, limit);
                try (ResultSet rs = ps.executeQuery()) {
                    String json = MAPPER.writeValueAsString(toList(rs));
                    return new CallToolResult(
                            List.of(new McpSchema.TextContent(json)), false);
                }
            } catch (SQLException | JsonProcessingException e) {
                return new CallToolResult(
                        List.of(new McpSchema.TextContent("SQL error: " + e.getMessage())), true);
            }
        });
    }

    // ─────────────────────── helpers ─────────────────────────────────────────
    /** ResultSet ➜ List<Map<String,Object>> keeping column order. */
    private static List<Map<String, Object>> toList(ResultSet rs) throws SQLException {
        List<Map<String, Object>> out = new ArrayList<>();
        ResultSetMetaData md = rs.getMetaData();
        int cols = md.getColumnCount();
        while (rs.next()) {
            Map<String, Object> row = new LinkedHashMap<>();
            for (int i = 1; i <= cols; i++) {
                row.put(md.getColumnLabel(i), rs.getObject(i));
            }
            out.add(row);
        }
        return out;
    }
    // ─────────────────────────────────────────────────────────────────────────
}
