<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Health Logger - Add Patient</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <style>
        body {
            text-align: center;
            font-family: Arial, sans-serif;
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

        .success-message {
            color: green;
        }

        .error-message {
            color: red;
        }

        /* New CSS styles */
        .form-group {
            margin-bottom: 15px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }

        input[type="text"],
        input[type="number"],
        input[type="email"],
        input[type="tel"],
        textarea {
            width: 100%;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        button[type="submit"] {
            padding: 8px 16px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        button[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <h1>Health Logger</h1>
    
    <div class="header">
        <form action="manage-patients.jsp">
            <button type="submit" class="home-btn">BACK</button>
        </form>
        </div>
    <div class="container">
        <h2>Add Vital Information</h2>
        <form method="POST" action="add-vital.jsp">
        <div class="form-group">
                <label for="patientid">Patient ID:</label>
                <input type="number" id="patientid" name="patientid" required>
            </div>
            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" required>
            </div>
            <div class="form-group">
                <label for="phone">Phone:</label>
                <input type="tel" id="phone" name="phone" required>
            </div>
            <div class="form-group">
                <label for="bplow">BP LOW:</label>
                <input type="number" id="bplow" name="bplow" required>
            </div>
            <div class="form-group">
                <label for="bphigh">BP HIGH:</label>
                <input type="number" id="bphigh" name="bphigh" required>
            </div>
            <div class="form-group">
                <label for="spo2">SPO2:</label>
                <input type="number" id="spo2" name="spo2" required>
            </div>
            <div class="form-group">
                <label for="recordedtime">Time:</label>
                <input type="text" id="recordedtime" name="recordedtime" required>
            </div>
            
            <div class="form-group">
                <button type="submit">Add</button>
            </div>
        </form>
    </div>
    
    <%-- Java code to insert data into the database --%>
    <%
        if ("POST".equals(request.getMethod())) {
        	String name = request.getParameter("name");
            String patientidParam = request.getParameter("patientid");
            int patientid = 0;
            if (patientidParam != null && !patientidParam.isEmpty()) {
                patientid = Integer.parseInt(patientidParam);
            }
            
            
            String phone = request.getParameter("phone");
            String bplowParam = request.getParameter("bplow");
            int bplow = 0;
            if (bplowParam != null && !bplowParam.isEmpty()) {
                bplow = Integer.parseInt(bplowParam);
            }
            String bphighParam = request.getParameter("bphigh");
            int bphigh = 0;
            if (bphighParam != null && !bphighParam.isEmpty()) {
                bphigh = Integer.parseInt(bphighParam);
            }
            String spo2Param = request.getParameter("spo2");
            int spo2 = 0;
            if (spo2Param != null && !spo2Param.isEmpty()) {
                spo2 = Integer.parseInt(spo2Param);
            }
            String recordedtime = request.getParameter("recordedtime");
            try {
                // Establish the database connection
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/health", "root", "silpa23");

                // Prepare the SQL statement
                String sql = "INSERT INTO vitals (patientid,name, phone,bplow,bphigh,spo2,recordedtime) VALUES (?, ?, ?, ?, ?, ?,?)";
                PreparedStatement statement = conn.prepareStatement(sql);
                statement.setInt(1, patientid);
                statement.setString(2, name);
                statement.setString(3, phone);
                statement.setInt(4, bplow);
                statement.setInt(5, bphigh);
                statement.setInt(6, spo2);
               
                statement.setString(7, recordedtime);
               
               

                // Execute the statement
                int rowsAffected = statement.executeUpdate();

                // Close the connections
                statement.close();
                conn.close();

                // Display success message if rows were affected
                if (rowsAffected > 0) {
                    out.println("<h2>Data Added Successfully!</h2>");
                    out.println("<p class=\"success-message\">Patient data has been added to the database.</p>");
                } else {
                    out.println("<h2>Error Occurred!</h2>");
                    out.println("<p class=\"error-message\">An error occurred while adding the patient data.</p>");
                }
            } catch (Exception e) {
                out.println("<h2>Error Occurred!</h2>");
                out.println("<p class=\"error-message\">An error occurred while adding the patient data: " + e.getMessage() + "</p>");
            }
        }
    %>
</body>
</html>
