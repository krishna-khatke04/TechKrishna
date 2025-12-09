package com.krishna.helper;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class MyConnector {

    private static Connection con;

    public static Connection getConnection() {
        try {
            if (con == null) {

                Class.forName("oracle.jdbc.driver.OracleDriver");
                con = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "Krishna_khatke", "Krishna04");

            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }

        return con;
    }
}
