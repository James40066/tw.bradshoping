package bsMain;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import bsAPI.Sql;

public class TransactionGetTransactionTotal {
	private Sql sql;
	private Connection conn;
	private ResultSet rs1;
	private int TransactionTotal = 0;
	private int OrderPostTotal = 0;
	private int Price = 0;
	private int discout = 0;
	private int checksellid = 0;
	private boolean init = true;

	public TransactionGetTransactionTotal(String tid) {
		try {
			sql = new Sql();
			conn = sql.conn();
			// 查詢購物車商品
			String sql1 = "select * from transaction right join transactiondetail on transaction.tid = transactiondetail.tid left join coupon on coupon = cname "
					+ "where transaction.tid = ? order by sellerid ";
			PreparedStatement prep1 = conn.prepareStatement(sql1);
			prep1.setString(1, tid);
			rs1 = prep1.executeQuery();

			while (rs1.next()) {
				// 要用店家來判斷運費
				int unitPrice = Integer.parseInt(rs1.getString("unitPrice"));
				int quantity = Integer.parseInt(rs1.getString("quantity"));
				int post = (Integer.parseInt(rs1.getString("post")) == 0 ? 0 : 60);
				int sellerid = Integer.parseInt(rs1.getString("sellerid"));
				discout = rs1.getString("discout") != null ? Integer.parseInt(rs1.getString("discout")) : 0;

				TransactionTotal += (unitPrice * quantity);

				if (init) {
					checksellid = sellerid;
					OrderPostTotal += post;
					init = false;
				}
				if (checksellid != sellerid) {
					OrderPostTotal += post;
					checksellid = sellerid;
				}
			}
			TransactionTotal += OrderPostTotal;

		} catch (SQLException e) {
			System.out.print(e.toString());
		}

	}

	public int GetTransactionTotal() {
		return TransactionTotal;

	}

}
