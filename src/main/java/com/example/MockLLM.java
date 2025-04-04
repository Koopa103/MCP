package com.example;

import com.anthropic.client.AnthropicClient;
import com.anthropic.client.okhttp.AnthropicOkHttpClient;
import com.anthropic.models.messages.Message;
import com.anthropic.models.messages.MessageCreateParams;
import com.anthropic.models.messages.Model;

/**
 * LLM integration using Anthropic's Claude API.
 */
public class MockLLM {
    private static final Model DEFAULT_MODEL = Model.CLAUDE_3_7_SONNET_LATEST;
    private static final long MAX_TOKENS = 1024;
    
    // AnthropicClient is thread-safe, so we can use a singleton
    private static final AnthropicClient client;
    
    static {
        // Initialize the client using API key from environment variable
        // You can also pass the API key directly: new AnthropicOkHttpClient("your-api-key")
        client = AnthropicOkHttpClient.fromEnv();
    }
    
    /**
     * Process input text using Anthropic's Claude API.
     * 
     * @param input The text input to process
     * @return The response from Claude
     */
    public static String processInput(String input) {
        try {
            // Create the message parameters
            MessageCreateParams params = MessageCreateParams.builder()
                .maxTokens(MAX_TOKENS)
                .model(DEFAULT_MODEL)
                .addUserMessage(input)
                .build();
            
            // Send the request to Anthropic's API
            Message response = client.messages().create(params);
            
            // Return the text content from the response
            return response.getContent().get(0).getText();
            
        } catch (Exception e) {
            // Log the exception and return an error message
            System.err.println("Error calling Anthropic API: " + e.getMessage());
            e.printStackTrace();
            return "Error processing request: " + e.getMessage();
        }
    }
    
    /**
     * Process input with streaming response (useful for longer responses).
     * Note: This returns a complete response but uses streaming internally to avoid timeouts.
     */
    public static String processInputWithStreaming(String input) {
        try {
            // Create the message parameters with streaming enabled
            MessageCreateParams params = MessageCreateParams.builder()
                .maxTokens(MAX_TOKENS)
                .model(DEFAULT_MODEL)
                .addUserMessage(input)
                .stream(true)
                .build();
            
            StringBuilder resultBuilder = new StringBuilder();
            
            // Send the streaming request to Anthropic's API
            client.messages().create(params).getContentStream().forEach(content -> {
                if (content.getText() != null) {
                    resultBuilder.append(content.getText());
                }
            });
            
            return resultBuilder.toString();
            
        } catch (Exception e) {
            System.err.println("Error calling Anthropic API with streaming: " + e.getMessage());
            e.printStackTrace();
            return "Error processing streaming request: " + e.getMessage();
        }
    }
}