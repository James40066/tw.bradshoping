package com.aes;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

//用來產生URL的參數字串
public class QueryString {

	private StringBuffer query = new StringBuffer();

	public QueryString(String name, String value) {
		encode(name, value);
	}

	public void add(String name, String value) {
		query.append("&");
		encode(name, value);
	}

	private void encode(String name, String value) {
		try {
			// 做出key=value&KEY=VALUE
			query.append(URLEncoder.encode(name, "UTF-8"));
			query.append("=");
			query.append(URLEncoder.encode(value, "UTF-8"));
		} catch (UnsupportedEncodingException ex) {
			throw new RuntimeException("Broken VM does not support UTF-8");
		}
	}

	public String getQuery() {
		return query.toString();
	}

	public String toString() {
		return getQuery();
	}

}
