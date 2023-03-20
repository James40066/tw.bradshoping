package com.aes;

import java.util.HashMap;

public class HttpBuildQuery {

	// 將參數(parameter)經過 URL ENCODED QUERY STRING
	// RespondType=JSON&Version=1.4&ItemDesc=UnitTest&Amt=40&MerchantOrderNo=S_1485232229&MerchantID=3430112&TimeStamp=1485232229
	public static String ToUrlENCODED(HashMap<String, String> parameter) {
		String str = "";
		boolean init = true;
		QueryString qs = null;

		for (String key : parameter.keySet()) {
			if (init) {
				qs = new QueryString(key, parameter.get(key));
			} else {
				qs.add(key, parameter.get(key));
			}
			init = false;
		}
		str = qs.getQuery();
		return str;
	}
}
