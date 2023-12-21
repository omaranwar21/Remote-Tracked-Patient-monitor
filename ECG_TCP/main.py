# csv_data = []

# with open ("ecg_simulated.csv", "r") as file:
#   # print("File Opened")
#   for line in file:
#     # print(line)
#     line = line.rstrip ("\n").rstrip ("\r")
#     csv_data.append (float(line))
#     # print("*"*50)
#     print(len(csv_data))

# print(csv_data)


# 

import usocket as socket

# Replace these values with your server's IP address and port
SERVER_IP = '192.168.1.8'  # Replace with your server's IP
SERVER_PORT = 55000  # Replace with your server's port

# Sample list to send
data_to_send = [1, 2, 3, 4, 5]

# Create a TCP socket
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# Connect to the server
server_address = (SERVER_IP, SERVER_PORT)
sock.connect(server_address)

# Convert the list to a string to send over the network
data_str = ','.join(map(str, data_to_send))

# Send the data
sock.sendall(data_str.encode())

# Close the socket after sending the data
sock.close()
