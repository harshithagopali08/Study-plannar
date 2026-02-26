package com.studyplanner;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class StudentDAO {
    private Connection conn;

    public StudentDAO(Connection conn) {
        this.conn = conn;
    }

    public Student getStudentById(int id) throws SQLException {
        String query = "SELECT * FROM login WHERE id = ?";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            String username = rs.getString("username");
            String email = rs.getString("email");
            return new Student(id, username, email);
        }
        return null;
    }
}
