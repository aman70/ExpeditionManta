
import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.core.*;
import de.fhpotsdam.unfolding.data.*;
import de.fhpotsdam.unfolding.events.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.interactions.*;
import de.fhpotsdam.unfolding.mapdisplay.*;
import de.fhpotsdam.unfolding.mapdisplay.shaders.*;
import de.fhpotsdam.unfolding.marker.*;
import de.fhpotsdam.unfolding.providers.*;
import de.fhpotsdam.unfolding.texture.*;
import de.fhpotsdam.unfolding.tiles.*;
import de.fhpotsdam.unfolding.ui.*;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.utils.*;
import de.fhpotsdam.unfolding.providers.Google;
import de.fhpotsdam.unfolding.providers.Microsoft;

import processing.serial.*;

AbstractMapProvider p1 = new Microsoft.AerialProvider();
UnfoldingMap map;

void settings() {
  size(800, 800, P2D); 

  //map = new UnfoldingMap(this, 100, 100, 100, 100, p1 ); //this line positions the map at 0,0 and around 500,500 size-see above image
  map = new UnfoldingMap(this, p1 ); //this works properly but the map is full screen
}

Serial myPort;  // Create object from Serial class
String val;     // Data received from the serial port
float lat = 0; 
float lon = 0;

void setup()
{
  // I know that the first port in the serial list on my mac
  // is Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[0]; //change the 0 to a 1 or 2 etc. to match your port
  myPort = new Serial(this, portName, 115200);
}

void draw()
{
  if ( myPort.available() > 0) 
  {  // If data is available,
    val = myPort.readStringUntil('\n');         // read it and store it in val
    if (val != null)
    {
      val = trim(val);
      //float[] newLatLon = float(split(val, ","));

      //lat = newLatLon[0] ;
      //lon = newLatLon[1] ;
      String[] tempSplit = split(val, ",");
      if (tempSplit.length == 2) 
      {
        lat = float(tempSplit[0]);
        lon = float(tempSplit[1]);
      }
    }
  }


  //map = new UnfoldingMap(this, p1 ); //if I try to put this line here I get this error: java.lang.NoSuchFieldError:quailty (unless I removed P2D from size)
  if (lat > 0)
  {
    Location melbourneLocation = new Location(lat, lon);
    float maxPanningDistance = 0.5; // in km
    map.zoomAndPanTo(19, melbourneLocation);
    map.setPanningRestriction(melbourneLocation, maxPanningDistance);
    map.setZoomRange(14, 18);
    MapUtils.createDefaultEventDispatcher(this, map);

    map.draw();

    // Create point markers for locations
    SimplePointMarker berlinMarker = new SimplePointMarker(melbourneLocation);

    // Adapt style
    berlinMarker.setColor(color(255, 0, 0, 100));
    berlinMarker.setStrokeColor(color(255, 0, 0));
    berlinMarker.setStrokeWeight(1);

    // Add markers to the map
    map.addMarkers(berlinMarker);

    println(lat+","+lon); //print it out in the console
  }
}