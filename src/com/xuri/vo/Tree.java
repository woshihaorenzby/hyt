package com.xuri.vo;


/**
 * @Title: Tree 
 * @Description: TODO 权限树
 * @author 王东
 * @date 2016-4-24
 */
public class Tree {
	private String id = "";
	private String pId = "";
	private String icon = "";
	private String name = "";
	private String path = "";
	private String isleaf = "";
	private Boolean checked;
	private int disPlay = 0 ;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getpId() {
		return pId;
	}

	public void setpId(String pId) {
		this.pId = pId;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPath() {
		return path;
	}

	public void setPath(String path) {
		this.path = path;
	}

	public String getIsleaf() {
		return isleaf;
	}

	public void setIsleaf(String isleaf) {
		this.isleaf = isleaf;
	}
	
	public Boolean getChecked() {
		return checked;
	}

	public void setChecked(Boolean checked) {
		this.checked = checked;
	}

	public int getDisPlay() {
		return disPlay;
	}

	public void setDisPlay(int disPlay) {
		this.disPlay = disPlay;
	}
}
