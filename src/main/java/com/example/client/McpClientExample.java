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
                runTestExamples(client);
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
                    String calculatorOutput;
                    if (result.isError()) {
                        calculatorOutput = ((TextContent) result.content().get(0)).text();
                        System.out.println("Error: " + calculatorOutput);
                    } else {
                        calculatorOutput = ((TextContent) result.content().get(0)).text();
                        System.out.println("Result: " + calculatorOutput);
                    }
                    
                    // Now pass the calculator result to the LLM for processing
                    System.out.println("\nSending to LLM for analysis...");
                    String promptToLLM;
                    
                    if (result.isError()) {
                        promptToLLM = String.format(
                            "I tried to perform a calculation using a calculator tool with the operation '%s' on operands %s and %s, " +
                            "but received the following error: %s\n\n" +
                            "Can you explain this error and suggest how to fix it?",
                            operation, a, b, calculatorOutput);
                    } else {
                        promptToLLM = String.format(
                            "I performed a calculation using a calculator tool with the operation '%s' on operands %s and %s. " +
                            "The calculator returned: %s\n\n" +
                            "Can you verify this result is correct and provide any additional insights or context about this calculation?",
                            operation, a, b, calculatorOutput);
                    }
                    
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
    
    /**
     * Run a set of test examples to demonstrate the integration.
     */
    private static void runTestExamples(McpSyncClient client) {
        System.out.println("\n=== Running Test Examples ===\n");
        
        // Test cases to run
        Object[][] testCases = {
            {"add", 25.0, 15.0, "Basic Addition"},
            {"divide", 10.0, 3.0, "Division with decimal result"},
            {"divide", 5.0, 0.0, "Division by zero error"},
            {"multiply", 1234.0, 5678.0, "Large numbers multiplication"},
            {"subtract", -15.0, 25.0, "Negative numbers subtraction"}
        };
        
        for (Object[] test : testCases) {
            String operation = (String) test[0];
            double a = (Double) test[1];
            double b = (Double) test[2];
            String description = (String) test[3];
            
            System.out.println("\nTest: " + description);
            System.out.println("Operation: " + operation + " " + a + " " + b);
            
            try {
                // Call the calculator tool
                CallToolRequest request = new CallToolRequest("calculator",
                        Map.of(
                            "operation", operation,
                            "a", a,
                            "b", b
                        ));

                CallToolResult result = client.callTool(request);
                
                // Process and display the result
                String calculatorOutput;
                boolean isError = result.isError();
                
                if (isError) {
                    calculatorOutput = ((TextContent) result.content().get(0)).text();
                    System.out.println("Calculator Error: " + calculatorOutput);
                } else {
                    calculatorOutput = ((TextContent) result.content().get(0)).text();
                    System.out.println("Calculator Result: " + calculatorOutput);
                }
                
                // Now pass the calculator result to the LLM for processing
                System.out.println("\nSending to LLM for analysis...");
                String promptToLLM;
                
                if (isError) {
                    promptToLLM = String.format(
                        "I tried to perform a calculation using a calculator tool with the operation '%s' on operands %s and %s, " +
                        "but received the following error: %s\n\n" +
                        "Can you explain this error and suggest how to fix it?",
                        operation, a, b, calculatorOutput);
                } else {
                    promptToLLM = String.format(
                        "I performed a calculation using a calculator tool with the operation '%s' on operands %s and %s. " +
                        "The calculator returned: %s\n\n" +
                        "Can you verify this result is correct and provide any additional insights or context about this calculation?",
                        operation, a, b, calculatorOutput);
                }
                
                // Call the MockLLM to process the result with Claude
                MockLLM.processInput(promptToLLM);
                
                System.out.println("\n----------------------------");
                
            } catch (Exception e) {
                System.out.println("Error in test calculation: " + e.getMessage());
                e.printStackTrace();
            }
        }
        
        System.out.println("\n=== Test Examples Completed ===");
    }
}