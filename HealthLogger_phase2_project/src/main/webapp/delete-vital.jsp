<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Vital</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
        }
        .container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
        }
        .message {
            text-align: center;
            margin-top: 20px;
            padding: 10px;
            background-color: #e9f7ef;
            border: 1px solid #2ecc71;
            color: #2ecc71;
            font-weight: bold;
        }
        .btn-container {
            text-align: center;
            margin-top: 20px;
        }
        .btn-container a {
            display: inline-block;
            margin: 0 10px;
            padding: 10px 20px;
            background-color: #2ecc71;
            color: #fff;
            text-decoration: none;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Delete Vital</h2>
        <%-- Check if the vital ID parameter is present --%>
        <%
    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        // Establish a connection to the database
        Class.forName("com.mysql.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/health", "root", "silpa23");

        // Check if the vital ID parameter is present
        if (request.getParameter("id") != null) {
            int id = Integer.parseInt(request.getParameter("id"));

            // Prepare the SQL statement to delete the vital record
            String sql = "DELETE FROM vitals WHERE id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);

            // Execute the delete statement
            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                // Display the success message if the deletion was successful
                out.println("<h2>Vital deleted successfully.</h2>");
            } else {
                // Display an error message if the deletion failed
                out.println("<h2>Error: Failed to delete the vital.</h2>");
            }
        } else {
            // Display an error message if the ID parameter is not present
            out.println("<h2>Error: Invalid request.</h2>");
        }
    } catch (Exception e) {
        // Handle any exceptions that occur during the database operation
        e.printStackTrace();
        out.println("<h2>Error: An unexpected error occurred.</h2>");
    } finally {
        // Close the database resources
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
        <div class="btn-container">
            <a href="manage-vitals.jsp">Go Back</a>
        </div>
    </div>
</body>
</html>
