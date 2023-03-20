<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	HashMap<String, Object> member = (HashMap<String,Object>)session.getAttribute("member");
	if ( member== null) {
		out.println("<script>sendRedirect('login.jsp');</script>");
		return;
	}else if((int)member.get("isseller")==0){
		out.println("<script>sendRedirect('seller.jsp');</script>");
		return;
	}
%>

<form action="#" class="contact_form" method="POST" onsubmit="return onSubmit(this)">
	<div class="form-row">
		<div class="col-md-12 h5 form-group">
			商店資料
		</div>
		<div class="col-md-8 form-group">
			<label>商店名稱</label>
			<input type="text" class="bg-light form-control editInfo" name="storeName" value='${member["storeName"] }' required disabled>
			<small class="form-text text-muted">此名稱將成為消費者瀏覽商品時的商店名稱。</small>
		</div>
		<div class="col-md-8 form-group">
			<label>面交地點</label>
			<input type="text" class="bg-light form-control editInfo" name="faceAddress" value='${member["faceAddress"] }' required disabled>
			<small class="form-text text-muted">將提供消費者選擇面交時的交貨地點。</small>
		</div>
	</div>
	<button class="button contact_button" type="button" id="changeInfo" onclick="editInfo()">
		<span>修改個人資料</span>
	</button>
	<button class="button contact_button" type="submit" id="submitInfo" style="display: none;">
		<span>送出修改</span>
	</button>
</form>
