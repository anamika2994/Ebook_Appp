<%@page import="java.util.List"%>
<%@page import="com.entity.BookDtls"%>
<%@page import="com.entity.user"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search Results - Online Ebook Store</title>
<%@include file="allcomponent/allCSS.jsp"%>
</head>
<body style="background-color: #f5f5f5;">
    <%@include file="allcomponent/Navber.jsp"%>

    <div class="container-fluid p-5">
        <h2 class="section-title">Search Results</h2>
        
        <%
        String searchQuery = (String) session.getAttribute("searchQuery");
        List<BookDtls> searchResults = (List<BookDtls>) session.getAttribute("searchResults");
        user u = (user) session.getAttribute("userobj");
        %>
        
        <p class="text-center text-muted mb-5">
            Search results for: "<strong><%= searchQuery != null ? searchQuery : "" %></strong>"
            <span class="badge badge-primary ml-2"><%= searchResults != null ? searchResults.size() : 0 %> books found</span>
        </p>

        <div class="row">
            <%
            if (searchResults != null && !searchResults.isEmpty()) {
                for (BookDtls b : searchResults) {
            %>
            <div class="col-md-3 mb-4">
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
            } else {
            %>
            <div class="col-12 text-center">
                <div class="alert alert-warning">
                    <i class="fas fa-search fa-2x mb-3"></i>
                    <h4>No books found!</h4>
                    <p>Try searching with different keywords.</p>
                    <a href="index.jsp" class="btn btn-primary">Browse All Books</a>
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