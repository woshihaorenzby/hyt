package com.xuri.system.action;

import org.springframework.beans.factory.annotation.Autowired;

import com.xuri.system.service.BaseService;
import com.xuri.util.BaseAction;
import com.xuri.vo.MessageVo;
import com.xuri.vo.UtilVo;

/**
 * @Title: UtilAction
 * @Description: TODO 后台用户
 * @author 王东
 * @date 2016-4-6
 */
public class UtilAction extends BaseAction {

	private static final long serialVersionUID = 4445739583071548816L;
	private UtilVo utilVo;
	private MessageVo messageVo = new MessageVo();

	@Autowired
	private BaseService baseService;

	public String updateTag() {
		try {
			baseService.update(utilVo);
			messageVo.setCode("1");
			return "messageVo";
		} catch (Exception e) {
			messageVo.setCode("0");
			e.printStackTrace();
		}
		return "messageVo";
	}

	public UtilVo getUtilVo() {
		return utilVo;
	}

	public void setUtilVo(UtilVo utilVo) {
		this.utilVo = utilVo;
	}

	public MessageVo getMessageVo() {
		return messageVo;
	}

	public void setMessageVo(MessageVo messageVo) {
		this.messageVo = messageVo;
	}
}
