<%@page import="bsAPI.BSapp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	if (session.getAttribute("member") != null) {
		response.sendRedirect("index.jsp");
		out.clearBuffer();
		out.clear();
		return;
	}

	//開啟即判斷是否是APP
	boolean isAPP = BSapp.isUseApp(request);
	session.setAttribute("isAPP", isAPP);
	if (isAPP) {
		out.println("<script>BSapp.changeView2Login()</script>");
		return;
	}
%>

<!DOCTYPE html>
<html>
<head>
<title>BradShopping</title>
<meta http-equiv="expires" content="0">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="pragma" content="no-cache">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- 第三方google -->
<meta name="google-signin-scope" content="profile email">
<meta name="google-signin-client_id"
	content="1030776440854-8opl3a2kf1enumeurrve0q5r1tr44vh4.apps.googleusercontent.com">
<script src="https://apis.google.com/js/platform.js" async defer></script>
<!-- Login樣式 -->
<link rel="icon" type="image/png" href="login/images/icons/favicon.ico" />
<link rel="stylesheet" type="text/css"
	href="CSS/login/vendor/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css"
	href="CSS/login/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
	href="CSS/login/fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
<link rel="stylesheet" type="text/css"
	href="CSS/login/vendor/animate/animate.css">
<link rel="stylesheet" type="text/css"
	href="CSS/login/vendor/css-hamburgers/hamburgers.min.css">
<link rel="stylesheet" type="text/css"
	href="CSS/login/vendor/animsition/css/animsition.min.css">
<link rel="stylesheet" type="text/css"
	href="CSS/login/vendor/select2/select2.min.css">
<link rel="stylesheet" type="text/css"
	href="CSS/login/vendor/daterangepicker/daterangepicker.css">
<link rel="stylesheet" type="text/css" href="CSS/login/css/util.css">
<link rel="stylesheet" type="text/css" href="CSS/login/css/main.css?20191009">

<script>
	//----------------------------------------------------------------------------------------
	function onSignIn(googleUser) {
		//var auth2 = gapi.auth2.getAuthInstance();
		//auth2.disconnect();

		var idtoken = googleUser.getAuthResponse().id_token;
		input(idtoken, "Gtoken");

	}
	//381583889188972
	window.fbAsyncInit = function() {
		FB.init({
			appId : '381583889188972',
			cookie : true,
			xfbml : true,
			version : 'v4.0'
		});

		FB.AppEvents.logPageView();
	};
	(function(d, s, id) {
		var js, fjs = d.getElementsByTagName(s)[0];
		if (d.getElementById(id)) {
			return;
		}
		js = d.createElement(s);
		js.id = id;
		js.src = "https://connect.facebook.net/en_US/sdk.js";
		fjs.parentNode.insertBefore(js, fjs);
	}(document, 'script', 'facebook-jssdk'));

	function checkLoginState() {
		FB.getLoginStatus(function(response) {
			if (response.status === 'connected') {
				FB.api('/me', 'post', {
					"fields" : "id,name,gender,email"
				}, function(response) {
					input(JSON.stringify(response), "FBtoken");
				});
			}
		});
	}

	function input(data, name) {
		var input = document.getElementById("input");
		input.value = data;
		input.name = name;

		if (name === "Gtoken") {
			gapi.auth2.getAuthInstance().disconnect();
		} else {
			FB.logout(function(response) {
			});
		}
		document.getElementById('form1').submit();
	}
</script>

</head>
<body>
	<div class="super_container">
		<jsp:include page="View/loginV.html"></jsp:include>
	</div>
	<!-- Login script -->
	<script src="CSS/login/vendor/jquery/jquery-3.2.1.min.js"></script>
	<script src="CSS/login/vendor/animsition/js/animsition.min.js"></script>
	<script src="CSS/login/vendor/bootstrap/js/popper.js"></script>
	<script src="CSS/login/vendor/bootstrap/js/bootstrap.min.js"></script>
	<script src="CSS/login/vendor/select2/select2.min.js"></script>
	<script src="CSS/login/vendor/daterangepicker/moment.min.js"></script>
	<script src="CSS/login/vendor/daterangepicker/daterangepicker.js"></script>
	<script src="CSS/login/vendor/countdowntime/countdowntime.js"></script>
	<script src="CSS/login/js/main.js"></script>
</body>
</html>