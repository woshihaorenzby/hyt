package com.xuri.main.system.dao.impl;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xuri.main.system.dao.NoticeDao;
import com.xuri.vo.Notice;

@Repository
public class NoticeDaoImpl implements NoticeDao {
	public static Logger logger = LoggerFactory.getLogger(NoticeDaoImpl.class);
	
	@Autowired  
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	* @Title: selectTopNotice
	* @Description: TODO(查询最新一条通知)
	* @author：王东
	* @date 2016-4-23
	*/
	@Override
	public Notice selectTopNotice() throws Exception {
		try{
			return sqlSessionTemplate.selectOne("topnotice_select", null);
		}catch(Exception e){
			logger.error("topnotice_select" + " failed :{}", e);
			throw e;
		}
	}
}
