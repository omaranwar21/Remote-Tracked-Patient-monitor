import usocket as socket
import network

# Function to connect to Wi-Fi network
def connect_to_wifi(ssid, password):
    wlan = network.WLAN(network.STA_IF)  # Station mode interface
    wlan.active(True)

    if not wlan.isconnected():
        print('Connecting to WiFi...')
        wlan.connect(ssid, password)

        while not wlan.isconnected():
            pass

    print('WiFi connected!')
    print('IP address:', wlan.ifconfig()[0])

# Replace these values with your Wi-Fi credentials
WIFI_SSID = "Omar Saad's Laptop"
WIFI_PASSWORD = "omar54321"

# Connect to Wi-Fi
connect_to_wifi(WIFI_SSID, WIFI_PASSWORD)

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

