package com.studyplanner;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/dateHandler")
public class DateHandlerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String dateParam = request.getParameter("date");
        HttpSession session = request.getSession();
        Integer studentId = (Integer) session.getAttribute("studentId");

        if (dateParam == null || studentId == null) {
            response.sendRedirect("log.jsp");
            return;
        }

        LocalDate clickedDate = LocalDate.parse(dateParam);
        boolean hasDueTask = false;
        boolean isMissed = false;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/study_planner", "root", "123456");

            String query = "SELECT status, due_date FROM tasks WHERE student_id = ? AND due_date = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, studentId);
            ps.setDate(2, Date.valueOf(clickedDate));
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String status = rs.getString("status");
                LocalDate dueDate = rs.getDate("due_date").toLocalDate();

                if ("pending".equalsIgnoreCase(status)) {
                    hasDueTask = true;
                    if (dueDate.isBefore(LocalDate.now())) {
                        isMissed = true;
                    }
                }
            }

            rs.close();
            con.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        // Redirect based on the result
        if (hasDueTask) {
            if (isMissed) {
                response.sendRedirect("goToPlanner.jsp#missed-deadlines");
            } else {
                response.sendRedirect("goToPlanner.jsp#all-tasks");
            }
        } else {
            response.sendRedirect("addTask.jsp?date=" + dateParam);  // Assuming you have a form for adding tasks
        }
    }
}
