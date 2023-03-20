<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.*"%>
<%
	HashMap<String, Object> member = (HashMap<String, Object>) session.getAttribute("member");

	if (member == null) {
		response.sendRedirect("login.jsp");
		return;
	}
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
<link rel="stylesheet" type="text/css"
	href="CSS/plugins/OwlCarousel2-2.2.1/owl.carousel.css">
<link rel="stylesheet" type="text/css"
	href="CSS/plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
<link rel="stylesheet" type="text/css"
	href="CSS/plugins/OwlCarousel2-2.2.1/animate.css">
<!-- product -->
<!-- cart -->
<link rel="stylesheet" type="text/css" href="CSS/styles/cart.css?20191009">
<link rel="stylesheet" type="text/css"
	href="CSS/styles/cart_responsive.css">
<!-- Categories -->
<!-- Checkout -->
<!-- Contact -->
<!-- BSmain -->
<link rel="stylesheet" type="text/css" href="CSS/BSmain.css?20191009">
<script src="https://code.jquery.com/jquery-3.4.0.min.js"
	integrity="sha256-BJeo0qm959uMBGb65z40ejJYGSgR7REI4+CW1fNKwOg="
	crossorigin="anonymous"></script>
<style type="text/css">
.details_discount {
	display: inline-block;
	color: #e95a5a;
}
</style>
</head>
<body>
	<div class="super_container">

		<jsp:include page="View/nav.jsp"></jsp:include>

		<!-- ps:內容 -->
		<jsp:include page="ShoppingCartViewM.jsp"></jsp:include>
        <jsp:include page="View/footer.html"></jsp:include>
	</div>

	<!-- nav -->
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
	<!-- product -->
	<!-- cart -->
	<script src="CSS/js/cart.js?20191009"></script>
	<!-- Categories -->
	<!-- Checkout -->
	<!-- Contact -->
</body>
</html>