using System;

class StopProcesses
{
    static void Main()
    {
        Console.Write("Enter the port number: ");
        string port = Console.ReadLine().Trim();

        if (int.TryParse(port, out int portNumber))
        {
            System.Diagnostics.Process.Start("taskkill", $"/F /PID {portNumber}");
            Console.WriteLine($"Processes using port {port} have been terminated.");
        }
        else
        {
            Console.WriteLine("Invalid port number. Please enter a valid numeric port.");
        }

        Console.WriteLine("Press Enter to exit.");
        Console.ReadLine();
    }
}