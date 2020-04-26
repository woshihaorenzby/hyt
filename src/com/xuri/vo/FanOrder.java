package com.xuri.vo;

public class FanOrder {
	private String id;
	private String fanType;
	private int fanMoney;
	private String toUserId;
	private String userId;
	private String createTime;
	private User user;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getFanType() {
		return fanType;
	}

	public void setFanType(String fanType) {
		this.fanType = fanType;
	}

	public int getFanMoney() {
		return fanMoney;
	}

	public void setFanMoney(int fanMoney) {
		this.fanMoney = fanMoney;
	}

	public String getToUserId() {
		return toUserId;
	}

	public void setToUserId(String toUserId) {
		this.toUserId = toUserId;
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

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
}
