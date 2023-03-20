<%@page import="java.util.HashMap"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Connection"%>
<%@page import="bsAPI.Sql"%>
<%@page import="com.aes.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%

	//訂單資料
    HashMap<String, Object> blueInfo = (HashMap<String, Object>)session.getAttribute("blueInfo");//從TransactionStart存入SESSION的資料
    String email = (String)blueInfo.get("email") ;
    String tid = (String)blueInfo.get("tidNew");
    String total = Integer.toString((int)blueInfo.get("transactionTotal"));
	HashMap<String, String> trade_info_arr = new HashMap<String, String>();//要給自訂方法將資料轉成請求參數的資料結構
	String ngrokPath = getServletContext().getInitParameter("ngrok");//虛擬路徑
	trade_info_arr.put("MerchantID", "MS17305750");//商店ID
	trade_info_arr.put("RespondType", "JSON");//藍新索回傳的資料格式
	trade_info_arr.put("TimeStamp", System.currentTimeMillis() + "");//訂單成立的時間搓記
	trade_info_arr.put("Version", "1.5");//版本數
	trade_info_arr.put("MerchantOrderNo",tid);//交易訂單編號(自訂)
	trade_info_arr.put("Amt",total);//交易金額
	trade_info_arr.put("ItemDesc", "BradShopping");//交易物品名稱
	trade_info_arr.put("CREDIT", "1");//信用卡 一次付清啟用 啟用
	trade_info_arr.put("ReturnURL", ngrokPath+"tw.bradshoping/TransactionStatus.jsp");//交易後傳回來的結果會回傳到這隻邏輯
	trade_info_arr.put("ClientBackURL", ngrokPath+"tw.bradshoping/TransactionStatus.jsp");//交易後傳回來的結果會回傳到這隻邏輯
	trade_info_arr.put("TradeLimit", "0");//交易時間限制
	trade_info_arr.put("Email",email);//付款人電子信箱 
	trade_info_arr.put("EmailModify", "1");//付款人電子信箱 是否開放修改 (可修改)
	trade_info_arr.put("LoginType", "0");// 不須登入藍新金流會員 
    //Key & iv 是藍新所給予的,用來AES256&SHA256加密
	String key = "zRvVhLHpyTd4ua5e9zFeI8UKE2OrsxiU";
	String iv = "C0aKgyGyfxpKgiLP";

	//1.URL (自訂邏輯HttpBuildQuery.ToUrlENCODED()會將資料結構給轉成網頁請求參數(?Key=Value))
	String str = HttpBuildQuery.ToUrlENCODED(trade_info_arr);

	//3.AES (自訂邏輯ToAes.encryptSpgateway()將請求字串給AES256加密化)
	String aes256 = ToAes.encryptSpgateway(key, iv, str);

	//3.SHA (組成要給自訂邏輯ToSHA256.getSHA256Str()加密化的字串)
	String strSha256 = "HashKey=" + key + "&" + aes256 + "&HashIV=" + iv;

	//5.Upper (將strSha256給加密化並將字串給轉大寫)
	String sha256 = ToSHA256.getSHA256Str(strSha256).toUpperCase();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BradShopping</title>
</head>
<body>
	<form name="newebpay" method="post" id="newebpay" action="https://ccore.newebpay.com/MPG/mpg_gateway">
		<input type="hidden" id="MerchantID" name="MerchantID" value="MS17305750"><br> 
		<input type="hidden" id="TradeInfo " name="TradeInfo" value="<%=aes256%>"><br>
		<input type="hidden" id="TradeSha" name="TradeSha" value="<%=sha256%>"><br>
		<input type="hidden" id="Version" name="Version" value="1.5"><br>
	</form>
<script>
	document.getElementById("newebpay").submit();
</script>
</body>
</html>