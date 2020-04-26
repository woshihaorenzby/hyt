package com.xuri.system.dao.impl;

import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xuri.system.dao.RoleDao;

@Repository
public class RoleDaoImpl implements RoleDao {
	public static Logger logger = LoggerFactory.getLogger(RoleDaoImpl.class);
	
	@Autowired  
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	* @Title: selectUserTree
	* @Description: TODO(查询用户的左侧树)
	* @author：王东
	* @date 2016-4-23
	*/
	@Override
	public String selectTreeInRole(HashMap<String, String> map) throws Exception {
		try{
			return sqlSessionTemplate.selectOne("treeinrole_select", map);
		}catch(Exception e){
			logger.error("treeinrole_select" + " failed :{}", e);
			throw e;
		}
	}
}
