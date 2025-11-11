package com.project.qlst.model;

import java.util.Date;

public class OnlineInvoice {
    private int id;
    private Date deliveryDate;
 
    Order order;
    Staff warehouseStaff;
    Staff deliveryStaff;
    //constructor getter setter
    public OnlineInvoice(Date deliveryDate, Order order, Staff warehouseStaff, Staff deliveryStaff) {
        this.deliveryDate = deliveryDate;
        this.order = order;
        this.warehouseStaff = warehouseStaff;
        this.deliveryStaff = deliveryStaff;
    }
    public int getId() {
        return id;
    }
    public Date getDeliveryDate() {
        return deliveryDate;
    }
    
    public Order getOrder() {
        return order;
    }
    public Staff getWarehouseStaff() {
        return warehouseStaff;
    }
    public Staff getDeliveryStaff() {
        return deliveryStaff;
    }
    public void setId(int id) {
        this.id = id;
    }
    public void setDeliveryDate(Date deliveryDate) {
        this.deliveryDate = deliveryDate;
    }
    public void setOrder(Order order) {
        this.order = order;
    }
    public void setWarehouseStaff(Staff warehouseStaff) {
        this.warehouseStaff = warehouseStaff;
    }
    public void setDeliveryStaff(Staff deliveryStaff) {
        this.deliveryStaff = deliveryStaff;
    }
}
