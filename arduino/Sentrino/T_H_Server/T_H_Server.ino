/*

 */

#include <Ethernet.h>
#include "DHT.h"
#include <SPI.h>

#define DHTPIN 2
#define DHTTYPE DHT11   // DHT 11 

DHT dht(DHTPIN, DHTTYPE);


// assign a MAC address for the ethernet controller.
// fill in your address here:
byte mac[] = { 
  0x00, 0xAA, 0xBB, 0xCC, 0xDE, 0x02 };
// assign an IP address for the controller:
IPAddress ip(192,168,0,105);
IPAddress gateway(192,168,0,1);	
IPAddress subnet(255, 255, 255, 0);


// Initialize the Ethernet server library
// with the IP address and port you want to use 
// (port 80 is default for HTTP):
EthernetServer server(80);

float temperature = 0.0;
float humidity = 0;
long lastReadingTime = 0;

void setup() {
  Serial.begin(9600); 
  Serial.println("DHT11 online!");
  dht.begin();

  // start the SPI library:
  SPI.begin();
  
  // start the Ethernet connection and the server:
  Ethernet.begin(mac, ip);
  server.begin();

  Serial.begin(9600);

  // give the sensor and Ethernet shield time to set up:
  delay(1000);

}

void loop() { 
  // check for a reading no more than once a second.
  if (millis() - lastReadingTime > 1000){
    humidity = dht.readHumidity();
    temperature = dht.readTemperature();
      // timestamp the last time you got a reading:
      lastReadingTime = millis();
  }

  // listen for incoming Ethernet connections:
  listenForEthernetClients();
}

void listenForEthernetClients() {
  // listen for incoming clients
  EthernetClient client = server.available();
  if (client) {
    Serial.println("Got a client");
    // an http request ends with a blank line
    boolean currentLineIsBlank = true;
    while (client.connected()) {
      if (client.available()) {
        char c = client.read();
        // if you've gotten to the end of the line (received a newline
        // character) and the line is blank, the http request has ended,
        // so you can send a reply
        if (c == '\n' && currentLineIsBlank) {
          // send a standard http response header
          client.println("HTTP/1.1 200 OK");
          client.println("Content-Type: text/html");
          client.println();
          // print the current readings, in HTML format:
          client.print("Temperature: ");
          client.print(Celcius2Fahrenheit(temperature));
          client.print(" degrees F");
          client.println("<br />");
          client.print("Humidity: ");
          client.print(humidity);
          client.print("%");
          client.println("<br />");  
          break;
        }
        if (c == '\n') {
          // you're starting a new line
          currentLineIsBlank = true;
        } 
        else if (c != '\r') {
          // you've gotten a character on the current line
          currentLineIsBlank = false;
        }
      }
    }
    // give the web browser time to receive the data
    delay(1);
    // close the connection:
    client.stop();
  }
} 

double Celcius2Fahrenheit(double celsius)
{
	return celsius * 9 / 5 + 32;
}
