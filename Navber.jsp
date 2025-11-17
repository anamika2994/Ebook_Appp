<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
/* -------- Modern Navbar Styles ---------- */
.container-fluid:first-child {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%) !important;
    height: 6px;
}

.bg-custom {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%) !important;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
}

/* -------- Header Section ---------- */
.container-fluid.p-3 {
    background: white;
    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    border-bottom: 1px solid #e0e0e0;
}

/* -------- Ebook Title ---------- */
.ebook-title {
    font-family: 'Georgia', serif;
    font-weight: bold;
    font-size: 24px;
    color: #2c3e50;
    text-shadow: none;
    margin-left: 10px;
    white-space: nowrap;
    transition: 0.3s;
}

.ebook-title:hover {
    color: #667eea;
    transform: scale(1.05);
}

.ebook-title i {
    color: #667eea;
    margin-right: 8px;
}

/* -------- Search Bar ---------- */
.form-inline .form-control {
    width: 320px;
    border-radius: 25px;
    padding: 10px 20px;
    border: 2px solid #e0e0e0;
    transition: all 0.3s ease;
}

.form-inline .form-control:focus {
    border-color: #667eea;
    box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
}

.form-inline .btn-primary {
    border-radius: 25px;
    padding: 10px 25px;
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    border: none;
    transition: all 0.3s ease;
    margin-left: 10px;
}

.form-inline .btn-primary:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
}

/* -------- User Buttons ---------- */
.btn-success {
    background: linear-gradient(135deg, #28a745, #20c997);
    border: none;
    border-radius: 20px;
    padding: 8px 15px;
    margin: 0 5px;
    transition: all 0.3s ease;
    font-size: 14px;
}

.btn-primary {
    background: linear-gradient(135deg, #667eea, #764ba2);
    border: none;
    border-radius: 20px;
    padding: 8px 15px;
    margin: 0 5px;
    transition: all 0.3s ease;
    font-size: 14px;
}

.btn-info {
    background: linear-gradient(135deg, #17a2b8, #6f42c1);
    border: none;
    border-radius: 20px;
    padding: 8px 15px;
    margin: 0 5px;
    transition: all 0.3s ease;
    font-size: 14px;
}

.btn-success:hover, .btn-primary:hover, .btn-info:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(0,0,0,0.2);
}

/* -------- User Section ---------- */
.user-section {
    display: flex;
    align-items: center;
    gap: 10px;
}

.user-welcome {
    background: linear-gradient(135deg, #28a745, #20c997);
    color: white;
    border-radius: 20px;
    padding: 8px 15px;
    font-weight: 500;
    font-size: 14px;
    display: flex;
    align-items: center;
    gap: 8px;
    white-space: nowrap;
}

.user-actions {
    display: flex;
    align-items: center;
    gap: 8px;
}

/* -------- Navigation Menu ---------- */
.navbar-nav .nav-link {
    color: white !important;
    font-weight: 500;
    padding: 12px 15px !important;
    margin: 0 2px;
    border-radius: 20px;
    transition: all 0.3s ease;
    display: flex;
    align-items: center;
    gap: 8px;
}

.navbar-nav .nav-link:hover {
    background: rgba(255,255,255,0.15);
    transform: translateY(-2px);
}

/* -------- Home Button ---------- */
.home-btn {
    background: rgba(255,255,255,0.2) !important;
    border-radius: 20px;
    font-weight: 600;
}

.home-btn:hover {
    background: rgba(255,255,255,0.3) !important;
    color: #ffd700 !important;
}

/* -------- Cart Icon ---------- */
.fa-cart-plus {
    color: #667eea;
    transition: all 0.3s ease;
    margin-right: 15px;
    font-size: 1.5rem;
}

.fa-cart-plus:hover {
    color: #764ba2;
    transform: scale(1.1);
}

/* -------- Settings & Contact ---------- */
.navbar-nav .nav-link[href*="setting"],
.navbar-nav .nav-link[href*="contact"] {
    background: rgba(255,255,255,0.1);
    margin-left: 10px;
}

.navbar-nav .nav-link[href*="setting"]:hover,
.navbar-nav .nav-link[href*="contact"]:hover {
    background: rgba(255,255,255,0.2);
}

/* -------- Category Icons Alignment ---------- */
.navbar-nav .nav-link i.fa-book-open {
    font-size: 14px;
    color: #ffd700;
    width: 16px;
    text-align: center;
}

/* -------- Dashboard Button ---------- */
.dashboard-btn {
    background: linear-gradient(135deg, #17a2b8, #6f42c1);
    border: none;
    border-radius: 20px;
    padding: 8px 15px;
    color: white;
    text-decoration: none;
    font-weight: 500;
    font-size: 14px;
    display: flex;
    align-items: center;
    gap: 8px;
    transition: all 0.3s ease;
    white-space: nowrap;
}

.dashboard-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(0,0,0,0.2);
    color: white;
    text-decoration: none;
}

/* -------- Responsive Design ---------- */
@media (max-width: 768px) {
    .ebook-title {
        font-size: 20px;
    }
    
    .form-inline .form-control {
        width: 200px;
    }
    
    .navbar-nav .nav-link {
        padding: 8px 15px !important;
        text-align: left;
    }
    
    .col-md-3 {
        text-align: center;
        margin-top: 10px;
    }
    
    .user-section {
        flex-direction: column;
        gap: 5px;
    }
    
    .user-welcome {
        font-size: 12px;
        padding: 6px 12px;
    }
    
    .dashboard-btn {
        font-size: 12px;
        padding: 6px 12px;
    }
}

/* -------- Active State ---------- */
.navbar-nav .nav-item.active .nav-link {
    background: rgba(255,255,255,0.25);
    font-weight: 600;
}

/* -------- Icon Colors ---------- */
.fa-book, .fa-book-open, .fa-house-chimney, .fa-cog, .fa-phone {
    color: #ffd700;
}

.fa-user-plus, .fa-sign-in-alt, .fa-tachometer-alt {
    color: white;
}

/* -------- Navigation Layout Fix ---------- */
.navbar-collapse {
    justify-content: space-between;
}

.navbar-nav.mr-auto {
    display: flex;
    flex-wrap: wrap;
    align-items: center;
}

.navbar-nav.ml-auto {
    display: flex;
    align-items: center;
    margin: 0;
}

/* -------- Header Layout ---------- */
.header-row {
    display: flex;
    align-items: center;
    justify-content: space-between;
    width: 100%;
}

.header-title {
    flex: 0 0 auto;
}

.header-search {
    flex: 1;
    display: flex;
    justify-content: center;
    max-width: 500px;
    margin: 0 20px;
}

.header-actions {
    flex: 0 0 auto;
    display: flex;
    align-items: center;
    gap: 15px;
}
</style>

<div class="container-fluid"
	style="height: 10px; background-color: #263238"></div>
<div class="container-fluid p-3">
	<div class="header-row">
		<!-- Title -->
		<div class="header-title">
			<h3 class="m-0 ebook-title">
				<i class="fa-solid fa-book"></i> Online Ebook Store
			</h3>
		</div>
		
		<!-- Search Bar -->
		<div class="header-search">
			<form class="form-inline my-2 my-lg-0 d-flex" action="search" method="get">
				<input class="form-control mr-2" type="search" name="query"
					placeholder="Search books..." aria-label="Search"
					style="width: 320px; border-radius: 20px; padding: 8px 15px;">
				<button class="btn btn-primary" type="submit"
					style="border-radius: 20px; padding: 8px 20px;">Search</button>
			</form>
		</div>

		<!-- User Actions -->
		<div class="header-actions">
			<!-- Cart Icon -->
			<c:if test="${not empty userobj}">
				<a href="cart.jsp" class="cart-icon">
					<i class="fas fa-cart-plus"></i>
				</a>
			</c:if>

			<!-- User Section -->
			<c:if test="${not empty userobj}">
				<div class="user-section">
					<!-- Dashboard Button -->
					<a href="user_dashboard.jsp" class="dashboard-btn"> 
						<i class="fas fa-tachometer-alt"></i> Dashboard
					</a>
					
					<!-- User Welcome -->
					<div class="user-welcome">
						<i class="fas fa-user"></i> ${userobj.name}
					</div>
					
					<!-- Logout Button -->
					<a href="logout" class="btn btn-primary text-white">
						<i class="fas fa-sign-in-alt"></i> Logout
					</a>
				</div>
			</c:if>

			<c:if test="${empty userobj}">
				<div class="user-section">
					<a href="login.jsp" class="btn btn-success">
						<i class="fas fa-sign-in-alt"></i> Login
					</a>
					<a href="register.jsp" class="btn btn-primary text-white">
						<i class="fas fa-user-plus"></i> Register
					</a>
				</div>
			</c:if>
		</div>
	</div>
</div>

<nav class="navbar navbar-expand-lg navbar-dark bg-custom">
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#navbarSupportedContent"
		aria-controls="navbarSupportedContent" aria-expanded="false"
		aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>
	<div class="collapse navbar-collapse" id="navbarSupportedContent">
		<ul class="navbar-nav mr-auto">
			<!-- Home button -->
			<li class="nav-item active">
				<a class="nav-link home-btn" href="index.jsp">
					<i class="fa-solid fa-house-chimney"></i> Home
				</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="all_fictionbook.jsp">
					<i class="fa-solid fa-book-open"></i> Fiction
				</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="all_nonfictionbook.jsp">
					<i class="fa-solid fa-book-open"></i> Non-Fiction
				</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="all_Educationalbook.jsp">
					<i class="fa-solid fa-book-open"></i> Educational
				</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="all_profesionalbook.jsp">
					<i class="fa-solid fa-book-open"></i> Professional
				</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="all_Technology.jsp">
					<i class="fa-solid fa-book-open"></i> Technology
				</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="all_comiesbook.jsp">
					<i class="fa-solid fa-book-open"></i> Comics
				</a>
			</li>
		</ul>
		<ul class="navbar-nav ml-auto">
			<li class="nav-item">
				<a class="nav-link" href="setting.jsp">
					<i class="fas fa-cog"></i> Settings
				</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" href="contact.jsp">
					<i class="fas fa-phone"></i> Contact Us
				</a>
			</li>
		</ul>
	</div>
</nav>