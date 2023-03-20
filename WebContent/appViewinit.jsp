<%@page import="java.util.HashMap"%>
<%@page import="bsAPI.BSapp"%>
<%@page import="bsAPI.UserData"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="org.json.JSONObject"%>
<%@page import="bsMain.*"%>
<%
	request.setCharacterEncoding("UTF-8");
	String memberJSON = request.getParameter("memberJSON");
	if(memberJSON!=null){
		session.setAttribute("member",new UserData(request.getParameter("memberJSON")).getMember());
	}
	session.setAttribute("isAPP", BSapp.isUseApp(request));
	response.sendRedirect("index.jsp");
%>