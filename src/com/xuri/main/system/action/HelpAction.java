package com.xuri.main.system.action;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.xuri.system.service.BaseService;
import com.xuri.util.BaseAction;
import com.xuri.vo.Help;
import com.xuri.vo.MessageVo;
import com.xuri.vo.Page;

/**
 * @Title: HelpAction
 * @Description: TODO 帮助中心
 * @author 王东
 * @date 2016-4-6
 */
public class HelpAction extends BaseAction {

	private static final long serialVersionUID = 3521058329803609578L;
	private Help help;
	private List<Help> helpList;
	private Page page;
	private MessageVo messageVo = new MessageVo();

	@Autowired
	private BaseService baseService;

	public String show() {
		return "show";
	}

	public String editPage() {
		try {
			if(help!=null && help.getId().length()>0) {
				help = baseService.selectById(help);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "editPage";
	}

	/**
	 * @Description: TODO 帮助中心列表
	 * @author 王东
	 */
	public String list() {
		try {
			help = new Help();
			page = baseService.selectPageList(page, help);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "page";
	}

	/**
	 * @Description: TODO 保存
	 * @author 王东
	 */
	public String save() {
		try {
			if (help.getId() == null || help.getId().length() == 0) {
				baseService.insert(help);
			} else {
				baseService.update(help);
			}
			messageVo.setCode("1");
		} catch (Exception e) {
			e.printStackTrace();
			messageVo.setCode("0");
		}
		return "messageVo";
	}

	/**
	 * @Description: TODO 删除帮助中心
	 * @author 王东
	 */
	public String delete() {
		try {
			baseService.delete(help);
			messageVo.setCode("1");
		} catch (Exception e) {
			e.printStackTrace();
			messageVo.setCode("0");
		}
		return "messageVo";
	}
	
	public String wxHelp() {
		try {
			help = new Help();
			help.setDisplay("1");
			helpList = baseService.selectList(help);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "wxHelp";
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

	public Help getHelp() {
		return help;
	}

	public void setHelp(Help help) {
		this.help = help;
	}

	public List<Help> getHelpList() {
		return helpList;
	}

	public void setHelpList(List<Help> helpList) {
		this.helpList = helpList;
	}

}
