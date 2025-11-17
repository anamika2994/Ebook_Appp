package com.user.servlet;
import jakarta.servlet.http.HttpServlet; 

import jakarta.servlet.http.HttpServletRequest; 
import jakarta.servlet.http.HttpServletResponse; 
import jakarta.servlet.http.HttpSession;

import jakarta.servlet.ServletException; 
import jakarta.servlet.annotation.WebServlet;
import java.io.IOException;

import com.DB.DBconnect;
import com.DAO.userDAOimpl;
import com.entity.user;

public class LoginServlet extends HttpServlet {

	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		 try {
			    userDAOimpl dao=new userDAOimpl(DBconnect.getConn());
			    HttpSession session = req.getSession();
	            String email = req.getParameter("email");
	            String password = req.getParameter("password");

	            if ("admin@gmail.com".equals(email) && "admin".equals(password)) {
	            	user us = new user();
	            	us.setName("Admin");
	            	session.setAttribute("userobj", us);
	                resp.sendRedirect("admin/Home.jsp");
	            } else {
	            	 user us = dao.login(email, password);
	            	    if (us != null) {
	            	        session.setAttribute("userobj", us);
	            	        resp.sendRedirect("index.jsp");
	            	    } else {
	            	        session.setAttribute("failedMsg", "Email & Password Invalid");
	            	        resp.sendRedirect("login.jsp");
	            	    }
	            	}
	                
	            
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
	
}

	

