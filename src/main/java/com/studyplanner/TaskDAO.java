package com.studyplanner;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class TaskDAO {

    private Connection conn;

    public TaskDAO(Connection conn) {
        this.conn = conn;
    }

    // Total number of tasks for the student
    public int getTotalTasks(int studentId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM tasks WHERE student_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, studentId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    // Number of completed tasks for the student
    public int getCompletedTasks(int studentId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM tasks WHERE student_id = ? AND status = 'completed'";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, studentId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    // Get all tasks due today that are not completed
    public List<Task> getTodayTasks(int studentId) throws SQLException {
        String sql = "SELECT * FROM tasks WHERE student_id = ? AND due_date = CURDATE() AND status != 'completed'";
        List<Task> todayTasks = new ArrayList<>();
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, studentId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Task task = extractTaskFromResultSet(rs);
                todayTasks.add(task);
            }
        }
        return todayTasks;
    }

    // Get upcoming tasks (due after today) not completed
    public List<Task> getUpcomingTasks(int studentId) throws SQLException {
        String sql = "SELECT * FROM tasks WHERE student_id = ? AND due_date > CURDATE() AND status != 'completed' ORDER BY due_date ASC";
        List<Task> upcomingTasks = new ArrayList<>();
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, studentId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Task task = extractTaskFromResultSet(rs);
                upcomingTasks.add(task);
            }
        }
        return upcomingTasks;
    }

    // Calculate progress % for today (completed / total * 100)
    public int calculateProgress(int studentId) throws SQLException {
        LocalDate today = LocalDate.now();
        Date todayDate = Date.valueOf(today);

        int totalTodayTasks = 0;
        int completedTodayTasks = 0;

        String totalQuery = "SELECT COUNT(*) FROM tasks WHERE student_id = ? AND due_date = ?";
        try (PreparedStatement totalStmt = conn.prepareStatement(totalQuery)) {
            totalStmt.setInt(1, studentId);
            totalStmt.setDate(2, todayDate);
            ResultSet rs = totalStmt.executeQuery();
            if (rs.next()) totalTodayTasks = rs.getInt(1);
        }

        String completedQuery = "SELECT COUNT(*) FROM tasks WHERE student_id = ? AND due_date = ? AND status = 'completed'";
        try (PreparedStatement completedStmt = conn.prepareStatement(completedQuery)) {
            completedStmt.setInt(1, studentId);
            completedStmt.setDate(2, todayDate);
            ResultSet rs = completedStmt.executeQuery();
            if (rs.next()) completedTodayTasks = rs.getInt(1);
        }

        if (totalTodayTasks == 0) return 0;
        return (completedTodayTasks * 100) / totalTodayTasks;
    }

    // Calculate overall progress % (completed / total * 100)
    public int calculateOverallProgress(int studentId) throws SQLException {
        int totalTasks = getTotalTasks(studentId);
        int completedTasks = getCompletedTasks(studentId);
        if (totalTasks == 0) return 0;
        return (completedTasks * 100) / totalTasks;
    }

    // Mark task as completed (use existing connection)
    public void markTaskAsCompleted(int taskId) throws SQLException {
        String sql = "UPDATE tasks SET status = 'completed' WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, taskId);
            stmt.executeUpdate();
        }
    }

    // Get tasks within a week range
    public List<Task> getTasksForWeek(int studentId, LocalDate start, LocalDate end) throws SQLException {
        String sql = "SELECT * FROM tasks WHERE student_id = ? AND due_date BETWEEN ? AND ? ORDER BY due_date";
        List<Task> tasks = new ArrayList<>();
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, studentId);
            stmt.setDate(2, Date.valueOf(start));
            stmt.setDate(3, Date.valueOf(end));
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Task task = extractTaskFromResultSet(rs);
                tasks.add(task);
            }
        }
        return tasks;
    }

    // Get reminder tasks due for notification (reminder_time <= now, notified = 0, not completed)
    public List<Task> getReminderTasks(int studentId) throws SQLException {
        String sql = "SELECT * FROM tasks WHERE student_id = ? AND reminder_time IS NOT NULL AND reminder_time <= NOW() AND notified = 0 AND status != 'completed'";
        List<Task> reminderTasks = new ArrayList<>();
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, studentId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Task task = extractTaskFromResultSet(rs);
                reminderTasks.add(task);
            }
        }
        return reminderTasks;
    }

    // Extract a Task object from ResultSet
    private Task extractTaskFromResultSet(ResultSet rs) throws SQLException {
        Task task = new Task();
        task.setId(rs.getInt("id"));
        task.setTaskName(rs.getString("task_name"));
        task.setDueDate(rs.getDate("due_date").toLocalDate());
        task.setPriority(rs.getString("priority"));
        task.setStatus(rs.getString("status"));
        // Make sure column name is consistent with your DB schema
        task.setCategory(rs.getString("task_type")); 

        Timestamp reminderTimestamp = rs.getTimestamp("reminder_time");
        if (reminderTimestamp != null) {
            task.setReminderTime(reminderTimestamp.toLocalDateTime());
        }

        task.setNotified(rs.getInt("notified") == 1);
        return task;
    }
}