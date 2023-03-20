<%@page import="java.util.LinkedList"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- Modal -->
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
													+ "<div class='form-group'>"
													+ "<input type='text' name='addFormatKey' class='form-control' placeholder='規格名稱  ex:材質' required>"
													+ "</div>"
													+ "<div class='form-group'>"
													+ "<input type='text' name='addFormatValue' class='form-control' placeholder='規格內容  ex:純棉' required>"
													+ "</div>"
													+ "<div class='form-group'><button type='button' class='btn btn-danger' onclick='deleAddSbj(ns"
													+ addCount
													+ ")'>刪除</button></div>"
													+ "</div>");
						});
	})

	function deleAddSbj(id) {
		id.remove();
	}
</script>
<!-- PS:修改資料modal -->
<div class="modal fade" id="productShowModal" tabindex="-1"
	role="productEdit" aria-labelledby="productShowModal"
	aria-hidden="true" data-backdrop="static">
	<div class="modal-dialog" role="input">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title">修改商品明細</h5>
				<button type="button" class="close" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<!-- **************************************************************PS:內容開始************************************************************** -->
				<div class="container">
					<div class="row">
						<form action="ProductUploadM" method="POST"
							enctype="multipart/form-data">
							<div class="form-row">
								<div class="form-group">
									<label>商品名稱</label> <input type="text" name="pname"
										class="form-control" size="100" maxlength="50" required
										value='${datas["pname"] }'> <small
										class="form-text text-muted">買家瀏覽商品名稱</small>
								</div>
							</div>
							<div class="form-row">
								<div class="form-group">
									<label>商品單價</label> <input type="text" name="pprice"
										class="form-control" pattern="^\+?[1-9][0-9]*$" required
										value='${datas["pprice"] }'> <small
										class="form-text text-muted">單價1元至1百萬元之間</small>
								</div>
								<div class="form-group">
									<label>商品庫存</label> <input type="text" name="pquantity"
										class="form-control" pattern="^\+?[1-9][0-9]*$" required
										value='${datas["pquantity"] }'> <small
										class="form-text text-muted">庫存需要至少1個</small>
								</div>
							</div>
							<div class="form-row"></div>
							<div class="form-row">
								<div class="form-group">
									<label>商品品牌</label> <input type="text" name="pbrand"
										class="form-control" required value='${datas["pbrand"] }'>
								</div>
								<div class="form-group">
									<label>出貨地</label> <select name="wherePost"
										class="form-control">
										<option selected disabled>出貨地</option>
										<option id="s1" value="1"
											${datas["wherePost"]==1?'selected':'' }>基隆市</option>
										<option id="s2" value="2"
											${datas["wherePost"]==2?'selected':'' }>台北市</option>
										<option id="s3" value="3"
											${datas["wherePost"]==3?'selected':'' }>新北市</option>
										<option id="s4" value="4"
											${datas["wherePost"]==4?'selected':'' }>桃園市</option>
										<option id="s5" value="5"
											${datas["wherePost"]==5?'selected':'' }>新竹市</option>
										<option id="s6" value="6"
											${datas["wherePost"]==6?'selected':'' }>新竹縣</option>
										<option id="s7" value="7"
											${datas["wherePost"]==7?'selected':'' }>苗栗縣</option>
										<option id="s8" value="8"
											${datas["wherePost"]==8?'selected':'' }>台中市</option>
										<option id="s9" value="9"
											${datas["wherePost"]==9?'selected':'' }>彰化縣</option>
										<option id="s10" value="10"
											${datas["wherePost"]==10?'selected':'' }>南投縣</option>
										<option id="s11" value="11"
											${datas["wherePost"]==11?'selected':'' }>雲林縣</option>
										<option id="s12" value="12"
											${datas["wherePost"]==12?'selected':'' }>嘉義市</option>
										<option id="s13" value="13"
											${datas["wherePost"]==13?'selected':'' }>嘉義縣</option>
										<option id="s14" value="14"
											${datas["wherePost"]==14?'selected':'' }>台南市</option>
										<option id="s15" value="15"
											${datas["wherePost"]==15?'selected':'' }>高雄市</option>
										<option id="s16" value="16"
											${datas["wherePost"]==16?'selected':'' }>屏東縣</option>
										<option id="s17" value="17"
											${datas["wherePost"]==17?'selected':'' }>宜蘭縣</option>
										<option id="s18" value="18"
											${datas["wherePost"]==18?'selected':'' }>花蓮縣</option>
										<option id="s19" value="19"
											${datas["wherePost"]==19?'selected':'' }>台東縣</option>
										<option id="s20" value="20"
											${datas["wherePost"]==20?'selected':'' }>澎湖縣</option>
										<option id="s21" value="21"
											${datas["wherePost"]==21?'selected':'' }>金門縣</option>
										<option id="s22" value="22"
											${datas["wherePost"]==22?'selected':'' }>連江縣</option>
										<option id="s22" value="23"
											${datas["wherePost"]==23?'selected':'' }>海外地區</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<button type="button" id="addformat" class="btn btn-success">新增產品規格</button>
							</div>
							<span id="addformatDiv"> <%
 	HashMap<String, Object> datas = (HashMap<String, Object>) request.getAttribute("datas");
 	HashMap<String, LinkedList<String>> addFormat = (HashMap<String, LinkedList<String>>) datas.get("addFormat");
 	if (addFormat != null) {
 		LinkedList<String> keys = addFormat.get("key");
 		LinkedList<String> values = addFormat.get("value");
 		for (int i = 0; i < keys.size(); i++) {
 			out.println("<div id='os" + i + "' class='form-row'>" + "<div class='form-group'>"
 					+ "<input type='text' name='addFormatKey' class='form-control' placeholder='規格名稱  ex:材質' required value='"
 					+ keys.get(i) + "'>" + "</div>" + "<div class='form-group'>"
 					+ "<input type='text' name='addFormatValue' class='form-control' placeholder='規格內容  ex:純棉' required value='"
 					+ values.get(i) + "'>" + "</div>"
 					+ "<div class='form-group'><button type='button' class='btn btn-danger' onclick='deleAddSbj(os"
 					+ i + ")'>刪除</button></div>" + "</div>");
 		}
 	}
 %>
							</span>
							<div class="form-row">
								<div class="form-group">
									<label>商品詳情</label>
									<textarea name="pdetail" class='form-control align-self-center'
										rows='15' cols='80' required>${datas["pdetail"] }</textarea>
								</div>
							</div>
							<div class="modal-footer">
								<input type="hidden" name='pid' value='${datas["pid"] }'
									readonly>
								<button type="button" class="btn btn-secondary"
									data-dismiss="modal">取消</button>
								<button type="submit" class="btn btn-primary">更新</button>
							</div>
						</form>
					</div>
				</div>
				<!-- **************************************************************PS:內容結束************************************************************** -->
			</div>
		</div>
	</div>
</div>


<!-- PS:加入購物車的提示madal -->
<div class="modal fade" id="productAddCart" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-body">
				<h4 class="text-center text-dark" id="addMsg"></h4>
				<button type="button" class="btn btn-primary btn-sm btn-block mt-3" data-dismiss="modal">確定</button>
			</div>
		</div>
	</div>
</div>


<!-- PS：新增商品特價金額madal -->
<div class="modal fade" id="setSpecial" tabindex="-1" aria-hidden="true" data-backdrop="static">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-body">
				<form action="ProductAttributesSpecialM" method="get">
  					<div class="form-group">
					    <input type="text" class="form-control" name="special" pattern="^\+?[1-9][0-9]*$" placeholder="請填入大於0的金額。">
					    <small id="emailHelp" class="form-text text-muted">商品販售將以此金額為主，會與原價分別呈現。</small>
 					</div>
 					<div class="modal-footer">
						<input type="hidden" name='product' value='${datas["pid"] }'
							readonly>
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">取消</button>
						<button type="submit" class="btn btn-primary">設定</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>



