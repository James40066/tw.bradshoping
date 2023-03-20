package bsMain;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.LinkedList;

import bsAPI.Sql;

public class MemberItems {
	private Boolean isBuyer;
	private int id;
	private Sql sql;
	private Connection conn;
	private CallableStatement call;
	private ResultSet rs;
	private LinkedList<HashMap<String, String>> datas;
	
	private void getdata() {
		try {
			datas = new LinkedList<HashMap<String,String>>();
			sql = new Sql();
			conn = sql.conn();
			call = conn.prepareCall(isBuyer?"{call getBuyerItems(?)}":"{call getsellerItems(?)}");
			call.setInt(1, id);
			rs = call.executeQuery();
			
			addDatas();
			
			conn.close();
			sql.closeSql();
		} catch (Exception e) {
			System.err.println(e.toString());
			try {
				if (conn!=null) {
					conn.close();
					sql.closeSql();
				}
			} catch (Exception e2) {}
		}		
	}
	
	private void addDatas() {
		try {
			if (isBuyer) {
				while (rs.next()) {
					HashMap<String, String> data = new HashMap<String, String>();
					data.put("tid", rs.getString("tid"));
					data.put("tdate", rs.getString("tdate"));
					data.put("pname", rs.getString("pname"));
					data.put("items", rs.getString("items"));
					data.put("itemsSum", rs.getString("post").equals("0")?rs.getString("itemsSum"):
							Integer.parseInt(rs.getString("itemsSum"))+
								Integer.parseInt(rs.getString("sellers"))*60+"");
					data.put("photo", rs.getString("small"));
					data.put("status", rs.getInt("status")==0?"待付款":"待出貨");
					datas.add(data);
				}
			}else {
				while (rs.next()) {
					HashMap<String, String> data = new HashMap<String, String>();
					data.put("tid", rs.getString("tid"));
					data.put("tdate", rs.getString("tdate"));
					data.put("name", rs.getString("name"));
					data.put("post", rs.getInt("post")==0?"面交":"郵寄");
					data.put("receive", rs.getString("receive"));
					data.put("items", rs.getString("items"));
					data.put("itemsSum", rs.getString("itemsSum"));
					data.put("coupon", rs.getString("coupon")==null?"無":rs.getString("coupon"));
					data.put("status", rs.getInt("status")==0?"待付款":"待出貨");
					datas.add(data);
				}
			}
			conn.close();
			sql.closeSql();
		} catch (Exception e) {
			System.err.println(e.toString());
			try {
				if (conn!=null) {
					conn.close();
					sql.closeSql();
				}
			} catch (Exception e2) {}
		}
	}
	
	
	public LinkedList<HashMap<String, String>> getDatas() {
		getdata();
		return datas;
	}

	public void setIsBuyer(Boolean isBuyer) {
		this.isBuyer = isBuyer;
	}
	public void setId(int id) {
		this.id = id;
	}
}
