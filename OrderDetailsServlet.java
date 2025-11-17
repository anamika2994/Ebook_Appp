package com.admin.servlet;

import com.DAO.OrderDAOImpl;
import com.DB.DBconnect;
import com.entity.Order;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

public class OrderDetailsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        
        try {
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            
            OrderDAOImpl dao = new OrderDAOImpl(DBconnect.getConn());
            Order order = dao.getOrderById(orderId);
            
            if (order != null) {
                out.println("<div class='order-details'>");
                out.println("<h4>Order Details - " + order.getOrderId() + "</h4>");
                out.println("<table class='table table-bordered'>");
                out.println("<tr><th>Order ID:</th><td>" + order.getOrderId() + "</td></tr>");
                out.println("<tr><th>Customer Name:</th><td>" + order.getCustomerName() + "</td></tr>");
                out.println("<tr><th>Email:</th><td>" + order.getCustomerEmail() + "</td></tr>");
                out.println("<tr><th>Amount:</th><td>৳" + order.getAmount() + "</td></tr>");
                out.println("<tr><th>Payment Method:</th><td>" + order.getPaymentMethod() + "</td></tr>");
                out.println("<tr><th>Status:</th><td>" + order.getPaymentStatus() + "</td></tr>");
                out.println("<tr><th>Transaction ID:</th><td>" + 
                    (order.getTransactionId() != null ? order.getTransactionId() : "N/A") + "</td></tr>");
                out.println("<tr><th>Phone:</th><td>" + 
                    (order.getPhoneNumber() != null ? order.getPhoneNumber() : "N/A") + "</td></tr>");
                out.println("<tr><th>Order Date:</th><td>" + order.getCreatedAt() + "</td></tr>");
                out.println("</table>");
                out.println("</div>");
            } else {
                out.println("<div class='alert alert-warning'>Order not found!</div>");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<div class='alert alert-danger'>Error loading order details: " + e.getMessage() + "</div>");
        }
    }
}