<%@page import="bsMain.CheckShoppingCartSellerIsRepeat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!-- Delivery -->
<script>
	var itemsNum =
<%=(int) request.getAttribute("cscsir") * 60%>
	;
	var isface = null;
	function transaction() {
		if (isface != null) {
			$("#transaction").submit();
		}
	}
	function checkAddress() {
		if (isface || $("#receive").val() != "") {
			return true;
		} else {
			$("#receive").focus();
			return false;7
		}
	}
	function addShippingtoTotal(fee) {
		var total = $(".Ordertotal");
		var newPrice = parseInt(total.text().replace("$", "")) + fee;
		total.text("$" + newPrice);
	}

	$(function() {
		$("#post").click(function() {
			if (isface || isface == null) {
				addShippingtoTotal(itemsNum);
			}
			$("#receive").slideDown();
			$("#receive").attr("required", "required");
			$("#shippingFee").text("$" + itemsNum);
			isface = false;
		})
		$("#face").click(function() {
			if (!isface && isface != null) {
				addShippingtoTotal(-itemsNum);
			}
			$("#receive").slideUp();
			$("#receive").val("");
			$("#receive").attr("required", "");
			$("#shippingFee").text("免費");
			isface = true;
		})
	})
</script>

<form action="TransactionStart" method="post" id="transaction"
	onsubmit="return checkAddress()">
	<div class="row row_extra">
		<div class="col-lg-4">
			<div class="delivery">
				<div class="section_title">寄送方式</div>
				<div class="section_subtitle">請選擇寄送方式</div>
				<div class="delivery_options">
					<c:if test="${cscsir==1 }">
						<label class="delivery_option clearfix" id="face">面交 <input
							type="radio" name="post" value="0"> <span
							class="checkmark"></span> <span class="delivery_price"></span>
						</label>
					</c:if>
					<label class="delivery_option clearfix" id="post">郵寄 <input
						type="radio" name="post" value="1"> <span
						class="checkmark"></span> <span class="delivery_price">$${cscsir*60
							}</span>
					</label> <input type="text" class="coupon_input" id="receive"
						placeholder="請填寫收貨地址" name="receive" style="display: none;">
				</div>
			</div>

			<!-- Coupon Code -->
			<div class="coupon">
				<div class="section_title">優惠券序號</div>
				<div class="section_subtitle"><a href="#">查看活動</a></div>
				<div class="coupon_form_container">
					<input type="text" class="coupon_input" placeholder="請輸入序號">
					<button class="button coupon_button">
						<span>送出</span>
					</button>
				</div>
			</div>
		</div>

		<div class="col-lg-6 offset-lg-2">
			<div class="cart_total">
				<div class="section_title">購物車總額</div>
				<div class="section_subtitle">請確認金額是否符合</div>
				<div class="cart_total_container">
					<ul>
						<li
							class="d-flex flex-row align-items-center justify-content-start">
							<div class="cart_total_title">小計</div>
							<div class="cart_total_value ml-auto total">$ ${ requestScope.Ordertotal }</div>
						</li>
						<li
							class="d-flex flex-row align-items-center justify-content-start">
							<div class="cart_total_title">運費</div>
							<div class="cart_total_value ml-auto" id="shippingFee">請選擇左方取貨方式</div>
						</li>
						<li
							class="d-flex flex-row align-items-center justify-content-start">
							<div class="cart_total_title">總額</div>
							<div class="cart_total_value ml-auto total Ordertotal" id="total">$
								${ requestScope.Ordertotal }</div>
						</li>
					</ul>
				</div>
				<div class="button checkout_button">
					<a onclick="transaction()">立刻刷卡結帳</a>
				</div>
			</div>
		</div>
	</div>
</form>