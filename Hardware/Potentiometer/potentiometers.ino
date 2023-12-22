#include <Arduino.h>
#include <WiFi.h>
#include <WiFiUdp.h>
#include <FirebaseESP32.h>

#include <addons/TokenHelper.h>
#include <addons/RTDBHelper.h>

#define RX_BUFFER_SIZE 16384
#define TX_BUFFER_SIZE 16384

#define RELAY_PIN 23 // ESP32 pin GPIO16 connected to the IN pin of relay


/* WiFi credentials Definition*/
const char *ssid = "Omar Saad's Laptop";
const char *password = "omar54321";

/* API Key Definition */
#define API_KEY "AIzaSyBedb_YI8cEEahX0ymhF5ojcmhIGMwAP5k"

/* RTDB URL Definition */
#define DATABASE_URL "https://smarticu-c78aa-default-rtdb.firebaseio.com/"

/* Email and password that alreadey registerd or added in the project Definition*/
#define USER_EMAIL "nnnn@gmail.com"
#define USER_PASSWORD "55555555"

// Define Firebase Data object
FirebaseData fbdo;
FirebaseAuth auth;
FirebaseConfig config;



void setup()
{
    pinMode(RELAY_PIN, OUTPUT);
    digitalWrite(RELAY_PIN, true);

    Serial.begin(115200);

    WiFi.begin(ssid, password);
    Serial.print("Connecting to Wi-Fi");

    WiFi.begin(ssid, password);

    while (WiFi.status() != WL_CONNECTED)
    {
        delay(1000);
        Serial.println(WiFi.status());
        Serial.println("Connecting to WiFi...");
    }

    // Serial.println();
    // Serial.print("Connected with IP: ");
    // Serial.println(WiFi.localIP());
    // Serial.println();

    // Serial.printf("Firebase Client v%s\n\n", FIREBASE_CLIENT_VERSION);

    /* Assign the api key (required) */
    config.api_key = API_KEY;
    /* Assign the user sign in credentials */
    auth.user.email = USER_EMAIL;
    auth.user.password = USER_PASSWORD;
    /* Assign the RTDB URL (required) */
    config.database_url = DATABASE_URL;
    /* Assign the callback function for the long running token generation task */
    config.token_status_callback = tokenStatusCallback; // see addons/TokenHelper.h


    fbdo.setBSSLBufferSize(RX_BUFFER_SIZE /* Rx buffer size in bytes from 512 - 16384 */, TX_BUFFER_SIZE /* Tx buffer size in bytes from 512 - 16384 */);
    Firebase.begin(&config, &auth);
    Firebase.reconnectNetwork(true);
}

void loop()
{
    if (Firebase.ready())
    {
        // sendDataPrevMillis = millis();

        float temperature = analogRead(32); // Read value from potentiometer connected to pin A0  (35 - 40)
        float rate = analogRead(35);        // Read value from potentiometer connected to pin A1 (50-110)
        float spo2 = analogRead(34);        // Read value from potentiometer connected to pin A2  (90 - 100)

        float Temperature = map(temperature, 0, 4095, 35, 40); // Map the value to the desired range
        float Rate = map(rate, 0, 4095, 50, 110);              // Map the value to the desired range
        float Spo2 = map(spo2, 0, 4095, 90, 100);              // Map the value to the desired range

        bool bVal;

        Firebase.setInt(fbdo, F("/RealData/Temperature"), (int)Temperature);
        Firebase.setInt(fbdo, F("/RealData/Rate"), (int)Rate);
        Firebase.setInt(fbdo, F("/RealData/spo2"), (int)Spo2);

        Firebase.getBool(fbdo, F("/RealData/control"), &bVal);

        // Serial.println(bVal);
        digitalWrite(RELAY_PIN, bVal);

    }
}