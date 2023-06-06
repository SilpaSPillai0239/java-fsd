<%@ page import="com.health.Patient" %>
<%@ page import="org.hibernate.*" %>
<%@ page import="com.simpli.HibernateUtil" %>

<%
    int patientId = Integer.parseInt(request.getParameter("id"));
    
    // Retrieve the patient from the database
    Session session2 = HibernateUtil.getSessionFactory().openSession();
    Transaction transaction = null;
    Patient patient = null;
    
    try {
        transaction = session2.beginTransaction();
        patient = session2.get(Patient.class, patientId);
        transaction.commit();
    } catch (Exception ex) {
        if (transaction != null) {
            transaction.rollback();
        }
        ex.printStackTrace();
    } finally {
        session2.close();
    }
    
    if (patient == null) {
    	response.sendRedirect("manage-patients.jsp?error=PatientNotFound");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Update Patient</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
    <h1>Update Patient</h1>
    
    <form method="POST" action="update-patient.jsp?id=<%= patientId %>">
        <label for="diagnosis">Diagnosis:</label>
        <input type="text" id="diagnosis" name="diagnosis" value="<%= patient.getDiagnosis() %>"><br><br>
        
        <label for="remark">Remark:</label>
        <input type="text" id="remark" name="remark" value="<%= patient.getRemark() %>"><br><br>
        
        <input type="submit" value="Update">
    </form>
    
    <%-- Process the form submission and update the patient --%>
    <%
        if (request.getMethod().equals("POST")) {
            String diagnosis = request.getParameter("diagnosis");
            String remark = request.getParameter("remark");
            
            // Update the patient details in the database
            Session updateSession = HibernateUtil.getSessionFactory().openSession();
            Transaction updateTransaction = null;
            
            try {
                updateTransaction = updateSession.beginTransaction();
                Patient updatedPatient = updateSession.get(Patient.class, patientId);
                
                updatedPatient.setDiagnosis(diagnosis);
                updatedPatient.setRemark(remark);
                
                updateSession.update(updatedPatient);
                updateTransaction.commit();
                
                response.sendRedirect("manage-patients.jsp");
            } catch (Exception ex) {
                if (updateTransaction != null) {
                    updateTransaction.rollback();
                }
                ex.printStackTrace();
            } finally {
                updateSession.close();
            }
        }
    %>
</body>
</html>
