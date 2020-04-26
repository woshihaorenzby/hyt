package com.xuri.system.dao;

import java.util.List;

import com.xuri.vo.Syuser;
import com.xuri.vo.Tree;

public interface UserDao {
	//查询添加表的最新id
	public abstract List<Tree> selectUserTree(Syuser syuser) throws Exception;
	//还原用户密码
	public abstract String updateUserPas(Syuser syuser) throws Exception;
	//还原微信用户密码
	public abstract String updateWxUserPas(Syuser syuser) throws Exception;

    Syuser selectByPassWordAndUserName(Syuser syuser);
}
