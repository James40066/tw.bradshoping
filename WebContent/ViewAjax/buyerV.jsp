<%@page import="java.util.HashMap"%>
<%@page import="java.util.LinkedList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	LinkedList<HashMap<String, String>> datas =(LinkedList<HashMap<String, String>>)session.getAttribute("datas");
%>

<!-- ~~~~~~~~~~~~~~~~~~~~PS訂單列表，寫在這裡~~~~~~~~~~~~~~~~~~~~ -->
<%
	if(!datas.isEmpty()){
		for(HashMap<String, String> data:datas){
			out.println(
					"<script>$(function () {$('[data-toggle=\"tooltip\"]').tooltip()})</script>"+
					"<div class='row border  py-3 my-2 bg-light text-dark'>"+
					"<div class='col-md-2 col-4'>"+
						"<img src='/productPhoto/"+data.get("photo")+"' class='img-fluid'>"+
					"</div>"+
					"<div class='col-md-10 col-8'>"+
						"<div class='row'>"+
							"<div class='col-12 h6'>"+
								"<span onclick='changeBuyerItemAjaxView(this)' aria-View='"+data.get("tid")+"' class='text-dark click'"+
									"data-toggle='tooltip' data-placement='top' title='查看詳情'><b>"+data.get("pname")+"</b></span>"+
							"</div>"+
							"<div class='col-md-6'>訂購編號："+data.get("tid")+"</div>"+
							"<div class='col-md-6'>訂購日期："+data.get("tdate")+"</div>"+
							"<div class='col-md-6'>品項數量："+data.get("items")+"</div>"+
							"<div class='col-md-6'>交易金額："+data.get("itemsSum")+"</div>"+
							"<div class='col-md-12 text-right'>"+data.get("status")+"</div>"+
						"</div>"+
					"</div>"+
				"</div>"
			);
		}
	}else{
		out.println(
			"<div class='row border  py-3 my-2 bg-light text-dark'>"+
				"<div class='col-12 text-center'>"+
					"<b>無訂單紀錄</b>"+
				"</div>"+
			"</div>"
		);
	}
%>
