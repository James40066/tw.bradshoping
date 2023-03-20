<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>


<div class="BSnav col-lg-2 offset-lg-1 contact_col">
	<div class="row border  py-3 my-2 bg-light ">
		<div class="col-12 h5 my-3 text-center"><i class="fas fa-handshake mr-1"></i><b>商店系統</b></div>
		<div class="col-12 dropdown-divider"></div>
		<div class="col-12 h6 my-3 text-center click" onclick="changeAjaxView(this)" aria-View="sellerV"><i class="fas fa-comments-dollar mr-1"></i>訂單查詢</div>
		<div class="col-12 h6 my-3 text-center"><i class="fa fa-history mr-1"></i>歷史訂單</div>
		<div class="col-12 h6 my-3 text-center click" onclick="changeAjaxView(this)" aria-View="sellerProductAddV"><i class="fas fa-cloud-upload-alt mr-1"></i>新增商品</div>
		<div class="col-12 h6 my-3 text-center click" onclick="changeAjaxView(this)" aria-View="sellerProductList"><i class="fas fa-tasks mr-1"></i>商品管理</div>
		<div class="col-12 h6 my-3 text-center click" onclick="changeAjaxView(this)" aria-View="sellerInfo"><i class="fas fa-store mr-1"></i>商店資訊</div>
		<div class="col-12 h6 my-3 text-center click" onclick="changeAjaxView(this)" aria-View="analysis"><i class="fas fa-chart-bar mr-1"></i>銷售分析</div>
		<div class="col-12 h6 my-3 text-center"><i class="fas fa-info-circle mr-1"></i>賣家須知</div>
		<div class="col-12 dropdown-divider"></div>
		<div class="col-12 h6 my-3 text-center"><a href="buyer.jsp?view=buyerV" class="text-dark"><i class="fas fa-user mr-1"></i>買家系統</a></div>
	</div>
</div>