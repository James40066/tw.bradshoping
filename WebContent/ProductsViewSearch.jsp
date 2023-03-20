<%@page import="jdk.nashorn.api.scripting.JSObject"%>
<%@page import="com.mysql.cj.xdevapi.JsonArray"%>
<%@page import="bsAPI.*"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.*"%>
<%@page import="com.mysql.cj.xdevapi.JsonArray"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//設定
	request.setCharacterEncoding("utf-8");
	response.setContentType("text/html; charset=UTF-8");

	//接收搜尋參數
	String Search = request.getParameter("Search");
	if (Search == null) {
		response.sendRedirect("ProductsView.jsp");
		return;
	}
	String Page = request.getParameter("Page");
	if (Page == null) {
		//如果接收的頁碼參數為NULL就當他預設1
		Page = "1";
	}
%>
<!DOCTYPE html>
<html>
<head>
<title>BradShopping</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css"
	href="CSS/styles/bootstrap4/bootstrap.min.css">
<link href="CSS/plugins/font-awesome-4.7.0/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css"
	href="CSS/plugins/OwlCarousel2-2.2.1/owl.carousel.css">
<link rel="stylesheet" type="text/css"
	href="CSS/plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
<link rel="stylesheet" type="text/css"
	href="CSS/plugins/OwlCarousel2-2.2.1/animate.css">
<link rel="stylesheet" type="text/css" href="CSS/styles/main_styles.css">
<link rel="stylesheet" type="text/css" href="CSS/styles/responsive.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
	href="CSS/BSmain.css?201909252226">
<style type="text/css">
.details_discount {
	display: inline-block;
	font-size: 16px;
	font-weight: 500;
	color: #e95a5a;
	margin-right: 20px;
	text-decoration: line-through;
}

.products {
	width: 100%;
	background: #FFFFFF;
	padding-top: 50px;
	z-index: 2;
}
</style>
<!-- PS：範例 <i class="fa fa-envelope"></i> -->
<!-- https://www.w3schools.com/icons/icons_reference.asp -->
</head>
<body>
	<div class="super_container">

		<!-- 導覽列include -->
		<jsp:include page="View/nav.jsp"></jsp:include>
		<div class='BShome'></div>

		<!-- 商品搜尋結果include -->
		<c:catch var="catchException">
			<jsp:include page="ProductsViewSearchM.jsp">
				<jsp:param name="Search" value="<%=Search%>" />
				<jsp:param name="Page" value="<%=Page%>" />
			</jsp:include>
			<!-- 分頁按鈕include -->
			<jsp:include page="PaginationSearch.jsp">
				<jsp:param name="Search" value="<%=Search%>" />
			</jsp:include>
		</c:catch>
		<%
			if (session.getAttribute("error") != null && (boolean) session.getAttribute("error")) {
				session.removeAttribute("error");
				out.print("<div class='BShome'></div>");
				out.print("<div class='BShome'></div>");
				out.print("<h1 style='text-align:center'>沒有找到您搜尋的商品</h1>");
				out.print("<div class='BShome'></div>");
				out.print("<div class='BShome'></div>");
			}
		%>
		<!-- 頁腳 -->
		<jsp:include page="View/footer.html"></jsp:include>
	</div>
	<script src="CSS/js/jquery-3.2.1.min.js"></script>
	<script src="CSS/styles/bootstrap4/popper.js"></script>
	<script src="CSS/styles/bootstrap4/bootstrap.min.js"></script>
	<script src="CSS/plugins/greensock/TweenMax.min.js"></script>
	<script src="CSS/plugins/greensock/TimelineMax.min.js"></script>
	<script src="CSS/plugins/scrollmagic/ScrollMagic.min.js"></script>
	<script src="CSS/plugins/greensock/animation.gsap.min.js"></script>
	<script src="CSS/plugins/greensock/ScrollToPlugin.min.js"></script>
	<script src="CSS/plugins/OwlCarousel2-2.2.1/owl.carousel.js"></script>
	<script src="CSS/plugins/Isotope/isotope.pkgd.min.js"></script>
	<script src="CSS/plugins/easing/easing.js"></script>
	<script src="CSS/plugins/parallax-js-master/parallax.min.js"></script>
	<script src="CSS/js/custom.js"></script>
</body>
</html>