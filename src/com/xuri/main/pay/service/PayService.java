package com.xuri.main.pay.service;

import com.xuri.vo.Payorder;

public interface PayService {
	//添加视频访问量
	public abstract String insertPayOrder(Payorder payorder, String companyName) throws Exception;
}
