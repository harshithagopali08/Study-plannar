package com.studyplanner;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/deleteTask")
public class DeleteTaskServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("studentId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int studentId = (Integer) session.getAttribute("studentId");
        String taskIdStr = request.getParameter("taskId");

        if (taskIdStr == null || taskIdStr.isEmpty()) {
            response.sendRedirect("viewTasks?status=error");
            return;
        }

        try (Connection conn = DBUtil.getConnection()) {
            String sql = "DELETE FROM tasks WHERE id = ? AND student_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(taskIdStr));
            stmt.setInt(2, studentId);

            List<Task> taskList = new ArrayList<>();
            String query = "SELECT id, task_name, due_date, priority, status,task_type FROM tasks WHERE student_id = ?";
            PreparedStatement fetchStmt = conn.prepareStatement(query);
            fetchStmt.setInt(1, studentId);
            ResultSet rs = fetchStmt.executeQuery();
            stmt.executeUpdate();

            while (rs.next()) {
                Task task = new Task();
                task.setId(rs.getInt("id"));
                task.setTaskName(rs.getString("task_name"));
                task.setDueDate(rs.getDate("due_date").toLocalDate());
                task.setPriority(rs.getString("priority"));
                task.setStatus(rs.getString("status"));
                task.setCategory(rs.getString("task_type"));
                taskList.add(task);
            }

            session.setAttribute("taskList", taskList);
            response.sendRedirect("viewTasks?status=deleted");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("viewTasks?status=error");
        }
    }
}