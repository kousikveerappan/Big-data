import socket
import time

# Create a TCP/IP socket
server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# Bind the socket to the port
server_address = ('localhost', 9999)
server_socket.bind(server_address)

# Listen for incoming connections
server_socket.listen(5)

print(f"Listening on {server_address}")

# Send some data
while True:
    # Wait for a connection
    connection, client_address = server_socket.accept()
    
    try:
        print(f"Connection from {client_address}")
        
        # Send data in chunks
        data = "hello world from socket streaming example hello world from socket streaming example "
        connection.sendall(data.encode())
        
        time.sleep(2)  # Simulate some delay
        
    finally:
        # Clean up the connection
        connection.close()
