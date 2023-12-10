#include <WiFi.h>
#include <WiFiClient.h>
#include <WiFiServer.h>

// const char* ssid = "DESKTOP-BT2885B 4771";
// const char* password = "omar54321";

const char* ssid = "STUDBME2";
const char* password = "BME2Stud";


// const char* server_ip = "192.168.1.5";
// const char* server_ip = "172.20.10.7";
const char* server_ip = "172.28.135.16";
const int server_port = 55000;  // Match the port on the server


WiFiClient client;

void setup() {
  Serial.begin(115200);
  connectToWiFi();
}

void loop() {
  float pot1Value = analogRead(32) / 4095.0 * 3.3; // Read value from potentiometer connected to pin A0
  float pot2Value = analogRead(35) / 4095.0 * 3.3; // Read value from potentiometer connected to pin A1
  float pot3Value = analogRead(34) / 4095.0 * 3.3; // Read value from potentiometer connected to pin A2

  if (!client.connected()) {
    connectToServer();
  }

  String data = "Reading 1: " + String(pot1Value, 3) + "\n Reading 2: " + String(pot2Value, 3) + "\n Reading 3: " + String(pot3Value, 3);
  client.println(data);
  Serial.println(data);

  delay(1000); // Adjust delay as needed
}

void connectToWiFi() {
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Connecting to WiFi...");
  }
  Serial.println("Connected to WiFi");
}

void connectToServer() {
  while (!client.connect(server_ip, server_port)) {
    Serial.println("Connection to server failed. Retrying...");
    delay(1000);
  }
  Serial.println("Connected to server");
}
