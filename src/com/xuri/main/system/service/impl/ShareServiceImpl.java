package com.xuri.main.system.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xuri.main.system.service.ShareService;
import com.xuri.system.dao.BaseDao;
import com.xuri.vo.Share;
import com.xuri.vo.User;
import com.xuri.vo.Video;

@Service
@Transactional
public class ShareServiceImpl implements ShareService {

	@Autowired
	private BaseDao baseDao;

	/**
	 * @Description: TODO 分享
	 * @author 王东
	 * @date 2016-5-2
	 */
	@Override
	public String insertShare(Share share) throws Exception {
		try {
			Share itShare = baseDao.selectById(share);
			if(itShare == null) {
				User user = new User();
				user.setId(share.getUserId());
				user.setPoint(1);
				baseDao.update(user);//累积用户积分
				baseDao.insert(share);//添加分享记录
				
				Video video = new Video();
				video.setId(share.getVideoId());
				video.setShareNum("1");
				baseDao.update(video);
			} else {
				share.setShareNum("1");
				baseDao.update(share);//添加分享记录

				Video video = new Video();
				video.setId(share.getVideoId());
				video.setShareNum("1");
				baseDao.update(video);
			}
			return "1";
		} catch (Exception e) {
			throw e;
		}
	}

}
