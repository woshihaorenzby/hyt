package com.xuri.main.system.action;

import org.springframework.beans.factory.annotation.Autowired;

import com.xuri.system.service.BaseService;
import com.xuri.util.BaseAction;
import com.xuri.vo.Advice;
import com.xuri.vo.MessageVo;
import com.xuri.vo.Page;

/**
 * @Title: AdviceAction
 * @Description: TODO 意见反馈
 * @author 黄森泽
 * @date 2016-5-7
 */
public class AdviceAction extends BaseAction {
	private static final long serialVersionUID = 8109868459302222569L;
	private Advice advice;
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
			advice = new Advice();
			page = baseService.selectPageList(page, advice);
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
			if(advice.getId()==null){
				baseService.insert(advice);
			}else{
				baseService.update(advice);
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
			baseService.delete(advice);
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
	public String wxAdvice() {
		return "wxAdvice";
	}
	
	public Advice getAdvice() {
		return advice;
	}

	public void setAdvice(Advice advice) {
		this.advice = advice;
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
