package com.example.taskmanager.service;

import com.example.taskmanager.model.Category;
import java.util.ArrayList;
import java.util.List;

public class CategoryService {
    private static List<Category> categories = new ArrayList<>();
    private static int idCounter = 1;
    
    static {
        // Add default categories
        categories.add(new Category("Work", "#4CAF50", 0));
        categories.get(0).setId(idCounter++);
        categories.add(new Category("Personal", "#2196F3", 0));
        categories.get(1).setId(idCounter++);
        categories.add(new Category("Shopping", "#FF9800", 0));
        categories.get(2).setId(idCounter++);
        categories.add(new Category("Health", "#F44336", 0));
        categories.get(3).setId(idCounter++);
    }
    
    public List<Category> getAllCategories() {
        return categories;
    }
    
    public Category getCategoryById(int id) {
        for (Category category : categories) {
            if (category.getId() == id) {
                return category;
            }
        }
        return null;
    }
    
    public Category createCategory(Category category) {
        category.setId(idCounter++);
        categories.add(category);
        return category;
    }
    
    public boolean deleteCategory(int id) {
        for (int i = 0; i < categories.size(); i++) {
            Category category = categories.get(i);
            if (category.getId() == id) {
                categories.remove(i);
                return true;
            }
        }
        return false;
    }
    
    public List<Category> getUserCategories(int userId) {
        List<Category> userCategories = new ArrayList<>();
        for (Category category : categories) {
            if (category.getUserId() == userId || category.getUserId() == 0) {
                userCategories.add(category);
            }
        }
        return userCategories;
    }
}