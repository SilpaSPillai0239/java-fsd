<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Health Logger - Add Patient</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <style>
        body {
            text-align: center;
            font-family: Times New Roman, sans-serif;
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

        input[type="radio"] {
            margin-right: 5px;
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
        <h2>Add Patient Information</h2>
        <form method="POST" action="add-patient.jsp">
            <div class="form-group">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" required>
            </div>
            <div class="form-group">
                <label for="age">Age:</label>
                <input type="number" id="age" name="age" required>
            </div>
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required>
            </div>
            <div class="form-group">
                <label for="phone">Phone:</label>
                <input type="tel" id="phone" name="phone" required>
            </div>
            <div class="form-group">
                <label for="diagnosis">Diagnosis:</label>
                <input type="text" id="diagnosis" name="diagnosis" required>
            </div>
            <div class="form-group">
                <label for="remark">Remarks:</label>
                <textarea id="remark" name="remark" required></textarea>
            </div>
            <div class="form-group">
                <label for="gender">Gender:</label>
                <label><input type="radio" name="gender" value="Male" required> Male</label>
                <label><input type="radio" name="gender" value="Female" required> Female</label>
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
            String ageParam = request.getParameter("age");
            int age = 0;
            if (ageParam != null && !ageParam.isEmpty()) {
                age = Integer.parseInt(ageParam);
            }
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String diagnosis = request.getParameter("diagnosis");
            String remark = request.getParameter("remark");
            String gender = request.getParameter("gender");

            try {
                // Establish the database connection
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/health", "root", "silpa23");

                // Prepare the SQL statement
                String sql = "INSERT INTO patients (name, age, email, phone, diagnosis, remark, gender) VALUES (?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement statement = conn.prepareStatement(sql);
                statement.setString(1, name);
                statement.setInt(2, age);
                statement.setString(3, email);
                statement.setString(4, phone);
                statement.setString(5, diagnosis);
                statement.setString(6, remark);
                statement.setString(7, gender);

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
