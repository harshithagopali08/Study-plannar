package com.studyplanner;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:mysql://localhost:3306/study_planner";
    private static final String DB_USER = "root";
    private static final String DB_PASS = "123456"; // Update to your password

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session != null) {
            Integer studentId = (Integer) session.getAttribute("studentId"); // use correct session attr
            if (studentId != null) {
                try {
                    Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASS);
                    PreparedStatement stmt = conn.prepareStatement(
                        "UPDATE login SET status = 'inactive' WHERE id = ?"
                    );
                    stmt.setInt(1, studentId);
                    stmt.executeUpdate();
                    stmt.close();
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace(); // handle or log this properly
                }
            }
            session.invalidate(); // Invalidate session after DB update
        }

        response.sendRedirect("index.jsp");
    }
}