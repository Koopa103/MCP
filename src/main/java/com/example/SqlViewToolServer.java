package com.example;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import io.modelcontextprotocol.server.McpServerFeatures;
import io.modelcontextprotocol.spec.McpSchema.CallToolResult;
import io.modelcontextprotocol.spec.McpSchema.TextContent;
import io.modelcontextprotocol.spec.McpSchema.Tool;
import com.example.client.McpClientExample;

/**
 * MCP server that exposes <em>one dedicated tool per SQL view</em> backed by
 * an <b>embedded SQLite database</b> (via the {@code sqlite-jdbc} driver).
 * <p>
 * Every query tool returns <strong>all rows exactly as the view produces them</strong> –
 * no implicit limits and <em>no filter parameter</em>.
 */
public class SqlViewToolServer {

    private static final ObjectMapper MAPPER = new ObjectMapper();

    //────────────────────────── Paths & URLs ──────────────────────────
    /** Base directory that holds {@code Views.sql} and the {@code .db} files. */
    private static final Path MCP_DIR;
    /** JDBC URL for the SQLite file (can be overridden with {@code SQLITE_DB_URL}). */
    private static final String DB_URL;

    static {
        //  Locate external MCP folder
        String envDir = System.getenv("MCP_DIR");
        Path base = (envDir != null && !envDir.isBlank())
                ? Paths.get(envDir).toAbsolutePath().normalize()
                : Paths.get("..", "MCP").toAbsolutePath().normalize();
        MCP_DIR = base;

        //  Build DB URL (honour SQLITE_DB_URL if provided)
        String envDbUrl = System.getenv("SQLITE_DB_URL");
        DB_URL = (envDbUrl != null && !envDbUrl.isBlank())
                ? envDbUrl
                : "jdbc:sqlite:" + MCP_DIR.resolve("Database2.db");
    }

    //────────────────────────── Tool builders ─────────────────────────

    public static String removeQuotes(String input) {
        if (input == null || input.length() < 2) return input;
        
        // Option 1: Using substring
        if ((input.startsWith("\"") && input.endsWith("\"")) || 
            (input.startsWith("'") && input.endsWith("'"))) {
            return input.substring(1, input.length() - 1);
        }
        
        // Option 2: Handle unmatched quotes
        String result = input;
        if (result.startsWith("\"") || result.startsWith("'")) {
            result = result.substring(1);
        }
        if (result.endsWith("\"") || result.endsWith("'")) {
            result = result.substring(0, result.length() - 1);
        }
        
        return result;
    }
    
    private static McpServerFeatures.SyncToolSpecification createQueryToolForView() {
        String toolName = "Queryer";
        String description = ("""
                Queryer
Description
The Queryer is a SQL query tool that accesses academic database views containing information about students, courses, majors, professors, departments, and class schedules. It allows retrieval of specific academic information by querying predefined university database views.
Capabilities

Query detailed information about student academic records, course offerings, and curriculum requirements
Access information about course-major relationships and completion requirements
Retrieve data about professor assignments and department structures
View student enrollment information, schedules, and progress toward degree completion
Calculate academic metrics such as GPA and credit hour completion

When to Use

When you need specific academic information from the university database
To answer questions about student progress, course requirements, or departmental structure
When assisting with academic planning and course selection
To verify course prerequisites, major requirements, or schedule conflicts
When checking room assignments, professor information, or enrollment capacities

When Not to Use

For modifying any data in the database (this is a read-only tool)
To access student personal information beyond academic records
For retrieving historical data not contained in the defined views
When the request falls outside the scope of the available views
To make predictions about future course offerings not already in the system

Parameters
You're paramater is query. This is a SQL query to search the views. The query should be a valid SQL statement that can be executed against the database views.

Available Views

course_min_grade: Minimum passing grade required for each course. Table schema course_min_grade(course_id,course_name,minimum_required_grade).
major_concentrations: Every concentration offered within each major. Table schema major_concentrations(major_id,major_name,concentration_name).
major_completion: Credit-hours completed vs. required (and remaining) for every student's major. Table schema major_completion(student_id,major_id,major_name,hours_completed,hours_required,hours_remaining)
student_classes: Past & present classes for every student, with grades. Table schema student_classes(student_id,section_crn,course_id,course_name,term,days,room,grade).
current_hours: Current-term credit-hour load per student. Table schema current_hours(student_id,current_hours).
student_department: Department that hosts each student's declared major. Table schema student_department(student_id,department_id,department_name).
course_professors: All professors who have ever taught each course code. Table schema course_professors(course_id,course_name,professor_id,firstname,lastname).
student_majors: One row per student/major link (supports double-majors/minors). Table schema student_majors(student_id,major_id,major_name).
remaining_major_courses: Courses a student still needs to pass for the major. Table schema remaining_major_courses(student_id,major_id,course_id,course_name).
department_enrollment_count: Head-count of students currently enrolled in courses of each department. department_enrollment_count(department_id,department_name,enrolled_students).
department_professors: Directory of professors in every department. department_professors(department_id,department_name,professor_id,firstname,lastname,adjunct).
major_semester_courses: Ideal semester-by-semester plan for every major. Table schema major_semester_courses(major_id,course_id,course_name,hrs).
course_offerings: Scheduled class sections with term, capacity, seats remaining, meeting times. Table schema course_offerings(course_id,course_name,section_crn,term,days,room,startdate,enddate).
major_required_courses_count: Count of distinct courses required in each major. Table schema major_required_courses_count(major_id,major_name,required_course_count,required_hours).
transferable_courses: Courses completed that could satisfy remaining degree requirements but have not yet been applied. Table schema transferable_courses(student_id,potential_major,course_id,course_name).
student_class_rooms: Physical room/building for each class a student is enrolled in. Table schema student_class_rooms(student_id,course_id,course_name,room).
major_professors: Majors paired with all professors in the hosting department. Table schema major_professors(major_id,professor_id,firstname,lastname).
required_gpa_calc: GPA calculated only over courses marked as required for the student's major. Table schema required_gpa_calc(student_id,major_id,required_major_gpa).
student_current_class_schedule: Student's active weekly schedule with day-of-week, start/end times, room and building. Table schema student_current_class_schedule(student_id,course_id,course_name,days,room,term,startdate,enddate).

Response Format
You are allowed to query the views, but limit your query to the views only. The response will be in CSV format, with the first row containing the column names and subsequent rows containing the data. Each value will be separated by a comma, and any commas within values will be escaped with double quotes. The response will be a string representation of the CSV data.
                """);


        String schema = """
        {
            "type": "object",
            "properties": {
                "operation": {
                    "type": "string",
                    "description": "The operation to queue the SQL server views for specific data to answer user questions."
                },
                "view": {
                    "type": "string",
                    "description": "An SQL query to searth the views"
                }
            },
            "required": ["view"]
        }
        """;



        // Tool takes no parameters at all
        Tool tool = new Tool(toolName, description, schema);
        return new McpServerFeatures.SyncToolSpecification(tool, (exchange, args) -> {
            System.out.println("Tool initialized");
            JsonNode argumentTree = MAPPER.valueToTree(args);
            System.out.println("Argument retrieved");
            String viewName = argumentTree.path("input").path("view").toString();
            System.out.println("OK SO THIS HAPPENS:   \n" + viewName);
            System.out.println(DB_URL);
            String sql = removeQuotes(viewName);
            System.out.println("SQL: " + sql);

            try (Connection c = DriverManager.getConnection(DB_URL);
                 Statement  st = c.createStatement();
                 ResultSet  rs = st.executeQuery(sql)) {
                String csv = resultSetToCsv(rs);
                return new CallToolResult(List.of(new TextContent(csv)), false);
            } catch (SQLException e) {
                return new CallToolResult(List.of(new TextContent("SQL error: " + e.getMessage())), true);
            }
        });
    }


   //────────────────────────── Helpers ────────────────────────────────
    /**
     * Converts a {@link ResultSet} to a CSV string (header row + data rows).
     */
    private static String resultSetToCsv(ResultSet rs) throws SQLException {
        StringBuilder sb = new StringBuilder();
        ResultSetMetaData md = rs.getMetaData();
        int cols = md.getColumnCount();

        // Header row
        for (int i = 1; i <= cols; i++) {
            if (i > 1) sb.append(',');
            sb.append(md.getColumnName(i));
        }
        sb.append('\n');

        // Data rows
        while (rs.next()) {
            for (int i = 1; i <= cols; i++) {
                if (i > 1) sb.append(',');
                Object val = rs.getObject(i);
                if (val != null) {
                    String s = val.toString();
                    // Escape commas, quotes, and newlines per RFC 4180
                    boolean needsQuotes = s.contains(",") || s.contains("\"") || s.contains("\n");
                    if (needsQuotes) {
                        s = s.replace("\"", "\"\"");
                        sb.append('"').append(s).append('"');
                    } else {
                        sb.append(s);
                    }
                }
            }
            sb.append('\n');
        }
        return sb.toString();
    }

    static McpServerFeatures.SyncToolSpecification getTool() {
        return createQueryToolForView();
    }
}