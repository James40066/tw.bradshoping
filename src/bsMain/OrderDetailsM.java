package bsMain;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.LinkedList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mysql.cj.protocol.ServerSession;

import bsAPI.Sql;

public class OrderDetailsM extends HttpServlet {
	private Sql sql;
	private Connection conn;
	private HashMap<String, Object> SellerOrderInfo;
	private LinkedList<HashMap<String, Object>> SellerOrderProductInfo, BuyerOrderProductInfo, BuyerOrderInfo;
	private int SellerOrderProductTotal = 0;
	private int SellerProductQuantity = 0;

	public OrderDetailsM() {
		sql = new Sql();
		conn = sql.conn();
		SellerOrderInfo = new HashMap<String, Object>();
		SellerOrderProductInfo = new LinkedList<HashMap<String, Object>>();
		BuyerOrderInfo = new LinkedList<HashMap<String, Object>>();
		BuyerOrderProductInfo = new LinkedList<HashMap<String, Object>>();
	}

	public LinkedList<HashMap<String, Object>> getBuyerOrderDetails(int buyid, String tid) {
		try {
			String sql1 = "select transaction.tid,tdate,post,receive,status,quantity,unitPrice,pname,small,name,coupon,discout,storeName "
					+ "from transaction  left join transactiondetail on transaction.tid = transactiondetail.tid "
					+ "left join product on transactiondetail.pid = product.pid "
					+ "left join productphoto on product.pid = productphoto.pid "
					+ "left join member on product.id = member.id "
					+ "left join coupon on transaction.coupon = coupon.cname "
					+ "where  defaultPic=1 and  transaction.buyid=? and transaction.tid =? order by name";
			PreparedStatement prep = conn.prepareStatement(sql1);
			prep.setInt(1, buyid);
			prep.setString(2, tid);
			ResultSet rs1 = prep.executeQuery();

			while (rs1.next()) {
				HashMap<String, Object> boInfo = new HashMap<String, Object>();

				String tdate = rs1.getString("tdate");
				int post = Integer.parseInt(rs1.getString("post"));
				String receive = rs1.getString("receive");
				int status = Integer.parseInt(rs1.getString("status"));
				int quantity = Integer.parseInt(rs1.getString("quantity"));
				int unitPrice = Integer.parseInt(rs1.getString("unitPrice"));
				String pname = rs1.getString("pname");
				String small = rs1.getString("small");
				String SellerName = rs1.getString("name");
				String coupon = rs1.getString("coupon") == null ? "null" : rs1.getString("coupon");
				int discout = rs1.getString("discout") != null ? Integer.parseInt(rs1.getString("discout")) : 0;
				String storeName = rs1.getString("storeName") != null ? rs1.getString("storeName") : SellerName + "的商店";

				boInfo.put("tdate", tdate);
				boInfo.put("post", post);
				boInfo.put("receive", receive);
				boInfo.put("status", status);
				boInfo.put("quantity", quantity);
				boInfo.put("unitPrice", unitPrice);
				boInfo.put("pname", pname);
				boInfo.put("small", small);
				boInfo.put("SellerName", SellerName);
				boInfo.put("coupon", coupon);
				boInfo.put("discout", discout);
				boInfo.put("storeName", storeName);

				BuyerOrderInfo.add(boInfo);
			}
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return BuyerOrderInfo;
	}

	public HashMap<String, Object> getSellerOrderDetails(String tid) {
		try {
			String sql1 = "select * from transaction  left join member on transaction.buyid = member.id "
					+ "where transaction.tid =?";
			PreparedStatement prep = conn.prepareStatement(sql1);
			prep.setString(1, tid);
			ResultSet rs1 = prep.executeQuery();

			while (rs1.next()) {
				String tdate = rs1.getString("tdate");
				int post = Integer.parseInt(rs1.getString("post"));
				String receive = rs1.getString("receive");
				int status = Integer.parseInt(rs1.getString("status"));
				String name = rs1.getString("name");

				SellerOrderInfo.put("tdate", tdate);
				SellerOrderInfo.put("post", post);
				SellerOrderInfo.put("receive", receive);
				SellerOrderInfo.put("status", status);
				SellerOrderInfo.put("name", name);
			}
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return SellerOrderInfo;
	}

	public LinkedList<HashMap<String, Object>> getSellerOrderDetailsProduct(String tid, int sellerid) {
		try {
			String sql2 = "select tid,quantity,unitPrice,sellerid,pname,small "
					+ "from transactiondetail left join product on transactiondetail.pid = product.pid left join productphoto on product.pid = productphoto.pid "
					+ "where defaultPic = 1 and tid = ? and sellerid=?";
			PreparedStatement prep = conn.prepareStatement(sql2);
			prep.setString(1, tid);
			prep.setInt(2, sellerid);
			ResultSet rs2 = prep.executeQuery();

			// 順序=>1.small=>2.pname=>3.unitPrice=>4.quantity
			while (rs2.next()) {
				HashMap<String, Object> pInfo = new HashMap<String, Object>();

				String small = rs2.getString("small");
				String pname = rs2.getString("pname");
				int unitPrice = Integer.parseInt(rs2.getString("unitPrice"));
				int quantity = Integer.parseInt(rs2.getString("quantity"));

				SellerOrderProductTotal += (unitPrice * quantity);
				SellerProductQuantity++;

				pInfo.put("small", small);
				pInfo.put("pname", pname);
				pInfo.put("unitPrice", unitPrice);
				pInfo.put("quantity", quantity);

				SellerOrderProductInfo.add(pInfo);
			}

		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return SellerOrderProductInfo;
	}

	public int getSellerOrderProductTotal() {
		return SellerOrderProductTotal;
	}

	public int getSellerProductQuantity() {
		return SellerProductQuantity;
	}

	public void closeSQL() {
		try {
			sql.closeSql();
			conn.close();
		} catch (SQLException e) {
			System.out.println(e.toString());
		}
	}
}
