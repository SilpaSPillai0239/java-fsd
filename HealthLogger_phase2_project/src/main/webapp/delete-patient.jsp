<%@ page import="com.health.Patient" %>
<%@ page import="org.hibernate.*" %>
<%@ page import="com.simpli.HibernateUtil" %>

<%
    int patientId = Integer.parseInt(request.getParameter("id"));
    
    // Retrieve the patient from the database
    Session session3 = HibernateUtil.getSessionFactory().openSession();
    Transaction transaction = null;
    Patient patient = null;
    
    try {
        transaction = session3.beginTransaction();
        patient = session3.get(Patient.class, patientId);
        transaction.commit();
    } catch (Exception ex) {
        if (transaction != null) {
            transaction.rollback();
        }
        ex.printStackTrace();
    } finally {
        session3.close();
    }
    
    if (patient == null) {
        // Handle the case when the patient is not found
        response.sendRedirect("manage-patients.jsp?error=PatientNotFound");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Delete Patient</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <h1>Delete Patient</h1>
    
    <p>Are you sure you want to delete the patient with ID <%= patientId %>?</p>
    
    <form method="POST" action="delete-patient.jsp?id=<%= patientId %>">
        <input type="submit" value="Delete">
    </form>
    
    <%-- Process the form submission and delete the patient --%>
    <%
        if (request.getMethod().equals("POST")) {
            // Delete the patient from the database
            Session deleteSession = HibernateUtil.getSessionFactory().openSession();
            Transaction deleteTransaction = null;
            
            try {
                deleteTransaction = deleteSession.beginTransaction();
                Patient deletePatient = deleteSession.get(Patient.class, patientId);
                
                deleteSession.delete(deletePatient);
                deleteTransaction.commit();
                
                response.sendRedirect("manage-patients.jsp");
            } catch (Exception ex) {
                if (deleteTransaction != null) {
                    deleteTransaction.rollback();
                }
                ex.printStackTrace();
            } finally {
                deleteSession.close();
            }
        }
    %>
</body>
</html>
