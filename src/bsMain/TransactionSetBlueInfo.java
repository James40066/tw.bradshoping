package bsMain;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/TransactionSetBlueInfo")
public class TransactionSetBlueInfo extends HttpServlet {
	private String tidOld,tidNew;
	private String email;
	private int transactionTotal =0;
	private HashMap<String, Object> blueInfo;
	private HttpSession session;

	public TransactionSetBlueInfo() {
		super();
	}

	public TransactionSetBlueInfo(String tid, String email, int transactionTotal,HttpSession session) {
		// 建構式給購物車用
		this.tidOld = tid;
		this.tidNew = tid;
		this.email = email;
		this.transactionTotal = transactionTotal;
		this.session = session;
	}

	public void setblueinfo() {
		blueInfo = new HashMap<String, Object>();
		blueInfo.put("email", email);
		blueInfo.put("tid", tidOld);
		blueInfo.put("tidNew", tidNew);
		blueInfo.put("transactionTotal", transactionTotal);
		session.setAttribute("blueInfo", blueInfo);
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			session = request.getSession(false);

			HashMap<String, Object> member = (HashMap<String, Object>) session.getAttribute("member");
			if (member == null) {
				response.sendRedirect("login.jsp");
				return;
			}

			email = (String) member.get("account");
			tidOld = request.getParameter("tCode");
			TransactionGetTransactionTotal tg = new TransactionGetTransactionTotal(tidOld);
			transactionTotal = tg.GetTransactionTotal();
			tidNew = "t"+System.currentTimeMillis();
			setblueinfo();

			response.sendRedirect("TransactionForm.jsp");
		} catch (Exception e) {
			System.out.println(e.toString());
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
