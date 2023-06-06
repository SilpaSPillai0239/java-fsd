<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
    <style>
        body {
            font-family: Times new roman, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }

        .center {
            text-align: center;
            margin-top: 100px;
        }

        h1 {
            color: #333;
        }

        button {
            padding: 10px 20px;
            font-size: 16px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        button:hover {
            background-color: #45a049;
        }

        form {
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
<div class="center">
    <h1>Welcome to Doctor Dashboard</h1>
    <form action="manage-patients.jsp" method="post">
       <button style="margin:5px;">Manage Patients</button>
       </form>
        
       <form action="manage-vitals.jsp" method="post">
       <button style="margin:5px;">Manage Vitals</button>
       </form>
        </div>
       
   
</body>
</html>

