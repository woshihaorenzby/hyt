package com.xuri.main.system.action;

import com.xuri.system.service.BaseService;
import com.xuri.util.BaseAction;
import com.xuri.vo.MessageVo;
import com.xuri.vo.Page;
import com.xuri.vo.Qr;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * @Title: AdviceAction
 * @Description: TODO 意见反馈
 * @author 黄森泽
 * @date 2016-5-7
 */
public class QrAction extends BaseAction {
	private Qr qr;
	private Page page;
	private MessageVo messageVo = new MessageVo();

	@Autowired
	private BaseService baseService;

	public String show() {
		return "show";
	}
	
	/**
	 * @Description: TODO 意见反馈
	 * @author 黄森泽
	 */
	public String wxList() {
		try {
			qr = new Qr();
			page = new Page();
			page.setPageSize(10);
			page.setCurPage(1);
			page.setPageRecordCount(10);
			page = baseService.selectPageList(page, qr);
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
			if(qr.getId()!=null){
				baseService.update(qr);
			}else{
				baseService.insert(qr);
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
			baseService.delete(qr);
			messageVo.setCode("1");
		} catch (Exception e) {
			e.printStackTrace();
			messageVo.setCode("0");
		}
		return "messageVo";
	}
	/**
	 * @Description: TODO 微信显示反馈意见界面
	 * @author 王东
	 */
	public String wxQr() {
		return "wxQr";
	}

	public Qr getQr() {
		return qr;
	}

	public void setQr(Qr qr) {
		this.qr = qr;
	}

	public Page getPage() {
		return page;
	}

	public void setPage(Page page) {
		this.page = page;
	}
	
	public MessageVo getMessageVo() {
		return messageVo;
	}

	public void setMessageVo(MessageVo messageVo) {
		this.messageVo = messageVo;
	}
}
