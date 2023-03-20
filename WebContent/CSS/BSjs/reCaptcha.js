//用途:用來控制submit是否可以送出
var isReCaptchaOK = false;
// 驗證成功後執行
var onSubmit = function(token) {
	if (token!=null) {
		document.getElementById("captchaToken").value = token;
		isReCaptchaOK = true;
	}
	
	/*
	$.ajax({
		url : 'RegisteredReCaptcha',
		type : 'POST',
		data : {
			captchaToken : token
		},
		error : function(xhr) {
			alert('Ajax request 發生錯誤');
		},
		success : function(response) {
			isReCaptchaOK = response;
		}
	});
	*/
};
var onloadCallback = function() {

	grecaptcha.render('reCAPTCHA', {
		'sitekey' : '6Lfi0rkUAAAAAJgizcOP73FMGEU29NeTiMDNIQgj', // 這邊填寫自己的site_key
		'callback' : onSubmit
	// 執行成功後onSubmit變數接收
	});
};
// 控點:checkregistered
function checkFrom() {
	return isReCaptchaOK;
}