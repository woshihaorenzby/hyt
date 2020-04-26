package com.xuri.vo;

public class Type {
    private String id;
    private String typeLei;
    private String typeName;
    private String needQiTy;
    //topShow 1显示
    private String topShow;
    //分类图片
    private String typeImg;
    private String rid;
    private String display;
    private String webUrl;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public String getRid() {
        return rid;
    }

    public void setRid(String rid) {
        this.rid = rid;
    }

    public String getDisplay() {
        return display;
    }

    public void setDisplay(String display) {
        this.display = display;
    }

    public String getTypeLei() {
        return typeLei;
    }

    public void setTypeLei(String typeLei) {
        this.typeLei = typeLei;
    }

    public String getNeedQiTy() {
        return needQiTy;
    }

    public void setNeedQiTy(String needQiTy) {
        this.needQiTy = needQiTy;
    }

    public String getTopShow() {
        return topShow;
    }

    public void setTopShow(String topShow) {
        this.topShow = topShow;
    }

    public String getTypeImg() {
        return typeImg == null ? "" : typeImg.trim();
    }

    public void setTypeImg(String typeImg) {
        this.typeImg = typeImg;
    }

    public String getWebUrl() {
        return webUrl == null ? "" : webUrl.trim();
    }

    public void setWebUrl(String webUrl) {
        this.webUrl = webUrl;
    }
}
