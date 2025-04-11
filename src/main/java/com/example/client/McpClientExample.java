package com.example.client;

import java.util.Map;
import java.util.Scanner;

import org.springframework.web.reactive.function.client.WebClient;

import com.example.MockLLM;

import io.modelcontextprotocol.client.McpClient;
import io.modelcontextprotocol.client.McpSyncClient;
import io.modelcontextprotocol.client.transport.WebFluxSseClientTransport;
import io.modelcontextprotocol.spec.McpClientTransport;
import io.modelcontextprotocol.spec.McpSchema;
import io.modelcontextprotocol.spec.McpSchema.CallToolRequest;
import io.modelcontextprotocol.spec.McpSchema.CallToolResult;
import io.modelcontextprotocol.spec.McpSchema.TextContent;

public class McpClientExample {

    public static void main(String[] args) {
        // Create WebClient for communicating with the server
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
            
            System.out.println("\n=== MCP Calculator with LLM Analysis ===");
            System.out.println("1. Run test examples");
            System.out.println("2. Interactive mode");
            System.out.print("Choose an option (1-2) or any other key for interactive mode: ");
            
            String choice = scanner.nextLine().trim();
            
            if (choice.equals("1")) {
               // runTestExamples(client);
            } else {
                // Continue with interactive mode
                System.out.println("\nEntering interactive mode...");
            }
            
            while (running) {
                System.out.println("\nEnter calculation (e.g., 'add 5 3') or 'exit' to quit:");
                String input = scanner.nextLine().trim();
                
                if (input.equalsIgnoreCase("exit")) {
                    running = false;
                    continue;
                }
                
                                
                try {                    
                    // Process and display the result
                    // Now pass the calculator result to the LLM for processing
                    System.out.println("\nSending to LLM for analysis...");
                    String promptToLLM;
                    
                     promptToLLM = String.format(input);
 
                    
                    // Call the MockLLM to process the result with Claude
                    MockLLM.processInput(promptToLLM);
                    
                } catch (NumberFormatException e) {
                    System.out.println("Invalid numbers. Please enter valid numbers.");
                } catch (Exception e) {
                    System.out.println("Error: " + e.getMessage());
                    e.printStackTrace();
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