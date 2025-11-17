package com.user.servlet;

import com.DAO.BookDAOimpl;
import com.DAO.RatingDAOImpl;
import com.DB.DBconnect;
import com.entity.BookDtls;
import com.entity.BookRating;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

public class BookDetailsServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            
            BookDAOimpl dao = new BookDAOimpl(DBconnect.getConn());
            BookDtls b = dao.getBookById(bookId);
            
            if (b != null) {
                // Rating related data load
                RatingDAOImpl ratingDao = new RatingDAOImpl(DBconnect.getConn());
                
                // Average rating
                double averageRating = ratingDao.getAverageRating(bookId);
                // Rating count
                int ratingCount = ratingDao.getRatingCount(bookId);
                // All reviews
                List<BookRating> reviews = ratingDao.getRatingsByBook(bookId);
                
                // User's existing rating (if logged in)
                HttpSession session = request.getSession();
                com.entity.user user = (com.entity.user) session.getAttribute("userobj");
                BookRating userRating = null;
                
                if (user != null) {
                    userRating = ratingDao.getRatingByUserAndBook(user.getUserid(), bookId);
                }
                
                // Set attributes
                request.setAttribute("b", b);
                request.setAttribute("averageRating", Math.round(averageRating * 10.0) / 10.0); // Round to 1 decimal
                request.setAttribute("ratingCount", ratingCount);
                request.setAttribute("reviews", reviews);
                request.setAttribute("userRating", userRating);
                
                RequestDispatcher rd = request.getRequestDispatcher("book_details.jsp");
                rd.forward(request, response);
            } else {
                HttpSession session = request.getSession();
                session.setAttribute("failedMsg", "Book not found!");
                response.sendRedirect("index.jsp");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            HttpSession session = request.getSession();
            session.setAttribute("failedMsg", "Something went wrong!");
            response.sendRedirect("index.jsp");
        }
    }
}