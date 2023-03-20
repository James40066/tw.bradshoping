<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("utf-8");
	if (session.getAttribute("member") == null) {
		response.sendRedirect("login.jsp");
		return;
	}
%>

<form action="buyerInfoM.jsp" class="contact_form">
	<div class="form-row">
		<div class="col-md-12 h5 form-group">
			個人資料
		</div>
		<div class="col-md-8 form-group">
			<label>姓名</label>
			<input type="text" class="editInfo bg-light form-control" name="name" value='${sessionScope.member["name"] }' required disabled>
		</div>
		<div class="col-md-6 form-group">
			<label>生日</label>
			<input type="text" class="bg-light form-control" value='${sessionScope.member["birthday"] }' disabled>
		</div>
		<div class="col-md-6 form-group">
			<label>連絡電話</label>
			<input type="text" class="editInfo bg-light form-control" name="tel" value='${sessionScope.member["tel"] }' placeholder="請填寫手機號碼" required disabled>
		</div>
		<div class="col-md-12 form-group">
			<label>收貨地址</label>
			<input type="text" class="editInfo bg-light form-control" name="address" value='${sessionScope.member["address"] }' placeholder="請填寫常用收貨地址" required disabled>
		</div>
		<div class="col-md-12 form-group">
			<label>電子信箱</label>
			<input type="text" class="bg-light form-control" value='${sessionScope.member["account"] }' disabled>
		</div>
	</div>
	<button class="button contact_button" type="button" id="changeInfo" onclick="editInfo()">
		<span>修改個人資料</span>
	</button>
	<button class="button contact_button" type="submit" id="submitInfo" style="display: none;">
		<span>送出修改</span>
	</button>
</form>
