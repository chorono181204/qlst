package com.project.qlst.model;

public class Staff {
    private int id;
    private String position;
    private Member user;
    //constructor getter setter
    public Staff(String position, Member user) {
        this.position = position;
        this.user = user;
    }
    public int getId() {
        return id;
    }
    public String getPosition() {
        return position;
    }
    public Member getUser() {
        return user;
    }
    public void setId(int id) {
        this.id = id;
    }
    public void setPosition(String position) {
        this.position = position;
    }
    public void setUser(Member user) {
        this.user = user;
    }
}
