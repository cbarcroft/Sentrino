#include <Ethernet.h>
#include "DHT.h"
#include <SPI.h>
#include <LiquidCrystal.h>

#define DHTPIN 2
#define DHTTYPE DHT11   // DHT 11 

DHT dht(DHTPIN, DHTTYPE);
String readString = String(100);
String response = "";

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

LiquidCrystal lcd(7, 8, 9, 3, 5, 6);

float temperature = 0.0;
float humidity = 0.0;
long lastReadingTime = 0;

int photocellPin = 0;     // the cell and 10K pulldown are connected to a0
int photocellReading;     // the analog reading from the sensor divider

void setup() {
  Serial.begin(9600); 
  Serial.println("Sentrino server online.");
  dht.begin();
  
  // set up LCD columns and rows
  lcd.begin(16, 2);
  
  // start the Ethernet connection and the server:
  Ethernet.begin(mac, ip);
  server.begin();

  // give the sensor and Ethernet shield time to set up:
  delay(1000);

}

void loop() { 
  // check for a reading no more than once a second.
  if (millis() - lastReadingTime > 1000){
    humidity = dht.readHumidity();
    temperature = dht.readTemperature();
    photocellReading = analogRead(photocellPin);
      // timestamp the last time you got a reading:
      lastReadingTime = millis();
  }
  
  printStatus();
  //Serial.println(freeRam());
  //Serial.println(humidity);
  // listen for incoming Ethernet connections:
  listenForEthernetClients();
}

void listenForEthernetClients() {
  // listen for incoming clients
  EthernetClient client = server.available();
  if (client) {
    Serial.println("Incoming request...");
    // an http request ends with a blank line
    boolean currentLineIsBlank = true;
    while (client.connected()) {
      if (client.available()) {
        char c = client.read();
        
        //read char by char HTTP request
        if (readString.length() < 40) {
          //store characters to string 
          readString.concat(c); 
        } 
        // if you've gotten to the end of the line (received a newline
        // character) and the line is blank, the http request has ended,
        // so you can send a reply
   
        if (c == '\n' && currentLineIsBlank) {
          String strcommand = parseURLForCommand(readString);
         // command = command.toCharArray();
          
         char __command[sizeof(strcommand)];
         strcommand.toCharArray(__command, sizeof(__command));
         
          Serial.print("Command: ");
          Serial.println(__command);
          
          if(strcmp(__command, "ping") == 0){
            response = ping();
          }
          if(strcmp(__command, "temp") == 0){
            response = temp();
          }
          if(strcmp(__command, "hmdy") == 0){
            response = hmdy();
          }
        }
        
        
        if (c == '\n' && currentLineIsBlank) {
          // send a standard http response header
          client.println("HTTP/1.1 200 OK");
          client.println("Content-Type: text/html");
          client.println();
          // print the current readings, in HTML format:
          client.println(response);
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
    readString="";
    response = "{\"error\":{\"err\":true, \"reason\":\"no_func\"}}";
  }
} 

double Celcius2Fahrenheit(double celsius)
{
    return celsius * 9 / 5 + 32;
}

String parseURLForCommand(String inputString)
{
    int startCommandPosition = inputString.lastIndexOf('$$');
    return inputString.substring(startCommandPosition + 1, startCommandPosition + 5);
}

//Arduino response functions
String ping()
{
  String ping_response = "{\"error\":{\"err\":false},\"body\":{\"online\":true}}";
  return ping_response;
}

String temp()
{
  double t = Celcius2Fahrenheit(temperature);
  int temper = int(t * 100);
  char temp_response[65];
  sprintf(temp_response, "{\"error\":{\"err\":false}, \"body\":{\"temp\":%d}}", temper);
  return temp_response;
}

String hmdy() //humidity
{
  int humid = int(humidity * 100);
  char hmdy_response[65];
  sprintf(hmdy_response, "{\"error\":{\"err\":false}, \"body\":{\"hmdy\":%d}}", humid);
  Serial.println(hmdy_response);
  return hmdy_response;
}

int freeRam () {
  extern int __heap_start, *__brkval; 
  int v; 
  return (int) &v - (__brkval == 0 ? (int) &__heap_start : (int) __brkval); 
}

void printStatus(){
  lcd.setCursor(0, 0);
  lcd.print(Celcius2Fahrenheit(temperature));
  lcd.print(" F");
  lcd.setCursor(12, 0);
  lcd.print(photocellReading);
  lcd.print("L");
  
  lcd.setCursor(0, 1);
  lcd.print(humidity);
  lcd.print(" %");
  lcd.setCursor(11, 1);
  if (freeRam() < 1000)
  {
    lcd.print(" ");
  }
  lcd.print(freeRam());
  lcd.print("b");
}
