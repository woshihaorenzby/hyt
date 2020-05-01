package com.xuri.vo;

/**
 * @Title: Advice
 * @Description: TODO 意见反馈
 */
public class Advice {
	private String id;
	private String content;
	private String saler;
	private String needContent;
	private String contactInformation;
	private String userId;
	private String createTime;
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
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	public String getSaler() {
		return saler;
	}
	public void setSaler(String saler) {
		this.saler = saler;
	}
	public String getNeedContent() {
		return needContent;
	}
	public void setNeedContent(String needContent) {
		this.needContent = needContent;
	}
	public String getContactInformation() {
		return contactInformation;
	}
	public void setContactInformation(String contactInformation) {
		this.contactInformation = contactInformation;
	}
}
