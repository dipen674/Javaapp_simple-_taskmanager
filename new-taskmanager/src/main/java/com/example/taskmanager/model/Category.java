package com.example.taskmanager.model;

import java.io.Serializable;

public class Category implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private int id;
    private String name;
    private String color;
    private int userId;
    
    public Category() {}
    
    public Category(String name, String color, int userId) {
        this.name = name;
        this.color = color;
        this.userId = userId;
    }
    
    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public String getColor() { return color; }
    public void setColor(String color) { this.color = color; }
    
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
}