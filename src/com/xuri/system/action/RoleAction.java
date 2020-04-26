package com.xuri.system.action;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.xuri.system.service.BaseService;
import com.xuri.system.service.RoleService;
import com.xuri.util.BaseAction;
import com.xuri.vo.MessageVo;
import com.xuri.vo.Page;
import com.xuri.vo.Role;
import com.xuri.vo.RoleTree;
import com.xuri.vo.Tree;

/**
 * @Title: RoleAction
 * @Description: TODO 角色
 * @author 王东
 * @date 2016-4-6
 */
public class RoleAction extends BaseAction {

	private static final long serialVersionUID = 7649572536734704927L;
	private Role role;
	private Page page;
	private List<Tree> treeList;
	private String nodeId;
	private MessageVo messageVo = new MessageVo();

	@Autowired
	private RoleService roleService;
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
	 * @Description: TODO 角色列表
	 * @author 王东
	 */
	public String list() {
		try {
			role = new Role();
			page = baseService.selectPageList(page, role);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "page";
	}
	/**
	 * @Description: TODO 角色保存
	 * @author 王东
	 */
	public String save() {
		try {
			if(role.getId() == null || role.getId().length()==0) {
				baseService.insert(role);
			} else {
				baseService.update(role);
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
			if(role.getId() != null && role.getId().length()>0) {
				baseService.delete(role);
			}
			messageVo.setCode("1");
		} catch (Exception e) {
			messageVo.setCode("0");
			e.printStackTrace();
		}
		return "messageVo";
	}
	/**
	 * @Description: TODO 查询角色用户的权限
	 * @author 王东
	 */
	public String roleTree() {
		try {
			treeList = roleService.roleTree(role);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "treeList";
	}
	/**
	 * @Description: TODO 重新给角色授权
	 * @author 王东
	 */
	public String auditTree() {
		try {
			if(role.getId() != null && role.getId().length()>0) {
				String[] nodeIdArr = nodeId.split("\\|");
				List<RoleTree> roleTreeList = new ArrayList<RoleTree>();
				for(int i=0;i<nodeIdArr.length;i++) {
					RoleTree roleTree = new RoleTree();
					roleTree.setRoleId(role.getId());
					roleTree.setTreeId(nodeIdArr[i]);
					roleTreeList.add(roleTree);
				}
				roleService.updateRoleTree(roleTreeList);
			}
			messageVo.setCode("1");
		} catch (Exception e) {
			messageVo.setCode("0");
			e.printStackTrace();
		}
		return "messageVo";
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
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
	public List<Tree> getTreeList() {
		return treeList;
	}
	public void setTreeList(List<Tree> treeList) {
		this.treeList = treeList;
	}
	public String getNodeId() {
		return nodeId;
	}
	public void setNodeId(String nodeId) {
		this.nodeId = nodeId;
	}
}
