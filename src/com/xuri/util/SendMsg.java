package com.xuri.util;

import org.apache.commons.httpclient.Header;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;

public class SendMsg {
	public static String sendMsg(String phone, String content) {
		try {
			HttpClient client = new HttpClient();
	        PostMethod post = new PostMethod("http://www.qybor.com:8500/shortMessage"); //真实ip请参照开发文档
	        post.addRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=utf-8");//在头文件中设置转码
	        NameValuePair[] data ={ new NameValuePair("username", "szhnsz"),new NameValuePair("passwd", "SZhnsz30"),new NameValuePair("phone",phone),new NameValuePair("msg", content),new NameValuePair("needstatus","true"),new NameValuePair("port",""),new NameValuePair("sendtime","")};
	        post.setRequestBody(data);
	        client.executeMethod(post);
	        Header[] headers = post.getResponseHeaders();
	        int statusCode = post.getStatusCode();
	        
//	        System.out.println("statusCode:"+statusCode);
//	        for(Header h : headers){
//	            System.out.println(h.toString());
//	        }
	        String result = new String(post.getResponseBodyAsString().getBytes()); 
	        System.out.println(result); //打印返回消息状态
	        post.releaseConnection();
	        
	        return "1";
		} catch(Exception e) {
			e.printStackTrace();
		}
        return "0";
	}
}
