package bsMain;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.LinkedList;

import bsAPI.Sql;

public class ShoppingCartData {
	private int id;
	private Sql sql;
	private Connection conn;
	private ResultSet rs1;
	private int Ordertotal = 0;

	public ShoppingCartData(int id) {
		sql = new Sql();
		conn = sql.conn();
		this.id = id;
		try {
			// 查詢購物車商品
			String sql1 = "SELECT shoppingcart.id,shoppingcart.pid,shoppingcart.quantity,product.pname,product.pprice,productphoto.big,product.id AS sellerid,"+
					"product.special ,faceAddress "+
	                "FROM cart.shoppingcart right join cart.product on shoppingcart.pid= product.pid  right join cart.productphoto on product.pid = productphoto.pid "+ 
					"right join member on product.id = member.id "+
					"where cart.shoppingcart.id =? and cart.productphoto.defaultPic= 1 order by sellerid";
			PreparedStatement prep1 = conn.prepareStatement(sql1);
			prep1.setInt(1, id);
			rs1 = prep1.executeQuery();

		} catch (SQLException e) {
			System.out.print(e.toString());
		}
	}

	public ResultSet getRs() {
		return rs1;
	}

	public int getTotal() {
		try {
			rs1.absolute(0);
			while (rs1.next()) {
				int pprice = rs1.getInt("pprice");
				int quantity = rs1.getInt("quantity");
				int special = Integer.parseInt(rs1.getString("special"));
				if (special > 0) {
					Ordertotal += (special * quantity);
				} else {
					Ordertotal += (pprice * quantity);
				}
			}
		} catch (SQLException e) {
			System.err.print(e.toString());
		}
		return Ordertotal;
	}

	public void closeSQL() {
		try {
			rs1.close();
			sql.closeSql();
			conn.close();
		} catch (SQLException e) {
			System.err.print(e.toString());
		}
	}
}
