<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
@media only screen and (max-width: 575px) {
	.logo a, .header.scrolled .logo a {
		font-size: 22px;
	}
	.f1 {
		text-align: right;
		font-size: 12px;
		padding-top: 10px;
		padding-right: 5px;
		font-weight: 600;
		color: #767676;
		-webkit-transition: all 200ms ease;
		-moz-transition: all 200ms ease;
		-ms-transition: all 200ms ease;
		-o-transition: all 200ms ease;
		transition: all 200ms ease;
		font-weight: 600;
	}
}

@media only screen and (min-width: 970px) {
	.logo a {
		font-size: 45px;
		font-weight: 700;
		padding-bottom: 10px;
		color: #1b1b1b;
		-webkit-transition: all 200ms ease;
		-moz-transition: all 200ms ease;
		-ms-transition: all 200ms ease;
		-o-transition: all 200ms ease;
		transition: all 200ms ease;
		color: #1b1b1b;
	}
	.f1 {
		text-align: right;
		font-size: 16px;
		padding-top: 10px;
		padding-right: 5px;
		font-weight: 600;
		color: #767676;
		-webkit-transition: all 200ms ease;
		-moz-transition: all 200ms ease;
		-ms-transition: all 200ms ease;
		-o-transition: all 200ms ease;
		transition: all 200ms ease;
		font-weight: 600;
	}
}

.f1 {
	text-align: right;
	font-size: 16px;
	padding-top: 10px;
	padding-right: 5px;
	font-weight: 600;
	color: #767676;
	-webkit-transition: all 200ms ease;
	-moz-transition: all 200ms ease;
	-ms-transition: all 200ms ease;
	-o-transition: all 200ms ease;
	transition: all 200ms ease;
	font-weight: 600;
	font-family: 'Poppins','Microsoft YaHei', sans-serif;
}

.menu_container {
	width: 100%;
	height: 0px;
	padding-top: 40px;
}

.header_content {
	width: 100%;
	height: 60px;
	-webkit-transition: all 200ms ease;
	-moz-transition: all 200ms ease;
	-ms-transition: all 200ms ease;
	-o-transition: all 200ms ease;
	transition: all 200ms ease;
}

.header.scrolled .header_content {
	height: 30px;
}

@media only screen and (max-width: 575px) {
	.header_content {
		height: 30px;
	}
	.page_menu_item>a, .page_menu_selection li a {
		font-size: 13px;
		height: 6vh;
		line-height: 8vh;
	}
	.page_menu_selection li:last-child {
		padding-bottom: 0px;
	}
}

.search_input {
	width: 150px;
	height: 40px;
	border: none;
	outline: none;
	border-radius: 3px;
	padding-left: 20px;
}
</style>
<script>
$(document).ready(function(){
  
  $(".buys").click(function(){
	$(".bs1").show();
    $(".ss1").hide();
    });
    
  $(".sells").click(function(){
    $(".bs1").hide();
    $(".ss1").show();
    });
  
  });
</script>
<header class="header">
	<div class="header_container">
		<div class="container">
			<div class="row">
				<div class="col-md-4 col-6 align-self-end">
					<div class="row justify-content-center align-items-center">
						<div class="logo">
							<a href="index.jsp">BradShopping</a>
						</div>
					</div>
				</div>
				<div class="col-md-8 col-6">
					<div class="row justify-content-end">
						<div class='f1'>
							<%
								if (session.getAttribute("member") != null) {
									out.println("您好,");
								}
							%>
							${member.name}
						</div>
					</div>
					<div class="row">
						<div
							class="header_content d-flex flex-row align-items-center justify-content-start">
							<nav class="main_nav">
								<ul>
									<li><a href="index.jsp">首頁</a></li>
									<li><a href="">關於我們</a></li>
									<li><a href="ProductsView.jsp">商品導覽</a></li>
									<%
										if (session.getAttribute("member") == null) {
											out.println("<li><a href='login.jsp'>登入</a></li>");
										} else {
											out.println("<li><a href='buyer.jsp?view=buyerV'>會員中心</a></li>");
											out.println("<li><a href='logout.jsp'>登出</a></li>");
										}
									%>
								</ul>
							</nav>

							<div class="header_extra ml-auto">
								<div class="shopping_cart">
									<a href="ShoppingCart.jsp"> <svg version="1.1"
											xmlns="http://www.w3.org/2000/svg"
											xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
											viewBox="0 0 489 489"
											style="enable-background: new 0 0 489 489;"
											xml:space="preserve">
											<g>
												<path
												d="M440.1,422.7l-28-315.3c-0.6-7-6.5-12.3-13.4-12.3h-57.6C340.3,42.5,297.3,0,244.5,0s-95.8,42.5-96.6,95.1H90.3
													c-7,0-12.8,5.3-13.4,12.3l-28,315.3c0,0.4-0.1,0.8-0.1,1.2c0,35.9,32.9,65.1,73.4,65.1h244.6c40.5,0,73.4-29.2,73.4-65.1
													C440.2,423.5,440.2,423.1,440.1,422.7z M244.5,27c37.9,0,68.8,30.4,69.6,68.1H174.9C175.7,57.4,206.6,27,244.5,27z M366.8,462
													H122.2c-25.4,0-46-16.8-46.4-37.5l26.8-302.3h45.2v41c0,7.5,6,13.5,13.5,13.5s13.5-6,13.5-13.5v-41h139.3v41
													c0,7.5,6,13.5,13.5,13.5s13.5-6,13.5-13.5v-41h45.2l26.9,302.3C412.8,445.2,392.1,462,366.8,462z" />
											</g>
										</svg>
										<div>
											Cart <span></span>
										</div>
									</a>
								</div>
								<div class="search">
									<div class="search_icon">
										<svg version="1.1" id="Capa_1"
											xmlns="http://www.w3.org/2000/svg"
											xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
											viewBox="0 0 475.084 475.084"
											style="enable-background: new 0 0 475.084 475.084;"
											xml:space="preserve">
										<g>
											<path
												d="M464.524,412.846l-97.929-97.925c23.6-34.068,35.406-72.047,35.406-113.917c0-27.218-5.284-53.249-15.852-78.087
												c-10.561-24.842-24.838-46.254-42.825-64.241c-17.987-17.987-39.396-32.264-64.233-42.826
												C254.246,5.285,228.217,0.003,200.999,0.003c-27.216,0-53.247,5.282-78.085,15.847C98.072,26.412,76.66,40.689,58.673,58.676
												c-17.989,17.987-32.264,39.403-42.827,64.241C5.282,147.758,0,173.786,0,201.004c0,27.216,5.282,53.238,15.846,78.083
												c10.562,24.838,24.838,46.247,42.827,64.234c17.987,17.993,39.403,32.264,64.241,42.832c24.841,10.563,50.869,15.844,78.085,15.844
												c41.879,0,79.852-11.807,113.922-35.405l97.929,97.641c6.852,7.231,15.406,10.849,25.693,10.849
												c9.897,0,18.467-3.617,25.694-10.849c7.23-7.23,10.848-15.796,10.848-25.693C475.088,428.458,471.567,419.889,464.524,412.846z
												 M291.363,291.358c-25.029,25.033-55.148,37.549-90.364,37.549c-35.21,0-65.329-12.519-90.36-37.549
												c-25.031-25.029-37.546-55.144-37.546-90.36c0-35.21,12.518-65.334,37.546-90.36c25.026-25.032,55.15-37.546,90.36-37.546
												c35.212,0,65.331,12.519,90.364,37.546c25.033,25.026,37.548,55.15,37.548,90.36C328.911,236.214,316.392,266.329,291.363,291.358z
												" />
										</g>
									</svg>
									</div>
								</div>
								<div class="hamburger">
									<i class="fa fa-bars" aria-hidden="true"></i>
								</div>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>
	</div>

	<!-- Search Panel -->
	<div class="search_panel trans_300">
		<div class="container">
			<div class="row">
				<div class="col">
					<div class="search_panel_content d-flex flex-row align-items-center justify-content-end">
						<form action="ProductsViewSearch.jsp">
							<input type="text" class="search_input" placeholder="Search"
								required="required" name="Search">
							<button type="submit" class="btn btn-outline-dark">搜尋</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Social -->
</header>

<!-- Menu -->

<div class="menu menu_mm trans_300">
	<div class="menu_container menu_mm">
		<div class="page_menu_content">

			<div class="page_menu_search menu_mm">
				<form action="#">
					<input type="search" required="required"
						class="page_menu_search_input menu_mm"
						placeholder="Search for products...">
				</form>
			</div>
			<ul class="page_menu_nav menu_mm">
				<li class="page_menu_item"><a href="index.jsp">Home<i
						class="fa fa-angle-down"></i></a></li>
				<li class="page_menu_item"><a href="#">關於我們<i
						class="fa fa-angle-down"></i></a></li>
				<li class="page_menu_item menu_mm"><a href="ProductsView.jsp">商品導覽<i
						class="fa fa-angle-down"></i></a></li>
				<%
					if (session.getAttribute("member") == null) {
						out.println(
								"<li class='page_menu_item menu_mm'><a href='login.jsp'>登入<i class='fa fa-angle-down'></i></a></li>");
					} else {
						out.println("<li class='page_menu_item has-children menu_mm buys'>");
						out.println("<a href=''>買家系統<i class='fa fa-angle-down'></i></a>");

						out.println("<ul class='page_menu_selection menu_mm bs1'>");
						out.println(
								"<li class='page_menu_item menu_mm'><a href='buyer.jsp?view=buyerV'>訂單查詢<i class='fa fa-angle-down'></i></a></li>");
						out.println(
								"<li class='page_menu_item menu_mm'><a href='#'>歷史訂單<i class='fa fa-angle-down'></i></a></li>");
						out.println(
								"<li class='page_menu_item menu_mm'><a href='buyer.jsp?view=buyerInfo'>個人資料<i class='fa fa-angle-down'></i></a></li>");
						out.println(
								"<li class='page_menu_item menu_mm'><a href='buyer.jsp?view=buyerPwd'>變更密碼<i class='fa fa-angle-down'></i></a></li>");
						out.println(
								"<li class='page_menu_item menu_mm'><a href='#'>買家須知<i class='fa fa-angle-down'></i></a></li>");
						out.println("</ul></li>");

						out.println("<li class='page_menu_item has-children menu_mm sells'>");
						out.println("<a href=''>賣家系統<i class='fa fa-angle-down'></i></a>");

						out.println("<ul class='page_menu_selection menu_mm ss1'>");
						out.println(
								"<li class='page_menu_item menu_mm'><a href='seller.jsp?view=sellerV'>訂單查詢<i class='fa fa-angle-down'></i></a></li>");
						out.println(
								"<li class='page_menu_item menu_mm'><a href='#'>歷史訂單<i class='fa fa-angle-down'></i></a></li>");
						out.println(
								"<li class='page_menu_item menu_mm'><a href='seller.jsp?view=sellerProductAddV'>新增商品<i class='fa fa-angle-down'></i></a></li>");
						out.println(
								"<li class='page_menu_item menu_mm'><a href='seller.jsp?view=sellerProductList'>商品管理<i class='fa fa-angle-down'></i></a></li>");
						out.println(
								"<li class='page_menu_item menu_mm'><a href='seller.jsp?view=sellerInfo'>商店資訊<i class='fa fa-angle-down'></i></a></li>");
						out.println(
								"<li class='page_menu_item menu_mm'><a href='seller.jsp?view=analysis'>銷售分析<i class='fa fa-angle-down'></i></a></li>");
						out.println(
								"<li class='page_menu_item menu_mm'><a href='#'>賣家須知<i class='fa fa-angle-down'></i></a></li>");
						out.println("</ul></li>");

						out.println(
								"<li class='page_menu_item menu_mm'><a href='logout.jsp'>登出<i class='fa fa-angle-down'></i></a></li>");
					}
				%>
			</ul>
		</div>
	</div>

	<div class="menu_close">
		<i class="fa fa-times" aria-hidden="true"></i>
	</div>

	<div class="menu_social">
		<ul>
			<li><a href="#"><i class="fa fa-pinterest"
					aria-hidden="true"></i></a></li>
			<li><a href="#"><i class="fa fa-instagram"
					aria-hidden="true"></i></a></li>
			<li><a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a></li>
			<li><a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a></li>
		</ul>
	</div>
</div>