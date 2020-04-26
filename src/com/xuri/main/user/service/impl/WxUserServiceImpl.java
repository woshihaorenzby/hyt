package com.xuri.main.user.service.impl;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xuri.main.user.dao.WxUserDao;
import com.xuri.main.user.service.WxUserService;
import com.xuri.system.dao.BaseDao;
import com.xuri.util.EmojiFilter;
import com.xuri.util.EncryptUtil;
import com.xuri.util.WxUtil;
import com.xuri.vo.FanOrder;
import com.xuri.vo.MessageVo;
import com.xuri.vo.SearchPageUtil;
import com.xuri.vo.TiOrder;
import com.xuri.vo.User;
import com.xuri.vo.WxUser;
import com.xuri.vo.WxWebLo;

@Service
@Transactional
public class WxUserServiceImpl implements WxUserService {

	@Autowired
	private BaseDao baseDao;
	@Autowired
	private WxUserDao userDao;

	/**
	 * @Description: TODO 微信登录
	 * @param @param request
	 * @param @return
	 * @param @throws Exception
	 * @author 王东
	 * @date 2016-5-2
	 */
	@Override
	public User selectWxLogin(HttpServletRequest request) throws Exception {
		String code = request.getParameter("code").toString();
		WxWebLo wxWebLo = WxUtil.getWebOpenId(code);
		WxUser wxUser = WxUtil.getWebWxUser(wxWebLo);
		
		User user = new User();
		user.setOpenId(wxUser.getOpenid());
		user.setNiName(EmojiFilter.filterEmoji(wxUser.getNickname()));
		user.setHeadimgurl(wxUser.getHeadimgurl());
		if(wxUser.getSex().equals("1")) {
			user.setSex("男");
		} else if(wxUser.getSex().equals("2")) {
			user.setSex("女");
		}
		user.setProvince(wxUser.getProvince());
		user.setCity(wxUser.getCity());
		user.setCountry(wxUser.getCountry());
		User hauser = baseDao.selectById(user);
		if(hauser != null) {//说明已经存在了
			hauser.setHeadimgurl(user.getHeadimgurl());
			hauser.setNiName(user.getNiName());
			baseDao.updateCustom("updateUserLogin", hauser);
			return hauser;
		} else {
			com.xuri.vo.HySystem system = new com.xuri.vo.HySystem();
			system.setId("1");
			system = baseDao.selectById(system);//查询排序号
			system.setSpe(system.getSpe() + 1);
			baseDao.update(system);
			
			user.setUserCode(String.valueOf(system.getSpe()));
			baseDao.insert(user);
			user = baseDao.selectById(user);
			
			return user;
		}
	}

	/**
	 * @Description: TODO 查询二级用户数量
	 * @param @param user
	 * @author 王东
	 * @date 2016-5-18
	 */
	@Override
	public int selectNextNextUserCount(User user) throws Exception {
		try {
			return userDao.getNextNextUserCount(user);
		} catch (Exception e) {
			throw e;
		}
	}
	/**
	 * @Description: TODO 查询二级用户列表
	 * @param @param user
	 * @author 王东
	 * @date 2016-5-18
	 */
	@Override
	public List<User> selectNextNextUserList(User user) throws Exception {
		try {
			return userDao.getNextNextUserList(user);
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public int selectTotFanMoney(FanOrder fanOrder) throws Exception {
		try {
			return userDao.selectTotFanMoney(fanOrder);
		} catch (Exception e) {
			throw e;
		}
	}
	@Override
	public int selectTotalTiMoney(User user) throws Exception {
		try {
			return userDao.selectTotalTiMoney(user);
		} catch (Exception e) {
			throw e;
		}
	}

	@Override
	public String insertTiXian(TiOrder tiOrder) throws Exception {
		try {
			User user = new User();
			user.setId(tiOrder.getUserId());
			user = baseDao.selectById(user);
			if(user.getYueMon() >= tiOrder.getTiMoney()) {//判断是否余额不足
				baseDao.insert(tiOrder);//添加提现记录
				
				User upUser = new User();
				upUser.setId(user.getId());
				upUser.setTiMon(tiOrder.getTiMoney());
				upUser.setYueMon(user.getYueMon() - tiOrder.getTiMoney());
				baseDao.update(upUser);//修改用户的提现金额和余额
				return "1";
			} else {
				return "2";
			}
		} catch (Exception e) {
			throw e;
		}
	}
	
	@Override
	public MessageVo insertCompanyZhu(HttpServletRequest request) throws Exception {
		MessageVo messageVo = new MessageVo();
		
		String code = request.getParameter("code").toString();
		String state = request.getParameter("state").toString();
		state = EncryptUtil.decrypt(state);
		WxWebLo wxWebLo = WxUtil.getWebOpenId(code);
		WxUser wxUser = WxUtil.getWebWxUser(wxWebLo);
		User senUser = new User();
		senUser.setId(state);
		senUser = baseDao.selectById(senUser);
		if(senUser.getMemLevel().equals("3")) {//如果是普通企业会员，群组人数限制20人
			User selUser = new User();
			selUser.setPcomId(state);
			SearchPageUtil searchPageUtil = new SearchPageUtil();
			searchPageUtil.setObject(selUser);
			int count = baseDao.getCount(searchPageUtil);
			if(count >=20 ) {
				messageVo.setId(state);
				messageVo.setCode("2");
				return messageVo;
			}
		}
		
		User user = new User();
		user.setOpenId(wxUser.getOpenid());
		user.setNiName(wxUser.getNickname());
		user.setHeadimgurl(wxUser.getHeadimgurl());
		if(wxUser.getSex().equals("1")) {
			user.setSex("男");
		} else if(wxUser.getSex().equals("2")) {
			user.setSex("女");
		}
		user.setProvince(wxUser.getProvince());
		user.setCity(wxUser.getCity());
		user.setCountry(wxUser.getCountry());
		User hauser = baseDao.selectById(user);
		if(hauser != null) {//说明已经存在了
			if(hauser.getPcomId() == null || hauser.getPcomId().length()==0) {
				User upUser = new User();
				upUser.setId(hauser.getId());
				upUser.setPcomId(state);
				upUser.setJoinCompany("1");
				baseDao.update(upUser);
			}
		} else {
			com.xuri.vo.HySystem system = new com.xuri.vo.HySystem();
			system.setId("1");
			system = baseDao.selectById(system);//查询排序号
			system.setSpe(system.getSpe() + 1);
			baseDao.update(system);
			
			user.setPid(state);
			user.setPcomId(state);
			user.setJoinCompany("1");
			user.setUserCode(String.valueOf(system.getSpe()));
			baseDao.insert(user);
			user = baseDao.selectById(user);
		}
		messageVo.setId(state);
		messageVo.setCode("1");
		return messageVo;
	}
}
