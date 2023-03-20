package bsMain;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.Charset;
import java.nio.charset.StandardCharsets;
import org.json.JSONObject;

public class RegisteredReCaptcha {
	private static String secretKey = "6Lfi0rkUAAAAAEXsZeeuSeKxggkNsEz-GgmUaTfF";

	private static boolean checkReCaptcha(String captchaToken) {
		boolean isReCaptchaOK = false;
		try {
			String urlParameters = "secret=" + secretKey + "&response=" + captchaToken;
			byte[] postData = urlParameters.getBytes(StandardCharsets.UTF_8);
			int postDataLength = postData.length;

			URL url = new URL("https://www.google.com/recaptcha/api/siteverify");
			HttpURLConnection URLConn = (HttpURLConnection) url.openConnection();
			URLConn.setRequestMethod("POST");
			URLConn.setRequestProperty("Content-Length", Integer.toString(postDataLength));
			URLConn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			URLConn.setRequestProperty("charset", "utf-8");
			URLConn.setUseCaches(false);
			URLConn.setAllowUserInteraction(false);
			URLConn.setInstanceFollowRedirects(false);
			URLConn.setDoOutput(true);

			DataOutputStream os = new DataOutputStream(URLConn.getOutputStream());
			os.writeBytes(urlParameters);
			os.flush();
			os.close();

			InputStream res = URLConn.getInputStream();
			BufferedReader rd = new BufferedReader(new InputStreamReader(res, Charset.forName("UTF-8")));

			StringBuilder sb = new StringBuilder();
			int cp;
			while ((cp = rd.read()) != -1) {
				sb.append((char) cp);
			}
			String jsonText = sb.toString();
			res.close();

			JSONObject json = new JSONObject(jsonText);
			isReCaptchaOK = json.getBoolean("success");

		} catch (Exception e) {
			System.err.println(e.toString() + ":RegisteredReCaptcha");
		}
		return isReCaptchaOK;
	}

	public static boolean isReCaptchaOK(String captchaToken) {
		return checkReCaptcha(captchaToken);
	}
}
