<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	/*request.setCharacterEncoding("utf-8");
	if (session.getAttribute("member") == null || request.getParameter("pcode") == null) {
		response.sendRedirect("login.jsp");
		return;
	}*/
%>

<script>
	document.getElementById("ckPassword2")
			.addEventListener("input", ckPassword);
	document.getElementById("ckPassword1").addEventListener("input",
			isPasswordEmpty);
</script>
<%
	if (request.getParameter("pcode") != null) {
		session.setAttribute("pcode", request.getParameter("pcode"));
		out.println("<form action='catchpassword' class='contact_form' method='POST'>");
		System.out.println("pcode");
	} else {
		out.println(
				"<form action='buyerPwdM.jsp' class='contact_form' method='POST' onsubmit='return onSubmit(this)'>");
		System.out.println("member");
	}
%>
<div class="form-row">
	<div class="col-md-12 h5 form-group">修改使用者登入密碼</div>
	<div class="col-md-8 form-group">
		<label>請輸入新密碼</label> <input type="password"
			class="bg-light form-control" name="password" id="ckPassword1"
			required> <small class="form-text text-muted">密碼長度6~20，限英數混合，至少需要一個數字及英文字。</small>
	</div>
	<div class="col-md-8 form-group">
		<label>再次輸入新密碼</label> <input type="password"
			class="bg-light form-control" id="ckPassword2" required>
	</div>
</div>
<button class="button contact_button" type="submit">
	<span>送出修改</span>
</button>
</form>
