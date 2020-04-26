package com.xuri.util;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

public class HttpUtil {

	public static String getUrl(HttpServletRequest request) {
		request = ServletActionContext.getRequest();

		StringBuffer requestUrl = request.getRequestURL();

		String queryString = request.getQueryString();
		if(queryString != null && !queryString.equals("null")) {
			return requestUrl + "?" + queryString;
		} else {
			return requestUrl.toString();
		}
	}
	/**
	 * @param urlstr
	 *            网址链接
	 * @return 内容
	 */
	public static String getUrlContent(String urlstr) {
		try {
			URL url = new URL(urlstr);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			Thread.sleep(3000);
			InputStream inputStream = conn.getInputStream(); // 通过输入流获得网站数据
			byte[] getData = readInputStream(inputStream); // 获得网站的二进制数据
			String data = new String(getData, "utf-8");
			return data;
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		}
	}

	public static byte[] readInputStream(InputStream inputStream) throws IOException {
		byte[] buffer = new byte[1024];
		int len = 0;
		ByteArrayOutputStream bos = new ByteArrayOutputStream();
		while ((len = inputStream.read(buffer)) != -1) {
			bos.write(buffer, 0, len);
		}
		bos.close();
		return bos.toByteArray();
	}

	public static void download(String urlString, String filename,
			String savePath) throws Exception {
		// 构造URL
		URL url = new URL(urlString);
		// 打开连接
		URLConnection con = url.openConnection();
		// 设置请求超时为5s
		con.setConnectTimeout(5 * 1000);
		// 输入流
		InputStream is = con.getInputStream();

		// 1K的数据缓冲
		byte[] bs = new byte[1024];
		// 读取到的数据长度
		int len;
		// 输出的文件流
		File sf = new File(savePath);
		if (!sf.exists()) {
			sf.mkdirs();
		}
		OutputStream os = new FileOutputStream(sf.getPath() + "\\" + filename);
		// 开始读取
		while ((len = is.read(bs)) != -1) {
			os.write(bs, 0, len);
		}
		// 完毕，关闭所有链接
		os.close();
		is.close();
	}

	public static String sendPostRequest(String urlStr, String params) {
		StringBuffer stringBuffer = new StringBuffer("");
		try {
			String encoding = "UTF-8";
			byte[] data = params.getBytes(encoding);
			URL url = new URL(urlStr);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);
			conn.setConnectTimeout(5 * 1000);
			OutputStream outStream = conn.getOutputStream();
			outStream.write(data);
			outStream.flush();
			outStream.close();

			BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream(), "utf-8"));
			String line;
			while ((line = reader.readLine()) != null) {
				stringBuffer.append(line);
			}
			reader.close();
			//return new String(stringBuffer.toString().getBytes());
			return stringBuffer.toString();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return stringBuffer.toString();
	}
	
	/**
	 * 获取请求主机IP地址,如果通过代理进来，则透过防火墙获取真实IP地址;
	 * 
	 * @param request
	 * @return
	 * @throws IOException
	 */
	public final static String getIpAddress(HttpServletRequest request) throws IOException {
		// 获取请求主机IP地址,如果通过代理进来，则透过防火墙获取真实IP地址

		String ip = request.getHeader("X-Forwarded-For");
//		if (logger.isInfoEnabled()) {
//			logger.info("getIpAddress(HttpServletRequest) - X-Forwarded-For - String ip=" + ip);
//		}

		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
				ip = request.getHeader("Proxy-Client-IP");
//				if (logger.isInfoEnabled()) {
//					logger.info("getIpAddress(HttpServletRequest) - Proxy-Client-IP - String ip=" + ip);
//				}
			}
			if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
				ip = request.getHeader("WL-Proxy-Client-IP");
//				if (logger.isInfoEnabled()) {
//					logger.info("getIpAddress(HttpServletRequest) - WL-Proxy-Client-IP - String ip=" + ip);
//				}
			}
			if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
				ip = request.getHeader("HTTP_CLIENT_IP");
//				if (logger.isInfoEnabled()) {
//					logger.info("getIpAddress(HttpServletRequest) - HTTP_CLIENT_IP - String ip=" + ip);
//				}
			}
			if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
				ip = request.getHeader("HTTP_X_FORWARDED_FOR");
//				if (logger.isInfoEnabled()) {
//					logger.info("getIpAddress(HttpServletRequest) - HTTP_X_FORWARDED_FOR - String ip=" + ip);
//				}
			}
			if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
				ip = request.getRemoteAddr();
//				if (logger.isInfoEnabled()) {
//					logger.info("getIpAddress(HttpServletRequest) - getRemoteAddr - String ip=" + ip);
//				}
			}
		} else if (ip.length() > 15) {
			String[] ips = ip.split(",");
			for (int index = 0; index < ips.length; index++) {
				String strIp = (String) ips[index];
				if (!("unknown".equalsIgnoreCase(strIp))) {
					ip = strIp;
					break;
				}
			}
		}
		return ip;
	}
}
