package com.studyplanner;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/viewTasks")
public class ViewTasksServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("studentId") == null) {
            response.sendRedirect("log.jsp");
            return;
        }

        int studentId = (Integer) session.getAttribute("studentId");

        // ✅ Fix: Declare taskList here
        List<Task> taskList = new ArrayList<>();

        try (Connection conn = DBUtil.getConnection()) {
            String sql = "SELECT id, task_name, due_date, priority, status, task_type FROM tasks WHERE student_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, studentId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Task task = new Task();
                task.setId(rs.getInt("id"));
                task.setTaskName(rs.getString("task_name"));
                task.setDueDate(rs.getDate("due_date").toLocalDate());
                task.setPriority(rs.getString("priority"));
                task.setStatus(rs.getString("status")); // optional
                task.setCategory(rs.getString ("task_type"));
                taskList.add(task);
            }

            // ✅ Set it in session
            session.setAttribute("taskList", taskList);

            // ✅ Also make it available in request for JSP
            request.setAttribute("taskList", taskList);

            RequestDispatcher dispatcher = request.getRequestDispatcher("studyPlanner.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("viewTasks?status=error");
        }
    }
}
