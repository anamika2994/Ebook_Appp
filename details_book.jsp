<%@ page import="java.sql.Connection"%> 
<%@ page import="com.DB.DBconnect"%>
<%@ page import="com.DAO.BookDAOimpl"%>
<%@ page import="com.entity.BookDtls"%>
<%@ page import="com.entity.user"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Book Details</title>
<%@include file="allcomponent/allCSS.jsp"%>
<link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<style>
body {
    background-color: #f8f9fa;
    font-family: 'Poppins', sans-serif;
}

.details-container {
    margin-top: 50px;
    background: #fff;
    padding: 20px;
    border-radius: 12px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    max-width: 850px;
    margin-left: auto;
    margin-right: auto;
}

.book-img {
    width: 100%;
    max-width: 200px;
    height: 280px;
    object-fit: contain;
    border-radius: 10px;
    border: 1px solid #ddd;
    background-color: #f8f9fa;
}

.book-title {
    font-size: 22px;
    font-weight: 600;
    color: #343a40;
}

.price {
    color: #e53935;
    font-size: 20px;
    font-weight: 600;
}

.icon-info i {
    color: #28a745;
    font-size: 18px;
    margin-right: 8px;
}

.icon-info p {
    font-size: 14px;
    margin-bottom: 6px;
}

.btn-cart {
    font-size: 16px;
    padding: 8px 20px;
}

.star-rating {
    display: flex;
    flex-direction: row-reverse;
    justify-content: flex-end;
}

.star-rating input {
    display: none;
}

.star-rating label {
    cursor: pointer;
    font-size: 24px;
    color: #ddd;
    transition: color 0.2s;
    margin-right: 5px;
}

.star-rating label:hover,
.star-rating label:hover ~ label,
.star-rating input:checked ~ label {
    color: #ffc107;
}

.star-rating input:checked + label {
    color: #ffc107;
}

.stars {
    font-size: 18px;
}

.review-item {
    background: #f8f9fa;
    padding: 15px;
    border-radius: 5px;
}
</style>
</head>
<body>

<%@include file="allcomponent/Navber.jsp"%>

<%
String bookIdStr = request.getParameter("bookId");
if (bookIdStr != null) {
    int bookId = Integer.parseInt(bookIdStr);
    BookDAOimpl dao = new BookDAOimpl(DBconnect.getConn());
    BookDtls b = dao.getBookById(bookId);
    user u = (user) session.getAttribute("userobj"); // session user

    if (b != null && u != null) {
        // Rating related data load
        com.DAO.RatingDAOImpl ratingDao = new com.DAO.RatingDAOImpl(DBconnect.getConn());
        
        // Average rating
        double averageRating = ratingDao.getAverageRating(bookId);
        // Rating count
        int ratingCount = ratingDao.getRatingCount(bookId);
        // All reviews
        java.util.List<com.entity.BookRating> reviews = ratingDao.getRatingsByBook(bookId);
        
        // User's existing rating
        com.entity.BookRating userRating = ratingDao.getRatingByUserAndBook(u.getUserid(), bookId);
        
        // Set attributes for JSTL
        pageContext.setAttribute("b", b);
        pageContext.setAttribute("averageRating", Math.round(averageRating * 10.0) / 10.0);
        pageContext.setAttribute("ratingCount", ratingCount);
        pageContext.setAttribute("reviews", reviews);
        pageContext.setAttribute("userRating", userRating);
        pageContext.setAttribute("userobj", u);
%>

<div class="container details-container">
    <div class="row">

        <!-- Left Side: Book Image -->
        <div class="col-md-5 text-center">
            <img src="book/<%=b.getPhotoName()%>" class="book-img mb-3"
                alt="<%=b.getBookName()%>">
        </div>

        <!-- Right Side: Book Details -->
        <div class="col-md-7">
            <h3 class="book-title"><%=b.getBookName()%></h3>
            <p><strong>Author:</strong> <%=b.getAuthor()%></p>
            <p><strong>Category:</strong> <%=b.getBookCategory()%></p>
            <p><strong>Status:</strong> <%=b.getStatus()%></p>

            <hr>

            <div class="icon-info">
                <p><i class="fas fa-truck"></i> Free Delivery</p>
                <p><i class="fas fa-sync-alt"></i> Return Available</p>
                <p><i class="fas fa-money-bill-wave"></i> Cash on Delivery</p>
            </div>

            <hr>

            <div class="d-flex align-items-center">
                <a href="<%=request.getContextPath()%>/cart?bid=<%=b.getId()%>&uid=<%=u.getUserid()%>"
                    class="btn btn-danger btn-cart mr-3">
                    <i class="fas fa-shopping-cart"></i> Add to Cart
                </a>
                <span class="price">$<%=b.getPrice()%></span>
            </div>

            <a href="index.jsp" class="btn btn-outline-secondary mt-4">Back to Home</a>
        </div>
    </div>

    <!-- ⭐⭐⭐ Rating Section ⭐⭐⭐ -->
    <div class="card mt-4">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0">
                <i class="fas fa-star"></i> Book Ratings & Reviews
            </h5>
        </div>
        <div class="card-body">

            <!-- Average Rating -->
            <div class="row mb-4">
                <div class="col-md-6">
                    <h4>Average Rating</h4>

                    <div class="display-4 text-warning">
                        <c:choose>
                            <c:when test="${not empty averageRating && averageRating > 0}">
                                <fmt:formatNumber value="${averageRating}" pattern="0.0" />
                            </c:when>
                            <c:otherwise>0.0</c:otherwise>
                        </c:choose>
                        <small class="text-muted">/5</small>
                    </div>

                    <div class="stars mb-2">
                        <c:forEach begin="1" end="5" var="i">
                            <c:choose>
                                <c:when test="${not empty averageRating && i <= averageRating}">
                                    <i class="fas fa-star text-warning"></i>
                                </c:when>
                                <c:when test="${not empty averageRating && (i - averageRating) <= 0.5 && (i - averageRating) > 0}">
                                    <i class="fas fa-star-half-alt text-warning"></i>
                                </c:when>
                                <c:otherwise>
                                    <i class="far fa-star text-secondary"></i>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </div>

                    <p class="text-muted">
                        Based on ${not empty ratingCount ? ratingCount : 0} reviews
                    </p>
                </div>

                <!-- Add Rating Form -->
                <div class="col-md-6">
                    <c:if test="${not empty userobj}">
                        <h5>Rate this book</h5>
                        <form action="RatingServlet" method="post">
                            <input type="hidden" name="bookId" value="${b.id}">
                            
                            <!-- Star Rating -->
                            <div class="form-group">
                                <label>Your Rating:</label>
                                <div class="star-rating">
                                    <c:forEach begin="1" end="5" var="i">
                                        <input type="radio" id="star${i}" name="rating" value="${i}" 
                                               ${userRating.rating == i ? 'checked' : ''} required>
                                        <label for="star${i}" class="star">
                                            <i class="fas fa-star"></i>
                                        </label>
                                    </c:forEach>
                                </div>
                            </div>
                            
                            <!-- Review Text -->
                            <div class="form-group">
                                <label for="review">Your Review (Optional):</label>
                                <textarea class="form-control" id="review" name="review" 
                                          rows="3" placeholder="Share your thoughts about this book...">${userRating.reviewText}</textarea>
                            </div>
                            
                            <button type="submit" class="btn btn-warning">
                                <i class="fas fa-paper-plane"></i> 
                                <c:choose>
                                    <c:when test="${not empty userRating}">
                                        Update Rating
                                    </c:when>
                                    <c:otherwise>
                                        Submit Rating
                                    </c:otherwise>
                                </c:choose>
                            </button>
                        </form>
                    </c:if>

                    <c:if test="${empty userobj}">
                        <div class="alert alert-info">
                            <a href="login.jsp" class="btn btn-primary">Login</a> to rate this book
                        </div>
                    </c:if>
                </div>
            </div>

            <!-- Reviews List -->
            <h5>Customer Reviews</h5>

            <c:if test="${not empty reviews}">
                <c:forEach var="review" items="${reviews}">
                    <div class="review-item border-bottom pb-3 mb-3">
                        <div class="d-flex justify-content-between">
                            <strong>${review.userName}</strong>
                            <small class="text-muted">
                                <fmt:formatDate value="${review.createdAt}" pattern="MMM dd, yyyy" />
                            </small>
                        </div>

                        <div class="stars mb-1">
                            <c:forEach begin="1" end="5" var="i">
                                <i class="fas fa-star ${i <= review.rating ? 'text-warning' : 'text-secondary'}"></i>
                            </c:forEach>
                            <span class="ml-2">${review.rating}/5</span>
                        </div>

                        <c:if test="${not empty review.reviewText}">
                            <p class="mb-0 mt-2">${review.reviewText}</p>
                        </c:if>
                    </div>
                </c:forEach>
            </c:if>

            <c:if test="${empty reviews}">
                <p class="text-muted">No reviews yet. Be the first to review!</p>
            </c:if>

        </div>
    </div>
</div>

<%
    } else {
%>
<div class="container text-center mt-5">
    <h3>Book not found or User not logged in!</h3>
    <a href="index.jsp" class="btn btn-primary mt-3">Back to Home</a>
</div>
<%
    }
} else {
%>
<div class="container text-center mt-5">
    <h3>Invalid Request!</h3>
    <a href="index.jsp" class="btn btn-primary mt-3">Back to Home</a>
</div>
<%
}
%>

<%@include file="allcomponent/Footer.jsp"%>

<!-- JavaScript to fix reverse star rating -->
<script>
document.addEventListener('DOMContentLoaded', function() {
    // Fix star rating functionality
    const starRatings = document.querySelectorAll('.star-rating');
    
    starRatings.forEach(starRating => {
        // Fix the layout to normal direction
        starRating.style.flexDirection = 'row';
        starRating.style.justifyContent = 'flex-start';
        
        const stars = starRating.querySelectorAll('label');
        const inputs = starRating.querySelectorAll('input');
        
        // Reset all stars to default color
        stars.forEach(star => {
            star.style.color = '#ddd';
        });
        
        // Initialize based on checked input
        const checkedInput = starRating.querySelector('input:checked');
        if (checkedInput) {
            const value = parseInt(checkedInput.value);
            stars.forEach((star, index) => {
                if (index < value) {
                    star.style.color = '#ffc107';
                }
            });
        }
        
        // Add click events to stars
        stars.forEach((star, index) => {
            star.addEventListener('click', function() {
                // Update the corresponding input
                const input = inputs[index];
                input.checked = true;
                
                // Update star colors - color all stars up to clicked one
                stars.forEach((s, i) => {
                    if (i <= index) {
                        s.style.color = '#ffc107';
                    } else {
                        s.style.color = '#ddd';
                    }
                });
            });
            
            // Add hover effect
            star.addEventListener('mouseenter', function() {
                stars.forEach((s, i) => {
                    if (i <= index) {
                        s.style.color = '#ffc107';
                    } else {
                        s.style.color = '#ddd';
                    }
                });
            });
        });
        
        // Restore colors when mouse leaves
        starRating.addEventListener('mouseleave', function() {
            const checkedInput = starRating.querySelector('input:checked');
            if (checkedInput) {
                const value = parseInt(checkedInput.value);
                stars.forEach((star, index) => {
                    if (index < value) {
                        star.style.color = '#ffc107';
                    } else {
                        star.style.color = '#ddd';
                    }
                });
            } else {
                stars.forEach(star => {
                    star.style.color = '#ddd';
                });
            }
        });
    });
});
</script>

</body>
</html>