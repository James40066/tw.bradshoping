<%@page import="org.apache.tomcat.util.http.fileupload.RequestContext"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String account = null;
	String password = null;
	System.out.println("appwrite");
	if (request.getAttribute("act") != null && request.getAttribute("pwd") != null) {

		account = (String) request.getAttribute("act");
		password = (String) request.getAttribute("pwd");

		System.out.println(account);
		System.out.println(password);

		out.println("<script> window.onload = function(){Preferences2.saveLoginInfo(" + "\"" + account + "\""
				+ "," + "\"" + password + "\"" + ");} </script>");

		System.out.println("appwrite over");

	} else if (request.getAttribute("Googleid") != null) {
		String Googleid = (String) request.getAttribute("Googleid");
	} else if (request.getAttribute("Facebookid") != null) {
		String Facebookid = (String) request.getAttribute("Facebookid");
	} else {
		System.out.println("null!!");
	}
%>


