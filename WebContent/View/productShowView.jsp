<%@page import="bsAPI.WherePost"%>
<%@page import="java.util.LinkedList"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% 
	HashMap<String, Object> datas =(HashMap<String, Object>)request.getAttribute("datas"); 
	
	LinkedList photoPath = (LinkedList<String>)datas.get("photoPath");
	Boolean isphotoPathNull = photoPath==null;
%>

<script>
	$(function() {
		$(".cart_button").click(function() {
			if(${sessionScope.member!=null }){
				$.ajax({
					url : 'ShoppingCartAdd.jsp',
					type : 'GET',
					data : {
						"product" : <%=datas.get("pid") %>,
						"quantity" : $("#quantity_input").val()
					},
					datatype : "text",
					error : function(error) {
						$("#addMsg").text("出了些問題...");
						$('#productAddCart').modal('show');
					},
					success : function(response) {
						if (response) {
							$("#addMsg").text("成功加入購物車");
						}else {
							$("#addMsg").text("出了些問題...");
						}
						$('#productAddCart').modal('show');
					}
				});
			}else{
				location.href="login.jsp"
			}
		})
	})
</script>

	<div class="product_details BShome">
		<div class="container">
			<div class="row">
			<%
				out.println((Boolean)datas.get("openEditMode")?
						"<div class='col-12 alert alert-warning'>"+
						"<h3>預覽編輯模式</h3>"+
						"<button type='button' class='btn btn-secondary btn-sm'>返回我的商品</button>"+
						"<button type='button' class='btn btn-danger btn-sm' data-toggle='modal' data-target='#productShowModal'>修改資料</button>"+
						"<button type='button' class='btn btn-danger btn-sm'>修改照片</button>"+
						"<button type='button' class='btn btn-danger btn-sm' data-toggle='modal' data-target='#setSpecial'>設定特價金額</button>"+
						"<a class='btn btn-danger btn-sm' href='productisSale.jsp?product="+(int)datas.get("pid")+"'>開放銷售</a></div>"
					:"");
			%>
				<!-- Product Image -->
				<div class="col-lg-6">
					<div class="details_image">
						<div class="details_image_large"><img src="<%=!isphotoPathNull?"/productPhoto/"+photoPath.get(0):"images/404.png" %>">${datas["special"]==0?"":"<div class='product_extra product_sale text-white'><a>Sale</a></div>" }</div>
						<div class="details_image_thumbnails d-flex flex-row align-items-start justify-content-between">
							<%
								if(!isphotoPathNull){
									for(int i=0;i<photoPath.size();i++)
										out.println("<div class='details_image_thumbnail "+(i==0?"active":"")+
											"' data-image='/productPhoto/"+photoPath.get(i)+"'><img src='/productPhoto/"+photoPath.get(i)+"' alt=''></div>");
								}else{
									for(int i=0;i<4;i++)
										out.println("<div class='details_image_thumbnail "+(i==0?"active":"")+
											"' data-image='images/404.png'><img src='images/404.png' alt=''></div>");
								}
							%>
						</div>
					</div>
				</div>
				
				<!-- Product Content -->
				<div class="col-lg-6">
					<div class="details_content">
						<div class="details_name">${datas["pname"] }</div>
						<!--<div class='details_discount'>$890</div>-->
						<%=(int)datas.get("special")==0?"":"<div class='details_discount'>$"+(int)datas.get("pprice")+"</div>"%>
						<div class="details_price">$${datas["special"]==0?datas["pprice"]:datas["special"] }</div>

						<!-- In Stock -->
						<div class="in_stock_container">
							<div class="availability">商店名稱:</div>
							<span>${datas["storeName"] }</span><br>
							<div class="availability">庫存:</div>
							<span>${datas["pquantity"] }</span><br>
							<div class="availability">品牌:</div>
							<span>${datas["pbrand"] }</span><br>
							<div class="availability">出貨地:</div>
							<span><%=new WherePost().getWherePost((int)datas.get("wherePost")) %></span><br>
							<%
								HashMap<String, LinkedList<String>> addFormat = (HashMap<String, LinkedList<String>>)datas.get("addFormat");
								if(addFormat!=null){
									LinkedList<String> keys = addFormat.get("key");
									LinkedList<String> values = addFormat.get("value");
									for(int i=0;i<keys.size();i++){
										out.println("<div class='availability format'>"+keys.get(i)+":</div>");
										out.println("<span>"+values.get(i)+"</span><br>");
									}
								}
							%>
						</div>

						<!-- Product Quantity -->
						<div class="product_quantity_container">
							<div class="product_quantity clearfix">
								<span>數量</span>
								<input id="quantity_input" type="text" pattern="[0-9]*" max='${datas["pquantity"] }' value="1">
								<div class="quantity_buttons">
									<div id="quantity_inc_button" class="quantity_inc quantity_control"><i class="fa fa-chevron-up" aria-hidden="true"></i></div>
									<div id="quantity_dec_button" class="quantity_dec quantity_control"><i class="fa fa-chevron-down" aria-hidden="true"></i></div>
								</div>
							</div>
							<div class="button cart_button"><a>加入購物車</a></div>
							<!-- $('#productAddCart').modal('show'); 呼叫，顯示M -modal-->
						</div>

						<!-- Share -->
						<div class="details_share test">
							<span>分享:</span>
							<ul>
								<li><a href="#"><i class="fa fa-pinterest" aria-hidden="true"></i></a></li>
								<li><a href="#"><i class="fa fa-instagram" aria-hidden="true"></i></a></li>
								<li><a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a></li>
								<li><a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a></li>
							</ul>
						</div>
					</div>
				</div>
			</div>

			<div class="row description_row">
				<div class="col">
					<div class="description_title_container">
						<div class="description_title">商品詳情</div>
					</div>
					<div class="description_text">
						<pre>${datas["pdetail"] }</pre>
					</div>
				</div>
			</div>
		</div>
	</div>
	
		<jsp:include page="productShowViewModal.jsp"></jsp:include>
	