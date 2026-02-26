package com.studyplanner;


import java.io.IOException;
import java.sql.*;
import java.util.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/history")
public class HistoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    	    throws ServletException, IOException {

    	    HttpSession session = request.getSession();
    	    Integer studentId = (Integer) session.getAttribute("studentId");
    	    String filterPriority = request.getParameter("priority");
    	    String filterCategory = request.getParameter("category");

    	    List<Task> completedTasks = new ArrayList<>();

    	    try {
    	        Connection conn = DBConnection.getConnection();
    	        StringBuilder sql = new StringBuilder("SELECT task_name, due_date, priority, task_type FROM tasks WHERE student_id = ? AND status = 'completed'");
    	        
    	        // Dynamically build query
    	        if (filterPriority != null && !filterPriority.isEmpty()) {
    	            sql.append(" AND priority = ?");
    	        }
    	        if (filterCategory != null && !filterCategory.isEmpty()) {
    	            sql.append(" AND task_type = ?");
    	        }
    	        sql.append(" ORDER BY due_date DESC");

    	        PreparedStatement ps = conn.prepareStatement(sql.toString());
    	        ps.setInt(1, studentId);

    	        int index = 2;
    	        if (filterPriority != null && !filterPriority.isEmpty()) {
    	            ps.setString(index++, filterPriority);
    	        }
    	        if (filterCategory != null && !filterCategory.isEmpty()) {
    	            ps.setString(index, filterCategory);
    	        }

    	        ResultSet rs = ps.executeQuery();

    	        while (rs.next()) {
    	            Task task = new Task();
    	            task.setTaskName(rs.getString("task_name"));
    	            task.setDueDate(rs.getDate("due_date").toLocalDate());
    	            task.setPriority(rs.getString("priority"));
    	            task.setCategory(rs.getString("task_type"));
    	            completedTasks.add(task);
    	        }

    	        rs.close();
    	        ps.close();
    	        conn.close();

    	    } catch (Exception e) {
    	        e.printStackTrace();
    	    }

    	    request.setAttribute("completedTasks", completedTasks);
    	    RequestDispatcher rd = request.getRequestDispatcher("history.jsp");
    	    rd.forward(request, response);
    	}

}
