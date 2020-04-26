package com.xuri.main.wx.process;

import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;

import com.xuri.system.dao.BaseDao;
import com.xuri.vo.ReceiveXmlEntity;
import com.xuri.vo.User;

/**
 * 微信xml消息处理流程逻辑类
 * @author pamchen-1
 *
 */
public class WechatProcess {
	/**
	 * 解析处理xml、获取智能回复结果（通过图灵机器人api接口）
	 * @param xml 接收到的微信数据
	 * @return	最终的解析结果（xml格式数据）
	 */
	public String processWechatMag(String xml, BaseDao baseDao){
		/** 解析xml数据 */
		ReceiveXmlEntity xmlEntity = new ReceiveXmlProcess().getMsgEntity(xml);
		
		/** 以文本消息为例，调用图灵机器人api接口，获取回复内容 */
		String result = "";
		if(xmlEntity.getEvent().equals("subscribe")) {
			Date d = new Date();  
            long CreateTime = d.getTime()/1000;
			
			StringBuffer sb = new StringBuffer();
			sb.append("<xml>");
			sb.append("<ToUserName><![CDATA["+xmlEntity.getFromUserName()+"]]></ToUserName>");
			sb.append("<FromUserName><![CDATA[gh_5df007d86f2c]]></FromUserName>");
			sb.append("<CreateTime>"+CreateTime+"</CreateTime>");
			sb.append("<MsgType><![CDATA[text]]></MsgType>");
			sb.append("<Content><![CDATA[想要免费发广告，请在底部<a href=\"http://www.baidu.com\">点击</a>]]></Content>");
			sb.append("</xml>");
			result = sb.toString();
			
			String eventKey = xmlEntity.getEventKey();
			eventKey = eventKey.replace("qrscene_", "");//包含上级关系
			if(eventKey!=null && eventKey.length()>0) {
				User user = new User();
				user.setOpenId(xmlEntity.getFromUserName());
				try {
					User selUser = baseDao.selectById(user);
					if(selUser == null) {
						if(eventKey.startsWith("last_trade_no")) {
							user.setPid("");
						} else {
							user.setPid(eventKey);
						}
						baseDao.insert(user);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		return result;
	}
}
