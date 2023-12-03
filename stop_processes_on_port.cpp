#include <iostream>
#include <cstdlib>
#include <string>

void stopProcessesOnPort() {
    std::string port;

    // Prompt the user to enter the port number
    std::cout << "Enter the port number: ";
    std::getline(std::cin, port);

    // Validate that the user entered a valid port number
    bool isNumeric = true;
    for (char c : port) {
        if (!std::isdigit(c)) {
            isNumeric = false;
            break;
        }
    }

    if (!isNumeric) {
        std::cout << "Invalid port number. Please enter a valid numeric port." << std::endl;
    } else {
        // Build and execute the command to find and kill processes on the specified port
        std::string command = "netstat -aon | findstr :" + port;
        int result = std::system(command.c_str());

        if (result == 0) {
            std::cout << "Processes using port " << port << " have been terminated." << std::endl;
        } else {
            std::cout << "No processes found using port " << port << "." << std::endl;
        }
    }

    // Keep the console window open until user input
    std::cout << "Press Enter to exit." << std::endl;
    std::cin.ignore(); // Ignore any remaining characters in the input buffer
    std::cin.get();    // Wait for Enter key
}

int main() {
    stopProcessesOnPort();
    return 0;
}
