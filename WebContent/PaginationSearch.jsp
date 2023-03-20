<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//接收分頁參數
	int PageNum = 0;
	int ProductMaxPage = 0;
	boolean error;
	try {
		PageNum = (int) session.getAttribute("PageNum");
		ProductMaxPage = (int) session.getAttribute("ProductMaxPage");
	} catch (Exception e) {
		//捕捉例外,種session
		error = true;
		session.setAttribute("error", error);
		return;
		//System.out.print(e.toString());
	}

	//接收搜尋參數
	String Search = request.getParameter("Search");

	//搜尋參數轉成URLEncode
	String SearchEncode = URLEncoder.encode(Search, "UTF-8");
	//System.out.print(SearchEncode);
	//"ProductsViewSearch.jsp?Page=" + (PageNum - 1 <= 0 ? 1 : PageNum - 1) + "&" + "Search="+ SearchEncode
	//"<a class='page-link'" + " href='ProductsViewSearch.jsp?Page=" + i + "&" + "Search="+ SearchEncode + "'>" + i + "</a></li>"
%>
<style>
.page-item1.active1 .page-link {
    z-index: 2;
    background-color: 	#000000;
    border-color: 	#000000;
    color: white !important ;
}
.sp{
   height: 10px;
}
</style>
<!-- 分頁按鈕 -->
<div class="row justify-content-center">
	<nav aria-label="...">
		<ul class="pagination">
			<li class="page-item"><a class="page-link text-dark"
				href="<%out.print("ProductsViewSearch.jsp?Search=" + SearchEncode + "&" + "Page="
					+ (PageNum - 1 <= 0 ? 1 : PageNum - 1));%>"
				tabindex="-1" aria-disabled="true">上一頁</a></li>
			<%
				//印出分頁的按鈕
				for (int i = 1; i <= ProductMaxPage; i++) {
					if (PageNum == i) {
						out.print("<li class='page-item1 active1' aria-current='page'>");
					} else {
						out.print("<li class='page-item text-dark'>");
					}
					out.print("<a class='page-link text-dark'" + " href='ProductsViewSearch.jsp?Search=" + SearchEncode + "&"
							+ "Page=" + i + "'>" + i + "</a></li>");
				}
				session.removeAttribute("PageNum");
				session.removeAttribute("ProductMaxPage");
			%>
			<li class="page-item"><a class="page-link text-dark"
				href="<%out.print("ProductsViewSearch.jsp?Search=" + SearchEncode + "&" + "Page="
					+ (PageNum + 1 >= ProductMaxPage ? ProductMaxPage : PageNum + 1));%>">下一頁</a>
			</li>
		</ul>
	</nav>
</div>
<div class="sp"></div>