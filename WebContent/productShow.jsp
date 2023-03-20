<%@page import="java.util.HashMap"%>
<%@page import="bsMain.ProductDataM"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>BradShopping</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="description" content="BradShopping">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- nav -->
<link rel="stylesheet" type="text/css" href="CSS/styles/bootstrap4/bootstrap.min.css">
<link href="CSS/plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="CSS/plugins/OwlCarousel2-2.2.1/owl.carousel.css">
<link rel="stylesheet" type="text/css" href="CSS/plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
<link rel="stylesheet" type="text/css" href="CSS/plugins/OwlCarousel2-2.2.1/animate.css">
<!-- product -->
<link rel="stylesheet" type="text/css" href="CSS/styles/product.css?20191009">
<link rel="stylesheet" type="text/css" href="CSS/styles/product_responsive.css">
<!-- cart -->
<!-- Categories -->
<!-- Checkout -->
<!-- BSmain -->
<link rel="stylesheet" type="text/css" href="CSS/BSmain.css?201909252225">
<link rel="stylesheet" type="text/css" href="CSS/BSproduct.css">
<script src="https://code.jquery.com/jquery-3.4.0.min.js" integrity="sha256-BJeo0qm959uMBGb65z40ejJYGSgR7REI4+CW1fNKwOg=" crossorigin="anonymous"></script>
</head>
<body>
<div class="super_container">

	<%
		request.setCharacterEncoding("utf-8");
			String pid = request.getParameter("product");
			String edit = request.getParameter("edit");
			HashMap<String, Object> member = (HashMap<String, Object>)session.getAttribute("member");
			HashMap<String, Object> productData = null;
			
			if(pid==null){
		response.sendRedirect("productShowNotFound.html");	//PS：回商品導覽
		return;
			}else if(member!=null&&edit!=null){
		productData = new ProductDataM(pid,(int)member.get("id")).getData();
			}else{
		productData = new ProductDataM(pid).getData();
			}
			
			Boolean isEditMode = (Boolean)productData.get("isEditMode");
			if(isEditMode==null){
		request.setAttribute("datas",productData);	
			}else if(isEditMode){
		response.sendRedirect("productShowNotFound.html");	//PS:回產品修改頁面總攬
		return;
			}else{
		response.sendRedirect("productShowNotFound.html");	//PS：回商品導覽
		return;
			}
	%>
	<jsp:include page="View/nav.jsp"></jsp:include>
	<jsp:include page="View/productShowView.jsp"></jsp:include>
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
<script src="CSS/js/product.js"></script>
<!-- cart -->
<!-- Categories -->
<!-- Checkout -->
</body>
</html>