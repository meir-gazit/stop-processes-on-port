#!/bin/bash

# Prompt the user to enter the port
read -p "Enter the port number: " port

# Validate that the user entered a valid port number
if [[ "$port" =~ ^[0-9]+$ ]]; then
    # Find processes using the specified port
    processes=$(lsof -t -i :$port)

    if [ -n "$processes" ]; then
        # Iterate through each process using the specified port
        for processId in $processes; do
            # Terminate the process using the obtained process ID
            kill -9 $processId
            echo "Process with ID $processId using port $port has been terminated."
        done
    else
        echo "No processes found using port $port."
    fi
else
    echo "Invalid port number. Please enter a valid numeric port."
fi

# Keep the terminal open until user input
read -p "Press Enter to exit"
