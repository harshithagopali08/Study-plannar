package com.studyplanner;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.time.LocalDate;
import java.io.IOException;
import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("studentId") == null) {
            response.sendRedirect("log.jsp");
            return;
        }

        int studentId = (Integer) session.getAttribute("studentId");

        try (Connection conn = DBUtil.getConnection()) {
            StudentDAO studentDAO = new StudentDAO(conn);
            TaskDAO taskDAO = new TaskDAO(conn);

            Student student = studentDAO.getStudentById(studentId);
            List<Task> upcomingTasks = taskDAO.getUpcomingTasks(studentId);
            List<Task> todayTasks = taskDAO.getTodayTasks(studentId);
            int todayProgress = taskDAO.calculateProgress(studentId);         // today's progress
            int overallProgress = taskDAO.calculateOverallProgress(studentId); // overall progress

            // Get reminder tasks for today that need notification
            List<Task> reminderTasks = taskDAO.getReminderTasks(studentId);
            request.setAttribute("reminderTasks", reminderTasks);

            List<Task> upcomingAssignments = new ArrayList<>();
            List<Task> upcomingExams = new ArrayList<>();
            List<Task> upcomingProjects = new ArrayList<>();

            for (Task task : upcomingTasks) {
                if (task.getDueDate().isAfter(LocalDate.now())) {
                    switch (task.getCategory()) {
                        case "Assignment":
                            upcomingAssignments.add(task);
                            break;
                        case "Exam":
                            upcomingExams.add(task);
                            break;
                        case "Project":
                            upcomingProjects.add(task);
                            break;
                        default:
                            System.out.println("Unrecognized category: " + task.getCategory());
                    }
                }
            }
            if (!upcomingAssignments.isEmpty()) {
                upcomingAssignments = upcomingAssignments.subList(0, 1);
            }

            if (!upcomingExams.isEmpty()) {
                upcomingExams = upcomingExams.subList(0, 1);
            }

            if (!upcomingProjects.isEmpty()) {
                upcomingProjects = upcomingProjects.subList(0, 1);
            }

            request.setAttribute("student", student);
            request.setAttribute("upcomingTasks", upcomingTasks);
            request.setAttribute("todayTasks", todayTasks);
            request.setAttribute("progress", todayProgress);
            request.setAttribute("overallProgress", overallProgress);
            request.setAttribute("upcomingAssignments", upcomingAssignments);
            request.setAttribute("upcomingExams", upcomingExams);
            request.setAttribute("upcomingProjects", upcomingProjects);
            request.setAttribute("reminderTasks", reminderTasks);  // Add this for reminders

            RequestDispatcher dispatcher = request.getRequestDispatcher("dashboard.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}