@echo off
set /p port=Enter the port number:

:: Validate that the user entered a valid port number
echo %port% | findstr /R "^[0-9]*$" >nul
if errorlevel 1 (
    echo Invalid port number. Please enter a valid numeric port.
) else (
    :: Find processes using the specified port
    for /f "tokens=2" %%i in ('netstat -aon ^| findstr /R ":%port%"') do (
        set "processId=%%i"
        :: Terminate the process using the obtained process ID
        taskkill /F /PID %processId%
        echo Process with ID %processId% using port %port% has been terminated.
    )

    if not defined processId (
        echo No processes found using port %port%.
    )
)

:: Keep the Command Prompt window open until user input
pause
