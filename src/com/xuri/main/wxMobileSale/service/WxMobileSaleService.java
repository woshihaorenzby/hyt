package com.xuri.main.wxMobileSale.service;

import com.xuri.vo.*;


public interface WxMobileSaleService {
	public abstract MessageVo saveWxMobileSale(WxMobileSale wxMobileSale) throws Exception;
	//删除广告
	public abstract String deleteAdv(Adv adv) throws Exception;
	//设置使用广告
	public abstract String updateAdvUse(Adv adv) throws Exception;
	//设置使用个人广告
	public abstract String updateAdvMp(User user) throws Exception;
	//广告点击
	public abstract String insertAdvClick(User user, HyView hyView) throws Exception;
}
