package com.example;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.ServerSocket;
import java.net.Socket;

/**
 * A basic example of an MCP-like server in Java.
 */
public class McpServer {

    private ServerSocket serverSocket;
    private boolean running;

    // Define a simple port to listen on
    private static final int PORT = 5555;

    public McpServer() {
        try {
            this.serverSocket = new ServerSocket(PORT);
            this.running = true;
            System.out.println("[Server] Listening on port " + PORT);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void startServer() {
        while (running) {
            try {
                // Accept incoming connections
                Socket clientSocket = serverSocket.accept();
                System.out.println("[Server] Client connected: " + clientSocket.getInetAddress());

                // Create a new thread for each client
                new Thread(() -> handleClient(clientSocket)).start();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    private void handleClient(Socket clientSocket) {
        try (
                BufferedReader in = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
                PrintWriter out = new PrintWriter(clientSocket.getOutputStream(), true)
        ) {
            // A simple greeting (MCP typically would do protocol negotiation)
            out.println("MCP 2.1 Hello-Server");

            // Listen for client messages
            String line;
            while ((line = in.readLine()) != null) {
                System.out.println("[Server] Received from client: " + line);

                if (line.equalsIgnoreCase("quit")) {
                    out.println("Goodbye!");
                    break;
                }

                // Integrate with a mock LLM
                String response = MockLLM.processInput(line);
                out.println(response);
            }

            clientSocket.close();
            System.out.println("[Server] Client disconnected.");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        McpServer server = new McpServer();
        server.startServer();
    }
}
