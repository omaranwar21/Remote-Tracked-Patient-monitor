import socket


# HOST = "192.168.1.5"  # Use your server's IP address here
HOST = "172.20.10.7"  # Use your server's IP address here
# HOST = "172.28.135.16"  # Use your server's IP address here

PORT = 55000     # Choose an available port

def start_server():
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.bind((HOST, PORT))
        s.listen()

        print(f"Server listening on port {PORT}")

        conn, addr = s.accept()
        with conn:
            print(f"Connected by {addr}")

            while True:
                data = conn.recv(1024)
                if not data:
                    break
                received_data = data.decode('utf-8')
                print(f"Received data: {received_data}")

if __name__ == "__main__":
    start_server()
