package com.example;

import com.anthropic.client.AnthropicClientAsync;
import com.anthropic.client.okhttp.AnthropicOkHttpClientAsync;
import com.anthropic.core.JsonField;
import com.anthropic.core.JsonValue;
import com.anthropic.models.messages.ContentBlock;
import com.anthropic.models.messages.Message;
import com.anthropic.models.messages.MessageCreateParams;
import com.anthropic.models.messages.Tool.InputSchema;
import com.anthropic.models.messages.TextBlock;
import com.anthropic.models.messages.Tool;
import com.anthropic.models.messages.ToolChoice;
import com.anthropic.models.messages.ToolUnion;
import com.anthropic.models.messages.ToolUseBlock;
import com.anthropic.models.messages.ToolUseBlockParam;

import io.modelcontextprotocol.client.McpClient;
import io.modelcontextprotocol.client.McpSyncClient;
import io.modelcontextprotocol.client.transport.WebFluxSseClientTransport;
import io.modelcontextprotocol.spec.McpClientTransport;
import io.modelcontextprotocol.spec.McpSchema;
import io.modelcontextprotocol.spec.McpSchema.CallToolRequest;
import io.modelcontextprotocol.spec.McpSchema.CallToolResult;
import io.modelcontextprotocol.spec.McpSchema.ListToolsResult;
import io.modelcontextprotocol.spec.McpSchema.TextContent;
import com.example.JsonSerializer;

import org.springframework.web.reactive.function.client.WebClient;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
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
        // Create tools for calculator
        List<ToolUnion> tools = new ArrayList<>();
        
        // Create calculator tool from MCP server
        if (mcpClient != null) {
            try {
                // Get tool schemas from MCP server
                McpSchema.ListToolsResult toolsResult = mcpClient.listTools();
                
                // Convert MCP tools to Anthropic tools
                toolsResult.tools().forEach(mcpTool -> {
                    Tool tool = Tool.builder()
                            .name(mcpTool.name())
                            .description(mcpTool.description())
                            .inputSchema(InputSchema.builder().properties(JsonValue.from(mcpTool.inputSchema().properties())).build())
                            .build();
                    tools.add(ToolUnion.ofTool(tool));
                });
                
                System.out.println("Configured " + tools.size() + " tools for LLM");
            } catch (Exception e) {
                System.err.println("Error getting tools from MCP server: " + e.getMessage());
            }
        }


        
        processWithTools(input, tools);
    }
    
    /**
     * Process input with the configured tools
     */
    private static void processWithTools(String input, List<ToolUnion> tools) {
        try {
            System.out.println("Sending request to Claude with " + tools.size() + " tools...");
            
            MessageCreateParams createParams = MessageCreateParams.builder()
                    .model(DEFAULT_MODEL)
                    .maxTokens(MAX_TOKENS)
                    .system("You are a calculator assistant that helps with math operations. " +
                           "When given a mathematical expression, use the calculator tool to solve it.")
                    .addUserMessage(input)
                    .tools(tools)
                    .build();
            
            Message response = client.messages().create(createParams).get();
            
            // Print initial response
            boolean hasToolUse = false;
            
            // Check all content blocks
            for (ContentBlock block : response.content()) {
                if (block.isToolUse()) {
                    hasToolUse = true;
                    System.out.println("\nClaude wants to use a tool:");
                    handleToolUseBlock(block.asToolUse(), input, response);
                } else if (block.isText()) {
                    // Print text content
                    System.out.println((block).text());
                } else {
                    System.out.println("Unknown content type: " + block);
                }
            }
            
            if (!hasToolUse) {
                System.out.println("Claude provided a response without using tools.");
            }
            
        } catch (Exception e) {
            System.err.println("Error calling Anthropic API: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    /**
     * Handle a tool use request from Claude
     */
    private static void handleToolUseBlock(ToolUseBlock toolUseBlock, String originalInput, Message response) {
        String toolId = toolUseBlock.id();
        String toolName = toolUseBlock.name();
        String toolInput = toolUseBlock.toString();
        
        System.out.println("Tool: " + toolName);
        System.out.println("Input: " + toolInput);
        
        try {
            // Execute the tool using MCP server
            if (mcpClient != null && !toolName.isEmpty()) {
                // Create tool request for MCP server
                CallToolRequest toolRequest = new CallToolRequest(toolName,JsonSerializer.convertToolUseBlockToJson(toolUseBlock));
                
                // Call the tool on the MCP server
                System.out.println("Calling MCP tool: " + toolName);
                CallToolResult toolResult = mcpClient.callTool(toolRequest);
                
                // Extract result text
                String resultText = "No result";
                if (!toolResult.content().isEmpty() && toolResult.content().get(0) instanceof TextContent) {
                    resultText = ((TextContent) toolResult.content().get(0)).text();
                }
                
                System.out.println("Tool result: " + resultText);
                
                // Continue the conversation with the tool result
                

                MessageCreateParams.Builder createBuilder = MessageCreateParams.builder();
                createBuilder.model(DEFAULT_MODEL).maxTokens(MAX_TOKENS);
                
                // Add the original user message
                createBuilder.addMessage(
                    Message.builder()
                    .addContent(
                        ContentBlock.ofText(
                            TextBlock.builder().text(
                                originalInput
                                ).build()))
                                .build()
                                );


                createBuilder.addMessage(
                    Message.builder()
                    .addContent(
                        ContentBlock.ofText(
                            TextBlock.builder().text(
                                originalInput
                                ).build()))
                                .build()
                                );

                // Add the tool result message

                createBuilder.addMessage(
                    Message.builder()
                    .addContent(
                        ContentBlock.ofText(
                            TextBlock.builder().text(
                                resultText
                                ).build()))
                                .build()
                                );


                // Add the assistant response with tool use
                createBuilder.addMessage(response);
                
                
                
                // Create the follow-up request
                MessageCreateParams  continueParams = createBuilder.build();

                
                // Continue the conversation with tool results
                Message finalResponse = client.messages().create(continueParams).get();
                
                // Print final response from Claude
                System.out.println("\nClaude's response after tool use:");
                for (ContentBlock block : finalResponse.content()) {
                    if (block.isText()) {
                        System.out.println(block.text());
                    } else {
                        System.out.println(block);
                    }
                }
            } else {
                System.out.println("Cannot execute tool: MCP client not initialized or unknown tool");
            }
        } catch (Exception e) {
            System.err.println("Error executing tool: " + e.getMessage());
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