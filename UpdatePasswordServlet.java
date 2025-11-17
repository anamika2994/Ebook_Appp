package com.user.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import com.DAO.userDAOimpl;
import com.DB.DBconnect;
import com.entity.user;

public class UpdatePasswordServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession(); // Move outside try block

		try {
			user currentUser = (user) session.getAttribute("userobj");

			if (currentUser == null) {
				response.sendRedirect("login.jsp");
				return;
			}

			// Get form data
			String currentPassword = request.getParameter("currentPassword");
			String newPassword = request.getParameter("newPassword");
			String confirmPassword = request.getParameter("confirmPassword");

			// Validate current password
			userDAOimpl dao = new userDAOimpl(DBconnect.getConn());
			user verifiedUser = dao.login(currentUser.getEmail(), currentPassword);

			if (verifiedUser == null) {
				session.setAttribute("failedMsg", "Current password is incorrect!");
				response.sendRedirect("setting.jsp");
				return;
			}

			// Check if new passwords match
			if (!newPassword.equals(confirmPassword)) {
				session.setAttribute("failedMsg", "New passwords do not match!");
				response.sendRedirect("setting.jsp");
				return;
			}

			// Check password length
			if (newPassword.length() < 6) {
				session.setAttribute("failedMsg", "Password must be at least 6 characters long!");
				response.sendRedirect("setting.jsp");
				return;
			}

			// Update password
			boolean success = dao.updatePassword(currentUser.getUserid(), newPassword);

			if (success) {
				// Update session user object
				currentUser.setPassword(newPassword);
				session.setAttribute("userobj", currentUser);
				session.setAttribute("succMsg", "Password updated successfully!");
			} else {
				session.setAttribute("failedMsg", "Failed to update password!");
			}

			response.sendRedirect("setting.jsp");

		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("failedMsg", "Server error: " + e.getMessage());
			response.sendRedirect("setting.jsp");
		}
	}
}