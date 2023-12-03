# Prompt the user to enter the port
$port = Read-Host "Enter the port number"

# Validate that the user entered a valid port number
if ($port -match '^\d+$') {
    # Find processes using the specified port
    $processes = Get-NetTCPConnection -LocalPort $port -ErrorAction SilentlyContinue

    # Check if there are processes using the specified port
if ($processes) {
    # Iterate through each process using the specified port
    foreach ($process in $processes) {
        # Get the process ID
        $processId = $process.OwningProcess

        # Stop the process using the obtained process ID
        Stop-Process -Id $processId -Force

        # Display a message indicating that the process has been stopped
        Write-Host "Process with ID $processId using port $port has been stopped."
    }
} else {
    # Display a message if no processes are found using the specified port
    Write-Host "No processes found using port $port."
}

} else {
    Write-Host "Invalid port number. Please enter a valid numeric port."
}

# Keep the PowerShell window open until user input
Read-Host "Press Enter to exit"
