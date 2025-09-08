package com.example.taskmanager.service;

import com.example.taskmanager.model.Task;
import com.example.taskmanager.util.DatabaseUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TaskService {
    
    public List<Task> getUserTasks(int userId) {
        List<Task> tasks = new ArrayList<>();
        String sql = "SELECT * FROM tasks WHERE user_id = ? ORDER BY due_date DESC";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Task task = new Task();
                    task.setId(rs.getInt("id"));
                    task.setTitle(rs.getString("title"));
                    task.setDescription(rs.getString("description"));
                    task.setDueDate(rs.getDate("due_date"));
                    task.setPriority(rs.getString("priority"));
                    task.setStatus(rs.getString("status"));
                    task.setCategoryId(rs.getInt("category_id"));
                    task.setUserId(rs.getInt("user_id"));
                    tasks.add(task);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tasks;
    }
    
    public Task getTaskById(int id) {
        String sql = "SELECT * FROM tasks WHERE id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Task task = new Task();
                    task.setId(rs.getInt("id"));
                    task.setTitle(rs.getString("title"));
                    task.setDescription(rs.getString("description"));
                    task.setDueDate(rs.getDate("due_date"));
                    task.setPriority(rs.getString("priority"));
                    task.setStatus(rs.getString("status"));
                    task.setCategoryId(rs.getInt("category_id"));
                    task.setUserId(rs.getInt("user_id"));
                    return task;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public Task createTask(Task task) {
        String sql = "INSERT INTO tasks (title, description, due_date, priority, status, category_id, user_id) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, task.getTitle());
            stmt.setString(2, task.getDescription());
            if (task.getDueDate() != null) {
                stmt.setDate(3, new java.sql.Date(task.getDueDate().getTime()));
            } else {
                stmt.setNull(3, Types.DATE);
            }
            stmt.setString(4, task.getPriority());
            stmt.setString(5, task.getStatus());
            stmt.setInt(6, task.getCategoryId());
            stmt.setInt(7, task.getUserId());
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        task.setId(generatedKeys.getInt(1));
                        return task;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public Task updateTask(Task task) {
        String sql = "UPDATE tasks SET title = ?, description = ?, due_date = ?, priority = ?, " +
                     "status = ?, category_id = ? WHERE id = ? AND user_id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, task.getTitle());
            stmt.setString(2, task.getDescription());
            if (task.getDueDate() != null) {
                stmt.setDate(3, new java.sql.Date(task.getDueDate().getTime()));
            } else {
                stmt.setNull(3, Types.DATE);
            }
            stmt.setString(4, task.getPriority());
            stmt.setString(5, task.getStatus());
            stmt.setInt(6, task.getCategoryId());
            stmt.setInt(7, task.getId());
            stmt.setInt(8, task.getUserId());
            
            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                return task;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public boolean deleteTask(int id) {
        String sql = "DELETE FROM tasks WHERE id = ?";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public List<Task> getTasksByCategory(int categoryId, int userId) {
        List<Task> tasks = new ArrayList<>();
        String sql = "SELECT * FROM tasks WHERE category_id = ? AND user_id = ? ORDER BY due_date DESC";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, categoryId);
            stmt.setInt(2, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Task task = new Task();
                    task.setId(rs.getInt("id"));
                    task.setTitle(rs.getString("title"));
                    task.setDescription(rs.getString("description"));
                    task.setDueDate(rs.getDate("due_date"));
                    task.setPriority(rs.getString("priority"));
                    task.setStatus(rs.getString("status"));
                    task.setCategoryId(rs.getInt("category_id"));
                    task.setUserId(rs.getInt("user_id"));
                    tasks.add(task);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tasks;
    }
}