package bsAPI;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;

import javax.servlet.http.Part;

public class UploadPhoto {

	private LinkedList<HashMap<String, String>> photoName;
	private StringBuffer errorMsg;
	private String path;
	private int id;
	private int photoNum;

	public UploadPhoto(int id, String path) {
		this.path = path;
	}

	public int upload(Collection<Part> parts) {
		errorMsg = new StringBuffer();
		try {
			photoName = new LinkedList<HashMap<String,String>>();
			Iterator ckParts = parts.iterator();
			photoNum = 0;
			int debug =0;
			while (ckParts.hasNext()) {
				Part part = (Part) ckParts.next();
				String partType = part.getContentType();

				if (partType != null) {
					if (partType.equals("image/png") || partType.equals("image/jpeg")) {
						// os檔案型態
						String type = (String) partType.subSequence(6, partType.length());
						// compress_pictures2的Static方法用來儲存圖片並回傳LinkedList<HashMap<String, String>>
						photoName.add(new Compress_pictures().scaleImage(part.getInputStream(), id, path, photoNum++, type));
					} else {
						errorMsg.append(part.getSubmittedFileName() + ",");
					}
				}
			}
		} catch (Exception e) {
			System.err.println(e.toString() + ":upload");
		}
		return photoNum;
	}

	public LinkedList<HashMap<String, String>> getPhotoPath() {
		return photoName;
	}

	public String getErrorMsg() {
		return errorMsg.toString();
	}

}
