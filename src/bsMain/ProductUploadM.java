package bsMain;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.HashMap;
import java.util.LinkedList;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import bsAPI.DataTOJSON;
import bsAPI.Sql;
import bsAPI.UploadPhoto;


@WebServlet("/ProductUploadM")
@MultipartConfig
public class ProductUploadM extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("000LoginOK.jsp");
		return;
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		String pid = request.getParameter("pid");	Boolean isPidNull = pid ==null;
		String pname = request.getParameter("pname");
		String pprice = request.getParameter("pprice");
		String pquantity = request.getParameter("pquantity");
		String pbrand = request.getParameter("pbrand");
		String wherePost = request.getParameter("wherePost");
		String addFormatKey[] = request.getParameterValues("addFormatKey");
		String addFormatValue[] = request.getParameterValues("addFormatValue");
		String pdetail = request.getParameter("pdetail");
		Collection<Part> parts = request.getParts();
		HashMap<String, Object> member = (HashMap<String,Object>)request.getSession().getAttribute("member");
		int id = (int)member.get("id");
		
		if (pname==null||pprice==null||pquantity==null||pbrand==null||wherePost==null||pdetail==null||member==null) {
			response.sendRedirect("productAdd.jsp");
			return;
		}
		
		int photoUploadNum = 0;
		Boolean isAddFormatNull = false;
		UploadPhoto uploadPhoto = null;
		int price = 0;
		int quantity = 0;
		int post = 0;

		try{
			price = Integer.parseInt(pprice);
			quantity = Integer.parseInt(pquantity);
			post = Integer.parseInt(wherePost);
			
			uploadPhoto = new UploadPhoto(id,getServletContext().getInitParameter("ProductPhotoPath"));
			if (parts!=null&&isPidNull) {
				photoUploadNum = uploadPhoto.upload(parts);
			}

			Boolean isAddFormatOK = false;
			if ((addFormatKey==null && addFormatValue==null)) {
				isAddFormatNull =true;
				isAddFormatOK=true;
			
			}else if(addFormatKey!=null && addFormatValue!=null && addFormatKey.length==addFormatValue.length){
				isAddFormatOK=true;
			}
			
			if(
				!(0<price&&price<1000000)||
				!(0<quantity&&quantity<10000000)||
				!(0<post&&post<23)||
				!isAddFormatOK
					){
				response.sendRedirect("productAddFail.jsp");
				return;
			}
		}catch(Exception e){
			System.out.println(e.toString()+":productUpload");
			response.sendRedirect("productAddFail.jsp");
			return;
		}

		//PS:正式進入資料庫的地方。

		Sql sql =null;
		Connection conn =null;
		CallableStatement call = null;
		try{
			sql = new Sql();
			conn = sql.conn();
			if (isPidNull) {
				call = conn.prepareCall("{call addProduct(?,?,?,?,?,?,?,?)}");
				call.setInt(8, id);
			}else {
				call = conn.prepareCall("{call updateProduct(?,?,?,?,?,?,?,?,?)}");
				call.setInt(8,Integer.parseInt(pid));
				call.setInt(9, id);
			}
			call.setString(1, pname);
			call.setInt(2, price);
			call.setInt(3, quantity);
			call.setString(4, pbrand);
			call.setInt(5, post);
			call.setString(6, isAddFormatNull?"null":new DataTOJSON().getStringArrToJSON(addFormatKey,addFormatValue));
			call.setString(7, pdetail);
			
			if (call.executeUpdate()!=0) {
				if (!isPidNull) {
					response.sendRedirect("productShow.jsp?product="+pid+"&edit=0");
				}else {
					call = conn.prepareCall("{call getNewPid(?)}");
					call.setInt(1, id);
					ResultSet rs = call.executeQuery();
					rs.next();	//PS因為外層判斷資料是否新增成功，故必定可以抓到最新的pid
					int newPid = rs.getInt("pid");
					if (photoUploadNum!=0) {
						new ProductUploadPhotoM().toSql(conn.prepareCall("{call addPhoto(?,?,?,?,?)}"),
								newPid,uploadPhoto.getPhotoPath());
					}
					response.sendRedirect("productShow.jsp?product="+newPid+"&edit=0");
				}
			}else if(isPidNull){
				response.sendRedirect("productAddFail.jsp");	//PS:返回商品新增
			}else {
				response.sendRedirect("productShowNotFound.html");	//PS:返回商品修改
			}
			conn.close();
			sql.closeSql();
			
		}catch(Exception e){
			System.err.println(e.toString()+":productUpload-SQL");
			if(conn!=null){
				try {
					conn.close();
					sql.closeSql();
				} catch (Exception e1) {}
			}
			response.sendRedirect("productAddFail.jsp");
		}
	}
}
