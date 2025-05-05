package com.example;


import io.modelcontextprotocol.server.transport.WebFluxSseServerTransportProvider;
import io.modelcontextprotocol.spec.McpServerTransportProvider;
import io.modelcontextprotocol.server.McpSyncServer;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.reactive.config.EnableWebFlux;
import org.springframework.web.reactive.function.server.RouterFunction;

import com.fasterxml.jackson.databind.ObjectMapper;



@Configuration
@EnableWebFlux
@ComponentScan("com.example")
public class AppConfig {

    @Bean
    WebFluxSseServerTransportProvider webFluxSseServerTransportProvider(ObjectMapper mapper) {
        return new WebFluxSseServerTransportProvider(mapper, "/mcp/message","/sse");
    }
	// Router function for SSE transport used by Spring WebFlux to start an HTTP
	// server.
	@Bean
    RouterFunction<?> mcpRouterFunction(WebFluxSseServerTransportProvider transportProvider) {
        System.out.println("Got routeing function bean");
        return transportProvider.getRouterFunction();
    }

	@Bean
	public McpSyncServer mcpServerThing(WebFluxSseServerTransportProvider transportProvider) {

		// Configure server capabilities with resource support

		// Create the server with both tool and resource capabilities
		
		var server = new McpServerExample().mcpServer(transportProvider);
		System.out.println("----- i hate you bro --- ");

		System.out.println(server.getServerInfo());
		
		return server;
	} 
	
}
