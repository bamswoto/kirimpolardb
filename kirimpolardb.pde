import ketai.sensors.*;
import de.bezier.data.sql.*;

PostgreSQL pgsql;
KetaiLocation location;

double longitude, latitude, altitude;
int lastPrintTime = 0;

void setup() {
  size(displayWidth, displayHeight);
  orientation(PORTRAIT);
  location = new KetaiLocation(this);

  String user = "p5js_db";
  String pass = "bambang86!";
  String database = "appwebp5js";
  
  pgsql = new PostgreSQL(this, "megatroll.rwlb.ap-southeast-5.rds.aliyuncs.com:1921", database, user, pass);
  
  if (pgsql.connect()) {
    // display the last 10 weather data entries in the table
    pgsql.query("SELECT * FROM gps ORDER BY id");
    while (pgsql.next()) {
      println(pgsql.getString("id") + " " + pgsql.getInt("longitude") + " " + pgsql.getInt("latitude"));
    }
  } else {
    println("Connection to database failed.");
  }  
}

void draw() {
  background(78, 93, 75);
  if (location == null  || location.getProvider() == "none")
    text("Location data is unavailable. \n" +
      "Please check your location settings.", 0, 0, width, height);
  else
    text("Latitude: " + latitude + "\n" +
      "Longitude: " + longitude + "\n" +
      "Altitude: " + altitude + "\n" +
      "Provider: " + location.getProvider(), 0, 0, width, height);

  // Print the values to the console every 0,5 second
  if (millis() - lastPrintTime > 500) {
    pgsql.query("INSERT INTO gps (longitude, latitude, altitude) VALUES (" + longitude + "," + latitude + "," + altitude +")");
    
    pgsql.query("SELECT * FROM gps ORDER BY id");
    while (pgsql.next()) {
      println(pgsql.getString("id") + "," + pgsql.getInt("longitude") + "," + pgsql.getInt("latitude") + "," + pgsql.getInt("altitude"));
    }
    
    lastPrintTime = millis();
  }
}

void onLocationEvent(double _latitude, double _longitude, double _altitude)
{
  longitude = _longitude;
  latitude = _latitude;
  altitude = _altitude;
}

