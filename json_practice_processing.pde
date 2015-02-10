import processing.serial.*;
import cc.arduino.*;
JSONObject json;
String myURL = "https://www.kimonolabs.com/api/deufu5vw?apikey=Q3A2TIrWCxcSBqHP4wJCKN2ZjPSdXAeS";

Arduino arduino;

int red;
int green;
int blue;

void setup() {
  size(512, 200);
  arduino = new Arduino(this, Arduino.list()[2], 115200);
  json = loadJSONObject(myURL);
  background(255);
  size(460, 320);
}

void draw() {
  JSONObject results = json.getJSONObject("results");
  JSONArray collection = results.getJSONArray("collection1");
  int sizeOfCollection = collection.size()-1;
  int spacing = width/sizeOfCollection;
  int color1 = 0;
  int color2 = 0;
  int color3 = 0;
  red = constrain(color1, 0, 255);
  green = constrain(color2, 0, 255);
  blue = constrain(color3, 0, 255);
  for (int i = 1; i<sizeOfCollection; i++){
    JSONObject state = collection.getJSONObject(i);
    String fire_level = state.getString("fire_level");
    if (fire_level.equals("Moderate")){
      color3 = 255;
      delay(100);
    } else if (fire_level.equals("High")){
      color2 = 255;
      delay(100);
    } else if (fire_level.equals("Very High")){
      color1 = 255;
      delay(100);
    } else if (fire_level.equals("N-A")){
      delay(100);
    }
  background(red, green, blue);
  arduino.analogWrite(9, red);
  arduino.analogWrite(10, green);
  arduino.analogWrite(11, blue);
  }
}
