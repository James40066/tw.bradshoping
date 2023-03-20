<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="bsAPI.*"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.util.Properties"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%
	//修改userinfo
	//從UserData.java的member取出資料
	//int id =(int)((HashMap<String,Object>)session.getAttribute("member")).get("id");
	HashMap<String, Object> member = (HashMap<String, Object>) session.getAttribute("member");
	int id = (int) member.get("id");

	//抓取表單所填入的值 name address tel
	String name = request.getParameter("name");
	String address = request.getParameter("address");
	String tel = request.getParameter("tel");

	//載入jdbc(呼叫自訂API)
	Sql sql = new Sql();
	Connection conn = sql.conn();
	//修改句法

	try {
		PreparedStatement pstmt1 = conn.prepareStatement("update member set name=?,address=?,tel=? where id=?");
		pstmt1.setString(1, name);
		pstmt1.setString(2, address);
		pstmt1.setString(3, tel);
		pstmt1.setInt(4, id);

		//複查(是否有寫入成功)
		if (pstmt1.executeUpdate() != 0) {
			pstmt1 = conn.prepareStatement("Select * from member where id=?");
			//設定?代表甚麼參數
			pstmt1.setInt(1, id);
			ResultSet rs = pstmt1.executeQuery();
			rs.next();
			//重新種session
			session.setAttribute("member", new UserData(rs).getMember());
			session.setAttribute("callAjaxView", "<script>changeAjaxView('buyerInfo.jsp');</script>");

		} else {
			//記得告訴user新增失敗
			session.setAttribute("callAjaxView", "<script>changeAjaxView('buyerInfo.jsp');</script>");
		}
		response.sendRedirect("buyer.jsp");
		sql.closeSql();
		conn.close();
		
	} catch (Exception e) {
		System.err.println(e.toString());
		if (conn != null) {
			sql.closeSql();
			conn.close();
		}
	}
%>