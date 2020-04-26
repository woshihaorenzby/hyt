package com.xuri.vo;

public class HyUserStat {
	//1是月份，2是性别
	private String statType;
	private String month;
	private String con;
	private String nancon;
	private String nvcon;
	private String city;

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public String getCon() {
		return con;
	}

	public void setCon(String con) {
		this.con = con;
	}

	public String getNancon() {
		return nancon;
	}

	public void setNancon(String nancon) {
		this.nancon = nancon;
	}

	public String getNvcon() {
		return nvcon;
	}

	public void setNvcon(String nvcon) {
		this.nvcon = nvcon;
	}

	public String getStatType() {
		return statType;
	}

	public void setStatType(String statType) {
		this.statType = statType;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}
}
