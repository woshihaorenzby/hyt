package com.xuri.main.user.dao.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xuri.main.user.dao.WxUserDao;
import com.xuri.vo.FanOrder;
import com.xuri.vo.User;

@Repository
public class WxUserDaoImpl implements WxUserDao {
	public static Logger logger = LoggerFactory.getLogger(WxUserDaoImpl.class);
	
	@Autowired  
	private SqlSessionTemplate sqlSessionTemplate;

	@Override
	public int getNextNextUserCount(User user) throws Exception {
		try{
			return sqlSessionTemplate.selectOne("nextnextuser_count", user);
		}catch(Exception e){
			logger.error("nextnextuser_count" + " failed :{}", e);
			throw e;
		}
	}

	@Override
	public List<User> getNextNextUserList(User user) throws Exception {
		try{
			return sqlSessionTemplate.selectList("nextnextuser_list", user);
		}catch(Exception e){
			logger.error("nextnextuser_count" + " failed :{}", e);
			throw e;
		}
	}

	@Override
	public int selectTotFanMoney(FanOrder fanOrder) throws Exception {
		try{
			return sqlSessionTemplate.selectOne("totfanmoney_int", fanOrder);
		}catch(Exception e){
			logger.error("totfanmoney_int" + " failed :{}", e);
			throw e;
		}
	}
	
	@Override
	public int selectTotalTiMoney(User user) throws Exception {
		try{
			return sqlSessionTemplate.selectOne("timoney_int", user);
		}catch(Exception e){
			logger.error("timoney_int" + " failed :{}", e);
			throw e;
		}
	}
}
