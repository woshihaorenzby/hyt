package com.xuri.system.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xuri.system.dao.UserDao;
import com.xuri.system.service.UserService;
import com.xuri.vo.Syuser;
import com.xuri.vo.Tree;

@Service
@Transactional
public class UserServiceImpl implements UserService {

	@Autowired
	private UserDao userDao;
	
	/**
	 * @Description: TODO 查询用户左侧树
	 * @author 王东
	 * @date 2016-4-23
	 */
	@Override
	public List<Tree> selectUserTree(Syuser syuser) throws Exception {
		try {
			return userDao.selectUserTree(syuser);
		} catch (Exception e) {
			throw e;
		}
	}
	/**
	 * @Description: TODO 还原用户密码
	 * @author 王东
	 * @date 2016-3-8
	 */
	@Override
	public String updateUserPas(Syuser syuser) throws Exception {
		try {
			String message = userDao.updateUserPas(syuser);
			return message;
		} catch (Exception e) {
			throw e;
		}
	}
	@Override
	public String updateWxUserPas(Syuser syuser) throws Exception {
		try {
			String message = userDao.updateUserPas(syuser);
			return message;
		} catch (Exception e) {
			throw e;
		}
	}
	@Override
	public Syuser selectByPassWordAndUserName(Syuser syuser) throws Exception {
		Syuser s = null;
		try {
			s = userDao.selectByPassWordAndUserName(syuser);
		} catch (Exception e) {
			throw e;
		}
		return s ;
	}
}
