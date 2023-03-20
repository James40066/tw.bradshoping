package bsMain;

import java.io.IOException;
import java.sql.CallableStatement;
import java.util.HashMap;
import java.util.LinkedList;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@MultipartConfig
@WebServlet("/ProductUploadPhotoM")
public class ProductUploadPhotoM extends HttpServlet {
	private CallableStatement calling;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		return;
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
	
	public void toSql(CallableStatement call, int newPid, LinkedList<HashMap<String, String>> photos) {
		
		try {
			for (int i = 0; i < photos.size(); i++) {
				String original = photos.get(i).get("Original");
				String big = photos.get(i).get("Big");
				String small = photos.get(i).get("Small");
				call.setInt(1, newPid);
				call.setString(2, original);
				call.setString(3, big);
				call.setString(4, small);
				call.setInt(5, i==0?1:0);
				call.executeUpdate();		//PS未處理照片上傳失敗。
			}
		} catch (Exception e) {
			System.err.println(e.toString()+":ProductUploadPhotoM");
		}

	}
	

}
