<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ebook: Register</title>
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

.register-card {
	border: none;
	border-radius: 20px;
	box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
	overflow: hidden;
	transition: transform 0.3s ease;
	background: rgba(255, 255, 255, 0.95);
	backdrop-filter: blur(10px);
	width: 100%;
	max-width: 450px;
}

.register-card:hover {
	transform: translateY(-5px);
	box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15);
}

.register-header {
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	color: white;
	text-align: center;
	padding: 2rem;
	margin-bottom: 0;
}

.register-header h4 {
	margin: 0;
	font-weight: 600;
	font-size: 1.8rem;
}

.register-body {
	padding: 2.5rem;
}

.form-group {
	margin-bottom: 1.5rem;
	position: relative;
}

.form-group label {
	font-weight: 600;
	color: #333;
	margin-bottom: 0.5rem;
	display: block;
	font-size: 0.95rem;
}

.form-control {
	border: 2px solid #e9ecef;
	border-radius: 12px;
	padding: 0.75rem 1rem 0.75rem 2.5rem;
	font-size: 1rem;
	transition: all 0.3s ease;
	background: #fff;
	width: 100%;
}

.form-control:focus {
	border-color: #667eea;
	box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
	transform: translateY(-2px);
}

.form-icon {
	position: absolute;
	left: 1rem;
	top: 2.5rem;
	color: #667eea;
	font-size: 1rem;
}

.form-check {
	margin: 1.5rem 0;
	padding-left: 0;
}

.form-check-input {
	margin-right: 0.5rem;
	transform: scale(1.1);
}

.form-check-label {
	color: #555;
	font-size: 0.9rem;
}

.form-check-input:checked {
	background-color: #667eea;
	border-color: #667eea;
}

.btn-register {
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

.btn-register:hover {
	transform: translateY(-2px);
	box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
	color: white;
}

.login-link {
	text-align: center;
	margin-top: 1.5rem;
	padding-top: 1.5rem;
	border-top: 1px solid #e9ecef;
}

.login-link a {
	color: #667eea;
	text-decoration: none;
	font-weight: 600;
	transition: all 0.3s ease;
	display: inline-block;
}

.login-link a:hover {
	color: #764ba2;
	transform: translateX(5px);
}

.alert-message {
	border-radius: 12px;
	padding: 1rem 1.5rem;
	margin-bottom: 1.5rem;
	border: none;
	font-weight: 500;
	text-align: center;
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

@
keyframes slideUp {from { opacity:0;
	transform: translateY(20px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}

/* Password strength indicator */
.password-strength {
	height: 4px;
	border-radius: 2px;
	margin-top: 0.5rem;
	background: #e9ecef;
	overflow: hidden;
}

.strength-bar {
	height: 100%;
	width: 0%;
	transition: all 0.3s ease;
	border-radius: 2px;
}

/* Responsive Design */
@media ( max-width : 768px) {
	.main-content {
		padding: 1rem;
	}
	.register-card {
		margin: 1rem;
	}
	.register-body {
		padding: 2rem;
	}
}

/* Floating animation */
@
keyframes float { 0%, 100% {
	transform: translateY(0);
}

50
%
{
transform
:
translateY(
-10px
);
}
}
.register-card {
	animation: float 6s ease-in-out infinite;
}

/* Staggered animation delays */
.form-group:nth-child(1) {
	animation-delay: 0.1s;
}

.form-group:nth-child(2) {
	animation-delay: 0.2s;
}

.form-group:nth-child(3) {
	animation-delay: 0.3s;
}

.form-group:nth-child(4) {
	animation-delay: 0.4s;
}

.form-check {
	animation-delay: 0.5s;
}
</style>
</head>
<body>
	<%@include file="allcomponent/Navber.jsp"%>

	<div class="main-content">
		<div class="container">
			<div class="row">
				<div class="col-md-6 offset-md-3 col-lg-4 offset-lg-4">
					<div class="card register-card">
						<div class="register-header">
							<h4>
								<i class="fas fa-user-plus me-2"></i> Create Account
							</h4>
						</div>
						<div class="card-body register-body">
							<c:if test="${not empty succMsg }">
								<div class="alert alert-success alert-message">
									<i class="fas fa-check-circle me-2"></i> ${succMsg }
								</div>
								<c:remove var="succMsg" scope="session" />
							</c:if>

							<c:if test="${not empty failedMsg }">
								<div class="alert alert-danger alert-message">
									<i class="fas fa-exclamation-circle me-2"></i> ${failedMsg }
								</div>
								<c:remove var="failedMsg" scope="session" />
							</c:if>

							<form action="register" method="post" id="registerForm">
								<!-- Full Name -->
								<div class="form-group">
									<label for="fname"><i class="fas fa-user me-2"></i>
										Full Name</label> <input type="text" class="form-control" id="fname"
										name="fname" required placeholder="Enter your full name"
										style="text-align: left;">
								</div>

								<!-- Email -->
								<div class="form-group">
									<label for="email"><i class="fas fa-envelope me-2"></i>
										Email Address</label> <input type="email" class="form-control"
										id="email" name="email" required
										placeholder="Enter your email" style="text-align: left;">
								</div>

								<!-- Phone -->
								<div class="form-group">
									<label for="phno"><i class="fas fa-phone me-2"></i>
										Phone Number</label> <input type="tel" class="form-control" id="phno"
										name="phno" required placeholder="Enter phone number"
										style="text-align: left;">
								</div>

								<!-- Password -->
								<div class="form-group">
									<label for="password"><i class="fas fa-lock me-2"></i>
										Password</label> <input type="password" class="form-control"
										id="password" name="password" required
										placeholder="Create a password" style="text-align: left;">
									<div class="password-strength">
										<div class="strength-bar" id="passwordStrength"></div>
									</div>
								</div>

								<!-- Checkbox -->
								<div class="form-check">
									<input type="checkbox" class="form-check-input" id="check"
										name="check" required> <label class="form-check-label"
										for="check"> I agree to the terms and conditions </label>
								</div>

								<!-- Submit Button -->
								<button type="submit" class="btn btn-register">
									<i class="fas fa-user-plus me-2"></i> Create Account
								</button>

								<div class="login-link">
									Already have an account? <a href="login.jsp"> Sign In <i
										class="fas fa-arrow-right ms-1"></i>
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

	<script>
		// Password strength indicator
		document.getElementById('password').addEventListener(
				'input',
				function() {
					const password = this.value;
					const strengthBar = document
							.getElementById('passwordStrength');
					let strength = 0;

					if (password.length >= 6)
						strength += 25;
					if (password.match(/[a-z]/) && password.match(/[A-Z]/))
						strength += 25;
					if (password.match(/\d/))
						strength += 25;
					if (password.match(/[^a-zA-Z\d]/))
						strength += 25;

					strengthBar.style.width = strength + '%';

					// Color coding
					if (strength < 50) {
						strengthBar.style.background = '#dc3545';
					} else if (strength < 75) {
						strengthBar.style.background = '#ffc107';
					} else {
						strengthBar.style.background = '#28a745';
					}
				});

		// Form validation
		document.getElementById('registerForm').addEventListener('submit',
				function(e) {
					const password = document.getElementById('password').value;
					const checkbox = document.getElementById('check');

					if (password.length < 6) {
						e.preventDefault();
						alert('Password must be at least 6 characters long');
						return false;
					}

					if (!checkbox.checked) {
						e.preventDefault();
						alert('Please agree to the terms and conditions');
						return false;
					}
				});
	</script>
</body>
</html>