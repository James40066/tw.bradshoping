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
<%
	//設定
	request.setCharacterEncoding("utf-8");
	response.setContentType("text/html; charset=UTF-8");
	boolean error;

	//接收搜尋參數
	String Search = request.getParameter("Search");
	if (Search == null) {
		response.sendRedirect("ProductsView.jsp");
	}
	//out.print(Search);

	//設定頁碼參數
	String Page = request.getParameter("Page");

	//ProductMaxSize=>頁面最大顯示商品數
	int ProductMaxSize = 12;

	//使用者的頁面數
	int PageNum;
	if (Page == null) {
		//如果接收的頁碼參數為NULL就當他預設1
		PageNum = 1;
	} else {
		PageNum = Integer.parseInt(Page);
	}
	//存入session(給include的人用)
	session.setAttribute("PageNum", PageNum);
	session.setAttribute("Page", Page);

	//Sql連接
	Sql sql = new Sql();
	Connection conn = sql.conn();

	//Sql句法(先撈出有多少筆搜尋的資料)
	String sqlsearch1 = "SELECT count(*) FROM product where pname like " + "'%" + Search + "%'"
			+ "and isSale =1";
	PreparedStatement prep1 = conn.prepareStatement(sqlsearch1);
	ResultSet rs1 = prep1.executeQuery();

	//計算搜尋商品最大頁面數
	int ProductMaxPage = 0;
	if (rs1.next()) {
		if (rs1.getInt(1) != 0) {
			//最大頁面數=(四捨五入)(搜尋總筆數/(float)頁面最大顯示商品數+1(偏移量)
			ProductMaxPage = (int) (rs1.getInt(1) / (float) ProductMaxSize +1 );
			session.setAttribute("ProductMaxPage", ProductMaxPage);

			//sql句法(選擇product中isSale為1的品項)(order by pid limit "從多少開始顯示","最大筆數顯示")
			String sql2 = "SELECT product.pid,product.pname,product.pprice,product.isSale,productphoto.defaultPic,productphoto.big,product.special"
					+ " FROM cart.product left join cart.productphoto on cart.product.pid =cart.productphoto.pid "
					+ " where isSale =1 and defaultPic=1 and pname like " + "'%" + Search + "%'"
					+ " order by pid limit " + ((PageNum - 1) * ProductMaxSize) + "," + ProductMaxSize;

			PreparedStatement prep2 = conn.prepareStatement(sql2);
			ResultSet rs2 = prep2.executeQuery();

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
		} else {
			//若有搜尋例外(沒有搜尋的品項),種session
			error = true;
			session.setAttribute("error", error);
			return;
		}
	}
%>
