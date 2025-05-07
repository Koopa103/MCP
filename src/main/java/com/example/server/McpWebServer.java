
package com.example.server;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@EnableAutoConfiguration
public class McpWebServer {

	public static void main(String[] args) {
		SpringApplication.run(AppConfig.class, args);
	}

}
