
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>TechFlow Dashboard</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f9; padding: 30px; }
        .dashboard { background: white; padding: 20px; border-radius: 8px; box-shadow: 0px 0px 10px rgba(0,0,0,0.1); width: 60%; margin: auto; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 12px; border: 1px solid #ddd; text-align: left; }
        th { background-color: #0056b3; color: white; }
        .btn { display: inline-block; padding: 10px 15px; background: #28a745; color: white; text-decoration: none; border-radius: 4px; }
    </style>
</head>
<body>
    <div class="dashboard">
        <h2>TechFlow Engineering Dashboard</h2>
        <p>Status: <strong>All Systems Operational</strong></p>
        
        <p><a href="dashboard" class="btn">Load Current Tasks</a></p>

        <% 
            if(request.getAttribute("task1") != null) { 
                com.techflow.Task t1 = (com.techflow.Task) request.getAttribute("task1");
                com.techflow.Task t2 = (com.techflow.Task) request.getAttribute("task2");
        %>
            <table>
                <tr>
                    <th>Task ID</th>
                    <th>Description</th>
                    <th>Assignee</th>
                </tr>
                <tr>
                    <td><%= t1.getId() %></td>
                    <td><%= t1.getDescription() %></td>
                    <td><%= t1.getAssignee() %></td>
                </tr>
                <tr>
                    <td><%= t2.getId() %></td>
                    <td><%= t2.getDescription() %></td>
                    <td><%= t2.getAssignee() %></td>
                </tr>
            </table>
        <% } %>
    </div>
</body>
</html>
