package com.xuri.main.video.service;

import com.xuri.vo.HyView;

public interface VideoService {
	//添加视频访问量
	public abstract String insertVideoView(HyView hyView) throws Exception;
}
