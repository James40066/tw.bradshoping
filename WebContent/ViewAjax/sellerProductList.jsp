<%@page import="java.util.HashMap"%>
<%@page import="java.util.LinkedList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<jsp:useBean id="sellerProductList" class="bsMain.SellerProductList"/>
<jsp:setProperty name="sellerProductList" property="id" value="${member.id }"/>

<c:forEach items="${sellerProductList.lists }" var="list" varStatus="status">
	<div class="row border  py-3 my-2 bg-light">
		<div class='col-md-2 col-4'>
			<img src='/productPhoto/${list.small }' class='img-fluid'>
		</div>
		<div class='col-md-10 col-8'>
			<div class="row">
				<div class='col-12 h6'>${list.pname }</div>
				<div class='col-md-6'>原價：${list.pprice }</div>
				<div class='col-md-6'>特價：${list.special==0?"非特價商品":list.special }</div>
				<div class='col-md-6'>出貨地：${list.wherePost }</div>
				<div class='col-md-6'>品牌：${list.pbrand }</div>
				<div class='col-md-6'>庫存：${list.pquantity }</div>
				<div class='col-md-6'>銷售狀態：${list.isSale }</div>
				<div class='col-md-6'><a class='badge badge-primary' href="productisSale.jsp?edit=1&issale=1&product=${list.pid }">修改商品</a></div>
				<div class='col-md-6'><a class='badge badge-danger'  href='productisSale.jsp?issale=1&product=${list.pid }'>下架商品</a></div>
			</div>
		</div>
	</div>
</c:forEach>
	