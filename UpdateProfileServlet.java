package com.user.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import com.DAO.userDAOimpl;
import com.DB.DBconnect;
import com.entity.user;


public class UpdateProfileServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
	        throws ServletException, IOException {
	    
	    HttpSession session = request.getSession();
	    
	    try {
	        user currentUser = (user) session.getAttribute("userobj");
	        
	        if (currentUser == null) {
	            response.sendRedirect("login.jsp");
	            return;
	        }
	        
	        // Get form data
	        String name = request.getParameter("name");
	        String phno = request.getParameter("phno");
	        String address = request.getParameter("address");
	        String city = request.getParameter("city");
	        String state = request.getParameter("state");
	        String pincode = request.getParameter("pincode");
	        
	        System.out.println("=== Form Data ===");
	        System.out.println("Name: " + name);
	        System.out.println("Phone: " + phno);
	        System.out.println("Address: " + address);
	        System.out.println("City: " + city);
	        System.out.println("State: " + state);
	        System.out.println("Pincode: " + pincode);
	        
	        // Create updated user object
	        user updatedUser = new user();
	        updatedUser.setUserid(currentUser.getUserid());
	        updatedUser.setName(name);
	        updatedUser.setEmail(currentUser.getEmail());
	        updatedUser.setPhno(phno);
	        updatedUser.setPassword(currentUser.getPassword());
	        updatedUser.setAddress(address);
	        updatedUser.setLandmark(currentUser.getLandmark());
	        updatedUser.setCity(city);
	        updatedUser.setState(state);
	        updatedUser.setPincode(pincode);
	        
	        // Update in database
	        userDAOimpl dao = new userDAOimpl(DBconnect.getConn());
	        boolean success = dao.updateUser(updatedUser);
	        
	        if (success) {
	            // Update session with new user data
	            session.setAttribute("userobj", updatedUser);
	            session.setAttribute("succMsg", "Profile updated successfully!");
	            System.out.println("Profile update SUCCESS");
	        } else {
	            session.setAttribute("failedMsg", "Failed to update profile!");
	            System.out.println("Profile update FAILED");
	        }
	        
	        response.sendRedirect("setting.jsp");
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        session.setAttribute("failedMsg", "Server error: " + e.getMessage());
	        response.sendRedirect("setting.jsp");
	    }
	}}