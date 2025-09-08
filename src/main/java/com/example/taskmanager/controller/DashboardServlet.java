package com.example.taskmanager.controller;

import com.example.taskmanager.model.Task;
import com.example.taskmanager.model.User;
import com.example.taskmanager.service.TaskService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    private TaskService taskService = new TaskService();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login");
            return;
        }
        
        User user = (User) session.getAttribute("user");
        List<Task> userTasks = taskService.getUserTasks(user.getId());
        
        // Calculate statistics
        long totalTasks = userTasks.size();
        long completedTasks = userTasks.stream().filter(t -> "completed".equals(t.getStatus())).count();
        long pendingTasks = userTasks.stream().filter(t -> "pending".equals(t.getStatus())).count();
        
        // Get recent tasks (last 5)
        List<Task> recentTasks = userTasks.size() > 5 ? 
            userTasks.subList(0, 5) : userTasks;
        
        request.setAttribute("totalTasks", totalTasks);
        request.setAttribute("completedTasks", completedTasks);
        request.setAttribute("pendingTasks", pendingTasks);
        request.setAttribute("recentTasks", recentTasks);
        
        request.getRequestDispatcher("/WEB-INF/views/dashboard.jsp").forward(request, response);
    }
}