<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	HashMap<String, Object> member = (HashMap<String,Object>)session.getAttribute("member");
	if ( member== null) {
		out.println("<script>sendRedirect('login.jsp');</script>");
		return;
	}else if((int)member.get("isseller")!=0){
		out.println("<script>sendRedirect('seller.jsp?view=sellerV');</script>");
		return;
	}
%>

<form action="buyerSRSellerM.jsp" class="contact_form" method="POST" onsubmit="return onSubmit(this)">
	<div class="form-row">
		<div class="col-md-12 h5 form-group">
			啟用個人商店
		</div>
		<div class="col-md-8 form-group">
			<label>請輸入商店名稱</label>
			<input type="text" class="bg-light form-control" name="storeName" required>
			<small class="form-text text-muted">此名稱將成為消費者瀏覽商品時的商店名稱。</small>
		</div>
		<div class="col-md-8 form-group">
			<label>面交地點</label>
			<input type="text" class="bg-light form-control" name="faceAddress" required>
			<small class="form-text text-muted">將提供消費者選擇面交時的交貨地點。</small>
		</div>
	</div>
	<button class="button contact_button" type="submit">
		<span>送出修改</span>
	</button>
</form>
