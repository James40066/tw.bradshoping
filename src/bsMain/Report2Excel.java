package bsMain;

import java.io.BufferedOutputStream;
import java.io.IOException;
import java.time.LocalDate;
import java.util.LinkedList;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;

@WebServlet("/Report2Excel")
public class Report2Excel extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		LinkedList<LinkedList<String>> lists = new LinkedList();
		lists.add((LinkedList<String>) session.getAttribute("pnameList"));
		lists.add((LinkedList<String>) session.getAttribute("tquantityList"));
		
		//PS設定檔案名稱
		String filename = "BS"+LocalDate.now().toString();
		// PS清空response，不一定需要清除，只是怕干擾
		response.reset();
		// PS設置response的Header，包含設定檔案名稱
		response.addHeader("Content-Disposition", "attachment;filename="
			+ new String(filename.getBytes(),"iso8859-1")+".xls");
		ServletOutputStream sOut=new ReportExcel(lists,response.getOutputStream()).getServletOutputStream();
		BufferedOutputStream toClient = new BufferedOutputStream(sOut);
		//PS:設定副檔名
		response.setContentType("application/vnd.ms-excel;charset=utf-8");
		toClient.flush();
		toClient.close();
		return;
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
