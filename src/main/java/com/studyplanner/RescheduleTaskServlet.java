package com.studyplanner;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/rescheduleTask")
public class RescheduleTaskServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int taskId = Integer.parseInt(request.getParameter("taskId"));
        String newDueDate = request.getParameter("newDueDate");

        try (Connection conn = DBUtil.getConnection()) {
            PreparedStatement stmt = conn.prepareStatement("UPDATE tasks SET due_date = ? WHERE id = ?");
            stmt.setDate(1, java.sql.Date.valueOf(newDueDate));
            stmt.setInt(2, taskId);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("goToPlanner");
    }
}

