#include "esp_camera.h"
#include <WiFi.h>
#include <WiFiUdp.h>

#define CHUNK_LENGTH 1460

#define PWDN_GPIO_NUM 32
#define RESET_GPIO_NUM -1
#define XCLK_GPIO_NUM 0
#define SIOD_GPIO_NUM 26
#define SIOC_GPIO_NUM 27
#define Y9_GPIO_NUM 35
#define Y8_GPIO_NUM 34
#define Y7_GPIO_NUM 39
#define Y6_GPIO_NUM 36
#define Y5_GPIO_NUM 21
#define Y4_GPIO_NUM 19
#define Y3_GPIO_NUM 18
#define Y2_GPIO_NUM 5
#define VSYNC_GPIO_NUM 25
#define HREF_GPIO_NUM 23
#define PCLK_GPIO_NUM 22

// const char* ssid = "STUDBME2";
// const char* password = "BME2Stud";
const char* ssid = "DESKTOP-BT2885B 4771";
const char* password = "omar54321";

// const char* udpAddress = "192.168.1.5";
// const char* udpAddress = "172.20.10.7";
// const char* udpAddress = "172.28.133.188";
// const char* udpAddress = "172.28.135.16";
const char* udpAddress = "172.20.10.7";
const int udpPort = 55000;  // Match the port on the server
// const int udpPort = 8080;  // Match the port on the server

// boolean connected = false;
WiFiUDP udp;

void setup() {

  Serial.begin(115200);

  camera_config_t config;
  config.ledc_channel = LEDC_CHANNEL_0;
  config.ledc_timer = LEDC_TIMER_0;
  config.pin_d0 = Y2_GPIO_NUM;
  config.pin_d1 = Y3_GPIO_NUM;
  config.pin_d2 = Y4_GPIO_NUM;
  config.pin_d3 = Y5_GPIO_NUM;
  config.pin_d4 = Y6_GPIO_NUM;
  config.pin_d5 = Y7_GPIO_NUM;
  config.pin_d6 = Y8_GPIO_NUM;
  config.pin_d7 = Y9_GPIO_NUM;
  config.pin_xclk = XCLK_GPIO_NUM;
  config.pin_pclk = PCLK_GPIO_NUM;
  config.pin_vsync = VSYNC_GPIO_NUM;
  config.pin_href = HREF_GPIO_NUM;
  config.pin_sscb_sda = SIOD_GPIO_NUM;
  config.pin_sscb_scl = SIOC_GPIO_NUM;
  config.pin_pwdn = PWDN_GPIO_NUM;
  config.pin_reset = RESET_GPIO_NUM;
  config.xclk_freq_hz = 20000000;
  config.pixel_format = PIXFORMAT_JPEG;
  config.frame_size = FRAMESIZE_CIF;  // 400x296
  config.jpeg_quality = 10;
  config.fb_count = 2;

  // camera init
  esp_err_t err = esp_camera_init(&config);
  if (err != ESP_OK) {
    Serial.printf("Camera init failed with error 0x%x", err);
    return;
  }

  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println(WiFi.status());
    Serial.println("Connecting to WiFi...");
  }

  Serial.println("Connected to WiFi");
  Serial.println(WiFi.localIP());

  udp.begin(udpPort);

}

void loop() {

    camera_fb_t* fb = NULL;
    esp_err_t res = ESP_OK;
    fb = esp_camera_fb_get();
    if (!fb) {
      Serial.println("Camera capture failed");
      esp_camera_fb_return(fb);
      return;
    }

    if (fb->format != PIXFORMAT_JPEG) {
      Serial.println("PIXFORMAT_JPEG not implemented");
      esp_camera_fb_return(fb);
      return;
    }
    // Serial.println("Send Packet");

    sendPacketData((const char*)fb->buf, fb->len, CHUNK_LENGTH);
    esp_camera_fb_return(fb);

    // Serial.println("Sended");
    // delay(2000);  // Adjust delay as needed

    // 
  // }
}

void sendPacketData(const char* buf, uint16_t len, uint16_t chunkLength) {
  uint8_t buffer[chunkLength];
  size_t blen = sizeof(buffer);
  size_t rest = len % blen;

  for (uint8_t i = 0; i < len / blen; ++i) {
    // Serial.println("Send Buffer ");
    // Serial.println(i);
    // Serial.println(":");


    memcpy(buffer, buf + (i * blen), blen);
    udp.beginPacket(udpAddress, udpPort);
    udp.write(buffer, chunkLength);
    udp.endPacket();

      // for (int i = 0; i < chunkLength; ++i) 
      // {
      // Serial.print(buffer[i]);
      // }
      // Serial.println("");


  }

  if (rest) {
    memcpy(buffer, buf + (len - rest), rest);
    udp.beginPacket(udpAddress, udpPort);

    // Serial.println("Rest :");
    // Serial.println(rest);
    // for (int i = 0; i < rest; ++i) 
    // {
    // Serial.print(buffer[i]);
    // }
    // Serial.println("Done");

    udp.write(buffer, rest);
    udp.endPacket();
  }
}