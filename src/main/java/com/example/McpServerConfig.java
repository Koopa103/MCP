package com.example;


import com.fasterxml.jackson.databind.ObjectMapper;
import io.modelcontextprotocol.server.transport.HttpServletSseServerTransportProvider;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;



@Configuration
@EnableWebMvc
public class McpServerConfig implements WebMvcConfigurer {
    
    @Bean
    public HttpServletSseServerTransportProvider servletSseServerTransportProvider() {
        return new HttpServletSseServerTransportProvider(new ObjectMapper(), "/mcp/message");
    }
    
    @Bean
    public ServletRegistrationBean customServletBean(HttpServletSseServerTransportProvider transportProvider) {
        return new ServletRegistrationBean(transportProvider);
    }
}