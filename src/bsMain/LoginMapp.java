package bsMain;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONObject;
import bsAPI.PwdHash;
import bsAPI.Sql;
import bsAPI.UserData;

@WebServlet("/LoginMapp")
public class LoginMapp extends HttpServlet {
	private HttpServletRequest request;
	private HttpServletResponse response;
	private HttpSession session;
	private Sql sql;
	private Connection conn;
	private String sql1 = null;
	private HashMap<String, Object> loginInfo;
	private PrintWriter out;
	private UserData userData;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.request = request;
		this.response = response;
		this.session = request.getSession();
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=UTF-8");
		out = response.getWriter();

		// app端接收參數
		String typeStr = request.getParameter("type");
		String account = request.getParameter("BSaIn");
		String passwd = request.getParameter("BSpIn");
		String BSGId = request.getParameter("BSGId");
		String BSFbId = request.getParameter("BSFbId");
		
		try {
			int type = Integer.parseInt(typeStr);
			switch (type) {
			case UserData.NORMAL:
				sql1 = "SELECT * FROM member where account = ?";
				selectIdToSQL(type, account, passwd);
				break;
			case UserData.GOOGLE:
				sql1 = "SELECT * FROM member where isgoogle = ?";
				selectIdToSQL(type, BSGId, null);
				break;
			case UserData.FACEBOOK:
				sql1 = "SELECT * FROM member where isfacebook = ?";
				selectIdToSQL(type, BSFbId, null);
				break;
			default:
				break;
			}
		} catch (Exception e) {
			System.err.println(e.toString()+":LoginMapp");
		}
	}

	// 資料庫查詢
	private void selectIdToSQL(int type, String sid, String passwd) {
		try {
			sql = new Sql();
			conn = sql.conn();
			PreparedStatement prep1 = conn.prepareStatement(sql1);
			prep1.setString(1, sid);
			ResultSet rs = prep1.executeQuery();
			if (rs.next()) {
				if (type != UserData.NORMAL || 
						(type==UserData.NORMAL&&PwdHash.checkPwd(passwd, rs.getString("password")))) {
					userData = new UserData(rs,type);
					out.print("true="+new JSONObject(userData.getMember()).toString());
				}else {
					out.print("false=fail");
				}
			}else {
				out.print("false=fail");
			}
			sql.closeSql();
			conn.close();
		} catch (Exception e) {
			System.err.println(e.toString());
			if (conn!=null) {
				try {
					sql.closeSql();
					conn.close();
				} catch (Exception e2) {}
			}
		}
	}
}
