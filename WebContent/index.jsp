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
<link rel="stylesheet" type="text/css"
	href="CSS/styles/main_styles.css?2010101212">
<link rel="stylesheet" type="text/css" href="CSS/styles/responsive.css?10101253">
<!-- product -->
<!-- cart -->
<!-- Categories -->
<!-- Checkout -->
<!-- BSmain -->
<link rel="stylesheet" type="text/css"
	href="CSS/BSmain.css?201910101218">
<script src="https://code.jquery.com/jquery-3.4.0.min.js"
	integrity="sha256-BJeo0qm959uMBGb65z40ejJYGSgR7REI4+CW1fNKwOg="
	crossorigin="anonymous"></script>
</head>
<body>
	<div class="super_container">

		<jsp:include page="View/nav.jsp"></jsp:include>

		<!-- ps:內容 -->
		<!-- Home -->
	    <div class="BShome"></div>
		<!-- Ads -->
		<div class="avds">
			<div
				class="avds_container d-flex flex-lg-row flex-column align-items-start justify-content-between">
				<div class="avds_small">
					<div class="avds_background"
						style="background-image: url(CSS/images/avds_small.jpg)"></div>
					<div class="avds_small_inner">
						<div class="avds_discount_container">
							<img src="CSS/images/discount.png" alt="">
							<div>
								<div class="avds_discount">
									<div>
										20<span>%</span>
									</div>
									<div>Discount</div>
								</div>
							</div>
						</div>
						<div class="avds_small_content">
							<div class="avds_title">HTC-BS</div>
							<div class="avds_link">
								<a href="categories.html">查看詳情</a>
							</div>
						</div>
					</div>
				</div>
				<div class="avds_large">
					<div class="avds_background"
						style="background-image: url(CSS/images/avds_large.jpg)"></div>
					<div class="avds_large_container">
						<div class="avds_large_content">
							<div class="avds_title">專業相機</div>
							<div class="avds_text">搭載功能強大的「Exmor R」 CMOS 感光元件，即使在低光源的環境下，也能完美捕捉清晰銳利、張張精采的照片，動人夜色盡收掌中。</div>
							<div class="avds_link avds_link_large">
								<a href="categories.html">查看詳情</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<br>
		<div class="logo a" style="font-size: 36px; text-align: center">熱門銷售商品</div>
		<!-- 商品頁面include -->
		<jsp:include page="indexM.jsp"></jsp:include>
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
	<script src="CSS/js/custom.js"></script>
	<!-- product -->
	<!-- cart -->
	<!-- Categories -->
	<!-- Checkout -->
</body>
</html>