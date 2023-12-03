import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class StopProcessesOnPort {

    public static void main(String[] args) {
        stopProcessesOnPort();
    }

    private static void stopProcessesOnPort() {
        try {
            // Prompt the user to enter the port number
            System.out.print("Enter the port number: ");
            BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
            String port = reader.readLine().trim();

            // Validate that the user entered a valid port number
            if (port.matches("\\d+")) {
                // Build and execute the command to find and kill processes on the specified port
                String command = "netstat -aon | findstr :" + port;
                ProcessBuilder processBuilder = new ProcessBuilder("cmd", "/c", command);
                Process process = processBuilder.start();
                int exitCode = process.waitFor();

                if (exitCode == 0) {
                    System.out.println("Processes using port " + port + " have been terminated.");
                } else {
                    System.out.println("No processes found using port " + port + ".");
                }
            } else {
                System.out.println("Invalid port number. Please enter a valid numeric port.");
            }

            // Keep the console window open until user input
            System.out.println("Press Enter to exit.");
            reader.readLine(); // Wait for Enter key

        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
        }
    }
}
