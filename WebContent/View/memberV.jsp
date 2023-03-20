<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- $(".editInfo").attr("disabled","disabled"); -->
<script>
<!--按下檢視資料-->
	$(function() {
		$("#userInfo").click(function() {
			$("#memberInfo").show();
			$("#memberPw").hide();
			$(".editInfo").attr("disabled", "disabled");
		})
	})
	<!--按下修改資料-->
	$(function() {
		$("#changeInfo").click(function() {
			$("#memberInfo").show();
			$("#memberPw").hide();
			$(".editInfo").removeAttr("disabled");
		})
	})
	<!--按下修改密碼-->
	$(function() {
		$("#changePw").click(function() {
			$("#memberPw").show();
			$("#memberInfo").hide();
			$(".editInfo").attr("disabled", "disabled");
		})
	})
	<!--按下跳轉到賣家後台-->
	$(function() {
		$("#s1").click(function() {
			window.location.href = "productAdd.jsp";
		})
	})
</script>
<!-- Contact -->
<div class="contact BShome">
	<div class="container">
		<div class="row">
			<!-- 檢視資料、修改資料 -->
			<div id="memberInfo" class="BShome col-lg-8 contact_col">
				<div class="get_in_touch">
					<div class="section_title">會員中心</div>
					<div class="contact_form_container">
						<form action="changeMemberUserinfoM.jsp" class="contact_form">
							<div class="row">
								<div class="col-xl-6">
									<!-- Name -->
									<label for="contact_name">Name</label> <input type="text"
										id="contact_name" class="editInfo contact_input" name="name"
										value='${sessionScope.member["name"] }' required="required"
										placeholder="" disabled>
								</div>
								<div class="col-xl-6 last_name_col">
									<!-- Last Name -->
									<label for="contact_last_name">E-mail</label> <input
										type="text" id="contact_last_name" class="contact_input"
										required="required" placeholder=""
										value='${sessionScope.member["account"] }' disabled>
								</div>
							</div>
							<div>
								<!-- Subject -->
								<label for="contact_company">gender</label> <input type="text"
									class="contact_input"
									value='${sessionScope.member["gender"]==0?"女":"男" }' disabled>
							</div>
							<div>
								<label for="contact_company">birthday</label> <input type="text"
									class="contact_input"
									value='${sessionScope.member["birthday"] }' disabled>
							</div>
							<div>
								<label for="contact_company">address</label> <input type="text"
									class="editInfo contact_input" name="address"
									value='${sessionScope.member["address"] }' disabled>
							</div>
							<div>
								<label for="contact_company">tel</label> <input type="text"
									class="editInfo contact_input" name="tel"
									value='${sessionScope.member["tel"] }' disabled>
							</div>
							<button type="submit" class="editInfo button contact_button"
								disabled>
								<span>送出</span>
							</button>
						</form>
					</div>
				</div>
			</div>

			<!-- 修改密碼-->
			<div id="memberPw" class="BShome bshide col-lg-8 contact_col">
				<div class="get_in_touch">
					<div class="section_title">修改密碼</div>
					<div class="contact_form_container">
						<form action="changeMemberPasswordM.jsp" class="contact_form">
							<div>
								<!-- Subject -->
								<label for="contact_company">密碼</label> <input type="password"
									name="password" class="contact_input"
									placeholder="6~12碼，限英數字混合">
							</div>
							<div>
								<label for="contact_company">確認密碼</label> <input type="password"
									name="cpassword" class="contact_input" placeholder="再次輸入密碼">
							</div>
							<button type="submit" class="button contact_button">
								<span>修改密碼</span>
							</button>
						</form>
					</div>
				</div>
			</div>

			<!-- 功能區 -->
			<div class="BShome col-lg-3 offset-xl-1 contact_col">
				<div class="contact_info">
					<div class="contact_info_section">
						<div class="contact_info_title">
							<button id="userInfo" class="button contact_button">
								<span>個人資料</span>
							</button>
						</div>
						<div class="contact_info_title">
							<button id="changeInfo" class="button contact_button">
								<span>修改資料</span>
							</button>
						</div>
						<div class="contact_info_title">
							<button id="changePw" class="button contact_button">
								<span>修改密碼</span>
							</button>
						</div>
						<div class="contact_info_title">
							<button class="button contact_button">
								<span>購買清單</span>
							</button>
						</div>
						<div class="contact_info_title">
							<button class="button contact_button" id="s1">
								<span>我的賣場(暫時先連接到上傳商品頁面)</span>
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
