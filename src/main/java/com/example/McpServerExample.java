package com.example;
 

import java.util.List;

import com.fasterxml.jackson.databind.ObjectMapper;

import io.modelcontextprotocol.spec.McpSchema;
import io.modelcontextprotocol.spec.McpSchema.CallToolResult;
import io.modelcontextprotocol.spec.McpSchema.TextContent;
import io.modelcontextprotocol.server.McpServerFeatures;
import io.modelcontextprotocol.server.McpSyncServer;
import io.modelcontextprotocol.spec.McpSchema.ServerCapabilities;
import io.modelcontextprotocol.server.transport.StdioServerTransportProvider;
import io.modelcontextprotocol.spec.McpSchema.Tool;
import io.modelcontextprotocol.server.McpServer;


public class McpServerExample {

    public static void main(String[] args) {
        // Create a transport provider using stdio
        StdioServerTransportProvider transportProvider = new StdioServerTransportProvider(new ObjectMapper());

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
                    String operation = (String) arguments.get("operation");
                    double a = ((Number) arguments.get("a")).doubleValue();
                    double b = ((Number) arguments.get("b")).doubleValue();
                    
                    double result;
                    switch (operation.toLowerCase()) {
                        case "add":
                            result = a + b;
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
                    return new CallToolResult(
                            List.of(new TextContent(response)), 
                            false);
                }
        );

        // Create and start the server
        McpSyncServer server = McpServer.sync(transportProvider)
                .serverInfo("calculator-server", "1.0.0")
                .capabilities(ServerCapabilities.builder()
                        .tools(true)  // Enable tool support with list changes notification
                        .logging()    // Enable logging support
                        .build())
                .build();

        // Register the calculator tool
        server.addTool(calculatorTool);

        // Send a log message
        server.loggingNotification(McpSchema.LoggingMessageNotification.builder()
                .level(McpSchema.LoggingLevel.INFO)
                .logger("server")
                .data("Calculator server is ready")
                .build());

        System.err.println("Server started. Waiting for connections...");
        
        // The server will keep running until the client disconnects
        Runtime.getRuntime().addShutdownHook(new Thread(() -> {
            System.err.println("Shutting down server...");
            server.close();
        }));
    }
}