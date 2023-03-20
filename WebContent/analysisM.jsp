<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="bsAPI.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%
	HashMap<String,Object> member = (HashMap<String,Object>)session.getAttribute("member"); 
	int userId= 0;
	if(member!=null){
		userId=(int)member.get("id");
	}else{
		userId = Integer.parseInt(request.getParameter("code").substring(3, 4));
	}
	 
	Sql sql = null;
	Connection conn = null;
	CallableStatement call = null;
	try{
		//拿到sql物件實體
		sql=new Sql();
		//串流
		conn=sql.conn();
		
		//prepareCall是呼叫Stored Procedures用
		//prepareStatement是直接裝sql語法用
		call=conn.prepareCall("{call totalPquantity(?)}");
		call.setInt(1, userId);
		
		//executeQuery(執行上面的sql)拿到值
		ResultSet rs=call.executeQuery();
		String pname=null;
		String tquantity=null;
		
		//利用while將拿到的資料放進資料結構
		LinkedList<String> Pname =new LinkedList<String>();
		LinkedList<String> Tquantity =new LinkedList<String>();
		while(rs.next()){
			//拿到rs的value
			pname=rs.getString("pname");
			tquantity=rs.getString("tquantity");
			//將rs拿到的資料丟進LinkedList裡面
			Pname.add(pname);
			Tquantity.add(tquantity);
		}

		//種session方便analysisV使用
		session.setAttribute("pnameList", Pname);
		session.setAttribute("tquantityList", Tquantity);
		
		conn.close();
		sql.closeSql();
	}catch(Exception e){
		System.err.println(e.toString()+":analysisM");
		if(conn!=null){
			try{
				conn.close();
				sql.closeSql();
			}catch(Exception e1){}
		}
	}
%>