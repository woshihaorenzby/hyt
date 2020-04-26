package com.xuri.vo;

import java.util.List;

/** 
* @ClassName: Page 
* @Description: TODO(分页返回数据类) 
* @author: 王东
* @date: 2015-7-16 下午3:33:07
* 
*/
public class Page {
	/** 每页多少条数据 */
	private int pageRecordCount;
	/** 当前页 */
	private int curPage;
	/** 总条数 */
	private int totalRecord;
	/** 总页数 */
	private int pageSize;
	/** 查询的数据 */
	private List<?> data;

	public int getPageRecordCount() {
		return pageRecordCount;
	}

	public void setPageRecordCount(int pageRecordCount) {
		this.pageRecordCount = pageRecordCount;
	}
	
	public int getCurPage() {
		return curPage;
	}

	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}

	public int getTotalRecord() {
		return totalRecord;
	}

	public void setTotalRecord(int totalRecord) {
		this.totalRecord = totalRecord;
	}
	
	public int getPageSize() {
		return pageSize;
	}

	public void setPageSize(int pageSize) {
		
		this.pageSize = pageSize;
	}

	public List<?> getData() {
		return data;
	}

	public void setData(List<?> data) {
		this.data = data;
	}
	
}
