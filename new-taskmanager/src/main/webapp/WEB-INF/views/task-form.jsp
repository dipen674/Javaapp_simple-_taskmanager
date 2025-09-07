<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Task Manager - ${empty task ? 'New Task' : 'Edit Task'}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); color: white; padding: 1rem; text-align: center;">
    <h1>Task Manager</h1>
    <div>
        <a href="dashboard" style="color: white; margin: 0 10px; text-decoration: none;">Dashboard</a>
        <a href="tasks" style="color: white; margin: 0 10px; text-decoration: none;">My Tasks</a>
        <a href="profile" style="color: white; margin: 0 10px; text-decoration: none;">Profile</a>
        <a href="logout" style="color: white; margin: 0 10px; text-decoration: none;">Logout</a>
    </div>
</div>
    <header>
        <h1>Task Manager</h1>
        <nav>
            <span>Welcome, ${user.username}</span>
            <a href="dashboard">Dashboard</a>
            <a href="tasks">My Tasks</a>
            <a href="logout">Logout</a>
        </nav>
    </header>
    
    <main class="task-form-page">
        <h2>${empty task ? 'Create New Task' : 'Edit Task'}</h2>
        
        <form action="tasks" method="post">
            <c:if test="${not empty task}">
                <input type="hidden" name="id" value="${task.id}">
            </c:if>
            
            <div class="form-group">
                <label for="title">Title *</label>
                <input type="text" id="title" name="title" value="${task.title}" required>
            </div>
            
            <div class="form-group">
                <label for="description">Description</label>
                <textarea id="description" name="description">${task.description}</textarea>
            </div>
            
            <div class="form-group">
                <label for="dueDate">Due Date</label>
                <input type="date" id="dueDate" name="dueDate" value="${task.dueDate}">
            </div>
            
            <div class="form-group">
                <label for="priority">Priority</label>
                <select id="priority" name="priority">
                    <option value="low" ${task.priority == 'low' ? 'selected' : ''}>Low</option>
                    <option value="medium" ${task.priority == 'medium' ? 'selected' : ''}>Medium</option>
                    <option value="high" ${task.priority == 'high' ? 'selected' : ''}>High</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="status">Status</label>
                <select id="status" name="status">
                    <option value="pending" ${task.status == 'pending' ? 'selected' : ''}>Pending</option>
                    <option value="in-progress" ${task.status == 'in-progress' ? 'selected' : ''}>In Progress</option>
                    <option value="completed" ${task.status == 'completed' ? 'selected' : ''}>Completed</option>
                </select>
            </div>
            
            <div class="form-group">
                <label for="categoryId">Category</label>
                <select id="categoryId" name="categoryId">
                    <c:forEach items="${categories}" var="category">
                        <option value="${category.id}" ${task.categoryId == category.id ? 'selected' : ''}>
                            ${category.name}
                        </option>
                    </c:forEach>
                </select>
            </div>
            
            <div class="form-actions">
                <button type="submit">${empty task ? 'Create Task' : 'Update Task'}</button>
                <a href="tasks" class="btn-cancel">Cancel</a>
            </div>
        </form>
        
        <div class="add-category">
            <h3>Add New Category</h3>
            <form action="categories" method="post">
                <div class="form-group">
                    <label for="categoryName">Category Name</label>
                    <input type="text" id="categoryName" name="name" required>
                </div>
                <div class="form-group">
                    <label for="categoryColor">Color</label>
                    <input type="color" id="categoryColor" name="color" value="#4CAF50">
                </div>
                <button type="submit">Add Category</button>
            </form>
        </div>
    </main>
</body>
</html>