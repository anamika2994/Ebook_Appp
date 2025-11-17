package com.admin.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import com.DAO.BookDAOimpl;
import com.DB.DBconnect;

public class BooksDeleteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            BookDAOimpl dao = new BookDAOimpl(DBconnect.getConn());
            boolean f = dao.deleteBooks(id);

            HttpSession session = req.getSession();

            if (f) {
                session.setAttribute("succMsg", "Book deleted successfully!");
                resp.sendRedirect("admin/all_book.jsp");
            } else {
                session.setAttribute("failedMsg", "Something went wrong on server!");
                resp.sendRedirect("admin/all_book.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}