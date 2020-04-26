package com.xuri.system.dao.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xuri.system.dao.UserDao;
import com.xuri.vo.SearchPageUtil;
import com.xuri.vo.Syuser;
import com.xuri.vo.Tree;

@Repository
public class UserDaoImpl implements UserDao {
	public static Logger logger = LoggerFactory.getLogger(UserDaoImpl.class);
	
	@Autowired  
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	* @Title: selectUserTree
	* @Description: TODO(查询用户的左侧树)
	* @author：王东
	* @date 2016-4-23
	*/
	@Override
	public List<Tree> selectUserTree(Syuser syuser) throws Exception {
		try{
			return sqlSessionTemplate.selectList("syusertree_select", syuser);
		}catch(Exception e){
			logger.error("syusertree_select" + " failed :{}", e);
			throw e;
		}
	}
	/**
	* @Title: updateUserPas
	* @Description: TODO(还原用户密码)
	* @author：王东
	* @date 2016-4-23
	*/
	@Override
	public String updateUserPas(Syuser syuser) throws Exception {
		try{
			sqlSessionTemplate.update("syuserpas_update", syuser);
			return "1";
		}catch(Exception e){
			logger.error("syuserpas_update" + " failed :{}", e);
			throw e;
		}
	}
	@Override
	public String updateWxUserPas(Syuser syuser) throws Exception {
		try{
			sqlSessionTemplate.update("wxsyuserpas_update", syuser);
			return "1";
		}catch(Exception e){
			logger.error("syuserpas_update" + " failed :{}", e);
			throw e;
		}
	}

	@Override
	public Syuser selectByPassWordAndUserName(Syuser syuser) {
		Syuser s = null;
		try{
			Object o = sqlSessionTemplate.selectOne("syuserlogin_select", syuser);
			if(o!=null)
				s =(Syuser)o;
			return s;
		}catch(Exception e){
			logger.error("syusertree_select" + " failed :{}", e);
			throw e;
		}
	}
}
