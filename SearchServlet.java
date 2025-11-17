package com.user.servlet;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.DAO.BookDAOimpl;
import com.DB.DBconnect;
import com.entity.BookDtls;

public class SearchServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			String query = request.getParameter("query");

			if (query != null && !query.trim().isEmpty()) {
				BookDAOimpl dao = new BookDAOimpl(DBconnect.getConn());
				List<BookDtls> searchResults = dao.getBookBySerch(query.trim());

				HttpSession session = request.getSession();
				session.setAttribute("searchResults", searchResults);
				session.setAttribute("searchQuery", query);

				response.sendRedirect("search_results.jsp");
			} else {
				// If search query is empty, redirect to home
				response.sendRedirect("index.jsp");
			}

		} catch (Exception e) {
			e.printStackTrace();
			response.sendRedirect("error.jsp");
		}
	}

	private void handleSearch(HttpServletRequest request, HttpServletResponse response) 
	        throws ServletException, IOException {
	    
	    try {
	        String query = request.getParameter("query");
	        
	        if (query != null && !query.trim().isEmpty()) {
	            BookDAOimpl dao = new BookDAOimpl(DBconnect.getConn());
	            List<BookDtls> searchResults = dao.getBookBySerch(query.trim());
	            
	            HttpSession session = request.getSession();
	            session.setAttribute("searchResults", searchResults);
	            session.setAttribute("searchQuery", query);
	            
	            response.sendRedirect("search_results.jsp");
	        } else {
	            response.sendRedirect("index.jsp");
	        }
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        response.sendRedirect("error.jsp");
	    }
	}
}