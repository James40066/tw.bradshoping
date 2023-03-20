<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
    <%
	    request.setCharacterEncoding("utf-8");
    	HashMap<String, Object> member = (HashMap<String,Object>)session.getAttribute("member");
	    if(member==null){
	    	response.sendRedirect("login.jsp");
	    	return;
		}else if((int)member.get("isseller")==0){
			session.setAttribute("callAjaxView", "<script>changeAjaxView('buyerSRSeller.jsp');</script>");
			response.sendRedirect("buyer.jsp");
			return;
	    }
	    String view = request.getParameter("view");
	    if(view!=null){
	    	session.setAttribute("callAjaxView", "<script>changeAjaxView('"+view+".jsp');</script>");
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
<link rel="stylesheet" type="text/css" href="CSS/styles/bootstrap4/bootstrap.min.css">
<link href="CSS/plugins/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="CSS/plugins/OwlCarousel2-2.2.1/owl.carousel.css">
<link rel="stylesheet" type="text/css" href="CSS/plugins/OwlCarousel2-2.2.1/owl.theme.default.css">
<link rel="stylesheet" type="text/css" href="CSS/plugins/OwlCarousel2-2.2.1/animate.css">
<!-- product -->
<!-- cart -->
<!-- Categories -->
<!-- Checkout -->
<!-- Contact -->
<link rel="stylesheet" type="text/css" href="CSS/styles/contact.css">
<link rel="stylesheet" type="text/css" href="CSS/styles/contact_responsive.css">
<!-- BSmain -->
<link rel="stylesheet" type="text/css" href="CSS/BSmain.css?20191009">
<script src="CSS/BSjs/buyer.js?201910172156"></script>
<script src="https://kit.fontawesome.com/4e76dc4904.js"></script>
<script src="https://code.jquery.com/jquery-3.4.0.min.js" integrity="sha256-BJeo0qm959uMBGb65z40ejJYGSgR7REI4+CW1fNKwOg=" crossorigin="anonymous"></script>
<!--chartjs CDN-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.js"></script>
</head>
<body>
<div class="super_container">

	<jsp:include page="View/nav.jsp"></jsp:include>

	<!-- ps:內容 -->
	
	
	
</div>
<div class="super_container">

		<jsp:include page="View/nav.jsp"></jsp:include>

		<!-- ps:內容 -->
		<jsp:useBean id="memberItems" class="bsMain.MemberItems"></jsp:useBean>
		<jsp:setProperty name="memberItems" property="isBuyer" value="false"></jsp:setProperty>
		<jsp:setProperty name="memberItems" property="id" value="${member.id }"></jsp:setProperty>
		<c:set scope="session" var="datas" value="${memberItems.datas }"></c:set> 
		
		<div class="contact BShome">
			<div class="container">
				<div class="row">
					<div class="col-lg-9 contact_col">
					<!-- 左側內容-->
						<span id="ajaxView"></span>
					</div>
					<!-- 右側 nav Child -->
					<jsp:include page="View/navSeller.jsp"></jsp:include>
				</div>
			</div>
		</div>
	</div>
	${sessionScope.callAjaxView }<%session.removeAttribute("callAjaxView"); %>
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
<!-- Categories -->
<!-- Checkout -->
<!-- Contact -->
<script src="CSS/js/contact.js"></script>
</body>
</html>