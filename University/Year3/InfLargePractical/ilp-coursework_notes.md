# Informatics Large Practical (ILP) Notes
_by Nathan Sharp | Oct 2020_

## Introduction

### The Brief
Program an autonoumous drone wich will collect readings from air quality sensors distributed around an urban geographical area as part of a (fictitious) research project to analyse urban air quality.

  - you will be marked heavily on the readibility of your code (it must be passed on)

###  Important Variables
Threshold distance to collect sensor reading =  0.0002 degrees\
Number of Sensors = 99\
Daily Sensor Readings to be taken = 33 (specified)\
Reading from reciever has 2 components:

  - reading: char string of air polution (0.0-256.0)
  - battery: 0.0-100.0 of sensor
    - if battery < 10% $\rightarrow$ `battery = null` $\rightarrow$ `flagNewBattery(sensor)`

### Other Information
  - 'What3Words' is used as the sensor location system

#### Drone Movement Restrictions
  - the drone nust stay inside the confinement area at all times 
  - the drone 'flight path' has at most 150 'moves'
  - A "move" is a straight line of len 0.0003 degrees
  - the drone can only move in direction multiples of 10 degrees 
  - the drone path should be a closed loop
  - the drone life cycle has a pattern which iterates (1) making a move, and (2) taking a sensor reading
  - the drone must move before making a reading even if the a sensor is in range at the starting point
    - NS: come to that point last
  - the drone cannot connect to two or more sensors without making a move

### Web Server
There is a web server with synthetic data (readings/battery)

#### Webserver Filestructure (maps, words, buildings)

#### ~/maps\
Contains thelist of sensors to be visited (for each day)\
Filestucture: `maps/year/numericMonth/numericDay/air-quality-data.json`\
_Example:_

```
{
  ...
  "location": "what.three.words",
  "battery": 94.53979,
  "reading": "null"
  ...
}
```

#### ~/words\
Contains the WhatThreeWords's square coordinates\
Filestructure: `~/words/first/second/third/details.json`\
_Example:_

```
{
  "country": "GB",
  "square": {
    "southwest":, {
      "lng": -3.187428,
      "lat" 55.945936
    },
    "northeast":, {
      "lng": -3.18738,
      "lat" 55.945963
    }
  },
  ...
}
```

#### ~/buildings\
Contains a geojson of the 4 regions in which the drone cannot fly (AT, DHT, Library, Inf Forum/Bayes/DSB)\
Filestructure: `buildings/no-fly-zones.geojson`

### The Implementation Task
Project Name: `aqmaps.jar` 

The command: `java -jar aqmaps.jar 15 06 2021 55.9444 -3.1878 5678 80` should load the `air-quality-data.json` file for the data, connecting at port 80, start th drone at (lon, lat) (55.9444, -3.1878) and use the number 5678 as the random seed for the application.

#### Output Files 
Your application should write two text files in the current working directory, `flightpath-DD-MM-YYYY.txt` and `readings-DD-MM-YYYY.geojson`

flightpath-DD-MM-YYYY.txt
  : should be 150 lines long with structure ` (int) linenumber, (double) lat-before, (double) lon-before, (int) movement-angle, (double) lat-after, (double) lon-after, (string) what.three.words` (essentially a csv)

readings-DD-MM-YY.geojson
  : 33 geojson `Point` 'markers', of the locations with the same structure as the `~/maps/YYYY/MM/DD/air-quality-data.json` with the following 4 properties:

    - `location`-- What3Words string
    - `rgb-string`--  polution coded danger color as per fig. 5 
    - `marker-color`-- rendered from rgb-string
    - `maker-symbol`-- lighthouse | danger | cross | nosymbol

#### Programing Language 
Java 11\
You are permitted to use any software under free licence (Mapbox is recomended).

$\pagebreak$

# Coursework 1
### 1.1 Introduction 
Don't submit late. Something about a heatmap.

### 1.2 Getting Started
Create a new maven project (on eclipse?) with:
  
  - Group Id -- uk.ac.inf
  - Artifact ID -- heatmap 

### 1.4 The Implementation Task
Input: 10x10 grid (.txt) file of air quality 'predictions'.\
Output: the command `java -jar heatmap.jar predictions.txt` should produce a heatmap.geojson output file. (`rgb-string == fill`

### 1.5 Marking Scheme
__Correctness (15)__
__Readability (10)__
