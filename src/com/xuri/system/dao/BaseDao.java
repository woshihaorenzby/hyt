package com.xuri.system.dao;

import java.util.List;

import com.xuri.vo.SearchPageUtil;

public interface BaseDao {
	//添加
	public abstract <T> String insert(T t) throws Exception;
	//批量添加
	public abstract <T> String insertList(List<T> t) throws Exception;
	//修改
	public abstract <T> String update(T t) throws Exception;
	//自定义修改
	public abstract <T> String updateCustom(String myStrId, T t) throws Exception;
	//删除
	public abstract <T> String delete(T t) throws Exception;
	//查询添加表的最新id
	public abstract String selectNewAddId(String table) throws Exception;
	//根据Id查询详情
	public abstract <T> T selectById(T t) throws Exception;
	//查询列表
	public abstract <T> List<T> selectList(T t) throws Exception;
	//查询数量
	public abstract int getCount(SearchPageUtil searchPageUtil) throws Exception;
	//查询分页列表
	public abstract <T> List<T> searchPageList(T t, SearchPageUtil searchPageUtil) throws Exception;
	//查询app分页列表
	public abstract <T> List<T> selectAppList(T t) throws Exception;
	//查询app分页列表
	public abstract <T> List<T> selectCustomList(String myStrId, T t) throws Exception;
	//自定义参数查询
	public abstract <T> T selectCustomOne(String myStrId, T t) throws Exception;
}
