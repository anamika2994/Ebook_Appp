<%@page import="com.entity.user"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="com.DAO.BookDAOimpl"%>
<%@ page import="com.entity.BookDtls"%>
<%@ page import="java.util.List, java.util.ArrayList"%>

<%@ page import="com.DB.DBconnect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Online Ebook Store: Home</title>
<%@include file="allcomponent/allCSS.jsp"%>
<style>
/* -------- Modern Blue Theme ---------- */
body {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    min-height: 100vh;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

/* -------- Hero Section ---------- */
.back-img {
    background: linear-gradient(135deg, rgba(102, 126, 234, 0.9), rgba(118, 75, 162, 0.9)), 
                url("img/bb.jpg") no-repeat center center/cover;
    height: 60vh;
    width: 100%;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    text-align: center;
    color: white;
}

.back-img h2 {
    font-size: 3rem;
    font-weight: bold;
    margin-bottom: 1rem;
    text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
}

.back-img p {
    font-size: 1.2rem;
    width: 60%;
    line-height: 1.6;
}

/* -------- Main Content Container ---------- */
.main-container {
    background: white;
    margin: -50px 20px 0 20px;
    border-radius: 20px;
    box-shadow: 0 20px 40px rgba(0,0,0,0.1);
    padding: 30px;
    position: relative;
}

/* -------- Section Titles ---------- */
.section-title {
    text-align: center;
    font-size: 2rem;
    font-weight: bold;
    color: #333;
    margin: 2rem 0;
    position: relative;
}

.section-title::after {
    content: '';
    position: absolute;
    bottom: -10px;
    left: 50%;
    transform: translateX(-50%);
    width: 80px;
    height: 4px;
    background: linear-gradient(135deg, #667eea, #764ba2);
    border-radius: 2px;
}

/* -------- Book Cards ---------- */
.crd-ho {
    border: none;
    border-radius: 15px;
    box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    transition: all 0.3s ease;
    margin-bottom: 20px;
    background: white;
    height: 100%;
    display: flex;
    flex-direction: column;
}

.crd-ho:hover {
    transform: translateY(-10px);
    box-shadow: 0 15px 30px rgba(102, 126, 234, 0.2);
}

.card-body {
    padding: 1.5rem;
    text-align: center;
    display: flex;
    flex-direction: column;
    flex-grow: 1;
}

.card-body img {
    border-radius: 10px;
    margin-bottom: 1rem;
    box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    width: 150px;
    height: 200px;
    object-fit: cover;
    align-self: center;
}

.card-title {
    font-weight: bold;
    color: #333;
    font-size: 1.1rem;
    margin-bottom: 0.5rem;
    min-height: 2.5rem;
    display: flex;
    align-items: center;
    justify-content: center;
}

.card-author {
    color: #666;
    font-style: italic;
    margin-bottom: 0.5rem;
}

.card-category {
    color: #888;
    font-size: 0.8rem;
    background: #f8f9fa;
    padding: 0.3rem 0.8rem;
    border-radius: 15px;
    display: inline-block;
    margin-bottom: 1rem;
}

.card-price {
    font-weight: bold;
    color: #333;
    font-size: 1.2rem;
    margin: 0.5rem 0;
    padding: 0.5rem;
    background: #f8f9fa;
    border-radius: 10px;
}

.card-actions {
    margin-top: auto;
    display: flex;
    justify-content: center;
    gap: 0.5rem;
    flex-wrap: wrap;
}

/* -------- Buttons ---------- */
.btn {
    border-radius: 20px;
    font-weight: 600;
    padding: 0.5rem 1rem;
    font-size: 0.8rem;
    border: none;
    transition: all 0.3s ease;
}

.btn-danger {
    background: linear-gradient(135deg, #667eea, #764ba2);
}

.btn-success {
    background: linear-gradient(135deg, #28a745, #20c997);
}

.btn:hover {
    transform: scale(1.05);
    box-shadow: 0 5px 15px rgba(0,0,0,0.2);
}

/* -------- View All Button ---------- */
.view-all-btn {
    text-align: center;
    margin: 2rem 0;
}

.view-all-btn a {
    background: linear-gradient(135deg, #667eea, #764ba2);
    color: white;
    padding: 0.8rem 2rem;
    border-radius: 25px;
    text-decoration: none;
    font-weight: 600;
    transition: all 0.3s ease;
}

.view-all-btn a:hover {
    transform: translateY(-3px);
    box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3);
    text-decoration: none;
    color: white;
}



/* -------- Responsive Design ---------- */
@media (max-width: 768px) {
    .back-img {
        height: 50vh;
        padding: 0 1rem;
    }
    
    .back-img h2 {
        font-size: 2rem;
    }
    
    .back-img p {
        font-size: 1rem;
        width: 90%;
    }
    
    .main-container {
        margin: -30px 10px 0 10px;
        padding: 1.5rem;
    }
    
    .section-title {
        font-size: 1.5rem;
    }
    
    .card-actions {
        flex-direction: column;
        align-items: center;
    }
    
    .card-actions .btn {
        width: 100%;
        margin-bottom: 0.5rem;
    }
}
</style>
</head>
<body>

	<%
	user u = (user) session.getAttribute("userobj");
	%>
	<%@include file="allcomponent/Navber.jsp"%>
	
	<!-- Hero Section -->
	<div class="container-fluid back-img">
		<h2>Welcome To Ebook Store</h2>
		<p>The more that you read, the more things you will know. The more that you learn, the more places you'll go.</p>
	</div>

	<!-- Main Content -->
	<div class="main-container">
		<h1 class="section-title">ALL BOOKS</h1>

		<!-- Fiction Books -->
		<div class="container-fluid">
			<p class="section-title">Fiction Books</p>
			<div class="row">
				<%
				try {
					BookDAOimpl dao = new BookDAOimpl(DBconnect.getConn());
					List<BookDtls> list = dao.getFictionBook();
					for (BookDtls b : list) {
				%>
				<div class="col-xl-3 col-lg-4 col-md-6 mb-4">
					<div class="card crd-ho">
						<div class="card-body text-center">
							<img alt="<%=b.getBookName()%>" src="book/<%=b.getPhotoName()%>" class="img-thumbnail">
							<div class="card-title"><%=b.getBookName()%></div>
							<div class="card-author"><%=b.getAuthor()%></div>
							<div class="card-category">Categories: <%=b.getBookCategory()%></div>
							<div class="card-price">
								<i class="fa-solid fa-dollar-sign"></i> <%=b.getPrice()%>
							</div>
							<div class="card-actions">
								<%
								if (u == null) {
								%>
								<a href="login.jsp" class="btn btn-danger btn-sm">Add Cart</a>
								<%
								} else {
								%>
								<a href="cart?bid=<%=b.getId() %>&&uid=<%=u.getUserid()%>" class="btn btn-danger btn-sm">Add Cart</a>
								<%
								}
								%>
								<a href="details_book.jsp?bookId=<%=b.getId()%>" class="btn btn-success btn-sm">Details</a>
							</div>
						</div>
					</div>
				</div>
				<%
				}
				} catch (Exception e) {
				out.println("Error: " + e.getMessage());
				}
				%>
			</div>
			<div class="view-all-btn">
				<a href="all_fictionbook.jsp">VIEW ALL FICTION</a>
			</div>
		</div>

		<!-- Non-Fiction Books -->
		<div class="container-fluid">
			<p class="section-title">Non-Fiction Books</p>
			<div class="row">
				<%
				try {
					BookDAOimpl dao = new BookDAOimpl(DBconnect.getConn());
					List<BookDtls> nonFictionList = dao.getNonFictionBook();
					for (BookDtls b : nonFictionList) {
				%>
				<div class="col-xl-3 col-lg-4 col-md-6 mb-4">
					<div class="card crd-ho">
						<div class="card-body text-center">
							<img alt="<%=b.getBookName()%>" src="book/<%=b.getPhotoName()%>" class="img-thumbnail">
							<div class="card-title"><%=b.getBookName()%></div>
							<div class="card-author"><%=b.getAuthor()%></div>
							<div class="card-category">Categories: <%=b.getBookCategory()%></div>
							<div class="card-price">
								<i class="fa-solid fa-dollar-sign"></i> <%=b.getPrice()%>
							</div>
							<div class="card-actions">
								<%
								if (u == null) {
								%>
								<a href="login.jsp" class="btn btn-danger btn-sm">Add Cart</a>
								<%
								} else {
								%>
								<a href="cart?bid=<%=b.getId() %>&&uid=<%=u.getUserid()%>" class="btn btn-danger btn-sm">Add Cart</a>
								<%
								}
								%>
								<a href="details_book.jsp?bookId=<%=b.getId()%>" class="btn btn-success btn-sm">Details</a>
							</div>
						</div>
					</div>
				</div>
				<%
				}
				} catch (Exception e) {
				out.println("Error: " + e.getMessage());
				}
				%>
			</div>
			<div class="view-all-btn">
				<a href="all_nonfictionbook.jsp">VIEW ALL NON-FICTION</a>
			</div>
		</div>

		<!-- Educational Books -->
		<div class="container-fluid">
			<p class="section-title">Educational Books</p>
			<div class="row">
				<%
				try {
					BookDAOimpl dao = new BookDAOimpl(DBconnect.getConn());
					List<BookDtls> eduList = dao.getEducationalBook();
					for (BookDtls b : eduList) {
				%>
				<div class="col-xl-3 col-lg-4 col-md-6 mb-4">
					<div class="card crd-ho">
						<div class="card-body text-center">
							<img alt="<%=b.getBookName()%>" src="book/<%=b.getPhotoName()%>" class="img-thumbnail">
							<div class="card-title"><%=b.getBookName()%></div>
							<div class="card-author"><%=b.getAuthor()%></div>
							<div class="card-category">Categories: <%=b.getBookCategory()%></div>
							<div class="card-price">
								<i class="fa-solid fa-dollar-sign"></i> <%=b.getPrice()%>
							</div>
							<div class="card-actions">
								<%
								if (u == null) {
								%>
								<a href="login.jsp" class="btn btn-danger btn-sm">Add Cart</a>
								<%
								} else {
								%>
								<a href="cart?bid=<%=b.getId() %>&&uid=<%=u.getUserid()%>" class="btn btn-danger btn-sm">Add Cart</a>
								<%
								}
								%>
								<a href="details_book.jsp?bookId=<%=b.getId()%>" class="btn btn-success btn-sm">Details</a>
							</div>
						</div>
					</div>
				</div>
				<%
				}
				} catch (Exception e) {
				out.println("Error: " + e.getMessage());
				}
				%>
			</div>
			<div class="view-all-btn">
				<a href="all_Educationalbook.jsp">VIEW ALL EDUCATIONAL</a>
			</div>
		</div>

		<!-- Professional Books -->
		<div class="container-fluid">
			<p class="section-title">Professional Books</p>
			<div class="row">
				<%
				try {
					BookDAOimpl dao = new BookDAOimpl(DBconnect.getConn());
					List<BookDtls> proList = dao.getProfessionalBook();
					for (BookDtls b : proList) {
				%>
				<div class="col-xl-3 col-lg-4 col-md-6 mb-4">
					<div class="card crd-ho">
						<div class="card-body text-center">
							<img alt="<%=b.getBookName()%>" src="book/<%=b.getPhotoName()%>" class="img-thumbnail">
							<div class="card-title"><%=b.getBookName()%></div>
							<div class="card-author"><%=b.getAuthor()%></div>
							<div class="card-category">Categories: <%=b.getBookCategory()%></div>
							<div class="card-price">
								<i class="fa-solid fa-dollar-sign"></i> <%=b.getPrice()%>
							</div>
							<div class="card-actions">
								<%
								if (u == null) {
								%>
								<a href="login.jsp" class="btn btn-danger btn-sm">Add Cart</a>
								<%
								} else {
								%>
								<a href="cart?bid=<%=b.getId() %>&&uid=<%=u.getUserid()%>" class="btn btn-danger btn-sm">Add Cart</a>
								<%
								}
								%>
								<a href="details_book.jsp?bookId=<%=b.getId()%>" class="btn btn-success btn-sm">Details</a>
							</div>
						</div>
					</div>
				</div>
				<%
				}
				} catch (Exception e) {
				out.println("Error: " + e.getMessage());
				}
				%>
			</div>
			<div class="view-all-btn">
				<a href="all_profesionalbook.jsp">VIEW ALL PROFESSIONAL</a>
			</div>
		</div>

		<!-- Technology Books -->
		<div class="container-fluid">
			<p class="section-title">Technology Books</p>
			<div class="row">
				<%
				try {
					BookDAOimpl dao = new BookDAOimpl(DBconnect.getConn());
					List<BookDtls> childrenList = dao.getTechnology();
					for (BookDtls b : childrenList) {
				%>
				<div class="col-xl-3 col-lg-4 col-md-6 mb-4">
					<div class="card crd-ho">
						<div class="card-body text-center">
							<img alt="<%=b.getBookName()%>" src="book/<%=b.getPhotoName()%>" class="img-thumbnail">
							<div class="card-title"><%=b.getBookName()%></div>
							<div class="card-author"><%=b.getAuthor()%></div>
							<div class="card-category">Categories: <%=b.getBookCategory()%></div>
							<div class="card-price">
								<i class="fa-solid fa-dollar-sign"></i> <%=b.getPrice()%>
							</div>
							<div class="card-actions">
								<%
								if (u == null) {
								%>
								<a href="login.jsp" class="btn btn-danger btn-sm">Add Cart</a>
								<%
								} else {
								%>
								<a href="cart?bid=<%=b.getId() %>&&uid=<%=u.getUserid()%>" class="btn btn-danger btn-sm">Add Cart</a>
								<%
								}
								%>
								<a href="details_book.jsp?bookId=<%=b.getId()%>" class="btn btn-success btn-sm">Details</a>
							</div>
						</div>
					</div>
				</div>
				<%
				}
				} catch (Exception e) {
				out.println("Error: " + e.getMessage());
				}
				%>
			</div>
			<div class="view-all-btn">
				<a href="all_Technology.jsp">VIEW ALL TECHNOLOGY</a>
			</div>
		</div>

		<!-- Comics Books -->
		<div class="container-fluid">
			<p class="section-title">Comics Books</p>
			<div class="row">
				<%
				try {
					BookDAOimpl dao = new BookDAOimpl(DBconnect.getConn());
					List<BookDtls> comicsList = dao.getComicsBook();
					for (BookDtls b : comicsList) {
				%>
				<div class="col-xl-3 col-lg-4 col-md-6 mb-4">
					<div class="card crd-ho">
						<div class="card-body text-center">
							<img alt="<%=b.getBookName()%>" src="book/<%=b.getPhotoName()%>" class="img-thumbnail">
							<div class="card-title"><%=b.getBookName()%></div>
							<div class="card-author"><%=b.getAuthor()%></div>
							<div class="card-category">Categories: <%=b.getBookCategory()%></div>
							<div class="card-price">
								<i class="fa-solid fa-dollar-sign"></i> <%=b.getPrice()%>
							</div>
							<div class="card-actions">
								<%
								if (u == null) {
								%>
								<a href="login.jsp" class="btn btn-danger btn-sm">Add Cart</a>
								<%
								} else {
								%>
								<a href="cart?bid=<%=b.getId() %>&&uid=<%=u.getUserid()%>" class="btn btn-danger btn-sm">Add Cart</a>
								<%
								}
								%>
								<a href="details_book.jsp?bookId=<%=b.getId()%>" class="btn btn-success btn-sm">Details</a>
							</div>
						</div>
					</div>
				</div>
				<%
				}
				} catch (Exception e) {
				out.println("Error: " + e.getMessage());
				}
				%>
			</div>
			<div class="view-all-btn">
				<a href="all_comiesbook.jsp">VIEW ALL COMICS</a>
			</div>
		</div>
	</div>

	<%@include file="allcomponent/Footer.jsp"%>
</body>
</html>