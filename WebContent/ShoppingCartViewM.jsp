<%@page import="bsAPI.*"%>
<%@page import="bsMain.*"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//取得session(member)(需要id)
	HashMap<String, Object> member = (HashMap<String, Object>) session.getAttribute("member");
	int id = (int) member.get("id");

	ShoppingCartData sq = new ShoppingCartData(id);
	ResultSet rs1 = sq.getRs();
	int Ordertotal = sq.getTotal();
	request.setAttribute("Ordertotal", Ordertotal);
%>

<!-- 購物車M -->
<style>
.cart_item_name_container {
	padding-left: 20px;
}

.cart_info_col_product {
	width: 52%;
}

.cart_info_col_quantity {
	width: 17%;
	text-align: center;
}

.cart_item_price {
	font-size: 14px;
	font-weight: 400;
	color: #1b1b1b;
	width: auto;
}

@media only screen and (max-width: 991px) {
	.cart_item_product, .cart_item_price, .cart_item_quantity,
		.cart_item_total {
		width: 100%;
		text-align: left;
		padding-bottom: 50px;
	}
	.cart_item_product, .cart_item_price, .cart_item_quantity,
		.cart_item_total {
		width: 100%;
		text-align: center;
		padding-bottom: 50px;
	}
}
</style>
<script>
	function updateCart(count, id, pid, pprice) {
		var item = $(id);
		var itemVal = item.val();
		var itemId = item.attr("id");
		var endVal = 0;

		if (count) {
			endVal = parseFloat(itemVal) + 1;
			item.val(endVal);
			$("#ctotal" + pid).text("總價:" + "$" + (pprice * endVal));
		} else {
			if (itemVal > 1) {
				endVal = parseFloat(itemVal) - 1;
				item.val(endVal);
				$("#ctotal" + pid).text("總價:" + "$" + (pprice * endVal));
			}
		}
		toSql(itemId, endVal, pid);
	}
	function toSql(id, val, pid) {
		$.ajax({
			url : 'ShoppingCartUpdateItem',
			type : 'GET',
			data : {
				"product" : id,
				"quantity" : val
			},
			datatype : "text",
			error : function(error) {
				console.log(error);
			},
			success : function(response) {
				if (response != -1) {
					/*PS:修改資料庫成功~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~寫在這裡*/
					$(".total").text("$" + response);
					if (!isface && isface != null) {
						addShippingtoTotal(60);
					}

				} else {
					/*PS:修改資料庫失敗或發生例外~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~寫在這裡*/
					window.location.href = "ShoppingCart.jsp";
				}
			}
		});
	}

	function cleacar() {
		window.location.href = "ShoppingCartClear.jsp";
	}
</script>

<div class="cart_info BShome">
	<div class="container">
		<div class="row">
			<div class="col">
				<!-- Column Titles -->
				<div class="cart_info_columns clearfix">
					<div class="cart_info_col cart_info_col_product">商品</div>
					<div class="cart_info_col cart_info_col_price">價格</div>
					<div class="cart_info_col cart_info_col_quantity">數量</div>
				</div>
			</div>
		</div>
		<div class="row cart_items_row">
			<div class="col">
				<!-- Cart Item -->
				<%  
				    //用來判斷是否開放面交選項
					CheckShoppingCartSellerIsRepeat cscsir = new CheckShoppingCartSellerIsRepeat();
					//尋訪出資料
					rs1.absolute(0);
					if (rs1.next()) {

						rs1.absolute(0);
						while (rs1.next()) {

							String pid = rs1.getString("pid");
							String pname = rs1.getString("pname");
							int pprice = Integer.parseInt(rs1.getString("pprice"));
							int quantity = Integer.parseInt(rs1.getString("quantity"));
							String big = rs1.getString("big");
							int special = Integer.parseInt(rs1.getString("special"));
							int sellerid = Integer.parseInt(rs1.getString("sellerid"));
							
                            //
							cscsir.AddSellidTOCheckBox(sellerid);

							out.println(
									"<div class='cart_item d-flex flex-lg-row flex-column align-items-lg-center align-items-center justify-content-center'>");
							out.println("<div class='container'>");
							out.println("<div class='row'>");
							out.println("<div class='col-md-3 col-12'>");
							out.println(
									"<div class='cart_item_product d-flex flex-row align-items-center justify-content-center'>");
							out.println("<div class='cart_item_image'>");
							out.println("<div><img src=" + "/productPhoto" + "/" + big + " alt=''></div>");
							out.println("</div>");
							out.println("</div>");
							out.println("</div>");
							out.println("<div class='col-md-3 col-12 align-self-center'>");
							out.println("<div class='cart_item_name_container'>");
							out.println("<div class='cart_item_name'><a href=" + "'" + "productShow.jsp?product=" + pid + "'"
									+ ">" + pname + "</a></div>");
							out.println("</div>");
							out.println("</div>");

							out.println("<div class='col-md-2 col-6 align-self-center'>");
							if (special > 0) {
								out.println(
										"<div class='cart_item_price details_discount'>" + "單價:" + "$" + special + "</div>");
							} else {
								out.println("<div class='cart_item_price' " + ">" + "單價:" + "$" + pprice + "</div>");
							}
							out.println("</div>");

							out.println("<div class='col-md-2 col-6 align-self-center'>");
							out.println("<div class='cart_item_quantity'>");
							out.println("<div class='product_quantity_container'>");
							out.println("<div class='product_quantity clearfix'>");
							out.println("<span>數量</span>");

							out.println("<input id='pid" + pid + "' type='text' pattern='[0-9]*' value=" + "'" + quantity + "'"
									+ ">");

							out.println("<div class='quantity_buttons'>");

							if (special > 0) {
								out.println("<div id='' class='quantity_inc quantity_control' onclick='updateCart( true,pid"
										+ pid + "," + pid + "," + special
										+ ")'><i class='fa fa-chevron-up' aria-hidden='true'></i></div>");
								out.println("<div id='' class='quantity_dec quantity_control' onclick='updateCart( false,pid"
										+ pid + "," + pid + "," + special
										+ ")'><i class='fa fa-chevron-down' aria-hidden='true'></i></div>");

							} else {
								out.println("<div id='' class='quantity_inc quantity_control' onclick='updateCart( true,pid"
										+ pid + "," + pid + "," + pprice
										+ ")'><i class='fa fa-chevron-up' aria-hidden='true'></i></div>");
								out.println("<div id='' class='quantity_dec quantity_control' onclick='updateCart( false,pid"
										+ pid + "," + pid + "," + pprice
										+ ")'><i class='fa fa-chevron-down' aria-hidden='true'></i></div>");

							}

							out.println("<div id='' class='quantity_inc quantity_control' onclick='updateCart( true,pid" + pid
									+ "," + pid + "," + pprice
									+ ")'><i class='fa fa-chevron-up' aria-hidden='true'></i></div>");
							out.println("<div id='' class='quantity_dec quantity_control' onclick='updateCart( false,pid" + pid
									+ "," + pid + "," + pprice
									+ ")'><i class='fa fa-chevron-down' aria-hidden='true'></i></div>");

							out.println("</div>");
							out.println("</div>");
							out.println("</div>");
							out.println("</div>");
							out.println("</div>");

							out.println("<div class='col-md-2 col-12 align-self-center'>");
							if (special > 0) {
								out.println("<div " + "id=" + "'" + "ctotal" + pid + "'" + " style='text-align: center'" + ">"
										+ "總價:" + "$" + (special * quantity) + "</div>");
							} else {
								out.println("<div " + "id=" + "'" + "ctotal" + pid + "'" + " style='text-align: center'" + ">"
										+ "總價:" + "$" + (pprice * quantity) + "</div>");
							}
							out.println("</div>");
							out.println("</div>");
							out.println("</div>");
							out.println("</div>");
						}
						pageContext.setAttribute("isShow", true);
					} else {
						out.print("<div class='BShome'></div>");
						out.print("<div class='main_nav f1'><h1 style='text-align:center'>您的購物車沒有任何商品</h1></div>");
						out.print("<div class='BShome'></div>");
						out.print("<div class='BShome'></div>");
					}
					request.setAttribute("cscsir", cscsir.CheckSellerIsRepeat());

					sq.closeSQL();
				%>
			</div>
		</div>

		<div class="row row_cart_buttons">
			<div class="col">
				<div class="row justify-content-between">
					<div class="col-6 col-md-auto ">
						<div class="button continue_shopping_button">
							<a href="ProductsView.jsp">繼續購物</a>
						</div>
					</div>
					<div class="col-6 col-md-auto">
						<div class="button continue_shopping_button ">
							<a href="#" onclick="cleacar()">清空購物車</a>
						</div>
					</div>
				</div>
			</div>
		</div>
		<c:if test="${!empty isShow }">
			<jsp:include page='View/shoppingCartCheckoutV.jsp'></jsp:include>
		</c:if>
	</div>
</div>