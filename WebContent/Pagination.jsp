<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//接收分頁參數
	int PageNum = (int) session.getAttribute("PageNum");
	int ProductMaxPage = (int) session.getAttribute("ProductMaxPage");
	session.removeAttribute("PageNum");
	session.removeAttribute("ProductMaxPage");
%>
<!-- 分頁按鈕 -->
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
<div class="row justify-content-center">
	<nav aria-label="...">
		<ul class="pagination">
			<li class="page-item"><a class="page-link text-dark"
				href="<%out.print("ProductsView.jsp?Page=" + (PageNum - 1 <= 0 ? 1 : PageNum - 1));%>"
				tabindex="-1" aria-disabled="true">上一頁</a></li>
			<%
				//印出分頁的按鈕
				for (int i = 1; i <= ProductMaxPage; i++) {
					if (PageNum == i) {
						out.print("<li class='page-item1 active1 ' aria-current='page'>");
					} else {
						out.print("<li class='page-item text-dark'>");
					}
					out.print("<a class='page-link text-dark'" + " href='ProductsView.jsp?Page=" + i + "'>" + i
							+ "</a></li>");
				}
			%>
			<li class="page-item"><a class="page-link text-dark"
				href="<%out.print("ProductsView.jsp?Page=" + (PageNum + 1 >= ProductMaxPage ? ProductMaxPage : PageNum + 1));%>">下一頁</a>
			</li>
		</ul>
	</nav>
</div>
<div class="sp"></div>
