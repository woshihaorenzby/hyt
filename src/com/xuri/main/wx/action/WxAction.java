package com.xuri.main.wx.action;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.Arrays;

import org.springframework.beans.factory.annotation.Autowired;

import com.xuri.main.wx.process.WechatProcess;
import com.xuri.system.dao.BaseDao;
import com.xuri.util.BaseAction;
import com.xuri.util.SHA1;

/**
 * @ClassName: WxAction
 * @Description: TODO(文章类别)
 * @author: 王东
 * @date: 2015-9-2 下午3:43:48
 * 
 */
public class WxAction extends BaseAction {

	private static final long serialVersionUID = -2390694362343616752L;// 自定义 token
	private String TOKEN = "845C25ewy03CE5413A56CAEQey2EA";
	private String echostr;

	@Autowired
	private BaseDao baseDao;
	
	public String appGetWxToken() throws Exception {
		String method = request.getMethod();
		if(method.equals("GET")){//效验微信token
			System.out.println("效验微信token");
			// 微信加密签名
			String signature = request.getParameter("signature");
			System.out.println("signature==" + signature);
			// 随机字符串
			echostr = request.getParameter("echostr");
			// 时间戳
			String timestamp = request.getParameter("timestamp");
			// 随机数
			String nonce = request.getParameter("nonce");

			String[] str = { TOKEN, timestamp, nonce };
			Arrays.sort(str); // 字典序排序
			String bigStr = str[0] + str[1] + str[2];
			// SHA1加密
			String digest = new SHA1().getDigestOfString(bigStr.getBytes()).toLowerCase();

			// 确认请求来至微信
			if (!digest.equals(signature)) {
				echostr = "";
			}
		}else{//获取消息
			StringBuffer sb = new StringBuffer();
			InputStream is = request.getInputStream();
			InputStreamReader isr = new InputStreamReader(is, "UTF-8");
			BufferedReader br = new BufferedReader(isr);
			String s = "";
			while ((s = br.readLine()) != null) {
				sb.append(s);
			}
			String xml = sb.toString();
			System.out.println(xml);
			echostr = new WechatProcess().processWechatMag(xml, baseDao);
		}
		return "echostr";
	}

	public String getEchostr() {
		return echostr;
	}

	public void setEchostr(String echostr) {
		this.echostr = echostr;
	}
}