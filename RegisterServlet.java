package com.user.servlet;

import java.io.IOException;

import com.DAO.userDAOimpl;
import com.DB.DBconnect;
import com.entity.user;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            System.out.println("=== RegisterServlet called ===");

            String name = req.getParameter("fname");
            String email = req.getParameter("email");
            String phno = req.getParameter("phno");
            String password = req.getParameter("password");
            String check = req.getParameter("check");

            user us = new user();
            us.setName(name);
            us.setEmail(email);
            us.setPhno(phno);
            us.setPassword(password);

            HttpSession session = req.getSession();

            if (check != null) {
                userDAOimpl dao = new userDAOimpl(DBconnect.getConn());
                boolean f2=dao.checkUser(email);
                if(f2)
                {
                    boolean f=dao.userRegister(us);

                    if(f)
                    {
                        //System.out.println("User Register Success..");
                        session.setAttribute("succMsg", "Registration Successfully..");
                        resp.sendRedirect("login.jsp");
                    }
                    else
                    {
                        //System.out.println("Something wrong on server..");
                        session.setAttribute("failedMsg", "Something wrong on server..");
                        resp.sendRedirect("register.jsp");
                    }
                }
                else // This 'else' block matches the 'if(f2)' at the top
                {
                    session.setAttribute("failedMsg", "User Already Exist Try Another Email id");
                    resp.sendRedirect("register.jsp");
                }
                //... code continues below (partially cut off)
            } else {
                session.setAttribute("failedMsg", "Please agree to the terms and conditions");
                resp.sendRedirect("register.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
