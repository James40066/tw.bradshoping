<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="bsAPI.*"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%
	//購物車邏輯

	//接收參數
	HashMap<String, Object> member = (HashMap<String, Object>) session.getAttribute("member");
	if (member == null) {
		response.sendRedirect("login.jsp");
		return;
	}
	int id = (int) member.get("id");
	
	//Sql連接
	Sql sql = new Sql();
	Connection conn = sql.conn();

	//Sql句法,刪除購物車資料
	String sql1 = "DELETE FROM cart.shoppingcart WHERE  id  = ?";
	PreparedStatement prep1 = conn.prepareStatement(sql1);
	prep1.setInt(1, id);
	int count = prep1.executeUpdate();

	//System.out.print("刪除的筆數:" + count);

	//頁面跳轉
	if(request.getAttribute("isFromBlueNew")==null)
		
	response.sendRedirect("ShoppingCart.jsp");

	//關閉串流
	sql.closeSql();
	conn.close();
%>