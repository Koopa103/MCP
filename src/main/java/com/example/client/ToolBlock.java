package com.example.client;

import java.util.List;

import com.anthropic.client.AnthropicClientAsync;
import com.anthropic.models.messages.ContentBlock;
import com.anthropic.models.messages.ContentBlockParam;
import com.anthropic.models.messages.Message;
import com.anthropic.models.messages.ToolResultBlockParam;
import com.anthropic.models.messages.ToolUseBlockParam;
import com.anthropic.models.messages.MessageCreateParams;

import com.anthropic.models.messages.ToolUseBlock;
import com.example.JsonSerializer;
import com.fasterxml.jackson.core.JsonProcessingException;

import io.modelcontextprotocol.client.McpClient;
import io.modelcontextprotocol.client.McpSyncClient;
import io.modelcontextprotocol.spec.McpSchema.CallToolRequest;
import io.modelcontextprotocol.spec.McpSchema.CallToolResult;
import io.modelcontextprotocol.spec.McpSchema.TextContent;

public class ToolBlock {

    private static final String DEFAULT_MODEL = "claude-3-7-sonnet-20250219";
    private static final long MAX_TOKENS = 8192;
    
    /**
     * Handle a tool use request from Claude
     */
    public static void handleToolUseBlock(ToolUseBlock toolUseBlock, String originalInput, Message response,MessageCreateParams.Builder createParams, McpSyncClient mcpClient, AnthropicClientAsync client) {
        String toolId = toolUseBlock.id();
        String toolName = toolUseBlock.name();
        String toolInput = toolUseBlock.toString();
        String jsonString = "";
        System.out.println("Tool: " + toolName);
        System.out.println("Input: " + toolInput);
        try {
            // Example usage
            jsonString = JsonSerializer.convertToolUseBlockToJson(toolUseBlock);
            System.out.println(jsonString);
            } catch (JsonProcessingException e) {
                e.printStackTrace();
            }

        
        try {
            // Execute the tool using MCP server
            if (mcpClient != null && !toolName.isEmpty()) {
                // Create tool request for MCP server
                CallToolRequest toolRequest = new CallToolRequest(toolName,jsonString);
                
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
                
                // Add the assistant response with tool use
                // createBuilder.addAssistantMessageOfBetaContentBlockParams(
                //     List.of(
                //         BetaContentBlockParam.ofToolUse(
                //             BetaToolUseBlockParam.builder()
                //             .id(toolUseBlock.name())
                //             .input(toolUseBlock._input())
                //             .name(toolUseBlock.name())
                //             .putAllAdditionalProperties(toolUseBlock._additionalProperties())
                //             .build())
                //         )
                //     );


                createParams.addMessage(response);

                createParams.addUserMessageOfBlockParams(List.of(
                        ContentBlockParam.ofToolResult(
                                ToolResultBlockParam.builder()
                                        .toolUseId(toolUseBlock.id())
                                        .content(resultText)
                                        .build()
                        )
                ));
                

            } else {
                System.out.println("Cannot execute tool: MCP client not initialized or unknown tool");
            }
        } catch (Exception e) {
            System.err.println("Error executing tool: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
}
