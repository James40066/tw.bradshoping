<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="bsMain.*"%>
<%@page import="java.util.*"%>
<%@page import="com.berry.*"%>
<%@page import="org.json.JSONObject"%>

<%
 Object member=session.getAttribute("member");
 out.print("member:"+(member==null)+":"+(String)member);
%>


