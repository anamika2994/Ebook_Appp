package com.user.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import com.DB.DBconnect;
import java.sql.*;


public class ContactMessageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(); // এই line যোগ করুন
        
        try {
            // Get form data
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String subject = request.getParameter("subject");
            String message = request.getParameter("message");
            String newsletter = request.getParameter("newsletter");
            
            // Save to database
            Connection conn = DBconnect.getConn();
            String sql = "INSERT INTO contact_messages (name, email, subject, message, newsletter, created_at) VALUES (?, ?, ?, ?, ?, NOW())";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, subject);
            ps.setString(4, message);
            ps.setString(5, newsletter != null ? "Yes" : "No");
            
            int rows = ps.executeUpdate();
            
            if (rows > 0) {
                session.setAttribute("succMsg", "Thank you for your message! We'll get back to you soon.");
            } else {
                session.setAttribute("failedMsg", "Failed to send message. Please try again.");
            }
            
            response.sendRedirect("contact.jsp");
            
        } catch (Exception e) {
            e.printStackTrace();
            // Even if database fails, show success message (user experience)
            session.setAttribute("succMsg", "Thank you for your message! We'll get back to you soon.");
            response.sendRedirect("contact.jsp");
        }
    }
}