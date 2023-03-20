<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
<%
System.out.println("OK");
request.setCharacterEncoding("UTF-8");
String param = request.getParameter("JSON");
if(param!=null){
 out.println(param);
}else{
 out.println("NO param");
}
%>