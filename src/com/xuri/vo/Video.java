package com.xuri.vo;

/**
 * @Title: Video
 * @Description: TODO 视频列表
 */
public class Video {
    private String id;
    private String mainType;
    private String typeName;
    private String title;
    private String imagePath;
    private String videoUrl;
    private String articleContent;
    private String viewNum;
    private String shareNum;
    private String auditTag;
    private String topShow;
    private String syInsert;
    private String userId;
    private String userName;
    private String niName;
    private String createTime;
    private String pushTime;
    //只能企业VIP版本可以设置广告
    private String needQiTy;
    private String showTime;

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

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getImagePath() {
        return imagePath;
    }

    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public String getVideoUrl() {
        return videoUrl;
    }

    public void setVideoUrl(String videoUrl) {
        this.videoUrl = videoUrl;
    }

    public String getViewNum() {
        return viewNum;
    }

    public void setViewNum(String viewNum) {
        this.viewNum = viewNum;
    }

    public String getShareNum() {
        return shareNum;
    }

    public void setShareNum(String shareNum) {
        this.shareNum = shareNum;
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

    public String getAuditTag() {
        return auditTag;
    }

    public void setAuditTag(String auditTag) {
        this.auditTag = auditTag;
    }

    public String getTopShow() {
        return topShow;
    }

    public void setTopShow(String topShow) {
        this.topShow = topShow;
    }

    public String getSyInsert() {
        return syInsert;
    }

    public void setSyInsert(String syInsert) {
        this.syInsert = syInsert;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getNiName() {
        return niName;
    }

    public void setNiName(String niName) {
        this.niName = niName;
    }

    public String getNeedQiTy() {
        return needQiTy;
    }

    public void setNeedQiTy(String needQiTy) {
        this.needQiTy = needQiTy;
    }

    public String getArticleContent() {
        return articleContent;
    }

    public void setArticleContent(String articleContent) {
        this.articleContent = articleContent;
    }

    public String getMainType() {
        return mainType;
    }

    public void setMainType(String mainType) {
        this.mainType = mainType;
    }

    public String getShowTime() {
        return showTime;
    }

    public void setShowTime(String showTime) {
        this.showTime = showTime;
    }

    public String getPushTime() {
        return pushTime;
    }

    public void setPushTime(String pushTime) {
        this.pushTime = pushTime;
    }
}
