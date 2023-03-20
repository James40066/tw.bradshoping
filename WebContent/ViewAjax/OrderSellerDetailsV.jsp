<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="bsMain.*"%>
<%@page import="java.util.*"%>
<%
	String tid = request.getParameter("tCode");
	HashMap<String, Object> member = (HashMap<String, Object>) session.getAttribute("member");
	int sellerid = (int) member.get("id");

	OrderDetailsM sm = new OrderDetailsM();
	HashMap<String, Object> OrderDetails = sm.getSellerOrderDetails(tid);
	LinkedList<HashMap<String, Object>> Products = sm.getSellerOrderDetailsProduct(tid, sellerid);
	//預先計算出訂單金額明細
	//
	int Postage = 0;
	if ((int) OrderDetails.get("post") == 0) {
		Postage = 0;
	} else {
		Postage = 60;
	}
	int OrderProductTotal = sm.getSellerOrderProductTotal();
	int ProductQuantity = sm.getSellerProductQuantity();
%>

<div class="row border py-3 my-2 bg-light text-dark">
	<div class="col-md-2 col-3 align-self-center text-center">
		<div class="row">
			<div class="col-12 h5">
				<b><%=(int) OrderDetails.get("status") == 0 ? "未結帳" : "待出貨"%></b>
			</div>
		</div>
	</div>
	<div class="col-md-10 col-9">
		<div class="row">
			<div class="col-md-6">
				<div class="row">
					<div class="col-12">
						訂購編號：<%=tid%></div>
					<div class="col-12">
						訂購日期：<%=(String) OrderDetails.get("tdate")%></div>
					<div class="col-12">
						買家姓名：<%=(String) OrderDetails.get("name")%></div>
					<div class="col-12">
						品項數量：<%=ProductQuantity%></div>
				</div>
			</div>
			<div class="col-md-6">
				<div class="row">
					<div class="col-12">
						交貨方式：<%=(int) OrderDetails.get("post") == 0 ? "面交" : "郵寄"%></div>
					<div class="col-12">
						交貨費用：<%=Postage%></div>
					<div class="col-12">
						交貨地址：<%=(String) OrderDetails.get("receive")%></div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- PS身體 -->
<!-- 商品OutPrint -->
<%
	for (HashMap<String, Object> Product : Products) {

		String small = (String) Product.get("small");
		String pname = (String) Product.get("pname");
		int unitPrice = (int) Product.get("unitPrice");
		int quantity = (int) Product.get("quantity");

		out.print("<div class='row border  py-3 my-2 bg-light text-dark'>");
		out.print("<div class='col-md-2 col-4'>");
		out.print("<img src=" + "'" + "/productPhoto" + "/" + small + "'" + " class='img-fluid'>");
		out.print("</div>");
		out.print("<div class='col-md-10 col-8'>");
		out.print("<div class='row'>");
		out.print("<div class='col-12 h6'>");
		out.print("<b>" + pname + "</b>");
		out.print("</div>");
		out.print("<div class='col-md-6'>購買價格: $" + unitPrice + "</div>");
		out.print("<div class='col-md-6'>購買數量: " + quantity + "</div>");
		out.print("<div class='col-md-6'>小計: $" + (unitPrice * quantity) + "</div>");
		out.print("</div>");
		out.print("</div>");
		out.print("</div>");
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
			<div class="col-12">商品總計:</div>
			<div class="col-12">郵寄運費:</div>
			<div class="col-12">交易金額:</div>
		</div>
	</div>
	<div class="col-6">
		<div class="row">
			<div class="col-12">
				$<%=OrderProductTotal%></div>
			<div class="col-12">
				$<%=(int) OrderDetails.get("post") == 0 ? "0" : "60"%></div>
			<div class="col-12">
				$<%=OrderProductTotal + ((int) OrderDetails.get("post") == 0 ? 0 : 60)%></div>
		</div>
	</div>
	<!-- 訂單金額總計 -->
</div>
