package com.user.servlet;

import com.DAO.RatingDAOImpl;
import com.DB.DBconnect;
import com.entity.BookRating;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class RatingServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            int ratingValue = Integer.parseInt(request.getParameter("rating"));
            String review = request.getParameter("review");
            
            HttpSession session = request.getSession();
            com.entity.user user = (com.entity.user) session.getAttribute("userobj");
            
            if (user != null) {
                RatingDAOImpl dao = new RatingDAOImpl(DBconnect.getConn());
                
                // Check if user already rated this book
                BookRating existingRating = dao.getRatingByUserAndBook(user.getUserid(), bookId);
                
                boolean success;
                if (existingRating != null) {
                    // Update existing rating
                    existingRating.setRating(ratingValue);
                    existingRating.setReviewText(review);
                    success = dao.updateRating(existingRating);
                    session.setAttribute("succMsg", "Rating updated successfully!");
                } else {
                    // Add new rating
                    BookRating newRating = new BookRating(user.getUserid(), bookId, ratingValue);
                    newRating.setReviewText(review);
                    success = dao.addRating(newRating);
                    session.setAttribute("succMsg", "Rating submitted successfully!");
                }
                
                if (!success) {
                    session.setAttribute("failedMsg", "Failed to submit rating!");
                }
                
            } else {
                session.setAttribute("failedMsg", "Please login to rate books!");
            }
            
            response.sendRedirect("details_book.jsp?bookId=" + bookId);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}