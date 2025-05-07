package com.example.server;
 
import java.util.List;
import java.util.Map;

import com.example.server.SqlViewToolServer;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import io.modelcontextprotocol.spec.McpSchema;
import io.modelcontextprotocol.spec.McpSchema.CallToolResult;
import io.modelcontextprotocol.spec.McpSchema.TextContent;
import io.modelcontextprotocol.server.McpServerFeatures;
import io.modelcontextprotocol.server.McpSyncServer;
import io.modelcontextprotocol.spec.McpSchema.ServerCapabilities;
import io.modelcontextprotocol.spec.McpSchema.Tool;
import io.modelcontextprotocol.spec.McpServerTransport;
import io.modelcontextprotocol.spec.McpServerTransportProvider;

import io.modelcontextprotocol.server.transport.WebFluxSseServerTransportProvider;
import io.modelcontextprotocol.server.McpServer;



public class McpServerExample {

    public McpSyncServer mcpServer(WebFluxSseServerTransportProvider transportProvider) {

        // Define input schema for calculator tool
        String schema = """
                {
                  "type": "object",
                  "properties": {
                    "operation": {
                      "type": "string",
                      "description": "The operation to perform (add, subtract, multiply, divide)"
                    },
                    "a": {
                      "type": "number",
                      "description": "First operand"
                    },
                    "b": {
                      "type": "number",
                      "description": "Second operand"
                    }
                  },
                  "required": ["operation", "a", "b"]
                }
                """;

        // Create a calculator tool specification
        var calculatorTool = new McpServerFeatures.SyncToolSpecification(
                new Tool("calculator", "Performs basic arithmetic operations", schema),
                (exchange, arguments) -> {
                    System.out.println("OK SO THIS HAPPENS:   \n" + arguments.toString());

                    ObjectMapper mapper = new ObjectMapper();
                    JsonNode argumentTree = mapper.valueToTree(arguments);


                    double a = argumentTree.path("input").path("a").asDouble();
                    double b = argumentTree.path("input").path("b").asDouble();

                    String operation = argumentTree.path("input").path("operation").asText();

                    double result;
                    System.out.println("we get to reeee");
                    switch (operation.toLowerCase()) {
                        case "add":
                            result = a + b;
                            System.out.println("RESULT:" + result);

                            break;
                        case "subtract":
                            result = a - b;
                            break;
                        case "multiply":
                            result = a * b;
                            break;
                        case "divide":
                            if (b == 0) {
                                return new CallToolResult(
                                        List.of(new TextContent("Division by zero error")), 
                                        true);
                            }
                            result = a / b;
                            break;
                        default:
                            return new CallToolResult(
                                    List.of(new TextContent("Unsupported operation: " + operation)), 
                                    true);
                    }

                    String response = String.format("Result of %s %s %s = %s", a, operation, b, result);
                    System.out.println(response);
                    return new CallToolResult(
                            List.of(new TextContent(response)), 
                            false);
                }
        );

        // Create and start the server


        McpSyncServer server = McpServer.sync(transportProvider)
        
                .serverInfo("SQL-COllege-Data", "1.8.0")
                .capabilities(ServerCapabilities.builder()
                  .resources(false, true)  // Resource support with list changes notifications
                  .tools(true)            // Tool support with list changes notifications
                  .prompts(true)
                  .logging()     // Prompt support with list changes notifications
                  .build())
                .build();

        server.addTool(SqlViewToolServer.getTool());
        server.notifyToolsListChanged();
        
        
        
        // Register the calculator tool
        System.out.println("SREVER CAN DO THIS!: "+ server.getServerInfo().toString());
        System.out.println("TOOLS CAN DO THIS!: "+ server.getServerCapabilities());


        // Send a log message
        // server.loggingNotification(McpSchema.LoggingMessageNotification.builder()
        //         .level(McpSchema.LoggingLevel.INFO)
        //         .logger("server")
        //         .data("Calculator server is ready")
        //         .build());

        System.err.println("Server started. Waiting for connections...");
        
        // The server will keep running until the client disconnects
        Runtime.getRuntime().addShutdownHook(new Thread(() -> {
            System.err.println("Shutting down server...");
            server.close();
        }));
        return server;

    }
}