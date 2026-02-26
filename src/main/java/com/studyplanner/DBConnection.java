package com.studyplanner;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/study_planner"; // change this
    private static final String USER = "root"; // change this
    private static final String PASSWORD = "123456"; // change this

    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver"); // Load the JDBC driver
        return DriverManager.getConnection(URL, USER, PASSWORD); // Connect to database
    }
}
