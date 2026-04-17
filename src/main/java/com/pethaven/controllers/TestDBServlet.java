package com.pethaven.controllers;

import com.pethaven.utils.DatabaseConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;

@WebServlet("/test-db")
public class TestDBServlet extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        out.println("<html><head><title>Database Test</title>");
        out.println("<style>body{font-family:Arial;padding:20px;} table{border-collapse:collapse;width:100%;} th,td{border:1px solid #ddd;padding:8px;text-align:left;} th{background:#4CAF50;color:white;}</style>");
        out.println("</head><body>");
        out.println("<h1>🔍 Pet Haven Database Test</h1>");
        
        try {
            Connection conn = DatabaseConnection.getConnection();
            out.println("<p style='color:green;'>✅ <strong>Database connection successful!</strong></p>");
            
            // Test pets table structure
            out.println("<h2>Pets Table Structure:</h2>");
            DatabaseMetaData metaData = conn.getMetaData();
            ResultSet columns = metaData.getColumns(null, null, "pets", null);
            out.println("<table><tr><th>Column</th><th>Type</th><th>Nullable</th></tr>");
            while (columns.next()) {
                String colName = columns.getString("COLUMN_NAME");
                String colType = columns.getString("TYPE_NAME");
                String nullable = columns.getString("IS_NULLABLE");
                out.println("<tr><td>" + colName + "</td><td>" + colType + "</td><td>" + nullable + "</td></tr>");
            }
            out.println("</table>");
            
            // Test pets data
            out.println("<h2>Pets in Database:</h2>");
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM pets");
            ResultSetMetaData rsmd = rs.getMetaData();
            int columnCount = rsmd.getColumnCount();
            
            out.println("<table><tr>");
            for (int i = 1; i <= columnCount; i++) {
                out.println("<th>" + rsmd.getColumnName(i) + "</th>");
            }
            out.println("</tr>");
            
            int count = 0;
            while (rs.next()) {
                count++;
                out.println("<tr>");
                for (int i = 1; i <= columnCount; i++) {
                    String value = rs.getString(i);
                    out.println("<td>" + (value != null ? value : "<em>null</em>") + "</td>");
                }
                out.println("</tr>");
            }
            out.println("</table>");
            out.println("<p><strong>Total pets found: " + count + "</strong></p>");
            
            if (count == 0) {
                out.println("<p style='color:orange;'>⚠️ No pets in database. Run <code>complete_setup.sql</code> to add sample data.</p>");
            }
            
            conn.close();
            
        } catch (SQLException e) {
            out.println("<p style='color:red;'>❌ <strong>Database error:</strong></p>");
            out.println("<pre style='background:#f5f5f5;padding:10px;'>");
            e.printStackTrace(out);
            out.println("</pre>");
        }
        
        out.println("<hr><p><a href='" + request.getContextPath() + "/manage-pets'>← Back to Manage Pets</a></p>");
        out.println("</body></html>");
    }
}
