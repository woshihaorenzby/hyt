package com.xuri.vo;

import java.util.Date;

/**
 * @Title: Advice
 * @Description: TODO 意见反馈
 */
public class Cooperation {
	private String id;
	private String content;
	private Date createTime;
	private String company;
	private String cooperationer;
	private String mobile;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getCooperationer() {
		return cooperationer;
	}

	public void setCooperationer(String cooperationer) {
		this.cooperationer = cooperationer;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
}
