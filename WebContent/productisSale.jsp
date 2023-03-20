<%@page import="bsMain.ProductAttributesIsSaleM"%>
<%@page import="java.util.HashMap"%>
<%@page import="bsMain.ProductAttributesIsSaleM"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
String edit = request.getParameter("edit");
String issale = request.getParameter("issale");
String product = request.getParameter("product");

ProductAttributesIsSaleM saleMode = null;

HashMap<String, Object> member = (HashMap<String, Object>)session.getAttribute("member");
try{
	if (member!=null&&product!=null) {
		boolean editMode = edit!=null;
		boolean saleClose = issale!=null;
		int pid = Integer.parseInt(product);
		saleMode = new ProductAttributesIsSaleM((int)member.get("id"),pid,saleClose,editMode);
		String url = saleMode.getUrl();
		if(url.equals("seller.jsp")){
			session.setAttribute("callAjaxView", "<script>changeAjaxView('sellerProductList.jsp');</script>");
		}
		response.sendRedirect(url);
		
	}else{
		response.sendRedirect("login.jsp");
		return;
	}
}catch(Exception e){
	
}
%>