package com.studyplanner;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
//    private static final String URL = "jdbc:mysql://localhost:3306/study_planner"; // change this
//    private static final String USER = "root"; // change this
//    private static final String PASSWORD = "123456"; // change this
	private static final String URL ="jdbc:mysql://mysql.railway.internal:3306/railway?useSSL=false&allowPublicKeyRetrieval=true";

			private static final String USER = "root";

			private static final String PASSWORD = "MibMSVgnxMjgfRhBbEUgvogdGYFCODgo";
    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver"); // Load the JDBC driver
        return DriverManager.getConnection(URL, USER, PASSWORD); // Connect to database
    }
}
