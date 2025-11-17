package com.user.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.*;
import com.DAO.UserBooksDAOImpl;
import com.DB.DBconnect;
import com.entity.user;


public class UserNotesServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            HttpSession session = request.getSession();
            user userObj = (user) session.getAttribute("userobj");
            
            if (userObj == null) {
                response.sendRedirect("login.jsp");
                return;
            }
            
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            String notes = request.getParameter("userNotes");
            
            UserBooksDAOImpl userBooksDAO = new UserBooksDAOImpl(DBconnect.getConn());
            boolean success = userBooksDAO.updateUserNotes(userObj.getUserid(), bookId, notes);
            
            if (success) {
                session.setAttribute("succMsg", "Notes saved successfully!");
            } else {
                session.setAttribute("failedMsg", "Failed to save notes!");
            }
            
            response.sendRedirect("read_book.jsp?bookId=" + bookId);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}