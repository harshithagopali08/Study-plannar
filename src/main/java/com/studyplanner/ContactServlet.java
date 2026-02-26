package com.studyplanner;

import java.io.IOException;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/ContactServlet")

public class ContactServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve form data
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        // Log received data
        System.out.println("Received contact form data:");
        System.out.println("Name: " + name);
        System.out.println("Email: " + email);
        System.out.println("Subject: " + subject);
        System.out.println("Message: " + message);

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            // Load JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("MySQL JDBC driver loaded.");

            // Establish the database connection
            System.out.println("Connecting to the database...");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/study_planner", "root", "123456");

            // SQL query to insert the message into the database
            String sql = "INSERT INTO contact_messages (name, email, subject, message) VALUES (?, ?, ?, ?)";
            stmt = conn.prepareStatement(sql);

            // Set values for the prepared statement
            stmt.setString(1, name);
            stmt.setString(2, email);
            stmt.setString(3, subject);
            stmt.setString(4, message);

            // Execute the update
            int rowsAffected = stmt.executeUpdate();
            System.out.println("Rows affected: " + rowsAffected);

            // Check if insertion was successful
            if (rowsAffected > 0) {
                response.sendRedirect("contact.jsp?success=true");
            } else {
                response.sendRedirect("contact.jsp?error=true&details=Insertion%20failed");
            }

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("contact.jsp?error=true&details=JDBC%20Driver%20not%20found");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("contact.jsp?error=true&details=" + e.getMessage());

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("contact.jsp?error=true&details=" + e.getMessage());

        } finally {
            // Close resources
            try {
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
