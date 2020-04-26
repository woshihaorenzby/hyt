package com.xuri.main.system.action;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.xuri.system.service.BaseService;
import com.xuri.util.BaseAction;
import com.xuri.vo.Lunimg;
import com.xuri.vo.MessageVo;
import com.xuri.vo.Page;
import com.xuri.vo.Role;

/**
 * @Title: LunimgAction
 * @Description: TODO 轮播图片
 * @author 王东
 * @date 2016-4-6
 */
public class LunimgAction extends BaseAction {

	private static final long serialVersionUID = 8109868459302222569L;
	private Lunimg lunimg;
	private Page page;
	private List<Role> roleList;
	private MessageVo messageVo = new MessageVo();

	@Autowired
	private BaseService baseService;

	public String show() {
		return "show";
	}
	public String editPage() {
		try {
			lunimg = baseService.selectById(lunimg);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "editPage";
	}
	/**
	 * @Description: TODO 用户列表
	 * @author 王东
	 */
	public String list() {
		try {
			lunimg = new Lunimg();
			page = baseService.selectPageList(page, lunimg);
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
			if(lunimg.getId()==null || lunimg.getId().length()==0) {
				baseService.insert(lunimg);
			} else {
				baseService.update(lunimg);
			}
			messageVo.setCode("1");
		} catch (Exception e) {
			e.printStackTrace();
			messageVo.setCode("0");
		}
		return "messageVo";
	}
	/**
	 * @Description: TODO 删除用户
	 * @author 王东
	 */
	public String delete() {
		try {
			baseService.delete(lunimg);
			messageVo.setCode("1");
		} catch (Exception e) {
			e.printStackTrace();
			messageVo.setCode("0");
		}
		return "messageVo";
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

	public List<Role> getRoleList() {
		return roleList;
	}

	public void setRoleList(List<Role> roleList) {
		this.roleList = roleList;
	}
	public Lunimg getLunimg() {
		return lunimg;
	}
	public void setLunimg(Lunimg lunimg) {
		this.lunimg = lunimg;
	}
}
