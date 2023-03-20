<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
    boolean isAPP = session.getAttribute("isAPP")!=null?(boolean) session.getAttribute("isAPP"):false;
    session.invalidate();
	if (isAPP) {
		//session.setAttribute("removeLoginInfo", "<script> Interface.removeLoginInfo();</script>");
	} 
	response.sendRedirect("index.jsp");
%>