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
	//修改密碼邏輯
	//從UserData.java的member取出資料
	//int id =(int)((HashMap<String,Object>)session.getAttribute("member")).get("id");
	HashMap<String, Object>member = (HashMap<String, Object>) session.getAttribute("member");
	int id=(int)member.get("id");
	//透過拿到pcode
	String pcode = (String) session.getAttribute("pcode");
	//現在時間-(pcode分割字串轉成long的結果)
	boolean timer;
	//抓取表單所填入的值轉換成雜湊值
	String hpw = PwdHash.toHash(request.getParameter("password"));
	
	//new出class
	PwdTest PT=new PwdTest();
	String colName=null;
	if(member!=null){
		colName="id";
		response.sendRedirect(PT.memberCP(hpw, id, colName));
	}else if(timer=System.currentTimeMillis()-(Long.parseLong(pcode.replace("p", "")))<3600000){
		colName="resetpassword";
		response.sendRedirect(PT.pcodeCP(hpw, pcode, colName));
	}else{
		response.sendRedirect("sendemailresetpws.jsp");
	}

%>