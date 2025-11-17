<%@page import="com.entity.user"%>
<%@page import="com.DB.DBconnect"%>
<%@page import="com.DAO.BookDAOimpl"%>
<%@page import="com.entity.BookDtls"%>
<%@ page import="java.util.List, java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Professional Books - Online Ebook Store</title>
<%@include file="allcomponent/allCSS.jsp"%>
</head>
<body style="background-color: #f5f5f5;">
    <%@include file="allcomponent/Navber.jsp"%>

    <div class="container-fluid p-5">
        <h2 class="section-title">💼 Professional Books</h2>
        <p class="text-center text-muted mb-5">Advance your career with professional development books</p>

        <%
        user u = (user) session.getAttribute("userobj");
        %>

        <!-- Success Messages -->
        <c:if test="${not empty addCart}">
            <div class="alert alert-success alert-dismissible fade show text-center" role="alert">
                <i class="fas fa-check-circle"></i> ${addCart}
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <c:remove var="addCart" scope="session"/>
        </c:if>

        <div class="row">
            <%
            try {
                BookDAOimpl dao = new BookDAOimpl(DBconnect.getConn());
                List<BookDtls> list = dao.getProfessionalBook();
                if (list.isEmpty()) {
            %>
                <div class="col-12 text-center">
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle"></i> No professional books available at the moment.
                    </div>
                </div>
            <%
                } else {
                    for (BookDtls b : list) {
            %>
            <div class="col-xl-3 col-lg-4 col-md-6 mb-4">
                <div class="card crd-ho h-100 book-card">
                    <div class="card-body text-center">
                        <img src="book/<%=b.getPhotoName()%>" 
                             style="width: 150px; height: 200px; object-fit: cover; border-radius: 8px;" 
                             class="img-thumbnail mb-3"
                             alt="<%=b.getBookName()%>">
                        <h5 class="card-title text-dark"><%=b.getBookName()%></h5>
                        <p class="card-text text-muted">
                            <i class="fas fa-user"></i> <%=b.getAuthor()%>
                        </p>
                        <p class="card-text">
                            <small class="text-muted">
                                <i class="fas fa-tag"></i> <%=b.getBookCategory()%>
                            </small>
                        </p>
                        <p class="card-text">
                            <span class="price-text">₹<%=b.getPrice()%></span>
                        </p>
                        <div class="card-footer bg-white border-0 pt-3">
                            <div class="row justify-content-center">
                                <div class="col-12 mb-2">
                                    <a href="details_book.jsp?bookId=<%=b.getId()%>" 
                                       class="btn btn-custom btn-sm btn-block">
                                        <i class="fas fa-eye"></i> View Details
                                    </a>
                                </div>
                                <div class="col-12">
                                    <%
                                    if (u == null) {
                                    %>
                                    <a href="login.jsp" class="btn btn-success-custom btn-sm btn-block">
                                        <i class="fas fa-cart-plus"></i> Add to Cart
                                    </a>
                                    <%
                                    } else {
                                    %>
                                    <a href="cart?bid=<%=b.getId()%>&&uid=<%=u.getUserid()%>" 
                                       class="btn btn-success-custom btn-sm btn-block">
                                        <i class="fas fa-cart-plus"></i> Add to Cart
                                    </a>
                                    <%
                                    }
                                    %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <%
                    }
                }
            } catch (Exception e) {
            %>
                <div class="col-12 text-center">
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-triangle"></i> Error loading books: <%= e.getMessage() %>
                    </div>
                </div>
            <%
            }
            %>
        </div>
    </div>

   <%@include file="allcomponent/Footer.jsp"%>
</body>
</html>