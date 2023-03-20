package bsMain;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class sendemail {

	public static void main(String[] args) {

		// Recipient's email ID needs to be mentioned.
		String to = "james40066@yahoo.com.tw";

		// Sender's email ID needs to be mentioned
		String from = "bradshoppingIII@gmail.com";

		// Assuming you are sending email from localhost
		String host = "localhost";

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
			message.setSubject("布萊德商店!");

			// Send the actual HTML message, as big as you like
			// message.setContent("<h1>This is actual message</h1>", "text/html");

			message.setContent("<!doctype html><html><meta charset='utf-8'><head>"
					+ "<meta name='viewport' content='width=device-width, initial-scale=1, shrink-to-fit=no'>"
					+ "<link rel='stylesheet' href='https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.cs' integrity='sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T' crossorigin='anonymous'>"
					+ "<style type='text/css'>.space { height: 100px; } </style>" + "</head><body>"
					+ "<div class='space'></div>" + "<div class='container'>"
					+ "<div class='alert alert-info' role='alert'>" + "<h1 class='display-4'>重設您的密碼</h1>"
					+ "<hr class='my-4'>" + "<p>請點擊按鈕，將跳轉至修改密碼頁面。此連結有效期限只有1小時，逾時麻煩請重新再操作一次忘記密碼流程。</p>" + "<a class='btn btn-info btn-lg' href="
					+ "https://disp.cc" + "role='button'>重設密碼</a>" + "</div></div></body></html>",
					"text/html; charset=UTF-8");
			// Send message
			Transport.send(message);

			System.out.println("Sent message successfully....");
		} catch (MessagingException mex) {
			mex.printStackTrace();
		}
	}

}
