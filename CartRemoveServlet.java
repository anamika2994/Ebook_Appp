package com.user.servlet;

import com.DAO.CartDAOimpl;
import com.DB.DBconnect;
import com.entity.user;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class CartRemoveServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            HttpSession session = request.getSession();
            
            // সেশন থেকে user object নিন - "userobj" নামেই stored আছে
            user u = (user) session.getAttribute("userobj");
            
            if (u != null) {
                int userId = u.getUserid(); // user object থেকে userid নিন
                CartDAOimpl dao = new CartDAOimpl(DBconnect.getConn());
                boolean removed = dao.removeCartItem(userId, bookId);

                if (removed) {
                    session.setAttribute("succMsg", "Book removed from cart successfully!");
                } else {
                    session.setAttribute("failedMsg", "Failed to remove book from cart!");
                }
            } else {
                session.setAttribute("failedMsg", "Please login first!");
                response.sendRedirect("login.jsp");
                return;
            }
            
            response.sendRedirect("cart.jsp");
            
        } catch (Exception e) {
            e.printStackTrace();
            HttpSession session = request.getSession();
            session.setAttribute("failedMsg", "Something went wrong: " + e.getMessage());
            response.sendRedirect("cart.jsp");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}