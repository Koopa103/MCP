package com.example;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.Scanner;

/**
 * A basic example of an MCP-like client in Java.
 */
public class McpClient {

    private static final String HOST = "localhost";
    private static final int PORT = 5555;

    public static void main(String[] args) {
        try (
                Socket socket = new Socket(HOST, PORT);
                BufferedReader in = new BufferedReader(new InputStreamReader(socket.getInputStream()));
                PrintWriter out = new PrintWriter(socket.getOutputStream(), true)
        ) {
            // Print the server's greeting
            String serverGreeting = in.readLine();
            System.out.println("[Client] Server says: " + serverGreeting);

            // Simple command loop
            Scanner scanner = new Scanner(System.in);
            String userInput;
            while (true) {
                System.out.print("[Client] Enter text: ");
                userInput = scanner.nextLine();

                // Send it to the server
                out.println(userInput);

                // Break if user wants to quit
                if ("quit".equalsIgnoreCase(userInput)) {
                    System.out.println("[Client] Quitting...");
                    break;
                }

                // Read server's response
                String response = in.readLine();
                System.out.println("[Client] Response: " + response);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
