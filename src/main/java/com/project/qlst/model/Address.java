package com.project.qlst.model;

public class Address {
    private int id;
    private String province;
    private String district;
    private String ward;
    private String street;
    //constructor getter setter
    public Address(String province, String district, String ward, String street) {
        this.province = province;
        this.district = district;
        this.ward = ward;
        this.street = street;
    }
    public int getId() {
        return id;
    }
    public String getProvince() {
        return province;
    }
    public String getDistrict() {
        return district;
    }
    public String getWard() {
        return ward;
    }
    public String getStreet() {
        return street;
    }
    public void setId(int id) {
        this.id = id;
    }
    public void setProvince(String province) {
        this.province = province;
    }
    public void setDistrict(String district) {
        this.district = district;
    }
    public void setWard(String ward) {
        this.ward = ward;
    }
    public void setStreet(String street) {
        this.street = street;
    }
}
