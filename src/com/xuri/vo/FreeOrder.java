package com.xuri.vo;

import java.util.Arrays;
import java.util.Date;
import java.util.List;

public class FreeOrder {
    private String id;
    //对应的手机号ID
    private String mobileId;
    //联系人证件姓名
    private String name;
    //联系人证件ID
    private String idNumber;
    //省
    private String addressProvince;
    //市
    private String addressCity;
    //区
    private String addressArea;
    //收件人电话
    private String addressMobile;
    //联系人证件card电话
    private String contact;
    //收件人姓名
    private String addressName;
    //详细地址
    private String address;
    //详细地址
    private String status;
    private Date createTime;

    private WxMobileSale mobileSale;
    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getMobileId() {
        return mobileId;
    }

    public void setMobileId(String mobileId) {
        this.mobileId = mobileId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getIdNumber() {
        return idNumber;
    }

    public void setIdNumber(String idNumber) {
        this.idNumber = idNumber;
    }


    public String getAddressProvince() {
        return addressProvince;
    }

    public void setAddressProvince(String addressProvince) {
        this.addressProvince = addressProvince;
    }

    public String getAddressCity() {
        return addressCity;
    }

    public void setAddressCity(String addressCity) {
        this.addressCity = addressCity;
    }

    public String getAddressArea() {
        return addressArea;
    }

    public void setAddressArea(String addressArea) {
        this.addressArea = addressArea;
    }

    public String getAddressMobile() {
        return addressMobile;
    }

    public void setAddressMobile(String addressMobile) {
        this.addressMobile = addressMobile;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getAddressName() {
        return addressName;
    }

    public void setAddressName(String addressName) {
        this.addressName = addressName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public WxMobileSale getMobileSale() {
        return mobileSale;
    }

    public void setMobileSale(WxMobileSale mobileSale) {
        this.mobileSale = mobileSale;
    }
}
