package com.xuri.main.system.dao;

import com.xuri.vo.Notice;

public interface NoticeDao {
	//查询最新一条通知
	public abstract Notice selectTopNotice() throws Exception;
}
