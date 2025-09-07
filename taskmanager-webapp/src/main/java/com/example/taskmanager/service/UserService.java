package com.example.taskmanager.service;

import com.example.taskmanager.model.User;
import java.util.ArrayList;
import java.util.List;

public class UserService {
    private static List<User> users = new ArrayList<>();
    private static int idCounter = 1;
    
    static {
        // Add a default user for testing
        User defaultUser = new User("admin", "password", "admin@taskmanager.com");
        defaultUser.setId(idCounter++);
        users.add(defaultUser);
    }
    
    public User authenticate(String username, String password) {
        for (User user : users) {
            if (user.getUsername().equals(username) && user.getPassword().equals(password)) {
                return user;
            }
        }
        return null;
    }
    
    public User getUserById(int id) {
        for (User user : users) {
            if (user.getId() == id) {
                return user;
            }
        }
        return null;
    }
}