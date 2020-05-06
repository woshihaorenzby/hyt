package com.xuri.vo;

import java.util.Arrays;
import java.util.List;

public class WxMobileSale {
    private String id;
    //归属地省
    private String province;
    //归属地市
    private String city;
    //价格
    private double price;
    //号码
    private String mobileNum;
    //内含话费
    private double telephoneBill;
    //最低消费
    private double minimumConsumption;
    //是否已经卖出（0未卖出，1已卖出）
    private int hasSale;
    //搜索类型scalNum，anyNum，endNum
    private String searchType;
    //用"，"拼接的id
    private String ids;
    //由ids通过"，"拆分获得的集合
    private List<String> _ids;
    //详细信息
    private String details;
    //0移动，1联通，2电信，3虚商
    private String operator;
    private Double startPrice;
    private Double endPrice;
    private String preferenceStr;
    private List<String> preference;
    private List<String> dobleLikeLaw;
    private List<String> startLikeLaw;
    private String law;
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getProvince() {
        return province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public String getMobileNum() {
        return mobileNum;
    }

    public void setMobileNum(String mobileNum) {
        this.mobileNum = mobileNum;
    }

    public double getTelephoneBill() {
        return telephoneBill;
    }

    public void setTelephoneBill(double telephoneBill) {
        this.telephoneBill = telephoneBill;
    }

    public double getMinimumConsumption() {
        return minimumConsumption;
    }

    public void setMinimumConsumption(double minimumConsumption) {
        this.minimumConsumption = minimumConsumption;
    }

    public int getHasSale() {
        return hasSale;
    }

    public void setHasSale(int hasSale) {
        this.hasSale = hasSale;
    }

    public String getSearchType() {
        return searchType;
    }

    public void setSearchType(String searchType) {
        this.searchType = searchType;
    }

    public String getOperator() {
        return operator;
    }

    public void setOperator(String operator) {
        this.operator = operator;
    }

    public String getIds() {
        return ids;
    }

    public void setIds(String ids) {
        this.ids = ids;
    }

    public List<String> get_ids() {
        if(ids!=null&&ids!=""){
            _ids = Arrays.asList(ids.split(","));
        }
        return _ids;
    }

    public void set_ids(List<String> _ids) {
        this._ids = _ids;
    }

    public String getDetails() {
        return details;
    }

    public void setDetails(String details) {
        this.details = details;
    }

    public Double getStartPrice() {
        return startPrice;
    }

    public void setStartPrice(Double startPrice) {
        this.startPrice = startPrice;
    }

    public Double getEndPrice() {
        return endPrice;
    }

    public void setEndPrice(Double endPrice) {
        this.endPrice = endPrice;
    }

    public String getPreferenceStr() {
        return preferenceStr;
    }

    public void setPreferenceStr(String preferenceStr) {
        this.preferenceStr = preferenceStr;
    }

    public List<String> getPreference() {
        if(preferenceStr!=null&&preferenceStr!=""){
            preference = Arrays.asList(preferenceStr.split(","));
        }
        return preference;
    }

    public void setPreference(List<String> preference) {
        this.preference = preference;
    }

    public List<String> getDobleLikeLaw() {
        return dobleLikeLaw;
    }

    public void setDobleLikeLaw(List<String> dobleLikeLaw) {
        this.dobleLikeLaw = dobleLikeLaw;
    }

    public List<String> getStartLikeLaw() {
        return startLikeLaw;
    }

    public void setStartLikeLaw(List<String> startLikeLaw) {
        this.startLikeLaw = startLikeLaw;
    }

    public String getLaw() {
        return law;
    }

    public void setLaw(String law) {
        this.law = law;
    }
}
