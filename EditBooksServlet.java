package com.admin.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import com.DAO.BookDAOimpl;
import com.DB.DBconnect;
import com.entity.BookDtls;


public class EditBooksServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(req.getParameter("id"));
            String bookName = req.getParameter("bname");
            String author = req.getParameter("author");
            String price = req.getParameter("price");
            String status = req.getParameter("status");

            BookDtls b = new BookDtls();
            b.setId(id);
            b.setBookName(bookName);
            b.setAuthor(author);
            b.setPrice(price);
            b.setStatus(status);

            BookDAOimpl dao = new BookDAOimpl(DBconnect.getConn());
            boolean f = dao.updateEditBooks(b);

            HttpSession session = req.getSession();

            if (f) {
                session.setAttribute("succMsg", "Book Update Successfully.");
                resp.sendRedirect("admin/all_book.jsp");
            } else {
                session.setAttribute("failedMsg", "Something wrong on server");
                resp.sendRedirect("admin/all_book.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}