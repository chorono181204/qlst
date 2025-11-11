package com.project.qlst.model;

import java.util.Date;

public class Order {
    private int id;
    private String code;
    private Date orderDate;
    private String status;
    private float totalAmount;
    private String paymentMethod;
    private Customer customer;
    //constructor getter setter
    public Order(String code, Date orderDate,  String status, float totalAmount, String paymentMethod, Customer customer) {
        this.code = code;
        this.orderDate = orderDate;

        this.status = status;
        this.totalAmount = totalAmount;
        this.paymentMethod = paymentMethod;
        this.customer = customer;
    }
    public int getId() {
        return id;
    }
    public String getCode() {
        return code;
    }
    public Date getOrderDate() {
        return orderDate;
    }
  
    public String getStatus() {
        return status;
    }
    public float getTotalAmount() {
        return totalAmount;
    }
    public String getPaymentMethod() {
        return paymentMethod;
    }
    public Customer getCustomer() {
        return customer;
    }
    public void setId(int id) {
        this.id = id;
    }
    public void setCode(String code) {
        this.code = code;
    }
    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }
    public void setStatus(String status) {
        this.status = status;
    }
    public void setTotalAmount(float totalAmount) {
        this.totalAmount = totalAmount;
    }
    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }
    public void setCustomer(Customer customer) {
        this.customer = customer;
    }
}
