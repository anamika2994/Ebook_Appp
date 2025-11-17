package com.user.servlet;

import jakarta.servlet.http.HttpServlet; 
import jakarta.servlet.http.HttpServletRequest; 
import jakarta.servlet.http.HttpServletResponse; 
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.ServletException; 
import java.io.IOException;

public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            HttpSession session = req.getSession(false);
            if (session != null) {
                session.removeAttribute("userobj");
                session.setAttribute("succMsg", "Logout Successfully");
            }

            // check from where the logout came
            String path = req.getRequestURI();

            if (path.contains("/admin/")) {
                // admin panel থেকে logout করলে
                resp.sendRedirect("../login.jsp");
            } else {
                // সাধারণ user logout করলে
                resp.sendRedirect("login.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
