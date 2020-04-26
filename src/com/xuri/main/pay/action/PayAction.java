package com.xuri.main.pay.action;

import java.util.HashMap;
import java.util.Map;
import java.util.SortedMap;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;

import com.xuri.main.pay.service.PayService;
import com.xuri.main.wx.WxPayDto;
import com.xuri.main.wx.utils.GetWxOrderno;
import com.xuri.main.wx.utils.RequestHandler;
import com.xuri.main.wx.utils.TenpayUtil;
import com.xuri.system.service.BaseService;
import com.xuri.util.BaseAction;
import com.xuri.util.DateUtil;
import com.xuri.vo.MessageVo;
import com.xuri.vo.Page;
import com.xuri.vo.Payorder;

/**
 * @Title: LunimgAction
 * @Description: TODO 轮播图片
 * @author 王东
 * @date 2016-4-6
 */
public class PayAction extends BaseAction {

	private static final long serialVersionUID = 8109868459302222569L;
	private Payorder payorder;
	private Page page;
	private String companyName;
	private MessageVo messageVo = new MessageVo();
	
	private WxPayDto wxPayDto;
	private Map weiMap;
	//微信支付商户开通后 微信会提供appid和appsecret和商户号partner
	private static String appid = "wx577b557dfebd5bd0";
	private static String appsecret = "64734fc05487c3301ef9b48a38a1ced7";
	private static String partner = "1362918502";
	//这个参数partnerkey是在商户后台配置的一个32位的key,微信商户平台-账户设置-安全设置-api安全
	private static String partnerkey = "34a90aIj00e2CphaqMedKf20e0Pxljka";
	//微信支付成功后通知地址 必须要求80端口并且地址不能带参数
	private static String notifyurl = "http://wd.cd08.com/hyt/jsp/paysuccess.jsp";// Key

	@Autowired
	private BaseService baseService;
	@Autowired
	private PayService payService;

	public String show() {
		return "show";
	}
	/**
	 * @Description: TODO 支付列表
	 * @author 王东
	 */
	public String list() {
		try {
			payorder = new Payorder();
			page = baseService.selectPageList(page, payorder);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "page";
	}
	/**
	 * @Description: TODO 获取支付订单
	 * @author 王东
	 */
	public String wxGetPay() {
		wxPayDto.setOrderId(DateUtil.getRecentDate("yyyyMMddHHmmss")+getSession().getAttribute("id"));
		wxPayDto.setSpbillCreateIp(getIpAddress(request));
		// 1 参数
		String orderId = wxPayDto.getOrderId();// 订单号
		// 附加数据 原样返回
		String attach = "微信测试";
		// 总金额以分为单位，不带小数点
		String totalFee = getMoney(wxPayDto.getTotalFee());
		
		// 订单生成的机器 IP
		String spbill_create_ip = wxPayDto.getSpbillCreateIp();
		// 这里notify_url是 支付完成后微信发给该链接信息，可以判断会员是否支付成功，改变订单状态等。
		String notify_url = notifyurl;
		String trade_type = "JSAPI";

		// 商户号
		String mch_id = partner;
		// 随机字符串
		String nonce_str = getNonceStr();

		// 商品描述根据情况修改
		String body = wxPayDto.getBody();

		// 商户订单号
		String out_trade_no = orderId;
		totalFee = wxPayDto.getTotalFee();
		SortedMap<String, String> packageParams = new TreeMap<String, String>();
		packageParams.put("appid", appid);
		packageParams.put("mch_id", mch_id);
		packageParams.put("nonce_str", nonce_str);
		packageParams.put("body", body);
		packageParams.put("attach", attach);
		packageParams.put("out_trade_no", out_trade_no);
		// 这里写的金额为1 分到时修改
		packageParams.put("total_fee", totalFee);
		packageParams.put("spbill_create_ip", spbill_create_ip);
		packageParams.put("notify_url", notify_url);

		packageParams.put("trade_type", trade_type);
		packageParams.put("openid", request.getSession().getAttribute("openId").toString());

		RequestHandler reqHandler = new RequestHandler(null, null);
		reqHandler.init(appid, appsecret, partnerkey);

		String sign = reqHandler.createSign(packageParams);
		String xml = "<xml>" + "<appid>" + appid + "</appid>" + "<mch_id>" + mch_id + "</mch_id>" + 
				"<nonce_str>" + nonce_str + "</nonce_str>" + "<sign>" + sign + "</sign>" + 
				"<body><![CDATA[" + body + "]]></body>" + "<out_trade_no>" + out_trade_no + "</out_trade_no>" + 
				"<attach>" + attach + "</attach>" + "<total_fee>" + totalFee + "</total_fee>"+ 
				"<spbill_create_ip>" + spbill_create_ip + "</spbill_create_ip>" + "<notify_url>" + notify_url + "</notify_url>" + 
				"<trade_type>" + trade_type + "</trade_type>" + "<openid>" + request.getSession().getAttribute("openId").toString() + "</openid>" + "</xml>";
		System.out.println(xml);
		String createOrderURL = "https://api.mch.weixin.qq.com/pay/unifiedorder";
		weiMap = GetWxOrderno.getCodeUrl(createOrderURL, xml);
		System.out.println("111==" + weiMap);
		
		SortedMap<String, String> signPar = new TreeMap<String, String>();
		signPar.put("appId", appid);
		signPar.put("timeStamp", DateUtil.timeStamp());
		signPar.put("nonceStr", getNonceStr());
		signPar.put("package", "prepay_id=" + weiMap.get("prepay_id").toString());
		signPar.put("signType", "MD5");
		sign = reqHandler.createSign(signPar);
		
		weiMap = new HashMap();
		weiMap.put("appid", signPar.get("appId"));
		weiMap.put("nonce_str", signPar.get("nonceStr"));
		weiMap.put("package", signPar.get("package"));
		weiMap.put("timestamp", signPar.get("timeStamp"));
		weiMap.put("sign", sign);
		System.out.println("222==" + weiMap);
		return "weiMap";
	}
	/**
	 * @Description: TODO 支付成功后调用
	 * @author 王东
	 */
	public String wxPaySuccess() {
		try {
			payorder.setUserId(getSession().getAttribute("id").toString());
			payService.insertPayOrder(payorder, companyName);
			messageVo.setCode("1");
		} catch(Exception e) {
			messageVo.setCode("0");
			e.printStackTrace();
		}
		return "messageVo";
	}
	
	/**
	 * 获取随机字符串
	 * @return
	 */
	public static String getNonceStr() {
		// 随机数
		String currTime = TenpayUtil.getCurrTime();
		// 8位日期
		String strTime = currTime.substring(8, currTime.length());
		// 四位随机数
		String strRandom = TenpayUtil.buildRandom(4) + "";
		// 10位序列号,可以自行调整。
		return strTime + strRandom;
	}
	/**
	 * 元转换成分
	 * @param money
	 * @return
	 */
	public static String getMoney(String amount) {
		if(amount==null){
			return "";
		}
		// 金额转化为分为单位
		String currency =  amount.replaceAll("\\$|\\￥|\\,", "");  //处理包含, ￥ 或者$的金额  
        int index = currency.indexOf(".");  
        int length = currency.length();  
        Long amLong = 0l;  
        if(index == -1){  
            amLong = Long.valueOf(currency+"00");  
        }else if(length - index >= 3){  
            amLong = Long.valueOf((currency.substring(0, index+3)).replace(".", ""));  
        }else if(length - index == 2){  
            amLong = Long.valueOf((currency.substring(0, index+2)).replace(".", "")+0);  
        }else{  
            amLong = Long.valueOf((currency.substring(0, index+1)).replace(".", "")+"00");  
        }  
        return amLong.toString(); 
	}
	
	public static String getIpAddress(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}
	
	public MessageVo getMessageVo() {
		return messageVo;
	}

	public void setMessageVo(MessageVo messageVo) {
		this.messageVo = messageVo;
	}

	public Page getPage() {
		return page;
	}

	public void setPage(Page page) {
		this.page = page;
	}
	public Map getWeiMap() {
		return weiMap;
	}
	public void setWeiMap(Map weiMap) {
		this.weiMap = weiMap;
	}
	public WxPayDto getWxPayDto() {
		return wxPayDto;
	}
	public void setWxPayDto(WxPayDto wxPayDto) {
		this.wxPayDto = wxPayDto;
	}
	public Payorder getPayorder() {
		return payorder;
	}
	public void setPayorder(Payorder payorder) {
		this.payorder = payorder;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
}
