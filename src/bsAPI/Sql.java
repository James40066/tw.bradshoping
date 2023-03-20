package bsAPI;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class Sql {
	private Connection conn=null;
	
	public Connection conn() {
		return connSql();
	}
	
	public void closeSql() throws SQLException {
		
		try {
			if(!conn.isClosed()) {
				conn.close();
				conn=null;
			}
		} catch (Exception e) {
			System.out.println("Close fail");
			System.out.println(e);
		}
		
	}
	
	private Connection connSql() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Properties prop = new Properties();
			prop.put("user", "root");
			prop.put("password", "jay0519");
			prop.put("serverTimezone", "Asia/Taipei");
			conn = DriverManager.getConnection(
					"jdbc:mysql://localhost/cart",prop);
			//System.out.println("conn OK");
			return conn;
		} catch (Exception e) {
			return conn;
		}
	}
}
