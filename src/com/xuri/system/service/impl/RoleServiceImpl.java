package com.xuri.system.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xuri.system.dao.BaseDao;
import com.xuri.system.dao.RoleDao;
import com.xuri.system.service.RoleService;
import com.xuri.vo.Role;
import com.xuri.vo.RoleTree;
import com.xuri.vo.Tree;

@Service
@Transactional
public class RoleServiceImpl implements RoleService {

	@Autowired
	private RoleDao roleDao;
	@Autowired
	private BaseDao baseDao;
	
	/**
	 * @Description: TODO 查询用户左侧树
	 * @author 王东
	 * @date 2016-4-23
	 */
	@Override
	public List<Tree> roleTree(Role role) throws Exception {
		try {
			List<Tree> treeList = baseDao.selectList(new Tree());
			List<Tree> returnList = new ArrayList<>();
			for(int i=0;i<treeList.size();i++){
				if(treeList.get(i).getDisPlay()==0){
					HashMap<String, String> map = new HashMap<String, String>();
					map.put("roleId", role.getId());
					map.put("treeId", treeList.get(i).getId());
					String roleTreeId = roleDao.selectTreeInRole(map);
					if(roleTreeId != null){
						treeList.get(i).setChecked(true);
					}else{
						treeList.get(i).setChecked(false);
					}
					returnList.add(treeList.get(i));
				}
			}
			return returnList;
		} catch (Exception e) {
			throw e;
		}
	}
	/**
	 * @Description: TODO 角色重新授权
	 * @author 王东
	 * @date 2016-4-23
	 */
	@Override
	public void updateRoleTree(List<RoleTree> roleTreeList) throws Exception {
		try {
			RoleTree roleTree = roleTreeList.get(0);
			baseDao.delete(roleTree);//删除以前的角色树
			baseDao.insertList(roleTreeList);//插入新的
		} catch (Exception e) {
			throw e;
		}
	}
}
