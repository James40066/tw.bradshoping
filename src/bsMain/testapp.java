package bsMain;

import java.util.Collections;

import org.json.JSONException;
import org.json.JSONObject;

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier;
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken.Payload;
import com.google.api.client.http.javanet.NetHttpTransport;
import com.google.api.client.json.jackson2.JacksonFactory;

import bsAPI.UserData;

public class testapp {

	public static void main(String[] args) {
		// google token
	    String Gtoken_web = "eyJhbGciOiJSUzI1NiIsImtpZCI6IjhjNThlMTM4NjE0YmQ1ODc0MjE3MmJkNTA4MGQxOTdkMmIyZGQyZjMiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJhY2NvdW50cy5nb29nbGUuY29tIiwiYXpwIjoiMzc5Nzc4OTQ3NTMzLTZlbW8xaWJzYzNwNnRwMWRicWQ1cXZmcDBjcDFoaG0zLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwiYXVkIjoiMzc5Nzc4OTQ3NTMzLTZlbW8xaWJzYzNwNnRwMWRicWQ1cXZmcDBjcDFoaG0zLmFwcHMuZ29vZ2xldXNlcmNvbnRlbnQuY29tIiwic3ViIjoiMTA3ODU5Mjk1MzU5NjUxMzkxNjg0IiwiZW1haWwiOiJhMDk1Mzc4MjA1N0BnbWFpbC5jb20iLCJlbWFpbF92ZXJpZmllZCI6dHJ1ZSwiYXRfaGFzaCI6IlZrTERTaVNsY1lITHJ4U2lwWF9sZEEiLCJuYW1lIjoiUk9ORyBGQU5HIFNISUgiLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EtL0FBdUU3bUNaRzRRVERMNWM0d0ptVFAweHZERVVYU2tubnBTVVhMMHdwOThwT0E9czk2LWMiLCJnaXZlbl9uYW1lIjoiUk9ORyBGQU5HIiwiZmFtaWx5X25hbWUiOiJTSElIIiwibG9jYWxlIjoiemgtVFciLCJpYXQiOjE1NzAxODUzOTcsImV4cCI6MTU3MDE4ODk5NywianRpIjoiODZmZWU0M2RmN2I0MDgyNDAyNWY3ZGQ2Zjg0MzNmZTVhZGVjMzY3YiJ9.XCiAkluaMqlgmdyiaXSALGqjHW1SBpjxv7BRPpOPa6I-P6x1x7BhxB83uAA-Bziot5ZIfDRUSGNcQqlqikY4FK4yffVWm_Vd8B0jeUXrTqQhVWWDE1aMHjCFuDT_FmXiK6zlWkz8ztPgqDbtCOD_VGaTeUKsryeJ06s4JaQ7R1tjfSAm4Aa3dboIwipDSXggPX_c6nPHTC8CpprbY1ik9knvTP7RLtorfdd3TlmaXlAzyDabPMVEy6kDrL5tYj3fI6L0u_DaooRWlnVbt5Zrinkjd0coWhoVO1CE3S0XWysZWqupSRlA4gdgQzZVaROlJNHnQhDsChtv0YcYLcf7RQ";
		String Gtoken_app = "eyJhbGciOiJSUzI1NiIsImtpZCI6IjhjNThlMTM4NjE0YmQ1ODc0MjE3MmJkNTA4MGQxOTdkMmIyZGQyZjMiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiIzNzk3Nzg5NDc1MzMtc3F0NWdmbXVwM205NjYwdmEyMGNlM2hkb2s1ZDRoc3IuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiIzNzk3Nzg5NDc1MzMtNmVtbzFpYnNjM3A2dHAxZGJxZDVxdmZwMGNwMWhobTMuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMDc4NTkyOTUzNTk2NTEzOTE2ODQiLCJlbWFpbCI6ImEwOTUzNzgyMDU3QGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJuYW1lIjoiUk9ORyBGQU5HIFNISUgiLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EtL0FBdUU3bUNaRzRRVERMNWM0d0ptVFAweHZERVVYU2tubnBTVVhMMHdwOThwT0E9czk2LWMiLCJnaXZlbl9uYW1lIjoiUk9ORyBGQU5HIiwiZmFtaWx5X25hbWUiOiJTSElIIiwibG9jYWxlIjoiemgtVFciLCJpYXQiOjE1NzAxODQ1MTUsImV4cCI6MTU3MDE4ODExNX0.xWbnI_RnhhM2SOmhoF9JEotRQPfUyHWlo4tecbis3at4ZYoXiFA3QlfyfV1TpTiVAahQFbmIogIunDIBMnfWk1OadCEf7lHbhdr8_lOfF5taNv6cvSuHVbogQeVFV3vcwKmZPXj-bptomHQoqLoV-uay8FO5iXitlbzR5J7Z2pwhRKc0RNvdRhs9XKwZ5naZAXblWLQeV9DVrUwNU--bFGOkrVlC6ok3ZitujZz2AiYsyK0E6ZwW87oryNjMpqXNWfnAz1P7PtMfV3aBiZ3exI6LnO8qyQspIY-pHRc7NUMYjkmNdAzqHbzVQ2JMaaUDLI8nxGZ_9tkLQXklDtuYkg";		
		// fb token
		String EMAIL = "email:james40066@yahoo.com.tw";
		String ID = "id:2628591940494149";
		String NAME = "name:施榮芳";
		
		// toJSON(ID, NAME, EMAIL)=>自訂類別轉JSONObject
		JSONObject fbtoken = toJSON(ID, NAME, EMAIL);

		//checkIsGoogle(Gtoken_web);
		checkIsGoogle(Gtoken_app);

		//checkIsFacebook(fbtoken.toString());
	}

	public static void checkIsGoogle(String Gtoken) {
		try {
			GoogleIdTokenVerifier verifier = new GoogleIdTokenVerifier.Builder(new NetHttpTransport(),
					JacksonFactory.getDefaultInstance())
							.setAudience(Collections.singletonList(
									"379778947533-sqt5gfmup3m9660va20ce3hdok5d4hsr.apps.googleusercontent.com"))
							.setIssuer("accounts.google.com").build();
			GoogleIdToken idToken = verifier.verify(Gtoken);
			Payload payload = idToken.getPayload();

			String id = payload.getSubject();
			String email = payload.getEmail();
			String name = (String) payload.get("name");
			int type = UserData.GOOGLE;

			System.out.println("Google-id=>" + payload.getSubject());
			System.out.println("Google-email=>" + payload.getEmail());
			System.out.println("Google-name=>" + (String) payload.get("name"));
			System.out.println("--------------------------------------------------------");

		} catch (Exception e) {
			System.err.println(e.toString());
		}
	}

	// FacebookFBtoken解析
	private static void checkIsFacebook(String FBtoken) {
		try {
			// 參數接收解JSON
			JSONObject j = new JSONObject(FBtoken);
			String id = j.getString("id");
			String name = j.getString("name");
			String email = j.getString("email");
			int type = UserData.FACEBOOK;

			System.out.println("Facebook-id=>" + j.getString("id"));
			System.out.println("Facebook-email=>" + j.getString("email"));
			System.out.println("Facebook-name=>" + j.getString("name"));

		} catch (Exception e) {
			System.err.println(e.toString());
		}
	}

	// 轉成JSON物件
	public static JSONObject toJSON(String id, String name, String email) {
		JSONObject Fbtoken = null;
		try {
			String obj = "{" + "\"id\"" + ":" + "\"" + id + "\"" + "," + "\"name\"" + ":" + "\"" + name + "\"" + ","
					+ "\"email\"" + ":" + "\"" + email + "\"" + "}";
			Fbtoken = new JSONObject(obj);
		} catch (JSONException e) {
			e.printStackTrace();
		}
		return Fbtoken;
	}
}
