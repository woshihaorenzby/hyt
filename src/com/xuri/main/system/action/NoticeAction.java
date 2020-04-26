package com.xuri.main.system.action;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.xuri.system.service.BaseService;
import com.xuri.util.BaseAction;
import com.xuri.vo.MessageVo;
import com.xuri.vo.Notice;
import com.xuri.vo.Page;

/**
 * @Title: NoticeAction
 * @Description: TODO 系统公告
 * @author 黄森泽
 * @date 2016-5-8
 */
public class NoticeAction extends BaseAction {

	private static final long serialVersionUID = -9098270242873738439L;
	private Notice notice;
	private List<Notice> noticeList;
	private Page page;
	private MessageVo messageVo = new MessageVo();

	@Autowired
	private BaseService baseService;

	public String show() {
		return "show";
	}

	public String editPage() {
		try {
			if(notice!=null && notice.getId().length()>0) {
				notice = baseService.selectById(notice);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "editPage";
	}

	/**
	 * @Description: TODO 公告列表
	 * @author 黄森泽
	 */
	public String list() {
		try {
			notice = new Notice();
			page = baseService.selectPageList(page, notice);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "page";
	}

	/**
	 * @Description: TODO 保存
	 * @author 黄森泽
	 */
	public String save() {
		try {
			if (notice.getId() == null || notice.getId().length() == 0) {
				baseService.insert(notice);
			} else {
				baseService.update(notice);
			}
			messageVo.setCode("1");
		} catch (Exception e) {
			e.printStackTrace();
			messageVo.setCode("0");
		}
		return "messageVo";
	}

	/**
	 * @Description: TODO 删除
	 * @author 黄森泽
	 */
	public String delete() {
		try {
			baseService.delete(notice);
			messageVo.setCode("1");
		} catch (Exception e) {
			e.printStackTrace();
			messageVo.setCode("0");
		}
		return "messageVo";
	}
	/**
	 * @Description: TODO 显示微信消息界面
	 * @author 王东
	 */
	public String wxNotice() {
		try {
			notice = new Notice();
			notice.setDisplay("1");
			noticeList = baseService.selectList(notice);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "wxNotice";
	}
	/**
	 * @Description: TODO 显示微信消息详情界面
	 * @author 王东
	 */
	public String wxNoticeDetail() {
		try {
			notice = baseService.selectById(notice);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "wxNoticeDetail";
	}
	public MessageVo getMessageVo() {
		return messageVo;
	}

	public void setMessageVo(MessageVo messageVo) {
		this.messageVo = messageVo;
	}

	public Page getPage() {
		return page;
	}

	public void setPage(Page page) {
		this.page = page;
	}

	public Notice getNotice() {
		return notice;
	}

	public void setNotice(Notice notice) {
		this.notice = notice;
	}

	public List<Notice> getNoticeList() {
		return noticeList;
	}

	public void setNoticeList(List<Notice> noticeList) {
		this.noticeList = noticeList;
	}

}
