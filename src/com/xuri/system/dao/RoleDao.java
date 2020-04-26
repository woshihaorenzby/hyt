package com.xuri.system.dao;

import java.util.HashMap;

public interface RoleDao {
	//查询添加表的最新id
	public abstract String selectTreeInRole(HashMap<String, String> map) throws Exception;
}
