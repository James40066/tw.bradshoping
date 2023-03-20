package bsAPI;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.HashMap;

public class GoogleMapLocation {
	
	public HashMap<String, Double> GetLatLng(String location) {
		HashMap<String, Double> latLng = new HashMap<String, Double>();
		try {
			BufferedReader reader = new BufferedReader(
					new InputStreamReader(
							new URL("https://www.google.com.tw/maps/place/"+location)
								.openConnection()
									.getInputStream()
							));
			String line = null;
			int i=0;
			while ((line=reader.readLine())!=null) {
				if (line.contains(location)) {
					if(i==1) {
						String[] htmlData = line.split(",");
						latLng.put("Lat", Double.parseDouble(htmlData[htmlData.length-2]));
						latLng.put("Lng", Double.parseDouble(htmlData[htmlData.length-1].replace("]", "")));
						break;
					}
					i++;
				}				
			}
			reader.close();
			return latLng;
		} catch (Exception e) {
			System.out.println(e.toString());
			return null;
		}
	}
	
}
