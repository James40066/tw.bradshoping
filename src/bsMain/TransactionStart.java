package bsMain;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.HashMap;

import javax.servlet.ServletException;
//import javax.servlet.ServletRequest;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import bsAPI.Sql;

@WebServlet("/TransactionStart")
public class TransactionStart extends HttpServlet {
	private ShoppingCartData sc;
	private LocalDate date;
	private String receive;
	private String tid;
	private String faceAddress;

	private int transactionTotal;
	private int selleridcheck;
	private int unitPrice;
	private int OrderPostTotal;
	private boolean init;
	private int test = 0;
	private TransactionSetBlueInfo sb;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		// 取得會員ID(沒有session就出去)
		HttpSession session = request.getSession(false);
		HashMap<String, Object> member = (HashMap<String, Object>) session.getAttribute("member");
		if (member == null) {
			response.sendRedirect("login.jsp");
			return;
		}
		int id = (int) member.get("id");
		String email = (String) member.get("account");

		// 其他參數接收
		int post = Integer.parseInt(request.getParameter("post"));

		String coupon = null;
		if (request.getParameter("coupon") != null) {
			coupon = request.getParameter("coupon");
		}

		date = LocalDate.now();
		tid = "t" + System.currentTimeMillis();

		// 做出購物車表格物件實體拿到ResultSet
		sc = new ShoppingCartData(id);
		ResultSet rs1 = sc.getRs();

		// 尋訪購物車
		try {

			initparameter();
			while (rs1.next()) {

				int pid = Integer.parseInt(rs1.getString("pid"));
				int pprice = Integer.parseInt(rs1.getString("pprice"));
				int special = Integer.parseInt(rs1.getString("special"));
				int quantity = Integer.parseInt(rs1.getString("quantity"));
				int sellerid = Integer.parseInt(rs1.getString("sellerid"));
				faceAddress = rs1.getString("faceAddress");

				if (special > 0) {
					unitPrice = special;
				} else {
					unitPrice = pprice;
				}

				if (init) {
					selleridcheck = sellerid;
					OrderPostTotal = (post == 0 ? 0 : 60);
					init = false;
				}

				if (selleridcheck != sellerid) {
					OrderPostTotal += (post == 0 ? 0 : 60);
					selleridcheck = sellerid;
				}

				transactionTotal += (unitPrice * quantity);

				SaveToTransactiondetail(tid, sellerid, pid, quantity, unitPrice);
			}

			transactionTotal += OrderPostTotal;

			System.out.println("final" + "=>" + transactionTotal);
			System.out.println("test=>" + test);

			if (post == 0) {
				receive = faceAddress;

			} else {
				receive = request.getParameter("receive");
			}

			SaveToTransaction(tid, date, id, post, receive, coupon);
			sc.closeSQL();

			// 存入資料結構(自訂類別建構物件實體時順便種session)
			sb = new TransactionSetBlueInfo(tid, email, transactionTotal, session);
			sb.setblueinfo();

			// 訂單創立完成,導入藍新科技表單頁面
			response.sendRedirect("TransactionForm.jsp");

		} catch (SQLException e) {
			System.out.println(e.toString());
		}
	}

	private void SaveToTransaction(String tid, LocalDate date, int id, int post, String receive, String coupon) {
		try {
			// 連接SQL
			Sql sql = new Sql();
			Connection conn = sql.conn();

			String sql1 = "INSERT INTO transaction (tid, tdate, buyid, post, receive,status,coupon) VALUES (?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement prep1 = conn.prepareStatement(sql1);
			prep1.setString(1, tid);
			prep1.setString(2, date.toString());
			prep1.setInt(3, id);
			prep1.setInt(4, post);
			prep1.setString(5, receive);
			prep1.setInt(6, 0);
			prep1.setString(7, coupon);
			int count = prep1.executeUpdate();

			sql.closeSql();
			conn.close();
		} catch (SQLException e) {
			System.out.println(e.toString());
		}
	}

	private void SaveToTransactiondetail(String tid, int sellerid, int pid, int quantity, int unitPrice) {
		try {
			// 連接SQL
			Sql sql = new Sql();
			Connection conn = sql.conn();

			String sql2 = "INSERT INTO transactiondetail (tid, sellerid, pid, quantity, unitPrice) VALUES (?, ?, ?, ?, ?)";
			PreparedStatement prep2 = conn.prepareStatement(sql2);
			prep2.setString(1, tid);
			prep2.setInt(2, sellerid);
			prep2.setInt(3, pid);
			prep2.setInt(4, quantity);
			prep2.setInt(5, unitPrice);
			int count = prep2.executeUpdate();

			sql.closeSql();
			conn.close();
		} catch (SQLException e) {
			System.out.println(e.toString());
		}
	}

	private void initparameter() {
		transactionTotal = 0;
		selleridcheck = 0;
		unitPrice = 0;
		OrderPostTotal = 0;
		init = true;
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
