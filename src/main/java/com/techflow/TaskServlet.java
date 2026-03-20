package com.techflow;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/dashboard")
public class TaskServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        Task t1 = new Task("TKT-101", "Configure Nexus Repository", "Alice");
        Task t2 = new Task("TKT-102", "Setup SonarQube Scanner", "Bob");
        
        // Running the bad code so SonarQube sees it is in use
        ValidationUtils.checkTaskPriority(t1);
        
        request.setAttribute("task1", t1);
        request.setAttribute("task2", t2);
        
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}