package bsMain;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bsAPI.Sql;

@WebServlet("/ProductAttributesSpecialM")
public class ProductAttributesSpecialM extends HttpServlet {
	private HashMap<String, Object> member;
	private String pid,special,sendTo;
	private Sql sql;
	private Connection conn;
	private int specialInt;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		pid = request.getParameter("product");
		special = request.getParameter("special");
		HttpSession session = request.getSession(false);
		
		if (session!=null && session.getAttribute("member")!=null && pid!=null && special!=null) {
			member = (HashMap<String, Object>)session.getAttribute("member");
			specialInt = Integer.parseInt(special);
			if (specialInt>0) {
				sendTo = updateSpecial();
			}
			response.sendRedirect(sendTo);
			
		}else {
			response.sendRedirect("login.jsp");
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	private String updateSpecial() {
		try {
			sql = new Sql();
			conn = sql.conn();
			PreparedStatement prep = conn.prepareStatement("UPDATE product SET special=? WHERE pid=? AND id=?");
			prep.setInt(1, Integer.parseInt(special));
			prep.setInt(2, Integer.parseInt(pid));
			prep.setInt(3, (int)member.get("id"));
			int isUpdateOK = prep.executeUpdate();
			conn.close();sql.closeSql();
			if (isUpdateOK!=0) {
				return "productShow.jsp?product="+pid+"&edit=1";
			}else {
				return "productShowNotFound.html";	//PS:修改SQL失敗，代表此商品不屬於此使用者，未來需修改導引到我的賣場商品列。
			}
			
		} catch (Exception e) {
			System.err.println(e.toString()+":ProductAttributesSpecialM");
			if(conn!=null) {
				try {
					conn.close();sql.closeSql();
				} catch (Exception e2) {}
			}
			return "productShow.jsp?product="+pid+"&edit=1";
		}
	}

}
