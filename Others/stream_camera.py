import cv2
import numpy as np
import socket

# UDP_IP = "192.168.1.5"  # Replace with your ESP32Cam IP
UDP_IP = "172.20.10.7"  # Use your server's IP address here
# UDP_IP = "172.28.135.16"  # Use your server's IP address here

UDP_PORT = 55000  # Match the port used in the ESP32Cam code

sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
sock.bind((UDP_IP, UDP_PORT))

print("Server started, waiting for image data...")
image_Buffer = b''  # Initialize an empty byte string to store received data

def image_receive():
    global image_Buffer  # Declare image_Buffer as a global variable


    data, addr = sock.recvfrom(1460)  # Adjust the buffer size as per your needs
    # nparr = np.frombuffer(data, np.uint8)
    # print(f"Received message from {addr}: /n {data}")

    if data.startswith(b'\xff\xd8'):
        image_Buffer = b''

    image_Buffer +=data 
# b'\xff\xd8
    if data.endswith(b'\xff\xd9'):
        view_image(np.frombuffer(image_Buffer, dtype=np.uint8))
        # print("*"*60)


def view_image(image_Buffer):
    img = cv2.imdecode(image_Buffer, cv2.IMREAD_COLOR)
    # print("*"*60)
    
    cv2.imshow('Received Image', img)
    cv2.waitKey(1)
    # if cv2.waitKey(1) & 0xFF == ord('q'):
    #     break


while True:
    image_receive()


cv2.destroyAllWindows()
