package com.xuri.system.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xuri.system.dao.BaseDao;
import com.xuri.system.service.BaseService;
import com.xuri.vo.Page;
import com.xuri.vo.SearchPageUtil;

@Service
@Transactional
public class BaseServiceImpl implements BaseService {

	@Autowired
	private BaseDao baseDao;
	
	/**
	 * @Description: TODO 添加
	 * @author 王东
	 * @date 2016-3-8
	 */
	@Override
	public <T> String insert(T t) throws Exception {
		try {
			String message = baseDao.insert(t);
			return message;
		} catch (Exception e) {
			throw e;
		}
	}
	/**
	 * @Description: TODO 批量添加
	 * @author 王东
	 * @date 2016-3-8
	 */
	@Override
	public <T> String insertList(List<T> t) throws Exception {
		try {
			String message = baseDao.insertList(t);
			return message;
		} catch (Exception e) {
			throw e;
		}
	}
	/**
	 * @Description: TODO 修改
	 * @author 王东
	 * @date 2016-3-8
	 */
	@Override
	public <T> String update(T t) throws Exception {
		try {
			String message = baseDao.update(t);
			return message;
		} catch (Exception e) {
			throw e;
		}
	}
	/**
	 * @Description: TODO 自定义修改
	 * @author 王东
	 * @date 2016-3-8
	 */
	@Override
	public <T> String updateCustom(String myStrId, T t) throws Exception {
		try {
			String message = baseDao.updateCustom(myStrId, t);
			return message;
		} catch (Exception e) {
			throw e;
		}
	}
	/**
	 * @Description: TODO 删除
	 * @author 王东
	 * @date 2016-3-8
	 */
	@Override
	public <T> String delete(T t) throws Exception {
		try {
			String message = baseDao.delete(t);
			return message;
		} catch (Exception e) {
			throw e;
		}
	}
	/**
	 * @Description: TODO 查询数量
	 * @author 王东
	 * @date 2016-3-8
	 */
	@Override
	public <T> int selectCount(T t) throws Exception {
		try {
			SearchPageUtil searchPageUtil = new SearchPageUtil();
			searchPageUtil.setObject(t);
			int count = baseDao.getCount(searchPageUtil);
			return count;
		} catch (Exception e) {
			throw e;
		}
	}
	/**
	 * @Description: TODO 查询添加表的最新id
	 * @author 王东
	 * @date 2016-3-8
	 */
	@Override
	public String selectNewAddId(String table) throws Exception {
		try {
			String message = baseDao.selectNewAddId(table);
			return message;
		} catch (Exception e) {
			throw e;
		}
	}
	/**
	 * @Description: TODO 根据id查询详情
	 * @author 王东
	 * @date 2016-3-8
	 */
	@Override
	public <T> T selectById(T t) throws Exception {
		try {
			return baseDao.selectById(t);
		} catch (Exception e) {
			throw e;
		}
	}
	/**
	 * @Description: TODO 查询列表
	 * @author 王东
	 * @date 2016-3-8
	 */
	@Override
	public <T> List<T> selectList(T t) throws Exception {
		try {
			return baseDao.selectList(t);
		} catch (Exception e) {
			throw e;
		}
	}
	/**
	 * @Description: TODO 查询分页列表
	 * @author 王东
	 * @date 2016-3-8
	 */
	@Override
	public <T> Page selectPageList(Page page, T t) throws Exception {
		SearchPageUtil searchPageUtil = new SearchPageUtil();
		searchPageUtil.setObject(t);
		int count = baseDao.getCount(searchPageUtil);
		page.setTotalRecord(count);
		page.setPageSize((int)Math.ceil((double)count/(double)page.getPageRecordCount()));
		searchPageUtil.setPage(page);
		List<T> list = baseDao.searchPageList(t, searchPageUtil);
		page.setData(list);
		return page;
	}
	/**
	 * @Description: TODO 查询app列表
	 * @author 王东
	 * @date 2016-3-8
	 */
	@Override
	public <T> List<T> selectAppPageList(T t) throws Exception {
		try {
			return baseDao.selectAppList(t);
		} catch (Exception e) {
			throw e;
		}
	}
	/**
	 * @Description: TODO 查询app列表
	 * @author 王东
	 * @date 2016-3-8
	 */
	@Override
	public <T> List<T> selectCustomList(String myStrId, T t) throws Exception {
		try {
			return baseDao.selectCustomList(myStrId, t);
		} catch (Exception e) {
			throw e;
		}
	}
	/**
	 * @Description: TODO 自定义参数查询
	 * @author 王东
	 * @date 2016-3-8
	 */
	@Override
	public <T> T selectCustomOne(String myStrId, T t) throws Exception {
		try {
			return baseDao.selectCustomOne(myStrId, t);
		} catch (Exception e) {
			throw e;
		}
	}
}
