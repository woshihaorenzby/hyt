package com.xuri.main.wxMobileSale.dao.impl;

import com.xuri.main.wxMobileSale.dao.WxMobileSaleDao;
import com.xuri.vo.Adv;
import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class WxMobileSaleDaoImpl implements WxMobileSaleDao {
	public static Logger logger = LoggerFactory.getLogger(WxMobileSaleDaoImpl.class);
	
	@Autowired  
	private SqlSessionTemplate sqlSessionTemplate;
	
	@Override
	public String updateTopAdvUseTag(Adv adv) throws Exception {
		try{
			sqlSessionTemplate.update("advtopusetag_update", adv);
			return "1";
		}catch(Exception e){
			logger.error("advtopusetag_update" + " failed :{}", e);
			throw e;
		}
	}
	
	@Override
	public String updateAdvTotUseTag(Adv adv) throws Exception {
		try{
			sqlSessionTemplate.update("advtotusetag_update", adv);
			return "1";
		}catch(Exception e){
			logger.error("advtotusetag_update" + " failed :{}", e);
			throw e;
		}
	}
	
	@Override
	public String updateAdvUserTag(Adv adv) throws Exception {
		try{
			sqlSessionTemplate.update("advusetag_update", adv);
			return "1";
		}catch(Exception e){
			logger.error("advusetag_update" + " failed :{}", e);
			throw e;
		}
	}
}
