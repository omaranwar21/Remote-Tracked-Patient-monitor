import socket

def get_server_ip():
    try:
        # Create a socket to get the IP address
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.connect(("8.8.8.8", 80))  # Connecting to a known IP (Google's DNS) to get the local IP
        server_ip = s.getsockname()[0]
        s.close()
        return server_ip
    except Exception as e:
        print("Error occurred while getting server IP:", e)
        return None

# Get the server's IP address
server_ip = get_server_ip()
if server_ip:
    print("Server IP address:", server_ip)
else:
    print("Unable to retrieve server IP.")
