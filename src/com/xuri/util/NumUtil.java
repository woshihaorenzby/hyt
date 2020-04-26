package com.xuri.util;

import java.util.Random;

public class NumUtil {
	/**
	* @Title: checkCode
	* @Description: TODO(获取6位随机数字)
	* @param @return 设定文件
	*/
	public static String checkCode(){
		Random random = new Random();
		String result="";
		for(int i=0;i<6;i++){
			result+=random.nextInt(10);
		}
		return result;
	}
}
