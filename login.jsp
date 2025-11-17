<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ebook: Login</title>
<%@include file="allcomponent/allCSS.jsp"%>
<style>
body {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    min-height: 100vh;
    display: flex;
    flex-direction: column;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

.main-content {
    flex: 1;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 2rem 0;
}

.login-card {
    border: none;
    border-radius: 20px;
    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
    overflow: hidden;
    transition: transform 0.3s ease;
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
}

.login-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
}

.login-header {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    text-align: center;
    padding: 2rem;
    margin-bottom: 1.5rem;
}

.login-header h4 {
    margin: 0;
    font-weight: 600;
    font-size: 1.8rem;
}

.login-body {
    padding: 2rem;
}

.form-group {
    margin-bottom: 1.5rem;
}

.form-group label {
    font-weight: 600;
    color: #333;
    margin-bottom: 0.5rem;
    display: block;
}

.form-control {
    border: 2px solid #e9ecef;
    border-radius: 12px;
    padding: 0.75rem 1rem;
    font-size: 1rem;
    transition: all 0.3s ease;
    background: #fff;
}

.form-control:focus {
    border-color: #667eea;
    box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
    transform: translateY(-2px);
}

.btn-login {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    border: none;
    border-radius: 12px;
    padding: 0.75rem 2rem;
    font-weight: 600;
    font-size: 1.1rem;
    color: white;
    width: 100%;
    transition: all 0.3s ease;
    margin-top: 1rem;
}

.btn-login:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
    color: white;
}

.create-account-link {
    text-align: center;
    margin-top: 1.5rem;
    padding-top: 1.5rem;
    border-top: 1px solid #e9ecef;
}

.create-account-link a {
    color: #667eea;
    text-decoration: none;
    font-weight: 600;
    transition: all 0.3s ease;
    display: inline-block;
}

.create-account-link a:hover {
    color: #764ba2;
    transform: translateX(5px);
}

.alert-message {
    border-radius: 12px;
    padding: 1rem 1.5rem;
    margin-bottom: 1.5rem;
    border: none;
    font-weight: 500;
}

.alert-success {
    background: linear-gradient(135deg, #d4edda, #c3e6cb);
    color: #155724;
}

.alert-danger {
    background: linear-gradient(135deg, #f8d7da, #f1b0b7);
    color: #721c24;
}

/* Animation for form elements */
.form-group {
    animation: slideUp 0.5s ease;
}

@keyframes slideUp {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

/* Responsive Design */
@media (max-width: 768px) {
    .main-content {
        padding: 1rem;
    }
    
    .login-card {
        margin: 1rem;
    }
    
    .login-body {
        padding: 1.5rem;
    }
}

/* Floating animation for card */
@keyframes float {
    0%, 100% {
        transform: translateY(0);
    }
    50% {
        transform: translateY(-10px);
    }
}

.login-card {
    animation: float 6s ease-in-out infinite;
}
</style>
</head>
<body>
	<%@include file="allcomponent/Navber.jsp"%>
	
	<div class="main-content">
		<div class="container">
			<div class="row">
				<div class="col-md-6 offset-md-3 col-lg-4 offset-lg-4">
					<div class="card login-card">
						<div class="login-header">
							<h4><i class="fas fa-sign-in-alt me-2"></i> Welcome Back</h4>
						</div>
						<div class="card-body login-body">
							<c:if test="${not empty failedMsg}">
								<div class="alert alert-danger alert-message text-center">
									<i class="fas fa-exclamation-circle me-2"></i>${failedMsg}
								</div>
								<c:remove var="failedMsg" scope="session" />
							</c:if>

							<c:if test="${not empty succMsg}">
								<div class="alert alert-success alert-message text-center">
									<i class="fas fa-check-circle me-2"></i>${succMsg}
								</div>
								<c:remove var="succMsg" scope="session" />
							</c:if>
							
							<form action="login" method="post">
								<div class="form-group">
									<label for="email"><i class="fas fa-envelope me-2"></i> Email Address</label> 
									<input type="email"
										class="form-control" id="email" name="email"
										placeholder="Enter your email" required>
								</div>

								<div class="form-group">
									<label for="password"><i class="fas fa-lock me-2"></i> Password</label> 
									<input type="password"
										class="form-control" id="password" name="password"
										placeholder="Enter your password" required>
								</div>

								<button type="submit" class="btn btn-login">
									<i class="fas fa-sign-in-alt me-2"></i> Login
								</button>
								
								<div class="create-account-link">
									Don't have an account? 
									<a href="register.jsp">
										Create Account <i class="fas fa-arrow-right ms-1"></i>
									</a>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<%@include file="allcomponent/Footer.jsp"%>
</body>
</html>