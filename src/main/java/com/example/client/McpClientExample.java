package com.example.client;


import java.util.Map;
import java.util.Scanner;

import org.springframework.web.reactive.function.client.WebClient;

import io.modelcontextprotocol.client.McpClient;
import io.modelcontextprotocol.client.McpSyncClient;
import io.modelcontextprotocol.client.transport.ServerParameters;
import io.modelcontextprotocol.client.transport.WebFluxSseClientTransport;
import io.modelcontextprotocol.spec.ClientMcpTransport;
import io.modelcontextprotocol.spec.McpClientTransport;
import io.modelcontextprotocol.spec.McpSchema;
import io.modelcontextprotocol.spec.McpSchema.CallToolRequest;
import io.modelcontextprotocol.spec.McpSchema.CallToolResult;
import io.modelcontextprotocol.spec.McpSchema.TextContent;
import io.modelcontextprotocol.spec.McpTransport;

public class McpClientExample {

    public static void main(String[] args) {
        // Path to the server JAR or main class
        //String serverPath = Paths.get("/home/austin/CodeBukkit/CS375/MCP/src/main/java/com/example/McpServerExample.java").toAbsolutePath().toString();
        
        // Create server parameters for launching the server process
        // ServerParameters params = ServerParameters.builder("mvn exec:java")
        //         .args("-Dexec.mainClass=\"com.example.McpServer\"")
        //         .build();
                
        // Create stdio transport for communicating with the server
        WebClient.Builder webClientBuilder = WebClient.builder()
                                        .baseUrl("http://localhost:8080/");
        McpClientTransport transport = new WebFluxSseClientTransport(webClientBuilder);

        // Create and initialize the client
        McpSyncClient client = McpClient.sync(transport).requestTimeout(java.time.Duration.ofSeconds(30)).build();
                
        try {
            // Initialize connection with the server
            System.out.println("Connecting to MCP server...");
            client.initialize();
            
            // List available tools
            System.out.println("Available tools:");
            McpSchema.ListToolsResult toolsResult = client.listTools();
            toolsResult.tools().forEach(tool -> {
                System.out.println("- " + tool.name() + ": " + tool.description());
            });
            
            // Set up interactive session for calculator
            Scanner scanner = new Scanner(System.in);
            boolean running = true;
            
            while (running) {
                System.out.println("\nEnter calculation (e.g., 'add 5 3') or 'exit' to quit:");
                String input = scanner.nextLine().trim();
                
                if (input.equalsIgnoreCase("exit")) {
                    running = false;
                    continue;
                }
                
                // Parse input
                String[] parts = input.split("\\s+");
                if (parts.length != 3) {
                    System.out.println("Invalid input. Format: <operation> <number> <number>");
                    continue;
                }
                
                try {
                    String operation = parts[0];
                    double a = Double.parseDouble(parts[1]);
                    double b = Double.parseDouble(parts[2]);
                    
                    // Call the calculator tool
                    CallToolRequest request = new CallToolRequest("calculator",
                            Map.of(
                                "operation", operation,
                                "a", a,
                                "b", b
                            ));

                    CallToolResult result = client.callTool(request);
                    
                    // Process and display the result
                    if (result.isError()) {
                        System.out.println("Error: " + ((TextContent) result.content().get(0)).text());
                    } else {
                        System.out.println("Result: " + ((TextContent) result.content().get(0)).text());
                    }
                    
                } catch (NumberFormatException e) {
                    System.out.println("Invalid numbers. Please enter valid numbers.");
                } catch (Exception e) {
                    System.out.println("Error: " + e.getMessage());
                }
            }
            
            scanner.close();
            
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
            e.printStackTrace();
        } finally {
            // Close the client connection
            client.closeGracefully();
            System.out.println("Client disconnected.");
        }
    }
}