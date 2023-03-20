<%@page import="jdk.nashorn.api.scripting.JSObject"%>
<%@page import="com.mysql.cj.xdevapi.JsonArray"%>
<%@page import="bsAPI.*"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.util.*"%>
<%@page import="com.mysql.cj.xdevapi.JsonArray"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
.details_discount {
	display: inline-block;
	font-size: 16px;
	font-weight: 500;
	color: #e95a5a;
	margin-right: 20px;
	text-decoration: line-through;
}
</style>
<%
	//設定
	request.setCharacterEncoding("utf-8");
	response.setContentType("text/html; charset=UTF-8");

	//Sql連接
	Sql sql = new Sql();
	Connection conn = sql.conn();

	//sql句法(選擇product中isSale為1的品項)(order by pid limit "從多少開始顯示","最大筆數顯示")
	String sql1 = "SELECT * ,count(*) "
			+ "FROM transactiondetail left join product on transactiondetail.pid = product.pid left join productphoto on product.pid = productphoto.pid "
			+ "where productphoto.defaultPic = 1 group by transactiondetail.pid order by count(*) desc limit 10";
	PreparedStatement prep = conn.prepareStatement(sql1);
	ResultSet rs2 = prep.executeQuery();

	//先印出容器<HTML>
	out.print("<div class='products'>");
	out.print("<div class='container'>");
	out.print("<div class='row'>");
	out.print("<div class='col'>");
	out.print("<div class='product_grid'>");

	//尋訪商品
	while (rs2.next()) {
		//抓取資料表各項欄位值
		String pname = rs2.getString("pname");
		String pprice = rs2.getString("pprice");
		String big = rs2.getString("big");
		String pid = rs2.getString("pid");
		int special = Integer.parseInt(rs2.getString("special"));

		//輸出html
		out.print("<div class='product'>");
		out.print("<div class='product_image'>");
		out.print("<img src='" + "/productPhoto" + "/" + big + "'" + "alt=''>");
		out.print("</div>");

		if (special > 0) {
			out.print("<div class='product_extra product_sale'>");
			out.print("<a href='#'>Sale</a>");
			out.print("</div>");
		}

		out.print("<div class='product_content'>");
		out.print("<div class='product_title'>");

		//進入商品詳細href(要給予PID)
		out.print("<a href=" + "'productShow.jsp?product=" + pid + "'" + ">" + pname + "</a>");

		out.print("</div>");
		if (special > 0) {
			out.print("<div class='details_discount'>$" + pprice + "</div>");
			out.print("<div class='product_price'>$" + special + "</div>");
		} else {
			out.print("<div class='product_price'>$" + pprice + "</div>");
		}
		out.print("</div>");
		out.print("</div>");
	}
	//印出容器</HTML>
	out.print("</div>");
	out.print("</div>");
	out.print("</div>");
	out.print("</div>");
	out.print("</div>");
	//搜尋與連線關閉
	rs2.close();
	conn.close();
%>