<%@page import="com.entity.user"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order Success - Ebook Store</title>
<%@include file="allcomponent/allCSS.jsp"%>
<style>
.success-container {
    background: white;
    border-radius: 20px;
    box-shadow: 0 20px 40px rgba(0,0,0,0.1);
    margin-top: 50px;
    margin-bottom: 50px;
    overflow: hidden;
}

.success-header {
    background: linear-gradient(135deg, #00b09b 0%, #96c93d 100%);
    color: white;
    padding: 40px;
    text-align: center;
}

.success-body {
    padding: 50px;
    text-align: center;
}

.success-icon {
    font-size: 100px;
    color: #28a745;
    margin-bottom: 30px;
}

.order-details {
    background: #f8f9fa;
    border-radius: 15px;
    padding: 30px;
    margin: 30px 0;
    text-align: left;
}

.detail-item {
    display: flex;
    justify-content: space-between;
    margin-bottom: 15px;
    padding-bottom: 15px;
    border-bottom: 1px solid #e9ecef;
}

.detail-item:last-child {
    border-bottom: none;
    margin-bottom: 0;
}

.detail-label {
    font-weight: 600;
    color: #495057;
}

.detail-value {
    font-weight: 600;
    color: #28a745;
}

.action-buttons {
    margin-top: 30px;
}

.btn-dashboard {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    border: none;
    border-radius: 25px;
    padding: 12px 30px;
    font-weight: 600;
    color: white;
    margin: 0 10px;
}

.btn-library {
    background: linear-gradient(135deg, #00b09b 0%, #96c93d 100%);
    border: none;
    border-radius: 25px;
    padding: 12px 30px;
    font-weight: 600;
    color: white;
    margin: 0 10px;
}
</style>
</head>
<body style="background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh;">
    <%@include file="allcomponent/Navber.jsp"%>

    <c:if test="${empty userobj}">
        <c:redirect url="login.jsp" />
    </c:if>

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="success-container">
                    <div class="success-header">
                        <h1><i class="fas fa-check-circle"></i> Order Successful!</h1>
                        <p class="lead mb-0">Thank you for your purchase. Your order has been confirmed.</p>
                    </div>
                    
                    <div class="success-body">
                        <div class="success-icon">
                            <i class="fas fa-check-circle"></i>
                        </div>
                        
                        <h3 class="text-success">Payment Completed Successfully</h3>
                        <p class="text-muted">Your books have been added to your library. You can start reading now!</p>
                        
                        <div class="order-details">
                            <h4 class="text-center mb-4">Order Details</h4>
                            
                            <div class="detail-item">
                                <span class="detail-label">Order ID:</span>
                                <span class="detail-value">${orderId}</span>
                            </div>
                            
                            <div class="detail-item">
                                <span class="detail-label">Customer Name:</span>
                                <span class="detail-value">${userobj.name}</span>
                            </div>
                            
                            <div class="detail-item">
                                <span class="detail-label">Email:</span>
                                <span class="detail-value">${userobj.email}</span>
                            </div>
                            
                            <div class="detail-item">
                                <span class="detail-label">Order Date:</span>
                                <span class="detail-value"><%= new java.util.Date() %></span>
                            </div>
                            
                            <div class="detail-item">
                                <span class="detail-label">Status:</span>
                                <span class="detail-value">Completed</span>
                            </div>
                        </div>
                        
                        <div class="action-buttons">
                            <a href="user_dashboard.jsp" class="btn btn-dashboard">
                                <i class="fas fa-tachometer-alt"></i> Go to Dashboard
                            </a>
                            <a href="user_dashboard.jsp" class="btn btn-library">
                                <i class="fas fa-book-reader"></i> View My Library
                            </a>
                        </div>
                        
                        <div class="mt-4">
                            <p class="text-muted">
                                A confirmation email has been sent to your email address.<br>
                                For any queries, please contact our support team.
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

   <%@include file="allcomponent/Footer.jsp"%>
</body>
</html>