package com.studyplanner;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL =
        "jdbc:mysql://kodama.proxy.rlwy.net:14958/railway?useSSL=false&allowPublicKeyRetrieval=true";

    private static final String USER =
        "root";

    private static final String PASSWORD =
        "ODxMEWoZhEAJxvIUqFDFdcapMLnlcRgr";

    public static Connection getConnection()
            throws SQLException, ClassNotFoundException {

        Class.forName("com.mysql.cj.jdbc.Driver");

        return DriverManager.getConnection(
                URL,
                USER,
                PASSWORD
        );
    }
}
