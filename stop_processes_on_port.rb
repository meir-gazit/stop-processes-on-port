print "Enter the port number: "
port = gets.chomp

if port.match?(/^\d+$/)
  system("kill -9 $(lsof -t -i:#{port})")
  puts "Processes using port #{port} have been terminated."
else
  puts "Invalid port number. Please enter a valid numeric port."
end

print "Press Enter to exit"
gets
