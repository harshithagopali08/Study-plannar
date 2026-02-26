package com.studyplanner;

import java.io.IOException;
import java.sql.*;
import java.sql.Date;
import java.time.*;
import java.time.format.TextStyle;
import java.util.*;
import jakarta.servlet.annotation.WebServlet;


import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/goToPlanner")
public class GoToPlannerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer studentId = (Integer) session.getAttribute("studentId");

        if (studentId == null) {
            response.sendRedirect("log.jsp");
            return;
        }

        LocalDate today = LocalDate.now();
        LocalDate startOfWeek = today.with(DayOfWeek.MONDAY);
        LocalDate endOfWeek = today.with(DayOfWeek.SUNDAY);

        Map<String, List<Task>> tasksByDay = new LinkedHashMap<>();
        for (DayOfWeek day : DayOfWeek.values()) {
            String dayName = day.getDisplayName(TextStyle.FULL, Locale.ENGLISH);
            tasksByDay.put(dayName, new ArrayList<>());
        }

        List<Task> allTasks = new ArrayList<>(); // For missed deadline section

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/study_planner", "root", "123456");

            // Query weekly tasks
            String queryWeek = "SELECT * FROM tasks WHERE student_id = ? AND due_date BETWEEN ? AND ?";
            PreparedStatement psWeek = con.prepareStatement(queryWeek);
            psWeek.setInt(1, studentId);
            psWeek.setDate(2, Date.valueOf(startOfWeek));
            psWeek.setDate(3, Date.valueOf(endOfWeek));

            ResultSet rsWeek = psWeek.executeQuery();
            while (rsWeek.next()) {
                String status = rsWeek.getString("status");

                if ("pending".equalsIgnoreCase(status)) {
                    Task task = new Task();
                    task.setId(rsWeek.getInt("id"));
                    task.setTaskName(rsWeek.getString("task_name"));
                    task.setDueDate(rsWeek.getDate("due_date").toLocalDate());
                    task.setPriority(rsWeek.getString("priority"));
                    task.setStatus(status);
                    task.setCategory(rsWeek.getString("task_type"));

                    DayOfWeek day = task.getDueDate().getDayOfWeek();
                    String dayName = day.getDisplayName(TextStyle.FULL, Locale.ENGLISH);
                    tasksByDay.get(dayName).add(task);
                }
            }

            // Query all tasks for missed deadline section
            String queryAll = "SELECT * FROM tasks WHERE student_id = ?";
            PreparedStatement psAll = con.prepareStatement(queryAll);
            psAll.setInt(1, studentId);
            ResultSet rsAll = psAll.executeQuery();

            while (rsAll.next()) {
                Task task = new Task();
                task.setId(rsAll.getInt("id"));
                task.setTaskName(rsAll.getString("task_name"));
                task.setDueDate(rsAll.getDate("due_date").toLocalDate());
                task.setPriority(rsAll.getString("priority"));
                task.setStatus(rsAll.getString("status"));
                task.setCategory(rsAll.getString("task_type"));
                allTasks.add(task);
            }

            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        Set<String> missedDates = new HashSet<>();
        Set<String> activeTaskDates = new HashSet<>();

        for (Task task : allTasks) {
            if ("pending".equalsIgnoreCase(task.getStatus())) {
                LocalDate dueDate = task.getDueDate();
                if (dueDate.isBefore(today)) {
                    missedDates.add(dueDate.toString());
                } else {
                    activeTaskDates.add(dueDate.toString());
                }
            }
        }


        request.setAttribute("missedDates", missedDates);
        request.setAttribute("activeTaskDates", activeTaskDates);
        request.setAttribute("tasksByDay", tasksByDay);

        List<Task> pendingTasks = new ArrayList<>();
        for (Task task : allTasks) {
            if ("pending".equalsIgnoreCase(task.getStatus())) {
                pendingTasks.add(task);
            }
        }
        request.setAttribute("taskList", pendingTasks);  // ✅ Only pending tasks

        RequestDispatcher rd = request.getRequestDispatcher("goToPlanner.jsp");
        rd.forward(request, response);

    }
}
