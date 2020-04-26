package com.xuri.system.service;

import java.util.List;

import com.xuri.vo.Syuser;
import com.xuri.vo.Tree;

public interface UserService {
	//查询用户的左侧树列表
	public abstract List<Tree> selectUserTree(Syuser syuser) throws Exception;
	//还原用户密码
	public abstract String updateUserPas(Syuser syuser) throws Exception;
	//修改微信用户登录的密码
	public abstract String updateWxUserPas(Syuser syuser) throws Exception;

    Syuser selectByPassWordAndUserName(Syuser syuser) throws Exception;
}
