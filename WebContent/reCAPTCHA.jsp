<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<html>
<head>
<title>reCAPTCHA</title>
<script src="https://code.jquery.com/jquery-3.4.0.min.js"
	integrity="sha256-BJeo0qm959uMBGb65z40ejJYGSgR7REI4+CW1fNKwOg="
	crossorigin="anonymous"></script>
<script type="text/javascript">
	//用途:用來控制submit是否可以送出
	var isReCaptchaOK = false;
	// 驗證成功後執行
	var onSubmit = function(token) {
		document.getElementById("captchaToken").value = token;
		console.log("1");
		$.ajax({
			url : 'imagecheckM',
			type : 'GET',
			data : {
				captchaToken : token
			},
			error : function(xhr) {
				alert('Ajax request 發生錯誤');
			},
			success : function(response) {
				console.log(response);

			}
		});
		console.log("2");
	};
	var onloadCallback = function() {

		grecaptcha.render('reCAPTCHA', {
			'sitekey' : '6Lfi0rkUAAAAAJgizcOP73FMGEU29NeTiMDNIQgj', // 這邊填寫自己的site_key
			'callback' : onSubmit
		// 執行成功後onSubmit變數接收
		});
	};
	//控點:checkregistered
	function checkFrom() {
		return isReCaptchaOK;
	}
</script>
</head>
<body>
	<div id="myDiv"></div>
	<form action="https://www.youtube.com/?gl=TW&hl=zh-tw" method="POST"
		onsubmit="return checkFrom(this)">
		<div id="reCAPTCHA"></div>
		<input id="captchaToken" name="captchaToken" type="hidden" value="" />
		<input name="submit" type="submit" />
	</form>
	<script
		src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit"
		async defer></script>

</body>
</html>