package com.xuri.main.system.action;

import com.xuri.system.service.BaseService;
import com.xuri.util.BaseAction;
import com.xuri.vo.FreeOrder;
import com.xuri.vo.MessageVo;
import com.xuri.vo.Page;
import net.sf.json.JSON;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * @Title: AdviceAction
 * @Description: TODO 意见反馈
 * @author 黄森泽
 * @date 2016-5-7
 */
public class FreeOrderAction extends BaseAction {
	private FreeOrder freeOrder;
	private Page page;
	private MessageVo messageVo = new MessageVo();

	@Autowired
	private BaseService baseService;

	public String wxShow() {
		return "wxShow";
	}
	
	/**
	 * @Description: TODO 意见反馈
	 * @author 黄森泽
	 */
	public String list() {
		try {
			page = baseService.selectPageList(page, freeOrder);
			System.out.println(JSONObject.valueToString(page));
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
			if(freeOrder.getId()==null||freeOrder.getId()==""){

				baseService.insert(freeOrder);
			}else{
				baseService.update(freeOrder);
			}
			messageVo.setCode("1");
		}catch (Exception e) {
			if(e.getMessage().contains("Cause: com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException")){
				messageVo.setCode("100");
			}else{
				messageVo.setCode("0");
			}
			e.printStackTrace();
		}
		return "messageVo";
	}
	/**
	 * @Description: TODO 保存
	 * @author 黄森泽
	 */
	public String wxUpdate() {
		try {
			baseService.update(freeOrder);
			messageVo.setCode("1");
		}catch (Exception e) {
			if(e.getMessage().contains("Cause: com.mysql.jdbc.exceptions.jdbc4.MySQLIntegrityConstraintViolationException")){
				messageVo.setCode("100");
			}else{
				messageVo.setCode("0");
			}
			e.printStackTrace();
		}
		return "messageVo";
	}
	public String editPage() {
		try {

			if (freeOrder.getId() != null && freeOrder.getId().length() > 0) {
				freeOrder = baseService.selectById(freeOrder);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "editPage";
	}
	/**
	 * @Description: TODO 删除
	 * @author 黄森泽
	 */
	public String delete() {
		try {
			baseService.delete(freeOrder);
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
	public String wxFreeOrder() {
		return "wxFreeOrder";
	}

	public FreeOrder getFreeOrder() {
		return freeOrder;
	}

	public void setFreeOrder(FreeOrder freeOrder) {
		this.freeOrder = freeOrder;
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
