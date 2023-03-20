package bsMain;

import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.time.LocalDate;
import java.util.LinkedList;

import javax.servlet.ServletOutputStream;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.HorizontalAlignment;

public class ReportExcel {
	private LinkedList<LinkedList<String>> lists;
	private String path;
	private HSSFWorkbook workbook;
	private ServletOutputStream sOut;
	public ReportExcel(LinkedList<LinkedList<String>> lists,ServletOutputStream sOut) {
		this.lists = lists;
		this.sOut = sOut;
		createExcel();
	}
	private void createExcel() {
		// PS建立一個Excel檔案
		workbook = new HSSFWorkbook();
		// PS建立一個工作表
		HSSFSheet sheet = workbook.createSheet("BS銷售報表");
		// PS新增表頭行
		HSSFRow hssfRow = sheet.createRow(0);
		// PS設定單元格格式居中
		HSSFCellStyle cellStyle = workbook.createCellStyle();
		cellStyle.setAlignment(HorizontalAlignment.CENTER);
		// PS新增表頭內容
		HSSFCell headCell = hssfRow.createCell(0);
		headCell.setCellValue("#");
			headCell.setCellStyle(cellStyle);
		headCell = hssfRow.createCell(1);
		headCell.setCellValue("商品名稱");
			headCell.setCellStyle(cellStyle);
		headCell = hssfRow.createCell(2);
		headCell.setCellValue("銷售數量");
			headCell.setCellStyle(cellStyle);
		// PS新增資料內容
		HSSFCell cell = null;
		for (int i = 0; i < lists.get(0).size(); i++) {
			hssfRow = sheet.createRow((int) i + 1);
			cell = hssfRow.createCell(0);
			cell.setCellValue(i+1);
			cell.setCellStyle(cellStyle);
			sheet.autoSizeColumn(0);
			for(int j=0; j<lists.size(); j++) {
				cell = hssfRow.createCell(j+1);
				cell.setCellValue(lists.get(j).get(i));
				if (j!=0) {
					cell.setCellStyle(cellStyle);
				}
				sheet.autoSizeColumn(1);
			}
		}
		//excel寫入輸出流
		try {
			workbook.write(sOut);
		} catch (IOException e) {
			System.err.println(e.toString()+":ReportExcel");
		}
		//PS第幾索引的欄位自動寬度
		// PS本地端儲存Excel檔案
//		try {
//			path ="BS"+LocalDate.now().toString()+".xls";
//			BufferedOutputStream outputStream = new BufferedOutputStream(
//					new FileOutputStream("C://bradshoping/reportExcel/"+path));
//			workbook.write(outputStream);
//			outputStream.close();
//		} catch (Exception e) {
//			
//		}
	}
	
	public ServletOutputStream getServletOutputStream() {
		return sOut;
	}
}
