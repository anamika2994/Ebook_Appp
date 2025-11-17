<%@page import="com.entity.user"%>
<%@page import="com.DAO.BookDAOimpl"%>
<%@page import="com.DAO.UserBooksDAOImpl"%>
<%@page import="com.entity.BookDtls"%>
<%@page import="com.entity.UserBooks"%>
<%@page import="com.DB.DBconnect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Read Book</title>
<%@include file="allcomponent/allCSS.jsp"%>
<style>
.reader-container {
    background: #fff;
    border-radius: 10px;
    box-shadow: 0 0 20px rgba(0,0,0,0.1);
    margin-top: 20px;
}

.pdf-viewer {
    height: 600px;
    border: 1px solid #ddd;
    border-radius: 5px;
}

.notes-container {
    background: #f8f9fa;
    border-radius: 10px;
    padding: 20px;
    height: 600px;
    display: flex;
    flex-direction: column;
}

.notes-header {
    border-bottom: 2px solid #007bff;
    padding-bottom: 10px;
    margin-bottom: 15px;
}

.notes-textarea {
    flex: 1;
    border: 1px solid #ddd;
    border-radius: 5px;
    padding: 15px;
    resize: none;
    font-family: 'Courier New', monospace;
    background: white;
}

.action-buttons {
    margin-top: 15px;
}

.book-info-card {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    border-radius: 10px;
    padding: 20px;
    margin-bottom: 20px;
}
</style>
</head>
<body style="background-color: #f5f5f5;">
    <%@include file="allcomponent/Navber.jsp"%>

    <c:if test="${empty userobj}">
        <c:redirect url="login.jsp" />
    </c:if>

    <%
        String bookIdStr = request.getParameter("bookId");
        BookDtls book = null;
        UserBooks userBook = null;
        String userNotes = "";
        
        if (bookIdStr != null) {
            int bookId = Integer.parseInt(bookIdStr);
            BookDAOimpl bookDAO = new BookDAOimpl(DBconnect.getConn());
            book = bookDAO.getBookById(bookId);
            
            user u = (user) session.getAttribute("userobj");
            UserBooksDAOImpl ubDAO = new UserBooksDAOImpl(DBconnect.getConn());
            userBook = ubDAO.getUserBook(u.getUserid(), bookId);
            
            if (userBook != null) {
                userNotes = userBook.getUserNotes() != null ? userBook.getUserNotes() : "";
            }
        }
    %>

    <div class="container">
        <!-- Success/Error Messages -->
        <c:if test="${not empty succMsg}">
            <div class="alert alert-success alert-dismissible fade show mt-3" role="alert">
                ${succMsg}
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <c:remove var="succMsg" scope="session" />
        </c:if>

        <c:if test="${not empty failedMsg}">
            <div class="alert alert-danger alert-dismissible fade show mt-3" role="alert">
                ${failedMsg}
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <c:remove var="failedMsg" scope="session" />
        </c:if>

        <% if (book != null) { %>
            <!-- Book Info Card -->
            <div class="book-info-card">
                <div class="row">
                    <div class="col-md-8">
                        <h3><i class="fas fa-book"></i> <%= book.getBookName() %></h3>
                        <p class="mb-1"><i class="fas fa-user"></i> <%= book.getAuthor() %></p>
                        <p class="mb-0"><i class="fas fa-tags"></i> <%= book.getBookCategory() %></p>
                    </div>
                    <div class="col-md-4 text-right">
                        <a href="downloadPDF?bookId=<%= book.getId() %>" 
                           class="btn btn-light btn-lg">
                            <i class="fas fa-download"></i> Download PDF
                        </a>
                    </div>
                </div>
            </div>

            <!-- PDF Reader + Notepad -->
            <div class="row reader-container p-4">
                <!-- PDF Viewer -->
                <div class="col-md-8">
                    <div class="pdf-viewer">
                        <%
                            if (book.getPdfFile() != null && !book.getPdfFile().isEmpty()) {
                        %>
                            <iframe src="pdf/<%= book.getPdfFile() %>" 
                                    width="100%" height="100%" 
                                    style="border: none;">
                                Your browser does not support PDF viewing. 
                                Please <a href="downloadPDF?bookId=<%= book.getId() %>">download the PDF</a>.
                            </iframe>
                        <%
                            } else {
                        %>
                            <div class="d-flex justify-content-center align-items-center h-100">
                                <div class="text-center">
                                    <i class="fas fa-file-pdf fa-4x text-muted mb-3"></i>
                                    <h4 class="text-muted">PDF Not Available</h4>
                                    <p>This book doesn't have a PDF version yet.</p>
                                </div>
                            </div>
                        <%
                            }
                        %>
                    </div>
                </div>

                <!-- Notepad Section -->
                <div class="col-md-4">
                    <div class="notes-container">
                        <div class="notes-header">
                            <h4><i class="fas fa-sticky-note"></i> My Notes</h4>
                            <small class="text-muted">Your personal notes for this book</small>
                        </div>
                        
                        <form action="saveNotes" method="post">
                            <input type="hidden" name="bookId" value="<%= book.getId() %>">
                            <textarea name="userNotes" class="notes-textarea" 
                                      placeholder="Write your notes here... You can add:
• Key points
• Important quotes  
• Personal reflections
• Questions to research
                                      
Your notes will be saved automatically when you click 'Save Notes'."><%= userNotes %></textarea>
                            
                            <div class="action-buttons">
                                <button type="submit" class="btn btn-success btn-block">
                                    <i class="fas fa-save"></i> Save Notes
                                </button>
                                <a href="user_dashboard.jsp" class="btn btn-outline-secondary btn-block">
                                    <i class="fas fa-arrow-left"></i> Back to Dashboard
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        <% } else { %>
            <div class="alert alert-danger text-center mt-5">
                <h4>Book Not Found!</h4>
                <p>The requested book could not be found.</p>
                <a href="user_dashboard.jsp" class="btn btn-primary">Back to Dashboard</a>
            </div>
        <% } %>
    </div>

   <%@include file="allcomponent/Footer.jsp"%> 
</body>
</html>