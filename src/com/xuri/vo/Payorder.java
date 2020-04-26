package com.xuri.vo;

/**
 * @Title: Payorder
 * @Description: TODO 支付记录
 */
public class Payorder {
	private String id;
	private String prepayId;
	private int payMoney;
	private String memLevel;
	private String userId;
	private String niName;
	private String createTime;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getPayMoney() {
		return payMoney;
	}

	public void setPayMoney(int payMoney) {
		this.payMoney = payMoney;
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

	public String getNiName() {
		return niName;
	}

	public void setNiName(String niName) {
		this.niName = niName;
	}

	public String getPrepayId() {
		return prepayId;
	}

	public void setPrepayId(String prepayId) {
		this.prepayId = prepayId;
	}

	public String getMemLevel() {
		return memLevel;
	}

	public void setMemLevel(String memLevel) {
		this.memLevel = memLevel;
	}
}
