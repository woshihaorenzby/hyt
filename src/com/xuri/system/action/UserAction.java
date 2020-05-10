package com.xuri.system.action;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import com.xuri.system.service.BaseService;
import com.xuri.system.service.UserService;
import com.xuri.util.BaseAction;
import com.xuri.util.EncryptUtil;
import com.xuri.vo.MessageVo;
import com.xuri.vo.Page;
import com.xuri.vo.Role;
import com.xuri.vo.Syuser;
import com.xuri.vo.Tree;
import com.xuri.vo.User;

/**
 * @Title: UserAction
 * @Description: TODO 后台用户
 * @author 王东
 * @date 2016-4-6
 */
public class UserAction extends BaseAction {

	private static final long serialVersionUID = 896662781112659507L;
	private Syuser syuser;
	private List<Tree> treeList;
	private Page page;
	private List<Role> roleList;
	private MessageVo messageVo = new MessageVo();

	@Autowired
	private BaseService baseService;
	@Autowired
	private UserService userService;
//	@Autowired
//	private Sy userService;
	/**
	 * @Description: TODO 显示后台登录界面
	 * @author 王东
	 * @date 2016-4-6
	 */
	public String gin() {
		return "showLogin";
	}

	/**
	 * @Description: TODO 登录成功界面
	 */
	public String indexPage() {
		return "index";
	}

	/**
	 * @Description: TODO 左侧界面
	 */
	public String left() {
		return "left";
	}

	/**
	 * @Description: TODO 头部界面
	 */
	public String head() {
		return "head";
	}

	/**
	 * @Description: TODO 登录
	 */
	public String login() {
		try {
			syuser.setPassword(EncryptUtil.encrypt(syuser.getPassword()));
			Syuser user = userService.selectByPassWordAndUserName(syuser);
			if (user != null) {
				getSession().setAttribute("userId", user.getId());
				getSession().setAttribute("userName", user.getUserName());
				getSession().setAttribute("roleId", user.getRoleId());
				getSession().setAttribute("syInsert", "1");
				messageVo.setCode("1");
			} else {
				User wxuser = new User();
				wxuser.setPhone(syuser.getUserName());
				wxuser.setPassword(syuser.getPassword());
				wxuser = baseService.selectById(wxuser);
				if (wxuser != null) {
					if(wxuser.getMemLevel().equals("1") || wxuser.getMemLevel().equals("2")) {//没有权限
						messageVo.setCode("2");
					} else {
						getSession().setAttribute("userId", wxuser.getId());
						getSession().setAttribute("userName", wxuser.getNiName());
						getSession().setAttribute("phone", wxuser.getPhone());
						getSession().setAttribute("yaoCode", EncryptUtil.encrypt(wxuser.getId()));
						getSession().setAttribute("companyName", wxuser.getCompanyName());
						getSession().setAttribute("roleId", "");
						getSession().setAttribute("syInsert", "0");
						
						messageVo.setCode("1");
					}
				} else {
					messageVo.setCode("0");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			messageVo.setCode("0");
		}
		return "messageVo";
	}

	/**
	 * @Description: TODO 查询左侧菜单
	 */
	public String leftTree() {
		try {
			syuser = new Syuser();
			String syInsert = getSession().getAttribute("syInsert").toString();
			if(syInsert.equals("1")) {
				syuser.setRoleId(getSession().getAttribute("roleId").toString());
			} else {
				syuser.setRoleId("2");
			}
			List<Tree> list = userService.selectUserTree(syuser);
			treeList= new ArrayList<>();
			for (Tree tree: list) {
				if(tree!=null&&tree.getDisPlay()==0){
					treeList.add(tree);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "treeList";
	}

	public String show() {
		Role role = new Role();
		try {
			roleList = baseService.selectList(role);//查询角色列表
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "show";
	}

	/**
	 * @Description: TODO 用户列表
	 * @author 王东
	 */
	public String list() {
		try {
			syuser = new Syuser();
			page = baseService.selectPageList(page, syuser);
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
			if(syuser.getId()==null || syuser.getId().length()==0) {
				baseService.insert(syuser);
			} else {
				baseService.update(syuser);
			}
			messageVo.setCode("1");
		} catch (Exception e) {
			e.printStackTrace();
			messageVo.setCode("0");
		}
		return "messageVo";
	}

	/**
	 * @Description: TODO 还原密码
	 * @author 王东
	 */
	public String revertPas() {
		try {
			syuser.setPassword("Vr7bCv0gjVpU0UjD0sBQLEibUzrA57x5");
			userService.updateUserPas(syuser);
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
			baseService.delete(syuser);
			messageVo.setCode("1");
		} catch (Exception e) {
			e.printStackTrace();
			messageVo.setCode("0");
		}
		return "messageVo";
	}
	/**
	 * @Description: TODO 显示修改密码界面
	 * @author 王东
	 */
	public String changePasShow() {
		return "changePasShow";
	}
	/**
	 * @Description: TODO 修改密码
	 * @author 王东
	 */
	public String changePas() {
		try {
			String syInsert = getSession().getAttribute("syInsert").toString();
			syuser.setPassword(EncryptUtil.encrypt(syuser.getPassword()));
			if(syInsert.equals("1")) {
				userService.updateUserPas(syuser);
			} else {
				userService.updateWxUserPas(syuser);
			}
			messageVo.setCode("1");
		} catch (Exception e) {
			messageVo.setCode("0");
			e.printStackTrace();
		}
		return "messageVo";
	}
	
	public MessageVo getMessageVo() {
		return messageVo;
	}

	public void setMessageVo(MessageVo messageVo) {
		this.messageVo = messageVo;
	}

	public Syuser getSyuser() {
		return syuser;
	}

	public void setSyuser(Syuser syuser) {
		this.syuser = syuser;
	}

	public List<Tree> getTreeList() {
		return treeList;
	}

	public void setTreeList(List<Tree> treeList) {
		this.treeList = treeList;
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
}
