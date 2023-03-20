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

@WebServlet("/ShoppingCartUpdateItem")
public class ShoppingCartUpdateItem extends HttpServlet {
	private String ajaxPid,quantity,pid;
	private int msg;
	private HashMap<String, Object> member;
	private Sql sql;
	private Connection conn;
	private PreparedStatement prep;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		ajaxPid = request.getParameter("product");
		quantity = request.getParameter("quantity");
		HttpSession session = request.getSession(false);
		
		if (session!=null && session.getAttribute("member")!=null && ajaxPid!=null && ajaxPid.startsWith("pid") && quantity!=null) {
			member = (HashMap<String, Object>)session.getAttribute("member");
			pid = ajaxPid.substring(ajaxPid.length()-2, ajaxPid.length());
			updateCart();
			
			response.getWriter().print(msg);
		}else {
			return;
		}
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
	
	private void updateCart() {
		try {
			sql = new Sql();
    		conn = sql.conn();
    		prep = conn.prepareStatement("UPDATE shoppingcart SET quantity=? WHERE pid=? AND id=?");
    		prep.setInt(1, Integer.parseInt(quantity));
    		prep.setInt(2, Integer.parseInt(pid));
    		prep.setInt(3, (int)member.get("id"));
    		
    		msg = prep.executeUpdate()!=0?
    				new ShoppingCartData((int)member.get("id")).getTotal()
    				:
    				-1;

			conn.close();sql.closeSql();
			
		} catch (Exception e) {
			System.err.println(e.toString()+":ProductAttributesIsSaleM");
			if(conn!=null) {
				try {
					conn.close();sql.closeSql();
				} catch (Exception e2) {}
			}
			msg=-1;
		}
	}
}
