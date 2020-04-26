package com.xuri.util;

public class StringUtil {
	public static String dealStr(String str){
		try{
			if(str==null || str.length() == 0) {
				return str;
			}
			str = str.replace("\r", "");
			str = str.replace("\n", "");
			return str;
		}catch(Exception e) {
			e.printStackTrace();
			return str;
		}
	}
	public static String gbEncoding(final String gbString) { // gbString = "测试"
		char[] utfBytes = gbString.toCharArray(); // utfBytes = [测, 试]
		String unicodeBytes = "";
		for (int byteIndex = 0; byteIndex < utfBytes.length; byteIndex++) {
			String hexB = Integer.toHexString(utfBytes[byteIndex]); // 转换为16进制整型字符串
			if (hexB.length() <= 2) {
				hexB = "00" + hexB;
			}
			unicodeBytes = unicodeBytes + "\\u" + hexB;
		}
		System.out.println("unicodeBytes is: " + unicodeBytes);
		return unicodeBytes;
	}
}