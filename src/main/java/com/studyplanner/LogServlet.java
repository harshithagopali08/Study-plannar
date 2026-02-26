package com.studyplanner;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/LogServlet")
public class LogServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");


        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/study_planner", "root", "123456")) {
            	String sql = "SELECT id FROM login WHERE username = ? AND email = ? AND password = ?";
            	PreparedStatement stmt = conn.prepareStatement(sql);
            	stmt.setString(1, username);
            	stmt.setString(2, email);
            	stmt.setString(3, password);


                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                	 int studentId = rs.getInt("id");

                     // Step 2: Mark user as 'active' in DB
                     String updateSql = "UPDATE login SET status = 'active' WHERE id = ?";
                     PreparedStatement updateStmt = conn.prepareStatement(updateSql);
                     updateStmt.setInt(1, studentId);
                     updateStmt.executeUpdate();
                     updateStmt.close();
                    HttpSession session = request.getSession();
                    session.setAttribute("username", username);
                    session.setAttribute("studentId", rs.getInt("id"));
                    response.sendRedirect("dashboard");
                } else {
                    response.sendRedirect("log.jsp?status=invalid");
                }

                rs.close();
                stmt.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("log.jsp?status=failed");
        }
    }
}
