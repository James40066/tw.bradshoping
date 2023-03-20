<%@page import="bsMain.RegisteredReCaptcha"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="bsAPI.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<!-- 載入DB -->
<%
	request.setCharacterEncoding("utf-8");
	//接收註冊參數
	String name = request.getParameter("name");
	String password = request.getParameter("password");
	String cpassword = request.getParameter("cpassword");
	String account = request.getParameter("account");
	String genderNum = request.getParameter("gender");
	String year = request.getParameter("year");
	String mouth = request.getParameter("mouth");
	String day = request.getParameter("day");
	String captchaToken = request.getParameter("captchaToken");

	Boolean isregister = false;
	if (name != null && password != null && cpassword != null && account != null && genderNum != null
	&& year != null && mouth != null && day != null && captchaToken != null
	&& RegisteredReCaptcha.isReCaptchaOK(captchaToken) && password.equals(cpassword)) {

		String birthday = year + "-" + mouth + "-" + day;
		int gender = Integer.parseInt(request.getParameter("gender"));

		//密碼加密(自訂API)
		String hpw = PwdHash.toHash(password);

		try {
	//載入jdbc(呼叫自訂API)
	Sql sql = new Sql();
	Connection conn = sql.conn();
	//先查詢有無被註冊
	String sql1 = "SELECT * FROM member where account = ?";
	PreparedStatement pstmt1 = conn.prepareStatement(sql1);
	pstmt1.setString(1, account);
	ResultSet rs = pstmt1.executeQuery();

	if (!rs.next()) {
		//沒有被註冊就進行
		String sql2 = "INSERT INTO member (account,password,name,gender,birthday) VALUES (?,?,?,?,?)";
		PreparedStatement pstmt2 = conn.prepareStatement(sql2);
		pstmt2.setString(1, account);
		pstmt2.setString(2, hpw);
		pstmt2.setString(3, name);
		pstmt2.setInt(4, gender);
		pstmt2.setString(5, birthday);
		pstmt2.executeUpdate();
		pageContext.setAttribute("account", account);
		response.sendRedirect("login.jsp");
	} else {
		response.sendRedirect("registered.jsp");
	}
		} catch (Exception e) {
	System.err.print(e.toString() + ":registeredM");
	response.sendRedirect("registered.jsp");
		}
	} else {
		response.sendRedirect("registered.jsp");
	}
%>