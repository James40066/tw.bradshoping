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
	request.setCharacterEncoding("UTF-8");
	HashMap<String, Object> member = (HashMap<String, Object>) session.getAttribute("member");

	int id = (int) member.get("id");
	String storeName = request.getParameter("storeName");
	String faceAddress = request.getParameter("faceAddress");

	if (member == null || storeName == null || faceAddress == null) {
		response.sendRedirect("buyer.jsp");
	} else {
		Sql sql = null;
		Connection conn = null;
		PreparedStatement prep = null;
		String href = null;
		try {
			sql = new Sql();
			conn = sql.conn();
			prep = conn.prepareStatement("update member set storeName=?,faceAddress=?, isseller=? where id=?");
			prep.setString(1, storeName);
			prep.setString(2, faceAddress);
			prep.setInt(3, 1);
			prep.setInt(4, id);
			if (prep.executeUpdate() != 0) {
				prep = conn.prepareStatement("Select * from member where id=?");
				prep.setInt(1, id);
				ResultSet rs = prep.executeQuery();
				rs.next();
				session.setAttribute("member", new UserData(rs).getMember());
				href = "seller.jsp";
			} else {
				href = "buyer.jsp";
				session.setAttribute("callAjaxView", "<script>changeAjaxView('buyerSRSeller.jsp');</script>");
			}
			response.sendRedirect(href);
			sql.closeSql();
			conn.close();
		} catch (Exception e) {
			System.err.println(e.toString());
			if (conn != null) {
				sql.closeSql();
				conn.close();
			}
		}
	}
%>