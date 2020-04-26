package com.xuri.main.user.dao;

import java.util.List;

import com.xuri.vo.FanOrder;
import com.xuri.vo.SearchPageUtil;
import com.xuri.vo.User;

public interface WxUserDao {
	//查询二级用户数量
	public abstract int getNextNextUserCount(User user) throws Exception;
	//查询二级用户列表
	public abstract List<User> getNextNextUserList(User user) throws Exception;
	//查询返利的总额
	public abstract int selectTotFanMoney(FanOrder fanOrder) throws Exception;
	//查询数量
	public abstract int selectTotalTiMoney(User user) throws Exception;
}
