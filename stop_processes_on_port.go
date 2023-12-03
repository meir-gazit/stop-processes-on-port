package main

import (
	"bufio"
	"fmt"
	"os"
	"os/exec"
	"regexp"
	"strings"
)

func main() {
	stopProcessesOnPort()
}

func stopProcessesOnPort() {
	// Prompt the user to enter the port number
	fmt.Print("Enter the port number: ")
	reader := bufio.NewReader(os.Stdin)
	port, _ := reader.ReadString('\n')
	port = strings.TrimSpace(port)

	// Validate that the user entered a valid port number
	if isValidPort(port) {
		// Build and execute the command to find and kill processes on the specified port
		command := fmt.Sprintf("netstat -aon | findstr :%s", port)
		cmd := exec.Command("cmd", "/C", command)
		cmd.Stdout = os.Stdout
		cmd.Stderr = os.Stderr
		err := cmd.Run()

		if err == nil {
			fmt.Printf("Processes using port %s have been terminated.\n", port)
		} else {
			fmt.Printf("No processes found using port %s.\n", port)
		}
	} else {
		fmt.Println("Invalid port number. Please enter a valid numeric port.")
	}

	// Keep the console window open until user input
	fmt.Print("Press Enter to exit.")
	reader.ReadString('\n')
}

func isValidPort(port string) bool {
	// Validate that the user entered a valid port number (numeric)
	match, _ := regexp.MatchString("^[0-9]+$", port)
	return match
}
