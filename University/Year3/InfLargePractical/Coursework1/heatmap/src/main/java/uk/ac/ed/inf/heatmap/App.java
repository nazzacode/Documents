package uk.ac.ed.inf.heatmap;

// import java.awt.geom.Point2D;
import java.io.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.SortedMap;
import java.util.TreeMap;

import com.mapbox.geojson.Polygon;
import com.mapbox.geojson.FeatureCollection;
import com.mapbox.geojson.Geometry;
import com.mapbox.geojson.Feature;
import com.mapbox.geojson.Point;

import com.google.gson.Gson;
import com.google.gson.JsonObject;


/**
 * Program to generate a 10x10 'pixel' GeoJson Heatmap from an input integer for each pixel
 * (representing air pollution predictions over a specified region of the Edinburgh Uni main campus)
 * Input given as a 10x10 csv style .txt file as a command line argument
 * Outputs a `heatmap.geojson` file to the present working directory
 */
public class App {
	
	/* Fields */
	// initialise drone confinement boundaries 
	// (as specified in ilp-coursework.pdf Figure 1)
	private static final HashMap<String, Double> BOUNDARIES = new HashMap<String, Double>();
	private static void insertBoundaries() { 
    	BOUNDARIES.put("LAT_MAX", 55.946233);  // North
    	BOUNDARIES.put("LAT_MIN", 55.942617);  // South
    	BOUNDARIES.put("LON_MAX", -3.184319);  // East
    	BOUNDARIES.put("LON_MIN", -3.192473);  // West
    	BOUNDARIES.put("LAT_STEP", ((BOUNDARIES.get("LAT_MAX") - BOUNDARIES.get("LAT_MIN")) / 10 ));
    	BOUNDARIES.put("LON_STEP", ((BOUNDARIES.get("LON_MAX") - BOUNDARIES.get("LON_MIN")) / 10 ));
    	// note: not accounting for modulo nature of lat/lon should the project be extended to other locations
    }
    // note: you could switch to the following BOUNDARIES implementation if;
    	// (i) the code was needed in a different geographical location, and 
    	// (ii) the geojson right hand rule (that points should be specified clockwise) was a dependency.
	// private static Point2D NORTHWEST_BOUND = new Point2D.Double(55.946233, -3.192473);
	// private static Point2D SOUTHEAST_BOUND = new Point2D.Double(55.942617, -3.184319);
	
	// initialise Map; pollution predictions to RGB color bucket
    // (key, value) = (pollution-bucket-upper-bound, RGB-color-string)
    // (as specified in ilp-coursework.pdf Figure 5)
    private static final SortedMap<Integer, String> POLLUTION_TO_RGB = new TreeMap<Integer, String>();
    private static void insertPollutionMap() { 
        POLLUTION_TO_RGB.put(32,  "#00ff00"); 
        POLLUTION_TO_RGB.put(64,  "#40ff00"); 
        POLLUTION_TO_RGB.put(96,  "#80ff00"); 
        POLLUTION_TO_RGB.put(128, "#c0ff00"); 
        POLLUTION_TO_RGB.put(160, "#ffc000");  
        POLLUTION_TO_RGB.put(192, "#ff8000"); 
        POLLUTION_TO_RGB.put(224, "#ff4000"); 
        POLLUTION_TO_RGB.put(256, "#ff0000"); 
        // note: keys 'low battery' & 'not-visited' not implemented as unnecessary 
    }

    /* methods */
	public static void main(String[] args) throws IOException {
	/** Try to run the program, outputting a heatmap.geojson file in the current working directory  	
	 */
		// read file from input
    	try (BufferedReader buffReader = new BufferedReader(new FileReader(args[0]))) {
    		
    		// populate global data structures 
    		insertBoundaries();
    		insertPollutionMap();
    		
    		// parse input into 10x10 int array 
    		int[][] predictions = parsePredictions(buffReader);
    		    		
    		// construct heatmap as a geoJson feature collection
    		FeatureCollection heatmap = constructHeatmap(predictions, BOUNDARIES, POLLUTION_TO_RGB);
    		
    		// output to present working directory as string 
    		try (PrintStream out = new PrintStream(
    				new FileOutputStream(System.getProperty("user.dir") + "/heatmap.geojson"))) {
    		    out.print(heatmap.toJson());
    		    // Completion Message
    		    System.out.println("All Done!!");
    		}
    	}
    }
    
	public static int[][] parsePredictions(BufferedReader buffReader) throws IOException {
	/** Parse input file to a 10x10 Integer array
    */	
    	int[][] predictions = new int[10][10];
    	String line;
    	int counter = 0;
    	
    	// loop over lines
    	while ((line = buffReader.readLine()) != null) {
    		// convert String to 10x1 Integer Array and append to `predictions`
    		predictions[counter] = Arrays.stream(line.split(","))
    								.map(String :: trim)  // remove whitespace
    								.mapToInt(Integer::parseInt).toArray();  
        	counter++;
    	}
		return predictions;	
    }
    
    
	public static FeatureCollection constructHeatmap(
			int[][] predictions, HashMap<String, Double> BOUNDARIES, SortedMap<Integer, String> POLLUTION_TO_RGB) {
	/** Constructs geojson heatmap by looping over `pixels` and for each;
	* create a geoJson (`Geometry`) `Polygon`-> convert to geoJson `Feature` 
	* with `properties` from `predictionToRGB()` to indicate pollution prediction color
	*/
		// initialise geojson Feature list
		List<Feature> heatmapFeatureList = new ArrayList<>();
		
		// loop over grid pixels
		// creating Feature (Polygon)'s
		// with the `properties` to visualise the pollution prediction
		for(int latIndex = 0; latIndex < 10; latIndex++) {
			for(int lonIndex = 0; lonIndex < 10; lonIndex++) {
								
				// calculate coordinates of pixel Corners
			    List<Point> pixelCorners = arrayIndexToPixelCorners(BOUNDARIES, latIndex, lonIndex);
			    // type cast for input to next function
		    	List<List<Point>> pixelCornersList = new ArrayList<List<Point>>();
				pixelCornersList.add(pixelCorners);
				// construct Polygon from List of Pixel corners (itself another list)
				Polygon pixelPolygon = Polygon.fromLngLats(pixelCornersList);
			
				// get pixel's RGB color string bucket
				String rgbString = predictionToRGB(predictions[latIndex][lonIndex], POLLUTION_TO_RGB);
				

				// type cast Polygon as Geometry for input to next function
				Geometry pixelGeometry = pixelPolygon;
				// initialise heatmap properties to be added to `pixelFeature`
				JsonObject properties = new JsonObject();
				properties.add("fill-opacity", new Gson().toJsonTree(0.75));
				properties.add("rgb-string", new Gson().toJsonTree(rgbString));
				properties.add("fill", new Gson().toJsonTree(rgbString));
				// construct Feature from  (Geometry) Polygon 
				Feature pixelFeature = Feature.fromGeometry(pixelGeometry, properties);
				
				// Append `pixelFeature` to `heatmapFeatureList`
				heatmapFeatureList.add(pixelFeature);
			}
		}
		// Convert the List of Features to a FeatureCollection
		FeatureCollection heatmapFeatureCollection = FeatureCollection.fromFeatures(heatmapFeatureList);
		
		return heatmapFeatureCollection;
	}
	
	

	public static String predictionToRGB(int prediction, SortedMap<Integer, String> pollutionToRGB) {
	/** Maps pollution concentration estimate to RGB colour bucket 
	 */
	    Set keySet = pollutionToRGB.entrySet();
        Iterator iter = keySet.iterator(); 
        Map.Entry mapEntry = null;
  
        // Traverse map (by increasing key values)
        while (iter.hasNext()) { 
            mapEntry = (Map.Entry) iter.next(); 
            int key = (Integer) mapEntry.getKey();
            if (prediction <= key) {
                break;
            }
        }
        String rgbString = (String) mapEntry.getValue(); 

		return rgbString;
	}
    
	
    private static List<Point> arrayIndexToPixelCorners(HashMap<String, Double> BOUNDARIES, int latIndex, int lonIndex) {
    /**	Calculates pixel corner coordinates and casts as a List of List of Points
     */
    	// unpack `BOUNDARIES` map values of use
    	double LAT_MAX = BOUNDARIES.get("LAT_MAX");
    	double LON_MIN = BOUNDARIES.get("LON_MIN");
    	double LAT_STEP = BOUNDARIES.get("LAT_STEP");
    	double LON_STEP = BOUNDARIES.get("LON_STEP");
    	// calculate pixel corners
    	double lat1 = LAT_MAX - latIndex * LAT_STEP;
    	double lat2 = LAT_MAX - ((latIndex+1) * LAT_STEP);
    	double lon1 = LON_MIN + (lonIndex * LON_STEP);
    	double lon2 = LON_MIN + (lonIndex+1) * LON_STEP;

    	// parse into required data structure 
		ArrayList<Point> pixelCorners = new ArrayList<Point>(List.of(
				Point.fromLngLat(lon1, lat1),   // north-west pixel boundary
				Point.fromLngLat(lon2, lat1),   // north-east pixel boundary
				Point.fromLngLat(lon2, lat2),   // south-west pixel boundary
				Point.fromLngLat(lon1, lat2),   // south-east pixel boundary
				Point.fromLngLat(lon1, lat1))); // north-west pixel boundary (again)

    	return pixelCorners;
    }
}
