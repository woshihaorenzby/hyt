package com.xuri.util;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Formatter;
import java.util.UUID;

import org.apache.struts2.ServletActionContext;

import com.google.gson.Gson;
import com.xuri.vo.AccessToken;
import com.xuri.vo.JsApiTicket;
import com.xuri.vo.WxQcTicket;
import com.xuri.vo.WxSign;
import com.xuri.vo.WxUser;
import com.xuri.vo.WxWebLo;

public class WxUtil {
	private static String AppID = "wx577b557dfebd5bd0";
	private static String AppSecret = "83ba3f037727bdabdefd76b160905173";
	public static String token = null;
    public static String time = null;
    public static String jsapi_ticket = null;
    
    private static void getAccess_token() {
    	time = DateUtil.getRecentDate("yyyy-MM-dd HH:mm:ss");//获取时的时间
    	String access_token = HttpUtil.sendPostRequest("https://api.weixin.qq.com/cgi-bin/token", "grant_type=client_credential&appid="+AppID+"&secret="+AppSecret);
    	AccessToken accessToken = new Gson().fromJson(access_token, AccessToken.class);//获取access_token
    	token = accessToken.getAccess_token();
    	getJsApiTicket();
    }
    private static void getJsApiTicket() {
    	String jsapiStr = HttpUtil.sendPostRequest("https://api.weixin.qq.com/cgi-bin/ticket/getticket", "access_token="+token+"&type=jsapi");
    	JsApiTicket jsApiTicket = new Gson().fromJson(jsapiStr, JsApiTicket.class);//获取jsapi_ticket
    	jsapi_ticket = jsApiTicket.getTicket();
    }
	
    /**
     * @Description: TODO 根据code获取openId
     * @param @param code
     * @return WxWebLo 带有openId的对象
     * @author 王东
     * @date 2016-4-29
     */
    public static WxWebLo getWebOpenId(String code) {
    	String json = HttpUtil.sendPostRequest("https://api.weixin.qq.com/sns/oauth2/access_token", "appid="+AppID+"&secret="+AppSecret+"&code="+code+"&grant_type=authorization_code");
    	WxWebLo wxWebLo = new Gson().fromJson(json, WxWebLo.class);
    	return wxWebLo;
    }
    
    public static WxUser getWebWxUser(WxWebLo wxWebLo) {
    	String json = HttpUtil.sendPostRequest("https://api.weixin.qq.com/sns/userinfo", "access_token="+wxWebLo.getAccess_token()+"&openid="+wxWebLo.getOpenid()+"&lang=zh_CN");
        System.out.println("登录json==" + json);
    	WxUser user = new Gson().fromJson(json, WxUser.class);
    	return user;
    }
    /*public static String getOpenId() {
    	if (token == null) {
			getAccess_token();
		} else {
			if (!time.substring(0, 13).equals(DateUtil.getRecentDate("yyyy-MM-dd HH:mm:ss").substring(0, 13))) { // 每小时刷新一次
				token = null;
				getAccess_token();
				getJsApiTicket();
				time = DateUtil.getRecentDate("yyyy-MM-dd HH:mm:ss");
			}
		}
    }*/
    public static WxQcTicket linQRCode(String userId) {
    	if (token == null) {
			getAccess_token();
		}
    	String json = HttpUtil.sendPostRequest("https://api.weixin.qq.com/cgi-bin/qrcode/create?access_token=" + token, "{\"expire_seconds\": 604800, \"action_name\": \"QR_SCENE\", \"action_info\": {\"scene\": {\"scene_id\": "+userId+"}}}");
    	WxQcTicket ticket = new Gson().fromJson(json, WxQcTicket.class);
    	return ticket;
    }
    
    public static void downWxImg(String mediaId, String savePath) {
    	if (token == null) {
			getAccess_token();
		}
    	InputStream inputStream = null;
        System.out.println("mediaId==" + mediaId);
    	String url = "http://file.api.weixin.qq.com/cgi-bin/media/get?access_token=" + token + "&media_id=" + mediaId;
    	System.out.println("url==" + url);
         try {
             URL urlGet = new URL(url);
             HttpURLConnection http = (HttpURLConnection) urlGet.openConnection();
             http.setRequestMethod("GET"); // 必须是get方式请求
             http.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
             http.setDoOutput(true);
             http.setDoInput(true);
             System.setProperty("sun.net.client.defaultConnectTimeout", "30000");// 连接超时30秒
             System.setProperty("sun.net.client.defaultReadTimeout", "30000"); // 读取超时30秒
             http.connect();
             // 获取文件转化为byte流
             inputStream = http.getInputStream();
         } catch (Exception e) {
             e.printStackTrace();
         }
         //保存图片
         //生成图片
         byte[] data = new byte[1024];
         int len = 0;
         FileOutputStream fileOutputStream = null;
         try {
             fileOutputStream = new FileOutputStream(savePath);
             while ((len = inputStream.read(data)) != -1) {
                 fileOutputStream.write(data, 0, len);
             }
         } catch (IOException e) {
             e.printStackTrace();
         } finally {
             if (inputStream != null) {
                 try {
                     inputStream.close();
                 } catch (IOException e) {
                     e.printStackTrace();
                 }
             }
             if (fileOutputStream != null) {
                 try {
                     fileOutputStream.close();
                 } catch (IOException e) {
                     e.printStackTrace();
                 }
             }
         }
    }
    
	/**
	 * @Description: TODO 分享时获取参数
	 * @param @param url 分享的链接
	 * @return WxSign
	 * @author 王东
	 * @date 2016-4-28
	 */
	public static WxSign sign(String url) {
		if (token == null) {
			getAccess_token();
		} else {
			if (!time.substring(0, 13).equals(DateUtil.getRecentDate("yyyy-MM-dd HH:mm:ss").substring(0, 13))) { // 每小时刷新一次
				token = null;
				getAccess_token();
				getJsApiTicket();
				time = DateUtil.getRecentDate("yyyy-MM-dd HH:mm:ss");
			}
		}
		if(jsapi_ticket==null) {
            getJsApiTicket();
        }
		String nonce_str = create_nonce_str();
		String timestamp = create_timestamp();
		String str;
		String signature = "";

		// 注意这里参数名必须全部小写，且必须有序
        System.out.println("jsapi_ticket==" + jsapi_ticket);
		str = "jsapi_ticket=" + jsapi_ticket + "&noncestr=" + nonce_str + "&timestamp=" + timestamp + "&url=" + url;
        System.out.println(str);
		try {
			MessageDigest crypt = MessageDigest.getInstance("SHA-1");
			crypt.reset();
			crypt.update(str.getBytes("UTF-8"));
			signature = byteToHex(crypt.digest());
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		WxSign wxSign = new WxSign();
		wxSign.setUrl(url);
		wxSign.setJsapi_ticket(jsapi_ticket);
		wxSign.setNonceStr(nonce_str);
		wxSign.setTimestamp(timestamp);
		wxSign.setSignature(signature);
		//ret.put("url", url);
		//ret.put("jsapi_ticket", jsapi_ticket);
		//ret.put("nonceStr", nonce_str);
		//ret.put("timestamp", timestamp);
		//ret.put("signature", signature);

		return wxSign;
	}

	private static String byteToHex(final byte[] hash) {
		Formatter formatter = new Formatter();
		for (byte b : hash) {
			formatter.format("%02x", b);
		}
		String result = formatter.toString();
		formatter.close();
		return result;
	}

	private static String create_nonce_str() {
		return UUID.randomUUID().toString();
	}

	private static String create_timestamp() {
		return Long.toString(System.currentTimeMillis() / 1000);
	}
}
