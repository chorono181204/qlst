package com.project.qlst.model;

public class Member {
    private int id;
    private String firstName;
    private String lastName;
    private String email;
    private String phone;
    private String note;
    private Address address;
    //constructor getter setter
    public Member(String firstName, String lastName, String email, String phone, String note, Address address) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.phone = phone;
        this.note = note;
        this.address = address;
    }
    public int getId() {
        return id;
    }
    public String getFirstName() {
        return firstName;
    }
    public String getLastName() {
        return lastName;
    }
    public String getEmail() {
        return email;
    }
    public String getPhone() {
        return phone;
    }
    public String getNote() {
        return note;
    }
    public Address getAddress() {
        return address;
    }
    public void setId(int id) {
        this.id = id;
    }
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public void setPhone(String phone) {
        this.phone = phone;
    }
    public void setNote(String note) {
        this.note = note;
    }
    public void setAddress(Address address) {
        this.address = address;
    }

}
