<%@page import="com.entity.user"%>
<%@page import="com.DAO.UserBooksDAOImpl"%>
<%@page import="com.entity.UserBooks"%>
<%@page import="java.util.List"%>
<%@page import="com.DB.DBconnect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Dashboard</title>
<%@include file="allcomponent/allCSS.jsp"%>
<style>
.dashboard-card {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    border-radius: 15px;
    padding: 25px;
    margin-bottom: 25px;
    box-shadow: 0 10px 20px rgba(0,0,0,0.2);
}

.book-card {
    border: none;
    border-radius: 12px;
    transition: all 0.3s ease;
    box-shadow: 0 5px 15px rgba(0,0,0,0.1);
}

.book-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 25px rgba(0,0,0,0.2);
}

.notes-preview {
    background: #f8f9fa;
    border-left: 4px solid #007bff;
    padding: 10px;
    border-radius: 5px;
    font-style: italic;
    max-height: 80px;
    overflow: hidden;
}
</style>
</head>
<body style="background-color: #f8f9fa;">
    <%@include file="allcomponent/Navber.jsp"%>

    <c:if test="${empty userobj}">
        <c:redirect url="login.jsp" />
    </c:if>

    <div class="container mt-4">
        <!-- User Profile Card -->
        <div class="dashboard-card text-center">
            <div class="row">
                <div class="col-md-8">
                    <h2><i class="fas fa-user-circle"></i> Welcome, ${userobj.name}</h2>
                    <p class="mb-1"><i class="fas fa-envelope"></i> ${userobj.email}</p>
                    <p class="mb-0"><i class="fas fa-phone"></i> ${userobj.phno}</p>
                </div>
                <div class="col-md-4 text-right">
                    <div class="bg-white text-dark p-3 rounded">
                        <h4>My Library</h4>
                        <%
                            UserBooksDAOImpl ubDao = new UserBooksDAOImpl(DBconnect.getConn());
                            user u = (user) session.getAttribute("userobj");
                            List<UserBooks> userBooks = ubDao.getUserBooksByUserId(u.getUserid());
                        %>
                        <h2><%= userBooks.size() %></h2>
                        <p>Books Purchased</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Purchased Books Section -->
        <div class="card">
            <div class="card-header bg-primary text-white">
                <h4 class="mb-0"><i class="fas fa-book"></i> My Purchased Books</h4>
            </div>
            <div class="card-body">
                <%
                    if (userBooks.isEmpty()) {
                %>
                    <div class="text-center py-5">
                        <i class="fas fa-book-open fa-3x text-muted mb-3"></i>
                        <h4 class="text-muted">No Books Purchased Yet</h4>
                        <p>Start building your digital library!</p>
                        <a href="index.jsp" class="btn btn-primary">Browse Books</a>
                    </div>
                <%
                    } else {
                %>
                <div class="row">
                    <%
                        for (UserBooks ub : userBooks) {
                    %>
                    <div class="col-md-4 mb-4">
                        <div class="card book-card h-100">
                            <div class="card-body">
                                <h5 class="card-title"><%= ub.getBookName() %></h5>
                                <p class="card-text text-muted">
                                    <i class="fas fa-user"></i> <%= ub.getAuthor() %>
                                </p>
                                
                                <!-- Notes Preview -->
                                <div class="notes-preview mb-3">
                                    <small>
                                        <%
                                            String notes = ub.getUserNotes();
                                            if (notes != null && !notes.trim().isEmpty()) {
                                                out.print(notes.length() > 100 ? 
                                                    notes.substring(0, 100) + "..." : notes);
                                            } else {
                                                out.print("No notes yet. Click 'Read Book' to add notes.");
                                            }
                                        %>
                                    </small>
                                </div>

                                <!-- Action Buttons -->
                                <div class="d-grid gap-2">
                                    <a href="read_book.jsp?bookId=<%= ub.getBookId() %>" 
                                       class="btn btn-primary btn-sm">
                                        <i class="fas fa-book-reader"></i> Read Book
                                    </a>
                                    <a href="downloadPDF?bookId=<%= ub.getBookId() %>" 
                                       class="btn btn-success btn-sm">
                                        <i class="fas fa-download"></i> Download PDF
                                    </a>
                                </div>
                            </div>
                            <div class="card-footer bg-transparent">
                                <small class="text-muted">
                                    Purchased: <%= ub.getPurchaseDate() != null ? 
                                        ub.getPurchaseDate().toString().substring(0, 10) : "Recently" %>
                                </small>
                            </div>
                        </div>
                    </div>
                    <%
                        }
                    %>
                </div>
                <%
                    }
                %>
            </div>
        </div>
    </div>
<%@include file="allcomponent/Footer.jsp"%>
    
</body>
</html>