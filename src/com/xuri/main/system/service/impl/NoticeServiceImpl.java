package com.xuri.main.system.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xuri.main.system.dao.NoticeDao;
import com.xuri.main.system.service.NoticeService;
import com.xuri.vo.Notice;

@Service
@Transactional
public class NoticeServiceImpl implements NoticeService {

	@Autowired
	private NoticeDao noticeDao;

	/**
	 * @Description: TODO 查询最新一条通知
	 * @author 王东
	 * @date 2016-5-2
	 */
	@Override
	public Notice selectTopNotice() throws Exception {
		try {
			return noticeDao.selectTopNotice();
		} catch (Exception e) {
			throw e;
		}
	}

}
