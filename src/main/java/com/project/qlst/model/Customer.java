package com.project.qlst.model;

public class Customer {
    private int id;
    private String customerCode;
    private Member user;

    public Customer(String customerCode, Member user) {
        this.customerCode = customerCode;
        this.user = user;
    }
    public int getId() {
        return id;
    }
    public String getCustomerCode() {
        return customerCode;
    }
    public Member getUser() {
        return user;
    }
    public void setId(int id) {
        this.id = id;
    }
    public void setCustomerCode(String customerCode) {
        this.customerCode = customerCode;
    }
    public void setUser(Member user) {
        this.user = user;
    }
}
