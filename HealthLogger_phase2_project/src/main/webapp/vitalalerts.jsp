<%@ page import="java.sql.*" %>
<%@ page import="com.health.Vital" %>
<%@ page import="com.health.Patient" %>


<!DOCTYPE html>
<html>
<head>
    <title>Doctor Home Page - Vital Alerts</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <style>
        body {
            text-align: center;
            font-family: times new roman, sans-serif;
        }

        h1 {
            color: #333;
        }

        .container {
            display: inline-block;
            text-align: left;
            border: 1px solid #ccc;
            padding: 20px;
            margin-top: 50px;
        }
        .threshold-violation {
        color: red;
        font-weight: bold;
    }
        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ccc;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .logout-btn {
            background-color: #cc0000;
            color: #fff;
            padding: 8px 16px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .action-btn {
            background-color: #007bff;
            color: #fff;
            padding: 4px 8px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <h1>Doctor Home Page - Vital Alerts</h1>
    <div class="header">
        <form action="manage-patients.jsp">
            <button type="submit" class="action-btn">Manage Patients</button>
        </form>
        <form action="export-data.jsp" method="post">
            <button type="submit" class="action-btn">Export</button>
        </form>
        <form action="add-vital.jsp" method="post">
            <button type="submit" class="action-btn">Record New Vital</button>
        </form>
        
        <form action="adminlogin.jsp">
            <button type="submit" class="logout-btn">Logout</button>
        </form>
    </div>
    <div class="container">
        <h2>Vital Alerts</h2>
        <table>
            <tr>
                <th>Serial Number</th>
                <th>Patient ID</th>
                <th>Name</th>
                <th>Phone</th>
                <th>BP Low</th>
                <th>BP High</th>
                <th>SPO2</th>
                <th>Recorded Time</th>
                <th>Action</th>
            </tr>
            <%-- Java code to retrieve and display vital data --%>
            <%  
                try {
                    // Establish the database connection
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/health", "root", "silpa23");

                    // Prepare the SQL statement
                    String sql = "SELECT * FROM vitals";
                    Statement statement = conn.createStatement();

                    // Execute the query
                    ResultSet resultSet = statement.executeQuery(sql);

                    int count = 1;
                    while (resultSet.next()) {
                        int id = resultSet.getInt("id");
                        int patientid = resultSet.getInt("patientid");
                        String name = resultSet.getString("name");
                        String phone = resultSet.getString("phone");
                        int bplow = resultSet.getInt("bplow");
                        int bphigh = resultSet.getInt("bphigh");
                        int spo2 = resultSet.getInt("spo2");
                        String recordedtime = resultSet.getString("recordedtime");

                        
                     // Check for threshold violations
                        boolean isBpLowViolation = bplow < 80; // Example threshold value, adjust as needed
                        boolean isBpHighViolation = bphigh > 160; // Example threshold value, adjust as needed
                        boolean isSpo2Violation = spo2 < 90; // Example threshold value, adjust as needed    
                        
                        
                        
                        
                        %>
                        <tr>
                             <td><%= count++ %></td>
                            <td><%= patientid %></td>
                            
                            <td><%= name %></td>
                            <td><%= phone %></td>
                            <td <%= isBpLowViolation ? "class='threshold-violation'" : "" %>><%= bplow %></td>
                <td <%= isBpHighViolation ? "class='threshold-violation'" : "" %>><%= bphigh %></td>
                <td <%= isSpo2Violation ? "class='threshold-violation'" : "" %>><%= spo2 %></td>
                            <td><%= recordedtime %></td>
                            <td>
                                <form action="delete-vital.jsp" method="POST">
                                    <input type="hidden" name="id" value="<%= id %>">
                                    <button type="submit" class="action-btn">Delete</button>
                                </form>
                                
                            </td>
                        </tr>
                        <%  
                    }
                    // Close the connections
                    resultSet.close();
                    statement.close();
                    conn.close();
                } catch (Exception e) {
                    out.println("<h2>Error Occurred!</h2>");
                    out.println("<p>An error occurred while retrieving vital data: " + e.getMessage() + "</p>");
                }
            %>
        </table>
    </div>
</body>
</html>
