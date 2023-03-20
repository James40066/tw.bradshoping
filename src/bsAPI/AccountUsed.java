package bsAPI;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/AccountUsed")
public class AccountUsed extends HttpServlet {
	private Connection conn;
	private String sqlCode = "select * from member where account= ?";
	private PreparedStatement pstmt;
	private Sql sql;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		String account = request.getParameter("account");
		if(account==null) {
			return;
		}
		out.print(ckAccountUsed(account));	//PS:將ckAccount回傳的值傳回去給SignUp的Ajax。
	}
	
	//PS:這個方法是給後端判斷帳號是否已經被使用，所呼叫的。
	public int isAccountUsed(String account) {
		return ckAccountUsed(account);
	}
	
	private int ckAccountUsed(String account) {
		//PS:結果是1 代表沒重複。 2已經有使用 3例外發生
		int isOK=1;
		try {
			sql = new Sql();
			conn = sql.conn();
			pstmt = conn.prepareStatement(sqlCode);
			pstmt.setString(1, account);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				isOK = 2;
			}
			conn.close();
			sql.closeSql();
			return isOK;
		}catch (Exception e) {
			System.out.println(e);
			if(conn!=null) {
				try {
					conn.close();
					sql.closeSql();
					System.out.println(conn.isClosed());
				} catch (SQLException e1) {
					System.out.println(e);
				}
			}
			isOK=3;
			return isOK;
		}
	}
	
	@Override
	public void destroy() {
		System.out.println("close");
		if (conn!=null) {
			try {
			conn.close();
			}catch(Exception e) {}
		}
		super.destroy();
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
