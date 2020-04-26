package com.xuri.system.service;

import java.util.List;

import com.xuri.vo.Role;
import com.xuri.vo.RoleTree;
import com.xuri.vo.Tree;

public interface RoleService {
	//查询角色的权限数
	public abstract List<Tree> roleTree(Role role) throws Exception;
	//授权
	public abstract void updateRoleTree(List<RoleTree> roleTreeList) throws Exception;
}
