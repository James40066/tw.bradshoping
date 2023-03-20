<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<html>
<head>
<title>reCAPTCHA</title>
<script type="text/javascript">
	// 驗證成功後執行
	var onSubmit = function(token) {
		document.getElementById("captchaToken").value = token;

	};
	var onloadCallback = function() {

		console.log("onloadCallback");
		grecaptcha.render('reCAPTCHA', {
			'sitekey' : '6Lfi0rkUAAAAAJgizcOP73FMGEU29NeTiMDNIQgj', // 這邊填寫自己的site_key
			'callback' : onSubmit
		// 執行成功後onSubmit變數接收
		});
	};
</script>
</head>
<body>
	<form action="imagecheckM" method="POST">
		<div id="reCAPTCHA"></div>
		<input id="captchaToken" name="captchaToken" type="hidden" value="" />
		<input name="submit" type="submit" />
	</form>
	<script
		src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit"
		async defer></script>
</body>
</html>