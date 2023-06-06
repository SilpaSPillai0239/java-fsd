<%@ page import="java.io.*, java.sql.*" %>
<%@ page contentType="text/csv" %>
<%@ page import="com.health.Vital" %>
<%@ page import="com.health.Patient" %>

<%
    // Get the patient ID from the request
    //int patientId = Integer.parseInt(request.getParameter("patientid"));
String patientIdParam = request.getParameter("patientid");
int patientId = 0;
if (patientIdParam != null && !patientIdParam.isEmpty()) {
    try {
        patientId = Integer.parseInt(patientIdParam);
    } catch (NumberFormatException e) {
        out.println("<h2>Error Occurred!</h2>");
        out.println("<p>Invalid patient ID format: " + patientIdParam + "</p>");
        return; // Stop further processing
    }
} else {
    out.println("<h2>Error Occurred!</h2>");
    out.println("<p>Missing patient ID parameter.</p>");
    return; // Stop further processing
}
    // Establish the database connection
    Connection conn = null;
    Statement statement = null;
    ResultSet resultSet = null;
    PrintWriter out1 = response.getWriter();

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost/health", "root", "silpa23");
        statement = conn.createStatement();

        // Prepare the SQL statement
        String sql = "SELECT * FROM vitals WHERE patientid = " + patientId;
        resultSet = statement.executeQuery(sql);

        // Set the response headers for CSV file
        response.setHeader("Content-Disposition", "attachment; filename=\"patient_" + patientIdParam + "_logs.csv\"");
        response.setContentType("text/csv");

        // Create a writer for CSV file
        PrintWriter writer = response.getWriter();

        // Write the CSV header
        writer.println("Serial Number, Patient ID, Name, Phone, BP Low, BP High, SPO2, Recorded Live Time");

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

            // Write the CSV record
            writer.println(count + "," + patientid + "," + name + "," + phone + "," + bplow + "," + bphigh + "," + spo2 + "," + recordedtime);
            count++;
        }

        // Close the writer and flush the response
        writer.close();
        response.flushBuffer();
    } catch (Exception e) {
        out.println("<h2>Error Occurred!</h2>");
        out.println("<p>An error occurred while exporting data: " + e.getMessage() + "</p>");
    } finally {
        // Close the connections
        if (resultSet != null) {
            resultSet.close();
        }
        if (statement != null) {
            statement.close();
        }
        if (conn != null) {
            conn.close();
        }
    }
%>
