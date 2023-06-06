<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
    <title>Doctor Home Page - Health Logger</title>
    <link rel="stylesheet" type="text/css" href="css/style1.css">
    <style>
        body {
            text-align: center;
            font-family: Times new roman, sans-serif;
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

        .home-btn {
            background-color: #007bff;
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

        .update-form {
            display: inline-block;
        }

        .update-input {
            padding: 4px;
        }
    </style>
</head>
<body>
    <h1>Doctor Home Page - Health Logger</h1>
    <div class="header">
        <form action="admindashboard.jsp">
            <button type="submit" class="home-btn">Home</button>
        </form>
        <form action="add-patient.jsp">
            <button type="submit">Add Patient</button>
        </form>
        <form action="adminlogin.jsp">
            <button type="submit" class="logout-btn">Logout</button>
        </form>
    </div>
    <div class="container">
        <h2>Search Patient</h2>
        <form method="GET" action="search-patient.jsp">
            <input type="text" name="search" placeholder="Search patient by name" required>
            <button type="submit">Search</button>
        </form>
        <br>
        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Age</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Diagnosis</th>
                <th>Remarks</th>
                <th>Gender</th>
                <th>Action</th>
            </tr>
            <%-- Java code to retrieve and display patient data --%>
            <%  
                String searchKeyword = request.getParameter("search");

                try {
                    // Establish the database connection
                    Class.forName("com.mysql.jdbc.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost/health", "root", "silpa23");

                    // Prepare the SQL statement
                    String sql = "SELECT * FROM patients WHERE name LIKE ?";
                    PreparedStatement statement = conn.prepareStatement(sql);
                    statement.setString(1, searchKeyword + "%");

                    // Execute the query
                    ResultSet resultSet = statement.executeQuery();

                    while (resultSet.next()) {
                        int id = resultSet.getInt("id");
                        String name = resultSet.getString("name");
                        int age = resultSet.getInt("age");
                        String email = resultSet.getString("email");
                        String phone = resultSet.getString("phone");
                        String diagnosis = resultSet.getString("diagnosis");
                        String remark = resultSet.getString("remark");
                        String gender = resultSet.getString("gender");

                        %>
                        <tr>
                            <td><%= id %></td>
                            <td><%= name %></td>
                            <td><%= age %></td>
                            <td><%= email %></td>
                            <td><%= phone %></td>
                            <td><%= diagnosis %></td>
                            <td><%= remark %></td>
                            <td><%= gender %></td>
                            <td>
                                <form action="manage-vitals.jsp" method="GET">
                                    <input type="hidden" name="id" value="<%= id %>">
                                    <button type="submit" class="action-btn">Manage Vitals</button>
                                </form>
                                <form action="update-patient.jsp" method="GET" class="update-form">
                                   <input type="hidden" name="id" value="<%= id %>">
                                  
                                    
                                    <button type="submit" class="action-btn">Update</button>
                                </form>
                                <form action="delete-patient.jsp" method="GET">
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
                    out.println("<p class=\"error-message\">An error occurred while searching for patients: " + e.getMessage() + "</p>");
                }
            %>
        </table>
    </div>
</body>
</html>
