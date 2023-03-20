<%@page import="com.braintreegateway.Request"%>
<%@page import="java.util.HashMap"%>
<%@page import="bsMain.Transaction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//接收藍新訂單回傳的response
	String Status = request.getParameter("Status");
	String MerchantID = request.getParameter("MerchantID");
	String TradeInfo = request.getParameter("TradeInfo");
	String url = null;
	//request.getRequestDispatcher("ShoppingCartClear.jsp").include(request, response);
	
	//交易狀態判斷
	if (Status!=null && Status.equals("SUCCESS")) {
		HashMap<String, Object> blueInfo = (HashMap<String, Object>) session.getAttribute("blueInfo");
		String tid = (String)blueInfo.get("tid");
		String tidNew = (String)blueInfo.get("tidNew");
		//Transaction的static方法updateLastOrderNo(),用於更新在SQL中的訂單編號
		Transaction.updateLastOrderNo(tid,tidNew);
		url = "TransactionCompletion.jsp";
	} else {
		url = "buyer.jsp";
	}
	request.getRequestDispatcher("ShoppingCartClear.jsp").include(request, response);
	//將我的"ShoppingCartClear.jsp"給incloud進來,進行清空購物車
	session.removeAttribute("blueInfo");
	//依照交易的結果而轉入不同的頁面
	response.sendRedirect(url);
%>
