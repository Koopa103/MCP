package com.example.client;

import com.anthropic.client.AnthropicClientAsync;
import com.anthropic.client.okhttp.AnthropicOkHttpClientAsync;
import com.anthropic.core.JsonField;
import com.anthropic.core.JsonValue;
import com.anthropic.models.messages.ContentBlock;
import com.anthropic.models.messages.Message;
import com.anthropic.models.messages.MessageCreateParams;
import com.anthropic.models.messages.StopReason;
import com.anthropic.models.messages.Tool.InputSchema;
import com.anthropic.models.messages.ToolResultBlockParam.Content;
import com.anthropic.models.messages.TextBlock;
import com.anthropic.models.messages.Tool;
import com.anthropic.models.messages.ToolChoice;
import com.anthropic.models.messages.ToolResultBlockParam;
import com.anthropic.models.messages.ToolUnion;
import com.anthropic.models.messages.ToolUseBlock;
import com.anthropic.models.messages.ToolUseBlockParam;

import com.anthropic.models.beta.messages.*;

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
import com.fasterxml.jackson.core.JsonProcessingException;

import org.springframework.web.reactive.function.client.WebClient;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.CompletableFuture;

/**
 * LLM integration using Anthropic's Claude API with MCP server integration.
 */
public class MockLLM {
    private static final String DEFAULT_MODEL = "claude-3-7-sonnet-20250219";
    private static final long MAX_TOKENS = 2000L;
    
    // AnthropicClient is thread-safe, so we can use a singleton
    private static AnthropicClientAsync client;
    private static McpSyncClient mcpClient;

    static {

        // Initialize the client using API key from environment variable
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
           // System.out.println("Connecting to MCP server...");
            mcpClient.initialize();
            
            // List available tools
            //System.out.println("Available MCP tools:");
            // McpSchema.ListToolsResult toolsResult = mcpClient.listTools();
            // toolsResult.tools().forEach(tool -> {
            //     System.out.println("- " + tool.name() + ": " + tool.description());
            // });
            
            // Register shutdown hook to close the client connection
            Runtime.getRuntime().addShutdownHook(new Thread(() -> {
                mcpClient.closeGracefully();
               // System.out.println("MCP Client disconnected.");
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
    public static void processInput(String input, String studentID) {


        String apiKey = System.getenv("ANTHROPIC_API_KEY");
        if (apiKey == null || apiKey.isEmpty()) {
            System.err.println("ERROR: ANTHROPIC_API_KEY environment variable is not set");
            System.exit(1);
        }

        client = AnthropicOkHttpClientAsync.builder().apiKey(apiKey).build();
        
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
                
                //System.out.println("Configured " + tools.size() + " tools for LLM");
            } catch (Exception e) {
                System.err.println("Error getting tools from MCP server: " + e.getMessage());
            }
        }
        
        processWithTools(input, tools, studentID);
    }
    
    /**
     * Process input with the configured tools
     */
    private static void processWithTools(String input, List<ToolUnion> tools, String studentID) {
        try {
            
            MessageCreateParams.Builder createParams = MessageCreateParams.builder()
                    .model(DEFAULT_MODEL)
                    .maxTokens(MAX_TOKENS)
                    .system("You are a College Student Advising Assistant" +
                           "When given a question, you have access to a tool containing a collection of SQLite views that describe different advising options." +
                           "The ID of the sudent you're helping is: " + studentID)
                    .addUserMessage(input)
                    .tools(tools);
            
            
            // Print initial response
            boolean hasToolUse = false;

            Message response = client.messages().create(createParams.build()).join();
            
           // System.out.println(response);
            // Check all content blocks
            for (ContentBlock block : response.content()) {
                if (block.isToolUse()) {
                    hasToolUse = true;

                    ToolBlock.handleToolUseBlock(block.asToolUse(), input, response,createParams,mcpClient,client);
                } else if (block.isText()) {
                    // Print text content
                    block.text().stream().forEach(textBlock -> System.out.println(textBlock.text()));
                } else {
                    System.out.println("Unknown content type: " + block);
                }
            }
            

                            // Continue the conversation with tool results
            Message finalResponse = client.messages().create(createParams.build()).get();
            finalResponse.content().stream()
            .flatMap(contentBlock -> contentBlock.text().stream())
            .forEach(textBlock -> System.out.println(textBlock.text()));
                
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