<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%
	    if(session.getAttribute("member")!=null){
	    	response.sendRedirect("index.jsp");
	    	return;
	    }
    %>
    
<!DOCTYPE html>
<html>
<head>
<title>BradShopping</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" type="image/png" href="CSS/login/images/icons/favicon.ico" />
<link rel="stylesheet" type="text/css" href="CSS/login/vendor/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="CSS/login/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css" href="CSS/login/fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
<link rel="stylesheet" type="text/css" href="CSS/login/vendor/animate/animate.css">
<link rel="stylesheet" type="text/css" href="CSS/login/vendor/css-hamburgers/hamburgers.min.css">
<link rel="stylesheet" type="text/css" href="CSS/login/vendor/animsition/css/animsition.min.css">
<link rel="stylesheet" type="text/css" href="CSS/login/vendor/select2/select2.min.css">
<link rel="stylesheet" type="text/css" href="CSS/login/vendor/daterangepicker/daterangepicker.css">
<link rel="stylesheet" type="text/css" href="CSS/login/css/util.css">
<link rel="stylesheet" type="text/css" href="CSS/login/css/main.css">
<!-- BS -->
${loginInfo["loginFrom"]?"":"<script src='CSS/BSjs/reCaptcha.js?123'></script>" }
${loginInfo["loginFrom"]?"":"<script src='https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit' async defer></script>" }
<script src="https://code.jquery.com/jquery-3.4.0.min.js" integrity="sha256-BJeo0qm959uMBGb65z40ejJYGSgR7REI4+CW1fNKwOg=" crossorigin="anonymous"></script>
</head>
<body>
<div class="super_container">
	<jsp:include page="View/registeredV.jsp"></jsp:include>
	
</div>
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