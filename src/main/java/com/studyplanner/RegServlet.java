package com.studyplanner;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.*;

@WebServlet("/RegServlet")
public class RegServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String username =
                request.getParameter("username");

        String email =
                request.getParameter("email");

        String password =
                request.getParameter("password");

        try {

            try (Connection connection =
                    DBUtil.getConnection()) {

                PreparedStatement checkStmt =
                        connection.prepareStatement(
                                "SELECT username FROM login WHERE username = ? OR email = ?"
                        );

                checkStmt.setString(
                        1,
                        username
                );

                checkStmt.setString(
                        2,
                        email
                );

                ResultSet rs =
                        checkStmt.executeQuery();

                if (rs.next()) {

                    response.sendRedirect(
                            "log.jsp?status=duplicate"
                    );

                } else {

                    PreparedStatement insertStmt =
                            connection.prepareStatement(
                                    "INSERT INTO login (username,email,password,status) VALUES (?,?,?,?)"
                            );

                    insertStmt.setString(
                            1,
                            username
                    );

                    insertStmt.setString(
                            2,
                            email
                    );

                    insertStmt.setString(
                            3,
                            password
                    );

                    insertStmt.setString(
                            4,
                            "inactive"
                    );

                    int rows =
                            insertStmt.executeUpdate();

                    if (rows > 0) {

                        response.sendRedirect(
                                "log.jsp?status=success"
                        );

                    } else {

                        response.sendRedirect(
                                "log.jsp?status=failed"
                        );
                    }

                    insertStmt.close();
                }

                rs.close();
                checkStmt.close();

            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "log.jsp?status=error"
            );
        }
    }
}