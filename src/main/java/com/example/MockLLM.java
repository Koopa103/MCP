package com.example;

import com.anthropic.client.AnthropicClientAsync;
import com.anthropic.client.okhttp.AnthropicOkHttpClientAsync;
import com.anthropic.models.messages.MessageCreateParams;

import io.modelcontextprotocol.client.McpClient;
import io.modelcontextprotocol.client.McpSyncClient;
import io.modelcontextprotocol.client.transport.WebFluxSseClientTransport;
import io.modelcontextprotocol.spec.McpClientTransport;
import io.modelcontextprotocol.spec.McpSchema;
import io.modelcontextprotocol.spec.McpSchema.CallToolRequest;
import io.modelcontextprotocol.spec.McpSchema.CallToolResult;
import io.modelcontextprotocol.spec.McpSchema.TextContent;

import org.springframework.web.reactive.function.client.WebClient;

import java.util.Map;
import java.util.concurrent.CompletableFuture;

/**
 * LLM integration using Anthropic's Claude API with MCP server integration.
 */
public class MockLLM {
    private static final String DEFAULT_MODEL = "claude-3-7-sonnet-20250219";
    private static final long MAX_TOKENS = 1024;
    
    // AnthropicClient is thread-safe, so we can use a singleton
    private static final AnthropicClientAsync client;
    private static McpSyncClient mcpClient;

    static {
        String apiKey = System.getenv("ANTHROPIC_API_KEY");
        if (apiKey == null || apiKey.isEmpty()) {
            System.err.println("ERROR: ANTHROPIC_API_KEY environment variable is not set");
            System.exit(1);
        }
        // Initialize the client using API key from environment variable
        client = AnthropicOkHttpClientAsync.builder()
                .apiKey(apiKey)
                .build();
                
        // Initialize MCP client connection
        initializeMcpClient();
    }
    
    /**
     * Initialize the MCP client connection to the server
     */
    private static void initializeMcpClient() {
        try {
            WebClient.Builder webClientBuilder = WebClient.builder()
                    .baseUrl("http://localhost:8080/");
            McpClientTransport transport = new WebFluxSseClientTransport(webClientBuilder);
            
            mcpClient = McpClient.sync(transport)
                    .requestTimeout(java.time.Duration.ofSeconds(30))
                    .build();
                    
            // Initialize connection with the server
            System.out.println("Connecting to MCP server...");
            mcpClient.initialize();
            
            // List available tools
            System.out.println("Available MCP tools:");
            McpSchema.ListToolsResult toolsResult = mcpClient.listTools();
            toolsResult.tools().forEach(tool -> {
                System.out.println("- " + tool.name() + ": " + tool.description());
            });
            
            // Register shutdown hook to close the client connection
            Runtime.getRuntime().addShutdownHook(new Thread(() -> {
                mcpClient.closeGracefully();
                System.out.println("MCP Client disconnected.");
            }));
        } catch (Exception e) {
            System.err.println("Error initializing MCP client: " + e.getMessage());
            e.printStackTrace();
            mcpClient = null;  // Set to null to indicate initialization failure
        }
    }
    
    /**
     * Process input text using Anthropic's Claude API.
     * 
     * @param input The text input to process
     */
    public static void processInput(String input) {
        try {
            MessageCreateParams createParams = MessageCreateParams.builder()
                    .model(DEFAULT_MODEL)
                    .maxTokens(MAX_TOKENS)
                    .addUserMessage(input)
                    .build();

            client.messages()
                    .create(createParams)
                    .thenAccept(message -> message.content().stream()
                            .flatMap(contentBlock -> contentBlock.text().stream())
                            .forEach(textBlock -> System.out.println(textBlock.text())))
                    .join();
        } catch (Exception e) {
            System.err.println("Error calling Anthropic API: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    /**
     * Process calculator operation first through MCP server and then send result to LLM.
     * 
     * @param operation The mathematical operation (add, subtract, multiply, divide)
     * @param a First operand
     * @param b Second operand
     * @return CompletableFuture that will be completed when LLM processing is done
     */
    public static CompletableFuture<Void> processCalculation(String operation, double a, double b) {
        if (mcpClient == null) {
            System.err.println("MCP client not initialized. Cannot perform calculation.");
            return CompletableFuture.completedFuture(null);
        }
        
        try {
            // Call the calculator tool through MCP
            CallToolRequest request = new CallToolRequest("calculator",
                    Map.of(
                        "operation", operation,
                        "a", a,
                        "b", b
                    ));

            CallToolResult result = mcpClient.callTool(request);
            
            // Process and display the calculator result
            String calculatorOutput;
            if (result.isError()) {
                calculatorOutput = "Calculator Error: " + ((TextContent) result.content().get(0)).text();
                System.out.println(calculatorOutput);
                return CompletableFuture.completedFuture(null);
            } else {
                calculatorOutput = ((TextContent) result.content().get(0)).text();
                System.out.println("Calculator Result: " + calculatorOutput);
            }
            
            // Now pass the calculator result to the LLM for processing
            String promptToLLM = "I performed a calculation using a calculator tool and got the following result: " + 
                                calculatorOutput + 
                                "\n\nCan you interpret this result and provide any additional insights or context?";
            
            MessageCreateParams createParams = MessageCreateParams.builder()
                    .model(DEFAULT_MODEL)
                    .maxTokens(MAX_TOKENS)
                    .addUserMessage(promptToLLM)
                    .build();

            return client.messages()
                    .create(createParams)
                    .thenAccept(message -> {
                        System.out.println("\n--- LLM Analysis of Calculation ---");
                        message.content().stream()
                               .flatMap(contentBlock -> contentBlock.text().stream())
                               .forEach(textBlock -> System.out.println(textBlock.text()));
                    });
            
        } catch (Exception e) {
            System.err.println("Error processing calculation: " + e.getMessage());
            e.printStackTrace();
            return CompletableFuture.completedFuture(null);
        }
    }
    
    /**
     * Closes the MCP client connection.
     */
    public static void shutdown() {
        if (mcpClient != null) {
            mcpClient.closeGracefully();
            System.out.println("MCP Client disconnected.");
        }
    }
}