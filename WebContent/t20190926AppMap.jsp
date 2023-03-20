<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script>
function callMap(obj) {
	BSapp.callMap(obj.value);
	obj.value="";
}
</script>
<link rel="stylesheet" type="text/css" href="CSS/styles/bootstrap4/bootstrap.min.css">
</head>
<body>
<form action="t20190927" method="post" enctype="multipart/form-data">
	<input type="text" id='input' class="form-control" placeholder="請輸入目的地">
	<input type="file" class="form-control" name="file">
	<input type="submit">
</form>
<button type="button" class="btn btn-primary btn-lg" onclick="callMap(input)">開啟地圖</button><br>
</body>
</html>