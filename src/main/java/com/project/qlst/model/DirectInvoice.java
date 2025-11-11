package com.project.qlst.model;

public class DirectInvoice {
    private int id;
    private Order order;
    private Staff saleStaff;
    public DirectInvoice(Order order, Staff saleStaff) {
        this.order = order;
        this.saleStaff = saleStaff;
    }
    public int getId() {
        return id;
    }
    public Order getOrder() {
        return order;
    }
    public Staff getSaleStaff() {
        return saleStaff;
    }
    public void setId(int id) {
        this.id = id;
    }
    public void setOrder(Order order) {
        this.order = order;
    }
    public void setSaleStaff(Staff saleStaff) {
        this.saleStaff = saleStaff;
    }
 
}
