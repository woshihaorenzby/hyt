package com.xuri.main.adv.service;

import com.xuri.vo.Adv;
import com.xuri.vo.HyView;
import com.xuri.vo.MessageVo;
import com.xuri.vo.User;


public interface AdvService {
	public abstract MessageVo saveAdv(Adv adv) throws Exception;
	//删除广告
	public abstract String deleteAdv(Adv adv) throws Exception;
	//设置使用广告
	public abstract String updateAdvUse(Adv adv) throws Exception;
	//设置使用个人广告
	public abstract String updateAdvMp(User user) throws Exception;
	//广告点击
	public abstract String insertAdvClick(User user, HyView hyView) throws Exception;
}
