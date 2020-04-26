package com.xuri.main.wxMobileSale.service.impl;

import com.xuri.main.wxMobileSale.service.WxMobileSaleService;
import com.xuri.system.dao.BaseDao;
import com.xuri.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class WxMobileSaleServiceImpl implements WxMobileSaleService {

	@Autowired
	private BaseDao baseDao;


	@Override
	public MessageVo saveWxMobileSale(WxMobileSale wxMobileSale) throws Exception {
		try {
			MessageVo messageVo = new MessageVo();
			if(wxMobileSale.getId()==null || wxMobileSale.getId().length()==0) {
				baseDao.insert(wxMobileSale);
				String id = baseDao.selectNewAddId("sy_wx_mobile_sale");
				messageVo.setMessage(id);
			} else {
				baseDao.update(wxMobileSale);
				messageVo.setMessage(wxMobileSale.getId());
			}
			messageVo.setCode("1");
			return messageVo;
		} catch (Exception e) {
			throw e;
		}
	}
	@Override
	public String deleteAdv(Adv adv) throws Exception {
		try {
//			baseDao.delete(adv);
//			if(adv.getUseTag().equals("1")) {//判断删除的是否是正在使用的广告
//				advDao.updateTopAdvUseTag(adv);
//			}
			return "1";
		} catch (Exception e) {
			throw e;
		}
	}
	@Override
	public String updateAdvUse(Adv adv) throws Exception {
		try {
//			User user = new User();
//			user.setId(adv.getUserId());
//			user.setMpUse("0");
//			baseDao.update(user);//设置个人名片不使用
//			advDao.updateAdvTotUseTag(adv);//重置所有使用标记
//			advDao.updateAdvUserTag(adv);//修改使用标记
			return "1";
		} catch (Exception e) {
			throw e;
		}
	}
	@Override
	public String updateAdvMp(User user) throws Exception {
		try {
//			user.setMpUse("1");
//			baseDao.update(user);//设置个人名片不使用
//			Adv adv = new Adv();
//			adv.setUserId(user.getId());
//			advDao.updateAdvTotUseTag(adv);//重置所有使用标记
			return "1";
		} catch (Exception e) {
			throw e;
		}
	}
	@Override
	public String insertAdvClick(User user, HyView hyView) throws Exception {
		try {
//			hyView.setType("2");
//			HyView clHyView = baseDao.selectById(hyView);
//			if(clHyView == null) {//说明第一次点击
//				baseDao.insert(hyView);//添加记录
//				user.setPoint(1);
//				if(user.getMpUse()!=null && user.getMpUse().equals("1")) {//说明使用的是名片
//					user.setMpClick("1");
//				} else {//说明普通广告
//					user.setAdvClick(1);
//
//					Adv adv = new Adv();
//					adv.setUseTag("1");
//					adv.setUserId(user.getId());
//					adv = baseDao.selectById(adv);
//					adv.setClickNum("1");
//					baseDao.update(adv);
//				}
//				baseDao.update(user);//修改用户积分和名片的点击量
//			}
			return "1";
		} catch (Exception e) {
			throw e;
		}
	}
}
