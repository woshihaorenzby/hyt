package com.xuri.vo;

public class TiOrder {
	private String id;
	private String payOrder;
	private int tiMoney;
	private int yuMoney;
	private String userId;
	private String tag;
	private String createTime;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getTiMoney() {
		return tiMoney;
	}

	public void setTiMoney(int tiMoney) {
		this.tiMoney = tiMoney;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}

	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	public String getPayOrder() {
		return payOrder;
	}

	public void setPayOrder(String payOrder) {
		this.payOrder = payOrder;
	}

	public int getYuMoney() {
		return yuMoney;
	}

	public void setYuMoney(int yuMoney) {
		this.yuMoney = yuMoney;
	}
}
