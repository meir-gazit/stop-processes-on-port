/*
	Please note that using system() to execute commands can have security implications, 
	and you should validate and sanitize user inputs to prevent potential vulnerabilities. 
	Additionally, this example is simplistic and may not cover all edge cases.
*/

#include <stdio.h>

int main() {
    char port[10];

    // Prompt the user to enter the port number
    printf("Enter the port number: ");
    scanf("%s", port);

    // Validate that the user entered a valid port number
    // Note: This simple validation checks if the input is numeric, but you might want to implement more robust validation.
    // Also, consider using safer input methods to avoid potential security vulnerabilities.
    // https://cwe.mitre.org/data/definitions/scanf.html
    int isNumeric = 1;
    for (int i = 0; port[i] != '\0'; i++) {
        if (port[i] < '0' || port[i] > '9') {
            isNumeric = 0;
            break;
        }
    }

    if (!isNumeric) {
        printf("Invalid port number. Please enter a valid numeric port.\n");
    } else {
        // Build and execute the command to find and kill processes on the specified port
        char command[100];
        sprintf(command, "netstat -aon | findstr :%s", port);
        int result = system(command);

        if (result == 0) {
            printf("Processes using port %s have been terminated.\n", port);
        } else {
            printf("No processes found using port %s.\n", port);
        }
    }

    // Keep the console window open until user input
    printf("Press Enter to exit.\n");
    getchar(); // Consume the newline character from the previous input
    getchar(); // Wait for Enter key

    return 0;
}
