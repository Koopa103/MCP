package com.example;

import com.anthropic.client.AnthropicClient;
import com.anthropic.client.AnthropicClientAsync;
import com.anthropic.client.okhttp.AnthropicOkHttpClient;
import com.anthropic.client.okhttp.AnthropicOkHttpClientAsync;
import com.anthropic.models.messages.MessageCreateParams;
import com.anthropic.models.messages.Model;

/**
 * LLM integration using Anthropic's Claude API.
 */
public class MockLLM {
    private static final String DEFAULT_MODEL = "claude-3-7-sonnet-20250219";
    private static final long MAX_TOKENS = 1024;
    
    // AnthropicClient is thread-safe, so we can use a singleton
    private static final AnthropicClient client;
    
    static {
        // Initialize the client using API key from environment variable
        // You can also pass the API key directly: new AnthropicOkHttpClient("your-api-key")
                // Configures using the `ANTHROPIC_API_KEY` environment variable
        client = AnthropicOkHttpClient.fromEnv();
    }
    
    /**
     * Process input text using Anthropic's Claude API.
     * 
     * @param input The text input to process
     * @return The response from Claude
     */
    public static void processInput(String input) {
        try {
            // Configures using the `ANTHROPIC_API_KEY` environment variable
        AnthropicClientAsync client = AnthropicOkHttpClientAsync.fromEnv();

        MessageCreateParams createParams = MessageCreateParams.builder()
                .model(Model.CLAUDE_3_7_SONNET_LATEST)
                .maxTokens(2048)
                .addUserMessage(input)
                .build();

        client.messages()
                .create(createParams)
                .thenAccept(message -> message.content().stream()
                        .flatMap(contentBlock -> contentBlock.text().stream())
                        .forEach(textBlock -> System.out.println(textBlock.text())))
                .join();
    

            
            
        } catch (Exception e) {
            // Log the exception and return an error message
            System.err.println("Error calling Anthropic API: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    // /**
    //  * Process input with streaming response (useful for longer responses).
    //  * Note: This returns a complete response but uses streaming internally to avoid timeouts.
    //  */
    // public static String processInputWithStreaming(String input) {
    //     try {
    //         // Create the message parameters with streaming enabled
    //         MessageCreateParams params = MessageCreateParams.builder()
    //             .maxTokens(MAX_TOKENS)
    //             .model(DEFAULT_MODEL)
    //             .addUserMessage(input)
    //             .stream(true)
    //             .build();
            
    //         StringBuilder resultBuilder = new StringBuilder();
            
    //         // Send the streaming request to Anthropic's API
    //         client.messages().create(params).getContentStream().forEach(content -> {
    //             if (content.getText() != null) {
    //                 resultBuilder.append(content.getText());
    //             }
    //         });
            
    //         return resultBuilder.toString();
            
    //     } catch (Exception e) {
    //         System.err.println("Error calling Anthropic API with streaming: " + e.getMessage());
    //         e.printStackTrace();
    //         return "Error processing streaming request: " + e.getMessage();
    //     }
    // }
}