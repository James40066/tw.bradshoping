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
				"<div class='row border py-3 my-2 bg-light text-dark'>"+
					"<div class='col-md-2 col-3 align-self-center text-center'>"+
						"<div class='row'>"+
							"<div class='col-12 h6'>"+
								"<b>"+data.get("status")+"</b>"+
							"</div>"+
							"<div class='col-12 '>"+
							"<span class='badge badge-dark click' onclick='changeSellerItemAjaxView(this)' aria-View='"+data.get("tid")+"'>"+"查看詳情"+"</span>"+
							"</div>"+
						"</div>"+
					"</div>"+
					"<div class='col-md-10 col-9'>"+
						"<div class='row'>"+
							"<div class='col-md-6'>"+
								"<div class='row'>"+
									"<div class='col-12'>訂購編號："+data.get("tid")+"</div>"+
									"<div class='col-12'>訂購日期："+data.get("tdate")+"</div>"+
									"<div class='col-12'>交易金額："+data.get("itemsSum")+"</div>"+
									"<div class='col-12'>品項數量："+data.get("items")+"</div>"+
								"</div>"+
							"</div>"+
							"<div class='col-md-6'>"+
								"<div class='row'>"+
									"<div class='col-12'>買家姓名："+data.get("name")+"</div>"+
									"<div class='col-12'>交貨方式："+data.get("post")+"</div>"+
									"<div class='col-12'>交貨費用："+(data.get("post").equals("面交")?"免費":"60")+"</div>"+
									"<div class='col-12'>交貨地址："+data.get("receive")+"</div>"+
								"</div>"+
							"</div>"+
						"</div>"+
					"</div>"+
				"</div>"
				);
			};
		}else{
			out.println(
				"<div class='row border py-3 my-2 bg-light text-dark'>"+
					"<div class='col-12 text-center'>"+
						"<b>無訂單紀錄</b>"+
					"</div>"+
				"</div>"
			);
		}
	%>
		