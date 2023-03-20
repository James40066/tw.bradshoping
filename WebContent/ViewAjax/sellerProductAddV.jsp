<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
	request.setCharacterEncoding("utf-8");
	HashMap<String, Object> member = (HashMap<String, Object>) session.getAttribute("member");
	if (member == null) {
		out.println("<script>sendRedirect('login.jsp');</script>");
		return;
	} else if ((int) member.get("isseller") == 0) {
		out.println("<script>sendRedirect('seller.jsp');</script>");
		return;
	}
%>

<script>
	$(function() {
		var addCount = 0;
		$("#addformat")
				.click(
						function() {
							addCount++;
							$("#addformatDiv")
									.append(
											"<div id='ns"+addCount+"' class='form-row'>"
													+ "<div class='col-5'>"
													+ "<input type='text' name='addFormatKey' class='form-control' placeholder='規格名稱  ex:材質' required>"
													+ "</div>"
													+ "<div class='col-5'>"
													+ "<input type='text' name='addFormatValue' class='form-control' placeholder='規格內容  ex:純棉' required>"
													+ "</div>"
													+ "<div class='col-2'><button type='button' class='btn btn-danger' onclick='deleAddSbj(ns"
													+ addCount
													+ ")'>刪除</button></div>"
													+ "</div>");
						});
	})

	function deleAddSbj(id) {
		id.remove();
	}
	
	function showloading() {
		$('.contact_form').hide();
		$('#displayloading').show();
		return true;
	}
</script>

<form action="ProductUploadM" class="contact_form" onsubmit="return showloading()" method="POST"
	enctype="multipart/form-data">
	<div class="form-row">
		<div class="col-md-12 h5 form-group">新增商品</div>
		<div class="col-md-12 form-group">
			<label>商品名稱</label> <input type="text"
				class="bg-light form-control editInfo" name="pname" size="100"
				maxlength="50" placeholder="買家瀏覽商品名稱" required>
		</div>
		<div class="col-sm-6 form-group">
			<label>商品單價</label> <input type="text"
				class="bg-light form-control editInfo" name="pprice"
				pattern="^\+?[1-9][0-9]*$" placeholder="請填寫單價，1~100萬元之間" required>
		</div>
		<div class="col-sm-6 form-group">
			<label>商品庫存</label> <input type="text"
				class="bg-light form-control editInfo" name="pquantity"
				pattern="^\+?[1-9][0-9]*$" placeholder="庫存需要至少1個" required>
		</div>
		<div class="col-sm-6 form-group">
			<label>商品品牌</label> <input type="text"
				class="bg-light form-control editInfo" name="pbrand"
				placeholder="請填寫商品品牌" required>
		</div>
		<div class="col-sm-6 form-group">
			<label>出貨地</label> 
			<select name="wherePost" class="form-control" required>
				<option selected id="s1" value="1">基隆市</option>
				<option id="s2" value="2">台北市</option>
				<option id="s3" value="3">新北市</option>
				<option id="s4" value="4">桃園市</option>
				<option id="s5" value="5">新竹市</option>
				<option id="s6" value="6">新竹縣</option>
				<option id="s7" value="7">苗栗縣</option>
				<option id="s8" value="8">台中市</option>
				<option id="s9" value="9">彰化縣</option>
				<option id="s10" value="10">南投縣</option>
				<option id="s11" value="11">雲林縣</option>
				<option id="s12" value="12">嘉義市</option>
				<option id="s13" value="13">嘉義縣</option>
				<option id="s14" value="14">台南市</option>
				<option id="s15" value="15">高雄市</option>
				<option id="s16" value="16">屏東縣</option>
				<option id="s17" value="17">宜蘭縣</option>
				<option id="s18" value="18">花蓮縣</option>
				<option id="s19" value="19">台東縣</option>
				<option id="s20" value="20">澎湖縣</option>
				<option id="s21" value="21">金門縣</option>
				<option id="s22" value="22">連江縣</option>
				<option id="s22" value="23">海外地區</option>
			</select>
		</div>
		<div class="col-md-12 form-group">
			<div class="form-row">
				<button type="button" id="addformat"
					class="btn btn-success col-12">新增產品規格</button>
					<label id="addformatDiv"></label>
			</div>
		</div>
		<div class="col-md-8 form-group">
			<label>商品詳情</label>
			<textarea class="form-control" name="pdetail" rows='15' cols='80'
				required="required"></textarea>
		</div>
		<div class="col-md-8 form-group">
			<label>商品照片</label> 
			<input type="file" name="file"class="form-control-file" multiple="multiple">
		
			<small class="form-text text-muted">非必填。可一次上傳多張照片</small>
		</div>
	</div>
	<button type="submit" class="button contact_button continue_new_button">
		<span>存檔商品資料預覽</span>
	</button>
</form>
<div id="displayloading" style="display:none;"><jsp:include page="../loading.jsp" ></jsp:include></div>
