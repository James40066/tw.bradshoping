package com.aes;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

public class ToAes {
	public static String encryptSpgateway(String hashKey, String hashIv, String value) {
		try {
			SecretKeySpec skeySpec = new SecretKeySpec(hashKey.getBytes("UTF-8"), "AES");
			IvParameterSpec iv = new IvParameterSpec(hashIv.getBytes("UTF-8"));
			Cipher cipher = Cipher.getInstance("AES/CBC/NoPadding");
			cipher.init(Cipher.ENCRYPT_MODE, skeySpec, iv);
			byte[] encrypted = cipher.doFinal(addPKCS7Padding(value.getBytes("UTF-8"), 32));
			String result = bytesToHex(encrypted);
			return result.toLowerCase();
		} catch (Exception e) {
			System.out.println(e.toString());
		}
		return null;
	}

	private static byte[] addPKCS7Padding(byte[] data, int iBlockSize) {
		int iLength = data.length;
		byte cPadding = (byte) (iBlockSize - (iLength % iBlockSize));
		byte[] output = new byte[iLength + cPadding];
		System.arraycopy(data, 0, output, 0, iLength);
		for (int i = iLength; i < output.length; i++)
			output[i] = (byte) cPadding;
		return output;
	}

	public static String bytesToHex(byte[] bytes) {
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < bytes.length; i++) {
			String hex = Integer.toHexString(bytes[i] & 0xFF);
			if (hex.length() == 1) {
				hex = '0' + hex;
			}
			sb.append(hex);
		}
		return sb.toString();
	}

}
