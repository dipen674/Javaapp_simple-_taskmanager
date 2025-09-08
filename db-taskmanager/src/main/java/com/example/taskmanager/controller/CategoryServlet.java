package com.example.taskmanager.controller;

import com.example.taskmanager.model.Category;
import com.example.taskmanager.model.User;
import com.example.taskmanager.service.CategoryService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/categories")
public class CategoryServlet extends HttpServlet {
    private CategoryService categoryService = new CategoryService();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        String name = request.getParameter("name");
        String color = request.getParameter("color");
        
        Category category = new Category(name, color, user.getId());
        categoryService.createCategory(category);
        
        response.sendRedirect("tasks?action=new");
    }
}