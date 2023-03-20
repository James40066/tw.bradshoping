<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="bsMain.*"%>
<%@page import="java.util.*"%>
<%
	String tid = request.getParameter("tCode");
	HashMap<String, Object> member = (HashMap<String, Object>) session.getAttribute("member");
	int buyid = (int) member.get("id");

	OrderDetailsM sm = new OrderDetailsM();
	LinkedList<HashMap<String, Object>> OrderDetails = sm.getBuyerOrderDetails(buyid, tid);
%>

<%
	int OrderquantityTotal = 0;
	int OrderPriceTotal = 0;
	int OrderPostTotal = 0;
	String checkName = "";
	String coupon = "";
	boolean Ordertitle = true;
	int discout = 0;
	int status = 0;

	for (HashMap<String, Object> od : OrderDetails) {
		String tdate = (String) od.get("tdate");
		int post = (int) od.get("post");
		String receive = (String) od.get("receive");
		status = (int) od.get("status");
		int quantity = (int) od.get("quantity");
		int unitPrice = (int) od.get("unitPrice");
		String pname = (String) od.get("pname");
		String small = (String) od.get("small");
		String SellerName = (String) od.get("SellerName");
		coupon = od.get("coupon").equals("null") ? "無" : (String) od.get("coupon");
		discout = od.get("discout") != null ? (int) od.get("discout") : 0;
		String storeName = od.get("storeName") != null ? (String) od.get("storeName") : SellerName + "的商店";

		OrderPriceTotal += (unitPrice * quantity);
		OrderquantityTotal += 1;

		if (Ordertitle) {
			out.println("<div class='row border py-3 my-2 bg-dark text-light'>");
			out.println("<div class='col-md-2 col-3 align-self-center text-center'>");
			out.println("<div class='row'>");
			out.println("<div class='col-12 h5'>");
			out.println("</div>");
			out.println("</div>");
			out.println("</div>");
			out.println("<div class='col-md-10 col-9'>");
			out.println("<div class='row'>");
			out.println("<div class='col-md-6'>");
			out.println("<div class='row'>");
			out.println("<div class='col-12'>訂購編號： " + tid + "</div>");
			out.println("<div class='col-12'>交貨方式： " + (post == 0 ? "面交" : "郵寄") + "</div>");
			out.println("<div class='col-12'>優惠券  ：" + coupon + "</div>");
			out.println("</div>");
			out.println("</div>");
			out.println("<div class='col-md-6'>");
			out.println("<div class='row'>");
			out.println("<div class='col-12'>訂購日期： " + tdate + "</div>");
			out.println("<div class='col-12'>訂單狀態： " + (status == 0 ? "未結帳" : "未出貨") + "</div>");
			out.println("<div class='col-12 click' onclick='BSapp.callMap(\""+receive+"\")'>交貨地址： " + receive + "</div>");
			out.println("</div>");
			out.println("</div>");
			out.println("</div>");
			out.println("</div>");
			out.println("</div>");
			Ordertitle = false;
		}

		if (!checkName.equals(storeName)) {
			out.println("<div class='row border py-3 my-2 bg-secondary text-light'>");
			out.println("<div class='col-12 h5 align-self-center text-center'>");
			out.println("<b>" + storeName + "</b>");
			out.println("</div>");
			out.println("</div>");

			checkName = (String) od.get("storeName");
			OrderPostTotal += (post == 0 ? 0 : 60);
		}

		out.println("<div class='row border  py-3 my-2 bg-light text-dark'>");
		out.println("<div class='col-md-2 col-4'>");
		out.println("<img src=" + "'" + "/productPhoto" + "/" + small + "'" + " class='img-fluid'>");
		out.println("</div>");
		out.println("<div class='col-md-10 col-8'>");
		out.println("<div class='row'>");
		out.println("<div class='col-12 h6'>");
		out.println("<b>" + pname + "</b>");
		out.println("</div>");
		out.println("<div class='col-md-6'>購買價格: $" + unitPrice + "</div>");
		out.println("<div class='col-md-6'>購買數量: " + quantity + "</div>");
		out.println("<div class='col-md-6'>小計: $" + (unitPrice * quantity) + "</div>");
		out.println("</div>");
		out.println("</div>");
		out.println("</div>");

	}
	sm.closeSQL();
%>
<!-- 商品OutPrint -->

<!-- 訂單金額總計 -->
<div class="row border  py-3 my-2 bg-light text-dark">
	<div class="col-12 h6">
		<b>訂單明細總計</b>
	</div>
	<div class="col-6">
		<div class="row">
			<div class='col-12'>訂單總品項數量：</div>
			<div class="col-12">商品總計:</div>
			<div class="col-12">郵寄運費:</div>
			<div class="col-12">優惠券折抵:</div>
			<div class="col-12">交易金額:</div>
		</div>
	</div>
	<div class="col-6">
		<div class="row">
			<div class="col-12">
				<%=OrderquantityTotal%>個
			</div>
			<div class="col-12">
				$<%=OrderPriceTotal%></div>
			<div class="col-12">
				$<%=OrderPostTotal%></div>
			<div class="col-12" style="color: red">
				$-<%=discout%></div>
			<div class="col-12">
				$<%=OrderPriceTotal + OrderPostTotal - discout%></div>
		</div>
	</div>
	<!-- 訂單金額總計 -->
	<%
		if (status == 0) {
			out.println("<div class='col-12 btn btn-danger my-3' onclick='checkOut()'>");
			out.println("立刻付款");
			out.println("</div>");
		}
	%>
</div>
<script>
	function checkOut() {
		document.getElementById('checkOut').submit();
	}
</script>
<form action="TransactionSetBlueInfo" method="get" id="checkOut">
	<input type="hidden" name="tCode" value="<%=tid%>">
</form>
