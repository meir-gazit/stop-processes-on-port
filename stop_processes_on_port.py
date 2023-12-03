import subprocess

def stop_processes_on_port():
    # Prompt the user to enter the port number
    port = input("Enter the port number: ").strip()

    # Validate that the user entered a valid port number
    if port.isdigit():
        # Build and execute the command to find and kill processes on the specified port
        command = f"netstat -aon | findstr :{port}"
        result = subprocess.run(["cmd", "/c", command], capture_output=True, text=True)

        if result.returncode == 0:
            print(f"Processes using port {port} have been terminated.")
        else:
            print(f"No processes found using port {port}.")
    else:
        print("Invalid port number. Please enter a valid numeric port.")

    # Keep the console window open until user input
    input("Press Enter to exit.")

if __name__ == "__main__":
    stop_processes_on_port()
