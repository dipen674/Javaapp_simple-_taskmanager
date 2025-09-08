package com.example.taskmanager.controller;

import com.example.taskmanager.model.Task;
import com.example.taskmanager.model.User;
import com.example.taskmanager.service.CategoryService;
import com.example.taskmanager.service.TaskService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/tasks")
public class TaskServlet extends HttpServlet {
    private TaskService taskService = new TaskService();
    private CategoryService categoryService = new CategoryService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        String action = request.getParameter("action");
        
        if (action == null) {
            // Show all tasks
            request.setAttribute("tasks", taskService.getUserTasks(user.getId()));
            request.setAttribute("categories", categoryService.getUserCategories(user.getId()));
            request.getRequestDispatcher("/WEB-INF/views/task-list.jsp").forward(request, response);
        } else if ("new".equals(action)) {
            // Show new task form
            request.setAttribute("categories", categoryService.getUserCategories(user.getId()));
            request.getRequestDispatcher("/WEB-INF/views/task-form.jsp").forward(request, response);
        } else if ("edit".equals(action)) {
            // Show edit task form
            int taskId = Integer.parseInt(request.getParameter("id"));
            Task task = taskService.getTaskById(taskId);
            
            if (task != null && task.getUserId() == user.getId()) {
                request.setAttribute("task", task);
                request.setAttribute("categories", categoryService.getUserCategories(user.getId()));
                request.getRequestDispatcher("/WEB-INF/views/task-form.jsp").forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } else if ("delete".equals(action)) {
            // Delete task
            int taskId = Integer.parseInt(request.getParameter("id"));
            Task task = taskService.getTaskById(taskId);
            
            if (task != null && task.getUserId() == user.getId()) {
                taskService.deleteTask(taskId);
            }
            response.sendRedirect("tasks");
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        
        String idParam = request.getParameter("id");
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String dueDateStr = request.getParameter("dueDate");
        String priority = request.getParameter("priority");
        String status = request.getParameter("status");
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        
        Date dueDate = null;
        if (dueDateStr != null && !dueDateStr.isEmpty()) {
            try {
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                dueDate = dateFormat.parse(dueDateStr);
            } catch (ParseException e) {
                e.printStackTrace();
            }
        }
        
        if (idParam != null && !idParam.isEmpty()) {
            // Update existing task
            int id = Integer.parseInt(idParam);
            Task existingTask = taskService.getTaskById(id);
            
            if (existingTask != null && existingTask.getUserId() == user.getId()) {
                existingTask.setTitle(title);
                existingTask.setDescription(description);
                existingTask.setDueDate(dueDate);
                existingTask.setPriority(priority);
                existingTask.setStatus(status);
                existingTask.setCategoryId(categoryId);
                
                taskService.updateTask(existingTask);
            }
        } else {
            // Create new task
            Task newTask = new Task(title, description, dueDate, priority, status, categoryId, user.getId());
            taskService.createTask(newTask);
        }
        
        response.sendRedirect("tasks");
    }
}