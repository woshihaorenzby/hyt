package com.xuri.main.system.action;

import com.xuri.system.service.BaseService;
import com.xuri.util.BaseAction;
import com.xuri.vo.Cooperation;
import com.xuri.vo.Customized;
import com.xuri.vo.MessageVo;
import com.xuri.vo.Page;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * @Title: AdviceAction
 * @Description: TODO 意见反馈
 * @author 黄森泽
 * @date 2016-5-7
 */
public class CustomizedAction extends BaseAction {
	private Customized customized;
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
	public String list() {
		try {
			customized = new Customized();
			page = baseService.selectPageList(page, customized);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "page";
	}
	/**
	 * @Description: TODO 保存
	 * @author 黄森泽
	 */
	public String wxSave() {
		try {
			if(customized.getId()==null){
				baseService.insert(customized);
			}else{
				baseService.update(customized);
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
			baseService.delete(customized);
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
	public String wxCustomized() {
		return "wxCustomized";
	}

	public Customized getCustomized() {
		return customized;
	}

	public void setCustomized(Customized customized) {
		this.customized = customized;
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
