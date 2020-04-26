package com.xuri.system.dao.impl;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.xuri.system.dao.BaseDao;
import com.xuri.vo.SearchPageUtil;

@Repository
public class BaseDaoImpl implements BaseDao {
	public static Logger logger = LoggerFactory.getLogger(BaseDaoImpl.class);
	
	@Autowired  
	private SqlSessionTemplate sqlSessionTemplate;
	
	/**
	* @Title: insert
	* @Description: TODO(添加记录)
	* @author：王东
	* @param @return
	* @throws Exception 
	* @date 2016-3-8
	*/
	@Override
	public <T> String insert(T t) throws Exception {
		try{
			sqlSessionTemplate.insert(t.getClass().getSimpleName().toLowerCase() + "_insert", t);
			return "1";
		}catch(Exception e){
			logger.error(t.getClass().getSimpleName().toLowerCase() + "_insert" + " failed :{}", e);
			throw e;
		}
	}
	/**
	* @Title: insertList
	* @Description: TODO(批量添加记录)
	* @author：王东
	* @param @return
	* @throws Exception 
	* @date 2016-3-8
	*/
	@Override
	public <T> String insertList(List<T> t) throws Exception {
		try{
			sqlSessionTemplate.insert(t.get(0).getClass().getSimpleName().toLowerCase() + "list_insert", t);
			return "1";
		}catch(Exception e){
			logger.error(t.getClass().getSimpleName().toLowerCase() + "_insert" + " failed :{}", e);
			throw e;
		}
	}
	/**
	* @Title: update
	* @Description: TODO(修改记录)
	* @author：王东
	* @param @return
	* @throws Exception 
	* @date 2016-3-8
	*/
	@Override
	public <T> String update(T t) throws Exception {
		try{
			sqlSessionTemplate.update(t.getClass().getSimpleName().toLowerCase() + "_update", t);
			return "1";
		}catch(Exception e){
			logger.error(t.getClass().getSimpleName().toLowerCase() + "_update" + " failed :{}", e);
			throw e;
		}
	}
	/**
	 * @Title: updateCustom
	 * @Description: TODO(自定义修改记录)
	 * @author：王东
	 * @param @return
	 * @throws Exception
	 * @date 2016-3-8
	 */
	@Override
	public <T> String updateCustom(String myStrId, T t) throws Exception {
		try{
			sqlSessionTemplate.update(myStrId, t);
			return "1";
		}catch(Exception e){
			System.out.println(myStrId + " failed :{}");
			logger.error(myStrId + " failed :{}", e);
			throw e;
		}
	}
	/**
	* @Title: delete
	* @Description: TODO(删除记录)
	* @author：王东
	* @param @return
	* @throws Exception 
	* @date 2016-3-8
	*/
	@Override
	public <T> String delete(T t) throws Exception {
		try{
			sqlSessionTemplate.delete(t.getClass().getSimpleName().toLowerCase() + "_delete", t);
			return "1";
		}catch(Exception e){
			logger.error(t.getClass().getSimpleName().toLowerCase() + "_delete" + " failed :{}", e);
			throw e;
		}
	}
	/**
	* @Title: selectNewAddId
	* @Description: TODO(查询添加表的最新id)
	* @author：王东
	* @param @return
	* @throws Exception 
	* @date 2016-3-8
	*/
	@Override
	public String selectNewAddId(String table) throws Exception {
		try{
			return sqlSessionTemplate.selectOne("table_select", table);
		}catch(Exception e){
			logger.error("" + " failed :{}", e);
			throw e;
		}
	}
	/**
	* @Title: selectById
	* @Description: TODO(查询详情)
	* @author：王东
	* @param @return
	* @throws Exception 
	* @date 2016-3-8
	*/
	@Override
	public <T> T selectById(T t) throws Exception {
		try{
			return sqlSessionTemplate.selectOne(t.getClass().getSimpleName().toLowerCase() + "detail_select", t);
		}catch(Exception e){
			logger.error(t.getClass().getSimpleName().toLowerCase() + "detail_select" + " failed :{}", e);
			throw e;
		}
	}
	/**
	* @Title: selectList
	* @Description: TODO(查询列表)
	* @author：王东
	* @param @return
	* @throws Exception 
	* @date 2016-3-8
	*/
	@Override
	public <T> List<T> selectList(T t) throws Exception {
		try{
			return sqlSessionTemplate.selectList(t.getClass().getSimpleName().toLowerCase() + "_select", t);
		}catch(Exception e){
			logger.error(t.getClass().getSimpleName().toLowerCase() + "_select" + " failed :{}", e);
			throw e;
		}
	}
	/**
	* @Title: getCount
	* @Description: TODO(获取数量)
	*/
	@Override
	public int getCount(SearchPageUtil searchPageUtil) throws Exception {
		try{
			return sqlSessionTemplate.selectOne(searchPageUtil.getObject().getClass().getSimpleName().toLowerCase() + "_count", searchPageUtil);
		}catch(Exception e){
			logger.error(searchPageUtil.getObject().getClass().getSimpleName().toLowerCase() + "_count" + " failed :{}", e);
			throw e;
		}
	}
	/**
	* @Title: searchPageList
	* @Description: TODO(查询分页列表)
	*/
	@Override
	public <T> List<T> searchPageList(T t, SearchPageUtil searchPageUtil) throws Exception {
		try{
			return sqlSessionTemplate.selectList(searchPageUtil.getObject().getClass().getSimpleName().toLowerCase() + "_pageList", searchPageUtil);
		}catch(Exception e){
			logger.error(searchPageUtil.getObject().getClass().getSimpleName().toLowerCase() + "_pageList" + " failed :{}", e);
			throw e;
		}
	}
	/**
	* @Title: selectAppList
	* @Description: TODO(查询app分页列表)
	*/
	@Override
	public <T> List<T> selectAppList(T t) throws Exception {
		try{
			return sqlSessionTemplate.selectList(t.getClass().getSimpleName().toLowerCase() + "_appList", t);
		}catch(Exception e){
			logger.error(t.getClass().getSimpleName().toLowerCase() + "_appList" + " failed :{}", e);
			throw e;
		}
	}
	/**
	 * @Title: selectAppList
	 * @Description: TODO(查询app分页列表)
	 */
	@Override
	public <T> List<T> selectCustomList(String myStrId, T t) throws Exception {
		try{
			return sqlSessionTemplate.selectList(myStrId, t);
		}catch(Exception e){
			logger.error(myStrId + " failed :{}", e);
			throw e;
		}
	}
	/**
	 * @Title: selectCustomOne
	 * @Description: TODO(自定义参数查询)
	 */
	@Override
	public <T> T selectCustomOne(String myStrId, T t) throws Exception {
		try{
			return sqlSessionTemplate.selectOne(myStrId, t);
		}catch(Exception e){
			logger.error(myStrId + " failed :{}", e);
			throw e;
		}
	}
}
