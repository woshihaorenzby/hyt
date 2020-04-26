package com.xuri.system.action;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.xuri.system.service.BaseService;
import com.xuri.util.BaseAction;
import com.xuri.vo.MessageVo;
import com.xuri.vo.Type;

/**
 * @Title: TypeAction
 * @Description: TODO 类别
 * @author 王东
 * @date 2016-4-6
 */
public class TypeAction extends BaseAction {

	private static final long serialVersionUID = 7069281050803915843L;
	private Type type;
	private List<Type> typeList;
	private MessageVo messageVo = new MessageVo();

	@Autowired
	private BaseService baseService;

	/**
	 * @Description: TODO 显示界面
	 * @author 王东
	 */
	public String show() {
		return "show";
	}
	/**
	 * @Description: TODO 类别列表
	 * @author 王东
	 */
	public String list() {
		try {
			typeList = baseService.selectList(type);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "typeList";
	}
	/**
	 * @Description: TODO 角色保存
	 * @author 王东
	 */
	public String save() {
		try {
			if(type.getId() == null || type.getId().length()==0) {
				baseService.insert(type);
			} else {
				baseService.update(type);
			}
			messageVo.setCode("1");
		} catch (Exception e) {
			messageVo.setCode("0");
			e.printStackTrace();
		}
		return "messageVo";
	}
	/**
	 * @Description: TODO 删除
	 * @author 王东
	 */
	public String delete() {
		try {
			if(type.getId() != null && type.getId().length()>0) {
				baseService.delete(type);
			}
			messageVo.setCode("1");
		} catch (Exception e) {
			messageVo.setCode("0");
			e.printStackTrace();
		}
		return "messageVo";
	}
	public Type getType() {
		return type;
	}
	public void setType(Type type) {
		this.type = type;
	}
	public List<Type> getTypeList() {
		return typeList;
	}
	public void setTypeList(List<Type> typeList) {
		this.typeList = typeList;
	}
	public MessageVo getMessageVo() {
		return messageVo;
	}
	public void setMessageVo(MessageVo messageVo) {
		this.messageVo = messageVo;
	}
}
