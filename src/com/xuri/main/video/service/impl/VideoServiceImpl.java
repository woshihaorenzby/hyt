package com.xuri.main.video.service.impl;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xuri.main.user.dao.WxUserDao;
import com.xuri.main.video.service.VideoService;
import com.xuri.system.dao.BaseDao;
import com.xuri.util.WxUtil;
import com.xuri.vo.HyView;
import com.xuri.vo.User;
import com.xuri.vo.Video;
import com.xuri.vo.WxUser;
import com.xuri.vo.WxWebLo;

@Service
@Transactional
public class VideoServiceImpl implements VideoService {

	@Autowired
	private BaseDao baseDao;

	/**
	 * @Description: TODO 视频访问量
	 * @param @param user
	 * @author 王东
	 * @date 2016-5-18
	 */
	@Override
	public String insertVideoView(HyView hyView) throws Exception {
		try {
			HyView selView = baseDao.selectById(hyView);
			if(selView == null) {//说明没有访问过
				hyView.setType("1");
				baseDao.insert(hyView);//添加访问记录
				if(hyView.getUserId() != null && hyView.getUserId().length()>0) {
					User user = new User();
					user.setId(hyView.getUserId());
					user = baseDao.selectById(user);//查询用户信息
					User upUser = new User();//需要修改的对象
					upUser.setId(user.getId());
					upUser.setAdvShow(1);
					if(upUser.getAdvShow()%10 == 0) {
						upUser.setPoint(1);
					}
					baseDao.update(upUser);//修改用户积分，广告展现量
				}
			}
			Video video = new Video();
			video.setId(hyView.getVideoId());
			Video seVideo = baseDao.selectById(video);
			video.setViewNum("1");
			if(seVideo!=null && seVideo.getViewNum()!=null) {
				if(Integer.parseInt(seVideo.getViewNum()) < 200) {
					video.setViewNum("20");
				}
			}
			baseDao.update(video);//修改视频的访问量
			return "1";
		} catch (Exception e) {
			throw e;
		}
	}
}
