<%@page import="java.util.LinkedList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.CallableStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="bsAPI.Sql"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	pageContext.setAttribute("urlCode", "analysisM.jsp?code="+request.getParameter("code"));
	
%>

<!DOCTYPE html>
<html>
<head>
<title>BradShopping</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="BradShopping">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- nav -->
<link rel="stylesheet" type="text/css"
	href="CSS/styles/bootstrap4/bootstrap.min.css">
<link href="CSS/plugins/font-awesome-4.7.0/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">
<!-- BSmain -->
<link rel="stylesheet" type="text/css" href="CSS/BSmain.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.js"></script>
<script src="https://code.jquery.com/jquery-3.4.0.min.js"
	integrity="sha256-BJeo0qm959uMBGb65z40ejJYGSgR7REI4+CW1fNKwOg="
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<!-- PS：範例 <i class="fa fa-envelope"></i> -->
<!-- https://www.w3schools.com/icons/icons_reference.asp -->
</head>
<body>

	<jsp:include page="${pageScope.urlCode }"/>
	<div class="m-5" id="report">
		<h1 class='text-center'>BS平台銷售報表</h1>
		<div class="pb-3 pt-5">
			<table class="table table-striped table-bordered">
				<thead>
					<tr>
						<th scope="col" class='text-center'>#</th>
						<th scope="col">商品名稱</th>
						<th scope="col" class='text-center'>銷售數量</th>
					</tr>
				</thead>
				<tbody>
					<%
						LinkedList<String> pnameList = (LinkedList<String>) session.getAttribute("pnameList");
						LinkedList<String> tquantityList = (LinkedList<String>) session.getAttribute("tquantityList");
						for (int i = 0; i < pnameList.size(); i++) {
							out.println("<tr>");
							out.println("<th scope='row' class='text-center'>" + (i + 1) + "</th>");
							out.println("<td>" + pnameList.get(i) + "</td>");
							out.println("<td class='text-center'>" + tquantityList.get(i) + "</td>");
							out.println("</tr>");
						}
					%>
				</tbody>
			</table>
		</div>
		<div class="py-3">
			<jsp:include page="View/analysisV.jsp" />
		</div>
	</div>
	<!-- nav -->
	<script src="CSS/js/jquery-3.2.1.min.js"></script>
	<script src="CSS/styles/bootstrap4/popper.js"></script>
	<script src="CSS/styles/bootstrap4/bootstrap.min.js"></script>
</body>
</html>