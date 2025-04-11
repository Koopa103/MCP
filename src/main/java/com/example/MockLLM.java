package com.example;

import com.anthropic.client.AnthropicClientAsync;
import com.anthropic.client.okhttp.AnthropicOkHttpClientAsync;
import com.anthropic.models.messages.Message;
import com.anthropic.models.messages.MessageCreateParams;
import com.anthropic.models.messages.Tool;
import com.anthropic.models.messages.ToolUnion;
import com.anthropic.models.messages.ToolUseBlock;

import io.modelcontextprotocol.client.McpClient;
import io.modelcontextprotocol.client.McpSyncClient;
import io.modelcontextprotocol.client.transport.WebFluxSseClientTransport;
import io.modelcontextprotocol.spec.McpClientTransport;
import io.modelcontextprotocol.spec.McpSchema;
import io.modelcontextprotocol.spec.McpSchema.CallToolRequest;
import io.modelcontextprotocol.spec.McpSchema.CallToolResult;
import io.modelcontextprotocol.spec.McpSchema.ListToolsResult;
import io.modelcontextprotocol.spec.McpSchema.TextContent;

import org.springframework.web.reactive.function.client.WebClient;

import java.util.List;
import java.util.Map;
import java.util.concurrent.CompletableFuture;
import java.util.stream.Collectors;

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
    public static void processInput(String input, List<ToolUnion> tools) {

        try {
            MessageCreateParams createParams = MessageCreateParams.builder()
                    .model(DEFAULT_MODEL)
                    .maxTokens(MAX_TOKENS)
                    .addUserMessage(input)
                    .tools(tools)
                    .build();

            
           Message response = client.messages().create(createParams).get();



            if (response.stopReason().equals("tool_use")) {
                // Extract tool use blocks from the response
                List<ToolUseBlock> toolUseBlocks = response.content()
                    .filter(block -> block instanceof ToolUseBlock)
                    .map(block -> (ToolUseBlock) block)
                    .collect(Collectors.toList());
                
                // Process each tool use request
                for (ToolUseBlock toolUseBlock : toolUseBlocks) {
                    String toolId = toolUseBlock.getId();
                    String toolName = toolUseBlock.getName();
                    Map<String, Object> toolInput = toolUseBlock.getInput();
                    
                    // Execute the actual tool functionality here based on toolName
                    // For example, if toolName is "get_weather", call your weather API
                    Object toolResult = executeYourTool(toolName, toolInput);
                    
                    // Return the tool results to Claude
                    MessageCreateParams continueParams = MessageCreateParams.builder()
                        .model("claude-3-7-sonnet-20250219")
                        .maxTokens(1000)
                        .messages(
                            // Include previous messages
                            response.getMessages()
                            // Add new user message with tool result
                            .add(MessageCreateParams.Message.builder()
                                .role("user")
                                .content(List.of(
                                    MessageCreateParams.ContentBlock.toolResult(
                                        ToolResultBlock.builder()
                                            .toolCallId(toolId)
                                            .content(toolResult) // Your tool result here
                                            .build()
                                    )
                                ))
                                .build()
                            )
                        )
                        .build();
                    
                    // Continue the conversation with tool results
                    response = client.messages().create(continueParams);
                }
            }
        
        } catch (Exception e) {
            System.err.println("Error calling Anthropic API: " + e.getMessage());
            e.printStackTrace();
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