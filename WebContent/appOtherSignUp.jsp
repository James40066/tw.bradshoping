<%@page import="java.util.HashMap"%>
<%@page import="org.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	session.setAttribute("loginInfo", 
			(HashMap<String,Object>)(
					new JSONObject(
						request.getParameter("otherSignUpInfoJSON"))
							.toMap()));
	response.sendRedirect("registered.jsp");
%>