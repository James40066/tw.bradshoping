package bsAPI;

import java.util.LinkedList;

public class DataTOJSON{
	
	private StringBuffer jsonBuffer = null;
	
	public String getStringArrToJSON(String[] keys, String[] values) {
		jsonBuffer = new StringBuffer("{") ;
		
		for (int i = 0; i < keys.length; i++) {
			jsonBuffer.append(keys[i]+":"+values[i]+",");
		}
		jsonBuffer.replace(jsonBuffer.length()-1, jsonBuffer.length(), "");
		return jsonBuffer.append("}").toString();
		
	}
	
	public String getPhotoNameToJSON(LinkedList<String> names) {
		jsonBuffer = new StringBuffer("{") ;
		
		for (int i = 0; i < names.size(); i++) {
			jsonBuffer.append(i+":"+names.get(i)+",");
		}
		jsonBuffer.replace(jsonBuffer.length()-1, jsonBuffer.length(), "");
		return jsonBuffer.append("}").toString();
		
	}
	
}
