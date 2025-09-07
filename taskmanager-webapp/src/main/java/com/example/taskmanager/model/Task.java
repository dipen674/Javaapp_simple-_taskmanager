package com.example.taskmanager.model;

import java.io.Serializable;
import java.util.Date;

public class Task implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private int id;
    private String title;
    private String description;
    private Date dueDate;
    private String priority;
    private String status;
    private int categoryId;
    private int userId;
    
    public Task() {}
    
    public Task(String title, String description, Date dueDate, String priority, String status, int categoryId, int userId) {
        this.title = title;
        this.description = description;
        this.dueDate = dueDate;
        this.priority = priority;
        this.status = status;
        this.categoryId = categoryId;
        this.userId = userId;
    }
    
    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public Date getDueDate() { return dueDate; }
    public void setDueDate(Date dueDate) { this.dueDate = dueDate; }
    
    public String getPriority() { return priority; }
    public void setPriority(String priority) { this.priority = priority; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }
    
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
}