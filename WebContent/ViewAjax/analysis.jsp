<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
	request.setCharacterEncoding("utf-8");
	if (session.getAttribute("member") == null) {
		response.sendRedirect("login.jsp");
		return;
	}
%>
<body>
	<jsp:include page="../analysisM.jsp"></jsp:include>
	<span id="ajaxView"><jsp:include page="../View/analysisV.jsp"></jsp:include></span>

	${sessionScope.callAjaxView }<%session.removeAttribute("callAjaxView"); %>
</body>