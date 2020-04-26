package com.xuri.main.wxMobileSale.dao;

import com.xuri.vo.Adv;

public interface WxMobileSaleDao {
	//还原用户密码
	public abstract String updateTopAdvUseTag(Adv adv) throws Exception;
	//重置所有密码标记
	public abstract String updateAdvTotUseTag(Adv adv) throws Exception;
	//修改使用标记
	public abstract String updateAdvUserTag(Adv adv) throws Exception;
}
