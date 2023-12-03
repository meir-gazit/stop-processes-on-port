use std::io::{self, Write};
use std::process::{Command, exit};

fn main() {
    stop_processes_on_port();
}

fn stop_processes_on_port() {
    // Prompt the user to enter the port number
    print!("Enter the port number: ");
    io::stdout().flush().unwrap();
    
    let mut port = String::new();
    io::stdin().read_line(&mut port).expect("Failed to read line");
    let port = port.trim();

    // Validate that the user entered a valid port number
    if is_valid_port(port) {
        // Build and execute the command to find and kill processes on the specified port
        let command = format!("netstat -aon | findstr :{}", port);
        let status = Command::new("cmd")
            .args(&["/C", &command])
            .status();

        match status {
            Ok(exit_status) if exit_status.success() => {
                println!("Processes using port {} have been terminated.", port);
            }
            _ => {
                println!("No processes found using port {}.", port);
            }
        }
    } else {
        println!("Invalid port number. Please enter a valid numeric port.");
    }

    // Keep the console window open until user input
    print!("Press Enter to exit.");
    io::stdout().flush().unwrap();
    io::stdin().read_line(&mut String::new()).expect("Failed to read line");
}

fn is_valid_port(port: &str) -> bool {
    // Validate that the user entered a valid port number (numeric)
    port.chars().all(char::is_numeric)
}
