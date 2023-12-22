import pyrebase
import socket
import csv
from utils import *

# Define Firebase Configurations
config = {
    "apiKey": "AIzaSyAPCMW9BEND7-JAJRE-25QipGyGpNFevNE",
    "authDomain": "smarticu-c78aa.firebaseapp.com",
    "databaseURL": "https://smarticu-c78aa-default-rtdb.firebaseio.com",
    "projectId": "smarticu-c78aa",
    "storageBucket": "smarticu-c78aa.appspot.com",
    "messagingSenderId": "771972734729",
    "appId": "1:771972734729:web:a5b49783504a872d747dd8",
    "measurementId": "G-8RXVDS0ZHR"
}
firebase = pyrebase.initialize_app(config)


# Define TCP Configurations
SERVER_IP = '192.168.1.8'  
SERVER_PORT = 55000  

def upload_detection(detection):
    db = firebase.database()
    db.child("Arythmia").set(detection)

# Function to predict ECG from Firebase
def predict_from_firebase():
    print("Predicting ECG from Firebase...\n")
    # get ECG file from firebase
    storage = firebase.storage()
    path_on_cloud = "ecg_file.csv"
    path_local = "ECG_Detection\\ecg_files\\"
    ecg_path = "firebase_ecg.csv"
    ecg_path = path_local + ecg_path
    storage.child(path_on_cloud).download(path_local, ecg_path)
    prediction = predict(ecg_path)
    print("Prediction : ",end="")
    print(prediction)
    upload_detection(prediction)


# Function to predict ECG from ESP
def predict_from_esp():
    print("Predicting ECG from ESP...")
    # Create a socket
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    # Bind the socket to the server address and port
    server_socket.bind((SERVER_IP, SERVER_PORT))

    # Listen for incoming connections
    server_socket.listen(1)

    print("Waiting for incoming connections...")
    received_data = b''
    
    while True:
        # Accept a new connection
        client_socket, client_address = server_socket.accept()
        print("Connection established with:", client_address)
        # Receive data from the client
        data = client_socket.recv(1024).decode()
        received_data = b''
        while True:
            data = client_socket.recv(1024)
            if not data:
                break
            received_data += data
        reconstructed_string = received_data.decode()
        client_socket.close()
        break
    received_list = [value for value in reconstructed_string.split(',')]
    # print("Received list:", received_list)
    # Specify the filename
    path_local = "ECG_Detection\\ecg_files\\"
    ecg_path = 'TCP_ecg.csv'
    ecg_path = path_local + ecg_path
    # Write the list to a CSV file with a column header
    with open(ecg_path, mode='w', newline='') as file:
        writer = csv.writer(file)
        writer.writerow(['ECG'])  # Writing the column header
        for number in received_list:
            number = number.rstrip ("\n").rstrip ("\r")
            number= float(number)
            writer.writerow([number])  # Writing each number as a separate row in the 'ECG' column
    print("ECG Received")
    prediction = predict(ecg_path)
    print("Prediction : ",end="")
    print(prediction)
    upload_detection(prediction)

def predict_local_ECG():
    print("Predicting Local ECG File...\n")
    path_local = "ECG_Detection\\ecg_files\\"
    ecg_path = "ecg.csv"
    ecg_path = path_local + ecg_path
    prediction = predict(ecg_path)
    print("Prediction : ",end="")
    print(prediction)
    upload_detection(prediction)

# Function to display menu and handle user choices
def display_menu():
    while True:
        print("\nMenu:")
        print("1. Predict ECG from Firebase")
        print("2. Predict ECG from ESP")
        print("3. Predict Local ECG File")
        print("4. Close the program")

        choice = input("Enter your choice (1/2/3): ")

        if choice == '1':
            predict_from_firebase()
        elif choice == '2':
            predict_from_esp()
        elif choice == '3':
            predict_local_ECG()
        elif choice == '4':
            print("Closing the program...")
            break
        else:
            print("Invalid choice. Please enter 1, 2, 3, or 4.")


# Call the main function to display the menu
if __name__ == "__main__":
    display_menu()
