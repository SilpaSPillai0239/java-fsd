<%@ page import="org.hibernate.Session" %>
<%@ page import="org.hibernate.query.Query" %>
<%@ page import="com.simpli.HibernateUtil" %>
<%@ page import="com.health.Vital" %>
<%@ page import="java.util.List" %>

<%
    // Fetch the vital data for the patient using Hibernate
    try {
        // Retrieve the vital data for the patient
        Session hibernateSession = HibernateUtil.getSessionFactory().openSession();
        Query<Vital> query = hibernateSession.createQuery("FROM Vital WHERE patientId = :patientId", Vital.class);
        query.setParameter("patientId", 1);
        List<Vital> vitals = query.list();
        hibernateSession.close();

        // Convert the vital data to JSON format
        String jsonData = "[";
        for (int i = 0; i < vitals.size(); i++) {
            Vital vital = vitals.get(i);
            String date = vital.getRecordedTime();
            double bplow = vital.getBpLow();

            // Create JSON object
            String jsonEntry = String.format("{\"recordedtime\":\"%s\", \"bplow\":%.2f}", date, bplow);
            jsonData += jsonEntry;

            // Add comma if not the last entry
            if (i < vitals.size() - 1) {
                jsonData += ",";
            }
        }
        jsonData += "]";

        // Set response content type as JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Send JSON data back as the response
        response.getWriter().write(jsonData);

    } catch (Exception e) {
        e.printStackTrace();
        response.setStatus(500); // Internal Server Error
    }
%>
