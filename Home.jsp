<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Dashboard - Ebook Store</title>
<%@include file="allCSS.jsp"%>
<style>
/* -------- Global Styles ---------- */
body {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    min-height: 100vh;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

/* -------- Dashboard Container ---------- */
.dashboard-container {
    margin-top: 80px;
    margin-bottom: 50px;
}

/* -------- Card Styles ---------- */
.dashboard-card {
    background: linear-gradient(145deg, #ffffff, #f8f9fa);
    border: none;
    border-radius: 20px;
    padding: 30px 20px;
    transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
    cursor: pointer;
    position: relative;
    overflow: hidden;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    height: 100%;
    min-height: 220px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
}

.dashboard-card::before {
    content: '';
    position: absolute;
    top: 0;
    left: -100%;
    width: 100%;
    height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255,255,255,0.4), transparent);
    transition: left 0.5s;
}

.dashboard-card:hover::before {
    left: 100%;
}

.dashboard-card:hover {
    transform: translateY(-12px) scale(1.02);
    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
}

/* -------- Card Colors & Gradients ---------- */
.card-add {
    background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
    color: white;
}

.card-allbook {
    background: linear-gradient(135deg, #007bff 0%, #6610f2 100%);
    color: white;
}

.card-order {
    background: linear-gradient(135deg, #fd7e14 0%, #ff6b6b 100%);
    color: white;
}

.card-logout {
    background: linear-gradient(135deg, #dc3545 0%, #e83e8c 100%);
    color: white;
}

/* -------- Icon Styles ---------- */
.card-icon {
    font-size: 4rem;
    margin-bottom: 20px;
    transition: all 0.3s ease;
    filter: drop-shadow(0 4px 8px rgba(0,0,0,0.2));
}

.dashboard-card:hover .card-icon {
    transform: scale(1.2) rotate(5deg);
    filter: drop-shadow(0 6px 12px rgba(0,0,0,0.3));
}

/* -------- Text Styles ---------- */
.card-title {
    font-size: 1.5rem;
    font-weight: 700;
    margin-bottom: 10px;
    text-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.card-subtitle {
    font-size: 0.9rem;
    opacity: 0.9;
    font-weight: 400;
}

/* -------- Badge Styles ---------- */
.card-badge {
    position: absolute;
    top: 15px;
    right: 15px;
    background: rgba(255,255,255,0.2);
    color: white;
    padding: 5px 12px;
    border-radius: 15px;
    font-size: 0.8rem;
    font-weight: 600;
    backdrop-filter: blur(10px);
    border: 1px solid rgba(255,255,255,0.3);
}

/* -------- Animation Keyframes ---------- */
@keyframes float {
    0%, 100% { transform: translateY(0px); }
    50% { transform: translateY(-10px); }
}

@keyframes glow {
    0%, 100% { box-shadow: 0 10px 30px rgba(0,0,0,0.1); }
    50% { box-shadow: 0 15px 40px rgba(0,0,0,0.2); }
}

.dashboard-card {
    animation: float 6s ease-in-out infinite, glow 4s ease-in-out infinite;
}

.dashboard-card:nth-child(1) { animation-delay: 0s; }
.dashboard-card:nth-child(2) { animation-delay: 0.5s; }
.dashboard-card:nth-child(3) { animation-delay: 1s; }
.dashboard-card:nth-child(4) { animation-delay: 1.5s; }

/* -------- Hover Effects ---------- */
.dashboard-card::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    width: 100%;
    height: 4px;
    background: linear-gradient(90deg, transparent, rgba(255,255,255,0.8), transparent);
    transform: scaleX(0);
    transition: transform 0.3s ease;
}

.dashboard-card:hover::after {
    transform: scaleX(1);
}

/* -------- Link Styles ---------- */
.dashboard-link {
    text-decoration: none !important;
    color: inherit !important;
    display: block;
    height: 100%;
}

.dashboard-link:hover {
    text-decoration: none !important;
    color: inherit !important;
}

/* -------- Container Styles ---------- */
.container {
    max-width: 1200px;
}

/* -------- Responsive Design ---------- */
@media (max-width: 768px) {
    .dashboard-container {
        margin-top: 40px;
    }
    
    .dashboard-card {
        min-height: 180px;
        padding: 20px 15px;
    }
    
    .card-icon {
        font-size: 3rem;
        margin-bottom: 15px;
    }
    
    .card-title {
        font-size: 1.3rem;
    }
    
    .card-badge {
        font-size: 0.7rem;
        padding: 4px 10px;
    }
}

@media (max-width: 576px) {
    .dashboard-card {
        min-height: 160px;
        margin-bottom: 20px;
    }
    
    .card-icon {
        font-size: 2.5rem;
    }
    
    .card-title {
        font-size: 1.1rem;
    }
}

/* -------- Grid Layout ---------- */
.row {
    margin: 0 -10px;
}

.col-md-3 {
    padding: 10px;
}

/* -------- Additional Visual Effects ---------- */
.dashboard-card .ripple {
    position: absolute;
    border-radius: 50%;
    background: rgba(255, 255, 255, 0.6);
    transform: scale(0);
    animation: ripple 0.6s linear;
    pointer-events: none;
}

@keyframes ripple {
    to {
        transform: scale(2.5);
        opacity: 0;
    }
}

/* -------- Header Styles ---------- */
.dashboard-header {
    text-align: center;
    margin-bottom: 50px;
}

.dashboard-header h1 {
    color: white;
    font-size: 2.5rem;
    font-weight: 700;
    text-shadow: 0 4px 8px rgba(0,0,0,0.3);
    margin-bottom: 10px;
}

.dashboard-header p {
    color: rgba(255,255,255,0.8);
    font-size: 1.1rem;
    font-weight: 300;
}

/* -------- Loading Animation ---------- */
.dashboard-card {
    opacity: 0;
    transform: translateY(30px);
    animation: fadeInUp 0.6s ease forwards;
}

@keyframes fadeInUp {
    to {
        opacity: 1;
        transform: translateY(0);
    }
}
</style>
</head>
<body>
    <%@include file="Navber.jsp"%>
    <c:if test="${empty userobj}">
        <c:redirect url="../login.jsp" />
    </c:if>

    <div class="dashboard-container">
        <!-- Dashboard Header -->
        <div class="dashboard-header">
            <h1><i class="fas fa-tachometer-alt me-3"></i>Admin Dashboard</h1>
            <p>Manage your ebook store efficiently</p>
        </div>

        <div class="container">
            <div class="row justify-content-center">
                <!-- Add Books Card -->
                <div class="col-md-3 mb-4">
                    <a href="add_book.jsp" class="dashboard-link">
                        <div class="dashboard-card card-add">
                            <div class="card-badge">New</div>
                            <i class="fas fa-plus-circle card-icon"></i>
                            <h3 class="card-title">Add Books</h3>
                            <p class="card-subtitle">Add new books to store</p>
                        </div>
                    </a>
                </div>

                <!-- All Books Card -->
                <div class="col-md-3 mb-4">
                    <a href="all_book.jsp" class="dashboard-link">
                        <div class="dashboard-card card-allbook">
                            <div class="card-badge">View</div>
                            <i class="fas fa-book-open card-icon"></i>
                            <h3 class="card-title">All Books</h3>
                            <p class="card-subtitle">Manage existing books</p>
                        </div>
                    </a>
                </div>

                <!-- Manage Orders Card -->
                <div class="col-md-3 mb-4">
                    <a href="orders" class="dashboard-link">
                        <div class="dashboard-card card-order">
                            <div class="card-badge">Orders</div>
                            <i class="fas fa-shopping-bag card-icon"></i>
                            <h3 class="card-title">Manage Orders</h3>
                            <p class="card-subtitle">Process customer orders</p>
                        </div>
                    </a>
                </div>

                <!-- Logout Card -->
                <div class="col-md-3 mb-4">
    <a data-toggle="modal" data-target="#adminLogoutModal" class="dashboard-link">
        <div class="dashboard-card card-logout">
            <div class="card-badge">Exit</div>
            <i class="fas fa-sign-out-alt card-icon"></i>
            <h3 class="card-title">Logout</h3>
            <p class="card-subtitle">Secure sign out</p>
        </div>
    </a>
</div>
            </div>
        </div>
    </div>

    <!-- JavaScript for Ripple Effect -->
    <script>
    document.addEventListener('DOMContentLoaded', function() {
        const cards = document.querySelectorAll('.dashboard-card');
        
        cards.forEach(card => {
            card.addEventListener('click', function(e) {
                const ripple = document.createElement('span');
                ripple.classList.add('ripple');
                
                const rect = card.getBoundingClientRect();
                const size = Math.max(rect.width, rect.height);
                const x = e.clientX - rect.left - size / 2;
                const y = e.clientY - rect.top - size / 2;
                
                ripple.style.width = ripple.style.height = size + 'px';
                ripple.style.left = x + 'px';
                ripple.style.top = y + 'px';
                
                card.appendChild(ripple);
                
                setTimeout(() => {
                    ripple.remove();
                }, 600);
            });
        });
        
        // Staggered animation delay
        cards.forEach((card, index) => {
            card.style.animationDelay = (index * 0.1) + 's';
        });
    });
    </script>

    <%@include file="Footer.jsp"%>
</body>
</html>