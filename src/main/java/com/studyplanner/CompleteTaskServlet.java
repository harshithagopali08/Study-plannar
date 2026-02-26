package com.studyplanner;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;

@WebServlet("/completeTask")
public class CompleteTaskServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String taskIdStr = request.getParameter("taskId");
        String redirectPage = request.getParameter("redirectPage");

        if (taskIdStr != null && !taskIdStr.trim().isEmpty()) {
            try {
                int taskId = Integer.parseInt(taskIdStr);

                try (Connection conn = DBUtil.getConnection()) {
                    TaskDAO taskDAO = new TaskDAO(conn);
                    taskDAO.markTaskAsCompleted(taskId);
                    System.out.println("Task ID received: " + taskId);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            } catch (NumberFormatException e) {
                System.out.println("Invalid task ID: " + taskIdStr);
            }
        }

        // Redirect appropriately
        if (redirectPage != null && !redirectPage.isEmpty()) {
            response.sendRedirect(redirectPage);
        } else {
            response.sendRedirect("dashboard");
        }
    }

}