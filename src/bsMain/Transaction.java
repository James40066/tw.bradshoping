package bsMain;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;

import bsAPI.Sql;

public class Transaction {
	
	public static void updateLastOrderNo(String tid,String tidNew) {
		Sql sql = null;
		Connection conn = null;
		CallableStatement prep = null;
		try {
			sql = new Sql();
			conn = sql.conn();
			prep = conn.prepareCall("{call updateTid(?,?)}");
			prep.setString(1, tidNew);
			prep.setString(2, tid);
			prep.execute();
			conn.close();
			sql.closeSql();
		} catch (Exception e) {
			System.err.println(e.toString());
			if (conn!=null) {
				try {
					conn.close();
					sql.closeSql();
				} catch (Exception e2) {}
			}
		}
	}
}
