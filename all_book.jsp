<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.DAO.BookDAOimpl"%>
<%@ page import="com.DB.DBconnect"%>
<%@ page import="java.util.*"%>
<%@ page import="com.entity.BookDtls"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin: All Books</title>
<%@include file="allCSS.jsp"%>
<style>
.table thead {
    background-color: #263238 !important;
    color: white !important;
}

/* Custom button styles for side-by-side layout */
.btn-action-group {
    display: flex;
    gap: 8px;
    flex-wrap: nowrap;
}

.btn-sm {
    padding: 5px 12px;
    font-size: 12px;
    border-radius: 4px;
    display: inline-flex;
    align-items: center;
    gap: 4px;
    text-decoration: none;
    white-space: nowrap;
}

.btn-primary {
    background-color: #007bff;
    border-color: #007bff;
}

.btn-danger {
    background-color: #dc3545;
    border-color: #dc3545;
}

.btn-primary:hover {
    background-color: #0056b3;
    border-color: #0056b3;
}

.btn-danger:hover {
    background-color: #c82333;
    border-color: #c82333;
}

/* Table responsive adjustments */
.table td {
    vertical-align: middle;
}

/* Image styling */
.book-img {
    width: 45px;
    height: 45px;
    object-fit: cover;
    border-radius: 4px;
}

/* Badge styling */
.badge {
    font-size: 11px;
    padding: 4px 8px;
}

/* Responsive design */
@media (max-width: 768px) {
    .btn-action-group {
        flex-direction: column;
        gap: 4px;
    }
    
    .btn-sm {
        padding: 4px 8px;
        font-size: 11px;
        justify-content: center;
    }
    
    .table td, .table th {
        padding: 8px 6px;
        font-size: 13px;
    }
    
    .book-img {
        width: 35px;
        height: 35px;
    }
}
</style>
</head>
<body>
    <%@include file="Navber.jsp"%>
    <c:if test="${empty userobj}">
        <c:redirect url="../login.jsp" />
    </c:if>

    <div class="container">
        <h1 class="text-center my-4">ALL BOOKS</h1>
        
        <c:if test="${not empty succMsg}">
            <div class="alert alert-success text-center">${succMsg}</div>
            <c:remove var="succMsg" scope="session" />
        </c:if>

        <c:if test="${not empty failedMsg}">
            <div class="alert alert-danger text-center">${failedMsg}</div>
            <c:remove var="failedMsg" scope="session" />
        </c:if>

        <div class="table-responsive">
            <table class="table table-striped table-bordered">
                <thead class="thead-dark">
                    <tr>
                        <th scope="col">ID</th>
                        <th scope="col">IMAGE</th>
                        <th scope="col">BOOK NAME</th>
                        <th scope="col">AUTHOR</th>
                        <th scope="col">PRICE</th>
                        <th scope="col">CATEGORY</th>
                        <th scope="col">STATUS</th>
                        <th scope="col" style="width: 150px;">ACTION</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                    BookDAOimpl dao = new BookDAOimpl(DBconnect.getConn());
                    List<BookDtls> list = dao.getAllBooks();
                    int rowNum = 1;

                    for (BookDtls b : list) {
                    %>
                    <tr>
                        <td><%=rowNum%></td>
                        <td>
                            <img src="../book/<%=b.getPhotoName()%>"
                                class="book-img" />
                        </td>
                        <td><%=b.getBookName()%></td>
                        <td><%=b.getAuthor()%></td>
                        <td>৳<%=b.getPrice()%></td>
                        <td><%=b.getBookCategory()%></td>
                        <td>
                            <span class="badge badge-<%=b.getStatus().equals("Active") ? "success" : "danger"%>">
                                <%=b.getStatus()%>
                            </span>
                        </td>
                        <td>
                            <div class="btn-action-group">
                                <a href="edit_books.jsp?id=<%=b.getId()%>"
                                    class="btn btn-sm btn-primary">
                                    <i class="fa-regular fa-pen-to-square"></i> Edit
                                </a>
                                <a href="../delete?id=<%=b.getId()%>" 
                                    class="btn btn-sm btn-danger"
                                    onclick="return confirm('Are you sure you want to delete this book?')">
                                    <i class="fa-solid fa-trash"></i> Delete
                                </a>
                            </div>
                        </td>
                    </tr>
                    <%
                    rowNum++;
                    }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <%@include file="Footer.jsp"%>
</body>
</html>