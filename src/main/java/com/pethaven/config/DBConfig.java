package com.pethaven.config;

// CONFIGURATION LAYER: Central database connection manager.
// All DAO classes call DBConfig.getConnection() — one place to change DB settings.
// Using the modern MySQL Connector/J 8+ driver class: com.mysql.cj.jdbc.Driver

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConfig {

    // DATABASE CREDENTIALS: Targeting XAMPP's default MySQL setup on localhost.
    // Change PASSWORD to your XAMPP MySQL password if you set one (default is blank).
    private static final String URL      = "jdbc:mysql://localhost:3306/pethaven_db"
                                         + "?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
    private static final String USER     = "root";
    private static final String PASSWORD = "";   // XAMPP default — no password

    // DRIVER LOADING: Using a static block so the driver registers once at class load time.
    // This avoids calling Class.forName() on every single connection request.
    static {
        try {
            // Modern JDBC 4.0+ auto-registers, but explicit load is safer for older containers
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            // If this fires, the mysql-connector-j JAR is missing from WEB-INF/lib
            System.err.println("[DBConfig] CRITICAL: MySQL JDBC Driver not found in WEB-INF/lib!");
            e.printStackTrace();
        }
    }

    // CONNECTION RETRIEVAL: Returns a fresh connection from DriverManager.
    // Callers must close this connection — best done via try-with-resources in DAOs.
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }

    // Private constructor — this is a utility class, no instances needed
    private DBConfig() {}
}
