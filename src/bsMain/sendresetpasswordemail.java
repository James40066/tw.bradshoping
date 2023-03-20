package bsMain;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import bsAPI.*;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/sendresetpasswordemail")
public class sendresetpasswordemail extends HttpServlet {
	private String from = "bradshoppingIII@gmail.com";
	private String host = "localhost";
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//1.接收來自於from 的email →user的email
		String to = request.getParameter("email");

		//2. 產生辨識用密碼→寫入資料庫
		String pcode = "p" + System.currentTimeMillis();
		
		//連接資料庫
		Sql sql=new Sql();
		Connection conn=sql.conn();
		//寫入資料庫
		try {
			//判斷如果是第三方登入，回直接導回login.jsp
			PreparedStatement pr=conn.prepareStatement("SELECT* FROM member WHERE account=? and isgoogle IS NULL and isfacebook IS Null ");
			pr.setString(1, to);
			ResultSet rs=pr.executeQuery();
			if(rs.next()) {
				pr=conn.prepareStatement("UPDATE member SET resetpassword=? WHERE account=?");
				pr.setString(1, pcode);
				pr.setString(2, to);
				pr.executeUpdate();
				
				// 自訂類別寄信
				sendResetEmail(to, pcode);
			}
			
			
			sql.closeSql();
			conn.close();
		}catch(Exception e) {
			System.out.println(e.toString());
		}
		
		response.sendRedirect("login.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
	//pid讓你使用url
	private void sendResetEmail(String to, String pcode) {

		// Get system properties
		Properties properties = System.getProperties();

		// Setup mail server
		properties.setProperty("mail.smtp.host", "smtp.gmail.com");
		properties.setProperty("mail.smtp.auth", "true");
		properties.setProperty("mail.smtp.starttls.enable", "true");
		properties.setProperty("mail.smtp.port", "587");

		// Get the default Session object.
		Session session = Session.getInstance(properties, new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(from, "!@#qweasdzxc");
			}
		});

		try {
			// Create a default MimeMessage object.
			MimeMessage message = new MimeMessage(session);

			// Set From: header field of the header.
			message.setFrom(new InternetAddress(from));

			// Set To: header field of the header.
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

			// Set Subject: header field
			message.setSubject("This is the Subject Line!");

			// Send the actual HTML message, as big as you like

			// 把剛剛的resetpaw.html語碼貼上並要有連結
			 message.setContent(
					 "<!doctype html><html><meta charset='utf-8'><head>"+
					    "<meta name='viewport' content='width=device-width, initial-scale=1, shrink-to-fit=no'>"+
					    "<link rel='stylesheet' href='https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.cs' integrity='sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T' crossorigin='anonymous'>"+
					    "<style type='text/css'>.space { height: 100px; } </style>"+
					    "</head><body>"+
					    "<div class='space'></div>"+
					    "<div class='container'>"+
					    "<div class='alert alert-info' role='alert'>"+
					    "<h1 class='display-4'>重設您的密碼</h1>"+
					    "<hr class='my-4'>"+
					    "<p>請點擊按鈕，將跳轉至修改密碼頁面</p>"+
					    "<a class='btn btn-info btn-lg' href="+"'"+ getServletContext().getInitParameter("ngrok")+"tw.bradshoping/ChangePassWord.jsp?pcode="+pcode+"' "+"role='button'>重設密碼</a>"+
					     "</div></div></body></html>"
					   , "text/html ;charset=UTF-8");

			// Send message
			Transport.send(message);

			System.out.println("寄送信件成功....");
		} catch (MessagingException mex) {
			mex.printStackTrace();
		}
	}

}
