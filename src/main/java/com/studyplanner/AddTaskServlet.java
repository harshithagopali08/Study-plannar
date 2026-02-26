package com.studyplanner;

import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/addTask")
public class AddTaskServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		if (session == null || session.getAttribute("studentId") == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		int studentId = (Integer) session.getAttribute("studentId");
		String taskName = request.getParameter("taskName");
		String dueDateStr = request.getParameter("dueDate");
		String priority = request.getParameter("priority");
		String category = request.getParameter("category");
		String reminderTimeStr = request.getParameter("reminderTime");

		if (taskName == null || dueDateStr == null || priority == null) {
			response.sendRedirect("viewTasks?status=error");
			return;
		}

		try (Connection conn = DBUtil.getConnection()) {

			String sql = "INSERT INTO tasks (student_id, task_name, due_date, priority, status, task_type, reminder_time, notified) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setInt(1, studentId);
			stmt.setString(2, taskName);
			stmt.setDate(3, Date.valueOf(LocalDate.parse(dueDateStr)));
			stmt.setString(4, priority);
			stmt.setString(5, "pending");
			stmt.setString(6, category);

			// Reminder time handling
			if (reminderTimeStr != null && !reminderTimeStr.isEmpty()) {
				LocalDateTime reminderTime = LocalDateTime.parse(reminderTimeStr);
				stmt.setTimestamp(7, Timestamp.valueOf(reminderTime));
			} else {
				stmt.setNull(7, Types.TIMESTAMP);
			}

			stmt.setInt(8, 0); // notified = false

			stmt.executeUpdate();

			// Fetch updated task list
			List<Task> taskList = new ArrayList<>();
			String query = "SELECT id, task_name, due_date, priority, status, task_type FROM tasks WHERE student_id = ?";
			PreparedStatement fetchStmt = conn.prepareStatement(query);
			fetchStmt.setInt(1, studentId);
			ResultSet rs = fetchStmt.executeQuery();

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
			response.sendRedirect("viewTasks?status=success");

		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("viewTasks?status=error");
		}
	}
}