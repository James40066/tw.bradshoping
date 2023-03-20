<%@page import="javax.sound.midi.SysexMessage"%>
<%@page import="java.sql.CallableStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="bsAPI.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>

<%
	request.setCharacterEncoding("utf-8");

	String loginId = request.getParameter("id");
	String loginTypeNum = request.getParameter("type");
	String name = request.getParameter("name");
	String account = request.getParameter("account");
	String genderStr = request.getParameter("gender");
	String year = request.getParameter("year");
	String mouth = request.getParameter("mouth");
	String day = request.getParameter("day");
	if (loginId == null || loginTypeNum ==null || name == null || account == null || genderStr == null || year == null
			|| mouth == null || day == null) {
		response.sendRedirect("registered.jsp");
	} else {
		Sql sql = null;
		Connection conn = null;
		try {
			int gender = Integer.parseInt(request.getParameter("gender"));
			String birthday = year + "-" + mouth + "-" + day;
			String loginType =null;
			switch(Integer.parseInt(loginTypeNum)){
				case 1:
					loginType = "registeredGoogle";
					break;
				case 2:
					loginType = "registeredFacebook";
					break;
				default:
					break;
			}

			sql = new Sql();
			conn = sql.conn();
			CallableStatement prep = conn.prepareCall("{call "+loginType+"(?,?,?,?,?,?)}");
			prep.setString(1, account);
			prep.setString(2, "null");
			prep.setString(3, name);
			prep.setInt(4, gender);
			prep.setString(5, birthday);
			prep.setString(6, loginId);
			ResultSet rs = prep.executeQuery();
			if (rs.next()) {
				session.setAttribute("member", new UserData(rs).getMember());
				response.sendRedirect("index.jsp");
			} else {
				response.sendRedirect("login.jsp");
			}
			conn.close();
			sql.closeSql();
		} catch (Exception e) {
			System.err.println(e.toString());
			if (conn != null) {
				try {
					conn.close();
					sql.closeSql();
				} catch (Exception e1) {}
			}
		}
	}
%>