package bsAPI;

import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;

import org.json.JSONObject;

public class ParseJSON {

	public LinkedList<String> getPhotoPath(String json) {
		
		JSONObject jsonObject = new JSONObject(json);
		LinkedList<String>photoPaths= new LinkedList<String>();
		
		for (int i = 0; i < jsonObject.length(); i++) {
			photoPaths.add(jsonObject.get(i+"").toString());
		}
		return photoPaths;
	}
	
	public HashMap<String, LinkedList<String>> getFormatDatas(String json) {
		HashMap<String, LinkedList<String>> addFormats = new HashMap<>();
		LinkedList<String> keys = new LinkedList<String>();
		LinkedList<String> values = new LinkedList<String>();
		JSONObject jsonObject = new JSONObject(json);
		Iterator iterator = jsonObject.keys();
		while (iterator.hasNext()) {
			String key = (String)iterator.next();
			keys.add(key);
			values.add(jsonObject.get(key).toString());
		}
		addFormats.put("key", keys);
		addFormats.put("value", values);
		return addFormats;
	}
}
