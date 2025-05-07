package com.example.client;

import java.util.Map;
import java.util.Scanner;

import org.springframework.web.reactive.function.client.WebClient;

import io.modelcontextprotocol.client.McpClient;
import io.modelcontextprotocol.client.McpSyncClient;
import io.modelcontextprotocol.client.transport.WebFluxSseClientTransport;

import io.modelcontextprotocol.spec.McpClientTransport;
import io.modelcontextprotocol.spec.McpSchema;
import io.modelcontextprotocol.spec.McpSchema.CallToolRequest;
import io.modelcontextprotocol.spec.McpSchema.CallToolResult;
import io.modelcontextprotocol.spec.McpSchema.ClientCapabilities;
import io.modelcontextprotocol.spec.McpSchema.CreateMessageRequest;
import io.modelcontextprotocol.spec.McpSchema.CreateMessageResult;
import io.modelcontextprotocol.spec.McpSchema.TextContent;

public class McpClientExample {

    public String studentID;
    public static void main(String[] args) {



        try {
            // Initialize connection with the server
  
            // List available tools
            // System.out.println("Available tools:");
            // McpSchema.ListToolsResult toolsResult = client.listTools();
            // toolsResult.tools().forEach(tool -> {
            //     System.out.println("- " + tool.name() + ": " + tool.description());
            // });
            
            // Set up interactive session for calculator
            Scanner scanner = new Scanner(System.in);
            boolean running = true;
            
            System.out.println("\n=== Better Wildcat Central bot ===");

            System.out.println("What is your Student ID?: ");
            String studentID = scanner.nextLine().trim();

            
            while (running) {
                System.out.println("\nEnter a Advising Query or type `exit` to exit: ");
                String input = scanner.nextLine().trim();
                
                if (input.equalsIgnoreCase("exit")) {
                    running = false;
                    continue;
                }
                
                                
                try {                    
                    // Process and display the result
                    // Now pass the calculator result to the LLM for processing
                    String promptToLLM = String.format(input);
 
                    // Call the MockLLM to process the result with Claude
                    // Make sure the input contains a mathematical expression to trigger the calculator

                    MockLLM.processInput(promptToLLM, studentID);
                    
                
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
            
            System.out.println("Client disconnected.");
        }
    }
}