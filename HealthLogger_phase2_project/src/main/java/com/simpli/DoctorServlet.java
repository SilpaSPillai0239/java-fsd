package com.simpli;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;


import org.hibernate.*;
import com.health.Doctor;

@WebServlet("/login")
public class DoctorServlet extends HttpServlet {
    private SessionFactory sessionFactory;

    public void init() throws ServletException {
        // Create the Hibernate SessionFactory
        sessionFactory = HibernateUtil.getSessionFactory();
    }

    @SuppressWarnings("deprecation")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Session session = sessionFactory.openSession();
        Transaction transaction = null;
        Doctor doctor = null;
        try {
            transaction = session.beginTransaction();
            Query<Doctor> query = session.createQuery("FROM Doctor WHERE email = :email AND password = :password", Doctor.class);
            query.setParameter("email", email);
            query.setParameter("password", password);
            doctor = query.uniqueResult();
            transaction.commit();
        } catch (Exception ex) {
            if (transaction != null) {
                transaction.rollback();
            }
            ex.printStackTrace();
        } finally {
            session.close();
        }

        if (doctor != null) {
            HttpSession httpSession = request.getSession();
            httpSession.setAttribute("doctor", doctor);
            response.sendRedirect("admindashboard.jsp");
        } else {
            response.sendRedirect("adminlogin.jsp?error=true");
        }
    }

    public void destroy() {
        // Close the Hibernate SessionFactory
        sessionFactory.close();
    }
}
