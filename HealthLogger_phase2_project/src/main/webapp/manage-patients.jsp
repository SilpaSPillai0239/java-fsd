<%@ page import="java.util.List" %>
<%@ page import="com.health.Patient" %>
<%@ page import="com.health.Vital" %>
<%@ page import="org.hibernate.*" %>
<%@ page import="com.simpli.HibernateUtil" %>

<!DOCTYPE html>
<html>
<head>
    <title>Doctor Home Page</title>
    <link rel="stylesheet" type="text/css" href="css/style1.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

    <style>
        .container {
            font-family: Times new roman, sans-serif;
            padding: 20px;
        }

        .container h1 {
            text-align: center;
        }

        .container table {
            width: 100%;
            border-collapse: collapse;
        }

        .container th,
        .container td {
            padding: 8px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        .container .button-group {
            display: flex;
            justify-content: center;
        }

        .container .button-group a,
        .container .button-group form {
            margin: 0 5px;
        }

        .container .logout-button {
            position: absolute;
            top: 20px;
            right: 20px;
        }

        .graph-container {
            text-align: center;
        }

        .graph-container canvas {
            max-width: 100%;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Doctor Home Page</h1>

        <div class="graph-container">
            <h2>Vital Graph</h2>
            <canvas id="vitalsGraph"></canvas>
        </div>

        <div class="button-group">
            <form action="admindashboard.jsp">
                <button type="submit" class="action-btn">HOME</button>
            </form>
            <button onclick="location.href='search-patient.jsp'">Search Patient</button>
            <button onclick="location.href='add-patient.jsp'">Add Patient</button>
            <button onclick="location.href='manage-vitals.jsp'">Manage Vitals</button>
        </div>

        <br>

        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Age</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Diagnosis</th>
                <th>Remark</th>
                <th>Gender</th>
                <th>Action</th>
            </tr>

            <% Session session6 = HibernateUtil.getSessionFactory().openSession();
               Transaction transaction = null;
               try {
                   transaction = session6.beginTransaction();
                   Query<Patient> query = session6.createQuery("FROM Patient", Patient.class);
                   List<Patient> patients = query.list();
                   for (int i = 0; i < patients.size(); i++) {
                       Patient patient = patients.get(i);
            %>
                       <tr>
                           <td><%= patient.getId() %></td>
                           <td><%= patient.getName() %></td>
                           <td><%= patient.getAge() %></td>
                           <td><%= patient.getEmail() %></td>
                           <td><%= patient.getPhone() %></td>
                           <td><%= patient.getDiagnosis() %></td>
                           <td><%= patient.getRemark() %></td>
                           <td><%= patient.getGender() %></td>
                           <td>
                               <div class="button-group">
                                   <form method="POST" action="manage-vitals.jsp?id=<%= patient.getId() %>">
                                       <button type="submit">Manage Vitals</button>
                                   </form>
                                   <form method="POST" action="update-patient.jsp?id=<%= patient.getId() %>">
                                       <input type="text" name="diagnosis" placeholder="Diagnosis">
                                       <input type="text" name="remark" placeholder="Remark">
                                       <button type="submit">Update</button>
                                   </form>
                                   <form method="POST" action="delete-patient.jsp?id=<%= patient.getId() %>"
                                         onclick="return confirm('Are you sure you want to delete this patient?')">  
                                       <button type="submit">Delete</button>
                                   </form>  
                               </div>
                           </td>
                       </tr>
            <%     }
                   transaction.commit();
               } catch (Exception ex) {
                   if (transaction != null) {
                       transaction.rollback();
                   }
                   ex.printStackTrace();
               } finally {
                   session6.close();
               }
            %>
        </table>

        <div class="logout-button">
            <button onclick="location.href='adminlogin.jsp'">Logout</button>
        </div>

        <script>
     const vitalsData = [
         { date: '2023-06-04', bpHigh: 120, bpLow: 80, spO2: 98 },
         { date: '2023-06-04', bpHigh: 130, bpLow: 90, spO2: 95 },
         { date: '2023-06-04', bpHigh: 120, bpLow: 80, spO2: 98 },
       
     ];

     
     const dates = vitalsData.map(data => data.date);
     const bpHighValues = vitalsData.map(data => data.bpHigh);
     const bpLowValues = vitalsData.map(data => data.bpLow);
     const spO2Values = vitalsData.map(data => data.spO2);

     // Create a line graph using chart.js
     const ctx = document.getElementById('vitalsGraph').getContext('2d');
     new Chart(ctx, {
         type: 'line',
         data: {
             labels: dates,
             datasets: [
                 {
                     label: 'BP High',
                     data: bpHighValues,
                     borderColor: 'red',
                     fill: false
                 },
                 {
                     label: 'BP Low',
                     data: bpLowValues,
                     borderColor: 'blue',
                     fill: false
                 },
                 {
                     label: 'SP02',
                     data: spO2Values,
                     borderColor: 'green',
                     fill: false
                 }
             ]
         },
         options: {
             responsive: true,
             scales: {
                 x: {
                     display: true,
                     title: {
                         display: true,
                         text: 'Date'
                     }
                 },
                 y: {
                     display: true,
                     title: {
                         display: true,
                         text: 'Vital Value'
                     }
                 }
             }
         }
     });

        </script>
    </div>
</body>
</html>
