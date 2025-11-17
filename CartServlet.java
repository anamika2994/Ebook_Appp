package com.user.servlet;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.ServletException;

import java.io.IOException;

import com.DAO.BookDAOimpl;
import com.DAO.CartDAOimpl;
import com.DB.DBconnect;
import com.entity.BookDtls;
import com.entity.Cart;

public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int bid = Integer.parseInt(req.getParameter("bid"));
            int uid = Integer.parseInt(req.getParameter("uid"));

            // Fetch book details
            BookDAOimpl dao = new BookDAOimpl(DBconnect.getConn());
            BookDtls b = dao.getBookById(bid);

            // Prepare Cart object
            Cart c = new Cart();
            c.setBid(bid);
            c.setUserId(uid);
            c.setBookName(b.getBookName());
            c.setAuthor(b.getAuthor());
            c.setPrice(Double.parseDouble(b.getPrice()));
            c.setTotalPrice(Double.parseDouble(b.getPrice()));

            // Add to Cart
            CartDAOimpl cartDao = new CartDAOimpl(DBconnect.getConn());
            boolean f = cartDao.addCart(c);

            HttpSession session = req.getSession();
            if (f) {
                session.setAttribute("addCart", "Book Added to Cart Successfully");
            } else {
                session.setAttribute("failed", "Something went wrong while adding book to cart");
            }

            // Redirect based on category
            String category = b.getBookCategory();
            String redirectPage = "all_fictionbook.jsp";

            if ("Non-Fiction".equalsIgnoreCase(category)) redirectPage = "all_nonfictionbook.jsp";
            else if ("Educational".equalsIgnoreCase(category)) redirectPage = "all_Educationalbook.jsp";
            else if ("Professional".equalsIgnoreCase(category)) redirectPage = "all_profesionalbook.jsp";
            else if ("Children".equalsIgnoreCase(category)) redirectPage = "all_childbook.jsp";
            else if ("Comics".equalsIgnoreCase(category)) redirectPage = "all_comiesbook.jsp";

            resp.sendRedirect(redirectPage);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
