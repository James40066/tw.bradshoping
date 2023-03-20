<%@page import="java.time.Year"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<div class="limiter">
	<div class="container-login100">
		<div class="wrap-login100">
			<div class="login100-form-title"
				style="background-image: url(CSS/login/images/bg-01.jpg);">
				<span class="login100-form-title-1">註冊</span>
				<span class="login100-form-title-1"  ${loginInfo["loginFrom"]?"":"style='display: none;'" }>${loginInfo["name"] } 您好</span>
				<span class="login100-form-title-1"  ${loginInfo["loginFrom"]?"":"style='display: none;'" }>請填寫以下資料以便提供完整服務。</span>
			</div>
			<form class="login100-form validate-form" action='${loginInfo["loginFrom"]?"registeredOtherM.jsp":"registeredM.jsp" }'
				method="post" ${loginInfo["loginFrom"]?"":"onsubmit='return checkFrom()'" }>
				<!--帳號-->
				<div class="wrap-input100 validate-input m-b-26"
					data-validate="Username is required">
					<span class="label-input100">帳號</span> <input class="input100"
						id="exampleInputEmail1" type="email" name="account"
						placeholder="請輸入帳號" value='${loginInfo["email"] }' pattern="[\w!#$%&'*+/=?^_`{|}~-]+(?:\.[\w!#$%&'*+/=?^_`{|}~-]+)*@(?:[\w](?:[\w-]*[\w])?\.)+[\w](?:[\w-]*[\w])?" required> <span
						class="focus-input100"></span>
				</div>
				<!--密碼-->
				
				<div class='wrap-input100 validate-input m-b-18'
					data-validate='Password is required' ${loginInfo["loginFrom"]?"style='display: none;'":"" }>
					<span class='label-input100'>密碼</span> <input
						class='input100' type='password' name='password'
						placeholder='6~12碼，限英數字混合' ${loginInfo["loginFrom"]?"value='a123456' disabled":"required" }> <span
						class='focus-input100'></span>
				</div>
				<!--確認密碼-->
				<div class="wrap-input100 validate-input m-b-18"
					data-validate="Password is required" ${loginInfo["loginFrom"]?"style='display: none;'":"" }>
					<span class="label-input100">確認密碼</span> <input class="input100"
						type="password" name="cpassword" placeholder="確認密碼" ${loginInfo["loginFrom"]?"value='a123456' disabled":"required" }>
					<span class="focus-input100"></span>
				</div>
				<!--姓名-->
				<div class="wrap-input100 validate-input m-b-18">
					<span class="label-input100">姓名</span> <input class="input100"
						id="formGroupExampleInput" type="text" name="name"
						placeholder="取貨專用" required> <span class="focus-input100"></span>
				</div>
				<!--男女-->
				<div class="wrap-input100 validate-input m-b-18">
					<span class="label-input100">性別</span> <select
						class="custom-select my-1 mr-sm-2" name="gender" required>
						<option selected disabled>性別</option>
						<option value="0">女</option>
						<option value="1">男</option>
					</select>
				</div>
				<!--生日-->
				<div class="wrap-input100 validate-input m-b-18">
					<span class="label-input100">生日</span> <select
						class="custom-select my-1 mr-sm-2" name="year" required>
						<option selected disabled>年</option>
						<%
							for(int i=Year.now().getValue();i>1898;i--){
								out.println("<option value='"+i+"'>"+i+"</option>");
							}
						%>
						

					</select> <select class="custom-select my-1 mr-sm-2" name="mouth" required>
						<option selected disabled>月</option>
						<option value="01">一月</option>
						<option value="02">二月</option>
						<option value="03">三月</option>
						<option value="04">四月</option>
						<option value="05">五月</option>
						<option value="06">六月</option>
						<option value="07">七月</option>
						<option value="08">八月</option>
						<option value="09">九月</option>
						<option value="10">十月</option>
						<option value="11">十一月</option>
						<option value="12">十二月</option>
					</select> <select class="custom-select my-1 mr-sm-2" name="day" required>
						<option selected disabled>日</option>
						<%
							for(int i=1;i<32;i++){
								out.println("<option value='"+i+"'>"+i+"</option>");
							}
						%>
					</select> <span class="focus-input100"></span>
				</div>
				<input type="hidden" name="id" value='${loginInfo["loginId"] }' readonly>
				<input type="hidden" name="type" value='${loginInfo["logintype"] }' readonly>
				${loginInfo["loginFrom"]?""
					:"<input id='captchaToken' name='captchaToken' type='hidden' readonly><div id='reCAPTCHA'></div>" }
				<div class="container-login100-form-btn">
					<button class="login100-form-btn" type="submit">註冊</button>
					<button class="login100-form-btn" type="button" onclick="location.href='login.jsp'">回上一頁</button>
				</div>
			</form>
		</div>
	</div>
</div>
<%
	session.removeAttribute("loginInfo");
%>
