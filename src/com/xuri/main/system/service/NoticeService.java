package com.xuri.main.system.service;

import com.xuri.vo.Notice;

public interface NoticeService {
	//查询最新一条通知
	public abstract Notice selectTopNotice() throws Exception;
}
