package com.xuri.main.pay.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xuri.main.pay.service.PayService;
import com.xuri.system.dao.BaseDao;
import com.xuri.util.DateUtil;
import com.xuri.vo.FanOrder;
import com.xuri.vo.Payorder;
import com.xuri.vo.User;

@Service
@Transactional
public class PayServiceImpl implements PayService {

	@Autowired
	private BaseDao baseDao;

	@Override
	public String insertPayOrder(Payorder payorder, String companyName) throws Exception {
		try {
			baseDao.insert(payorder);//添加订单记录
			User user = new User();
			user.setId(payorder.getUserId());
			user = baseDao.selectById(user);//查询详细信息，为了查询pid
			User payUser = new User();
			payUser.setId(payorder.getUserId());
			payUser.setMemLevel(payorder.getMemLevel());
			if(payorder.getMemLevel().equals("4")) {
				payUser.setCompanyName(companyName);
			}
			if(user.getMemLevel().equals(payorder.getMemLevel())) {//续费
				String memEndTime = user.getMemEndTime() + " 00:00";
				if(DateUtil.compare_date(DateUtil.getRecentDate("yyyy-MM-dd HH:mm"), memEndTime) == 1) {//如果会员结束日期小于当前时间，则从当前时间开始
					String curTime = DateUtil.getRecentDate("yyyy-MM-dd");
					String curYear = DateUtil.getRecentDate("yyyy");
					payUser.setMemEndTime(curTime.replace(curYear, String.valueOf(Integer.parseInt(curYear) + 1)));
				} else {//续费时间
					String curYear = memEndTime.substring(0, 4);
					payUser.setMemEndTime(memEndTime.replace(curYear, String.valueOf(Integer.parseInt(curYear) + 1)));
				}
			} else if(Integer.parseInt(payorder.getMemLevel()) > Integer.parseInt(user.getMemLevel())) {//升级
				String curTime = DateUtil.getRecentDate("yyyy-MM-dd");
				String curYear = DateUtil.getRecentDate("yyyy");
				payUser.setMemEndTime(curTime.replace(curYear, String.valueOf(Integer.parseInt(curYear) + 1)));
			}
			baseDao.update(payUser);//修改用户会员信息
			
			User pUser = new User();
			pUser.setId(user.getPid());
			if(pUser.getId()!=null && pUser.getId().length()>0) {
				pUser = baseDao.selectById(pUser);//查询上级用户
				if(!pUser.getMemLevel().equals("1")) {
					User upPuser = new User();
					upPuser.setId(pUser.getId());
					upPuser.setTotalMon((int)(payorder.getPayMoney()*0.3));
					upPuser.setYueMon((int)(payorder.getPayMoney()*0.3));
					baseDao.update(upPuser);//修改上级返利
					
					FanOrder fanOrder = new FanOrder();
					fanOrder.setFanType("1");
					fanOrder.setFanMoney(upPuser.getTotalMon());
					fanOrder.setToUserId(upPuser.getId());
					fanOrder.setUserId(payorder.getUserId());
					baseDao.insert(fanOrder);//添加返利记录，一级返利
				}
				if(pUser.getPid()!=null && pUser.getPid().length()>0) {//查询上级的上级的用户
					User ppUser = new User();
					ppUser.setId(pUser.getPid());
					ppUser = baseDao.selectById(ppUser);
					if(!ppUser.getMemLevel().equals("1")) {
						User upPPuser = new User();
						upPPuser.setId(ppUser.getId());
						upPPuser.setTotalMon((int)(payorder.getPayMoney()*0.2));
						upPPuser.setYueMon((int)(payorder.getPayMoney()*0.2));
						baseDao.update(upPPuser);//修改上级上级返利
						
						FanOrder fanOrder = new FanOrder();
						fanOrder.setFanType("2");
						fanOrder.setFanMoney(upPPuser.getTotalMon());
						fanOrder.setToUserId(upPPuser.getId());
						fanOrder.setUserId(payorder.getUserId());
						baseDao.insert(fanOrder);//添加返利记录，二级返利
					}
				}
			}
			return "1";
		} catch (Exception e) {
			throw e;
		}
	}
}
