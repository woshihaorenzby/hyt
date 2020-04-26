package com.xuri.main.user.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.xuri.vo.FanOrder;
import com.xuri.vo.MessageVo;
import com.xuri.vo.TiOrder;
import com.xuri.vo.User;

public interface WxUserService {
	//微信登录
	public abstract User selectWxLogin(HttpServletRequest request) throws Exception;
	//查询二级用户数量
	public abstract int selectNextNextUserCount(User user) throws Exception;
	//查询二级用户列表
	public abstract List<User> selectNextNextUserList(User user) throws Exception;
	//查询返利的总额
	public abstract int selectTotFanMoney(FanOrder fanOrder) throws Exception;
	//查询提现的总额
	public abstract int selectTotalTiMoney(User user) throws Exception;
	//提现
	public abstract String insertTiXian(TiOrder tiOrder) throws Exception;
	//邀请加入公司群组
	public abstract MessageVo insertCompanyZhu(HttpServletRequest request) throws Exception;
}
