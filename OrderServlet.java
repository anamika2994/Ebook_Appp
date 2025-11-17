package com.admin.servlet;

import com.DAO.OrderDAOImpl;
import com.DB.DBconnect;
import com.entity.Order;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class OrderServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
    
        
        System.out.println("=== ORDER SERVLET CALLED ===");
        
        try {
            OrderDAOImpl dao = new OrderDAOImpl(DBconnect.getConn());
            List<Order> orderList = dao.getAllOrders();
            
            System.out.println("Orders found in database: " + orderList.size());
            
            //HttpSession session = request.getSession();
            request.setAttribute("orderList", orderList);
            
            // FIX: Use forward instead of redirect to preserve path
            RequestDispatcher rd = request.getRequestDispatcher("order.jsp");
            rd.forward(request, response);
            
            
        } catch (Exception e) {
            System.out.println("Error in OrderServlet: " + e.getMessage());
            e.printStackTrace();
        }
    }
}