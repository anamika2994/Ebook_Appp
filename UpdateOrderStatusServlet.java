package com.admin.servlet;

import com.DAO.OrderDAOImpl;
import com.DB.DBconnect;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

public class UpdateOrderStatusServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        
        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String status = request.getParameter("status");
            
            OrderDAOImpl dao = new OrderDAOImpl(DBconnect.getConn());
            boolean success = dao.updateOrderStatus(orderId, status);
            
            if (success) {
                out.println("{\"success\": true, \"message\": \"Order status updated successfully!\"}");
            } else {
                out.println("{\"success\": false, \"message\": \"Failed to update order status!\"}");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            out.println("{\"success\": false, \"message\": \"Error: " + e.getMessage() + "\"}");
        }
    }
}