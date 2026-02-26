package com.studyplanner;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/RegServlet")
public class RegServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String JDBC_URL = "jdbc:mysql://localhost:3306/study_planner";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "123456";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection connection = DriverManager.getConnection(JDBC_URL, DB_USER, DB_PASSWORD)) {
                // Check for existing username or email
                PreparedStatement checkStmt = connection.prepareStatement(
                    "SELECT username FROM login WHERE username = ? OR email = ?"
                );
                checkStmt.setString(1, username);
                checkStmt.setString(2, email);

                ResultSet rs = checkStmt.executeQuery();

                if (rs.next()) {
                    // Username or email already exists
                    response.sendRedirect("log.jsp?status=duplicate");
                } else {
                    // Proceed to insert
                    PreparedStatement insertStmt = connection.prepareStatement(
                        "INSERT INTO login (username, email, password, status) VALUES (?, ?, ?, ?)"
                    );
                    insertStmt.setString(1, username);
                    insertStmt.setString(2, email);
                    insertStmt.setString(3, password);
                    insertStmt.setString(4, "inactive");

                    int rows = insertStmt.executeUpdate();
                    if (rows > 0) {
                        response.sendRedirect("log.jsp?status=success");
                    } else {
                        response.sendRedirect("log.jsp?status=failed");
                    }

                    insertStmt.close();
                }

                rs.close();
                checkStmt.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("log.jsp?status=error");
        }
    }
}
