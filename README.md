# Remote-Tracked-Patient-monitor

## Overview
The Remote-Tracked-Patient-monitor System is a comprehensive IoT project designed to monitor and manage real-time patient data within an ICU environment. 

## Parts and Functionalities

### Part 1: Mobile App (Flutter)
- **Functionality:** Real-time plotting of medical device data, connection to ESP32 via Firebase, and remote control of medical devices.
- **Features:**
  - Display real-time sensor data from medical devices (e.g., ECG, heart rate, temperature, SPO2).
  - Establish a Firebase connection to interact with ESP32 for data transmission.
  - View the ECG Prediction whether the user has Arrhythmia or not.
  - Enable users to control medical devices remotely, such as opening/closing lights.

### Part 2: Firebase Integration
- **Functionality:** Acts as a bridge between the mobile app and medical devices, controls relay for lighting through ESP32, and provides Authentication and Access Control.
- **Features:**
  - Manages data flow between the mobile app and medical devices securely.
  - Implements Authentication and Access Control to restrict system access.
  - Controls the relay system connected to ESP32 to manage lighting conditions based on app commands.

### Part 3: ESP32 Modules
- **Functionality:** Interfaces with medical devices, updates real-time analog data to Firebase, controls lights based on Firebase conditions, sends real-time ECG data, and streams video through TCP.
- **Features:**
  - Connects with various medical devices to gather real-time analog data and updates Firebase.
  - Controls lighting conditions based on Firebase conditions received from Part 2.
  - Streams real-time ECG data and video directly to the mobile app via TCP.

### Part 4: Local Server for ECG Analysis
- **Functionality:** Analyzes ECG signals, predicts arrhythmia, retrieves signals from Firebase or ESP32 via TCP, and uploads predictions to Firebase.
- **Features:**
  - Fetches ECG signals for analysis from Firebase or ESP32 via TCP.
  - Utilizes prediction models to detect arrhythmia in real time.
  - Uploads predictions regarding arrhythmia detection to Firebase.


## Technologies Used

### Part 1: Mobile App (Flutter)
- **Framework:** Flutter
- **Languages:** Dart
- **Database Integration:** Firebase

### Part 2: Firebase Integration
- **Platform:** Firebase
- **Features:** Real-time Database, Authentication

### Part 3: ESP32 Modules
- **Hardware:** ESP32 microcontroller & ESP32-Cam
- **Languages:** C & Micropython
- **Protocols:** Firebase API, TCP & UDP

### Part 4: Local Server for ECG Analysis
- **Technologies:** Python, Machine Learning Libraries
- **Signal Processing:** Deep Learning Models, Digital Signal Processing (DSP) Techniques


## Project Structure
  
```
Remote-Tracked-Patient-monitor
├─  Flutter Mobile App
├─  Hardware
│  ├─  Camera
│  ├─  ESP32 Medical Devices
│  └─  ESP32 ECG Send
├─  Model Training
│  ├─  ArrhythmiaModel.ipynb
│  ├─  Data
│     ├─ ecg_dataset.csv
│     └─ ecg_test.csv
├─  Locl Server
│  ├─  detection.py
│  ├─  trained_model.pkl
│  └─   ecg_files
README.md
```