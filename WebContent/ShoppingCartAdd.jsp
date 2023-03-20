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
	int product = Integer.parseInt(request.getParameter("product"));
	int quantity = Integer.parseInt(request.getParameter("quantity"));
	//Sql連接
	Sql sql = new Sql();
	Connection conn = sql.conn();

	//Sql句法,購物車寫入資料
	try {
		String sql1 = "INSERT INTO shoppingcart  (id,pid,quantity) VALUES (?,?,?)";
		PreparedStatement prep1 = conn.prepareStatement(sql1);
		prep1.setInt(1, id);
		prep1.setInt(2, product);
		prep1.setInt(3, quantity);
		int count = prep1.executeUpdate();

		out.println(true);
	} catch (Exception e) {
		out.println(false);
	}

	//關閉串流
	sql.closeSql();
	conn.close();
%>