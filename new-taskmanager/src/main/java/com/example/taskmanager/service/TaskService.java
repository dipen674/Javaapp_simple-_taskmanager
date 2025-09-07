package com.example.taskmanager.service;

import com.example.taskmanager.model.Task;
import java.util.ArrayList;
import java.util.List;

public class TaskService {
    private static List<Task> tasks = new ArrayList<>();
    private static int idCounter = 1;
    
    public List<Task> getUserTasks(int userId) {
        List<Task> userTasks = new ArrayList<>();
        for (Task task : tasks) {
            if (task.getUserId() == userId) {
                userTasks.add(task);
            }
        }
        return userTasks;
    }
    
    public Task getTaskById(int id) {
        for (Task task : tasks) {
            if (task.getId() == id) {
                return task;
            }
        }
        return null;
    }
    
    public Task createTask(Task task) {
        task.setId(idCounter++);
        tasks.add(task);
        return task;
    }
    
    public Task updateTask(Task updatedTask) {
        for (int i = 0; i < tasks.size(); i++) {
            Task task = tasks.get(i);
            if (task.getId() == updatedTask.getId()) {
                tasks.set(i, updatedTask);
                return updatedTask;
            }
        }
        return null;
    }
    
    public boolean deleteTask(int id) {
        for (int i = 0; i < tasks.size(); i++) {
            Task task = tasks.get(i);
            if (task.getId() == id) {
                tasks.remove(i);
                return true;
            }
        }
        return false;
    }
    
    public List<Task> getTasksByCategory(int categoryId, int userId) {
        List<Task> categoryTasks = new ArrayList<>();
        for (Task task : tasks) {
            if (task.getCategoryId() == categoryId && task.getUserId() == userId) {
                categoryTasks.add(task);
            }
        }
        return categoryTasks;
    }
}