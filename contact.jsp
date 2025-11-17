<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Contact Us</title>
<%@include file="allcomponent/allCSS.jsp"%>
<style>
.contact-hero {
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	color: white;
	padding: 60px 0;
	text-align: center;
}

.contact-card {
	background: white;
	border-radius: 15px;
	box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
	margin-top: -50px;
	position: relative;
	z-index: 1;
}

.contact-info-box {
	text-align: center;
	padding: 30px;
	border-radius: 10px;
	margin-bottom: 20px;
	transition: transform 0.3s ease;
}

.contact-info-box:hover {
	transform: translateY(-5px);
}

.contact-icon {
	font-size: 40px;
	margin-bottom: 15px;
}

.info-email {
	background: #e3f2fd;
	color: #1565c0;
}

.info-phone {
	background: #f3e5f5;
	color: #7b1fa2;
}

.info-address {
	background: #e8f5e8;
	color: #2e7d32;
}

.info-hours {
	background: #fff3e0;
	color: #ef6c00;
}

.contact-form {
	padding: 40px;
}

/* ✅ Fix for Subject dropdown text */
select.form-control {
	color: #333 !important; /* readable dark text */
	background-color: #fff !important;
	font-size: 16px;
	font-weight: 500;
	border: 1px solid #ccc;
	border-radius: 8px;
	padding: 8px 12px;
}

select.form-control option {
	color: #000 !important;
	background-color: #fff !important;
}

/* Optional hover effect */
select.form-control:hover {
	border-color: #667eea;
	box-shadow: 0 0 5px rgba(102, 126, 234, 0.3);
}

.map-container {
	border-radius: 10px;
	overflow: hidden;
	margin-top: 30px;
}
</style>
</head>
<body>
	<%@include file="allcomponent/Navber.jsp"%>

	<!-- Hero Section -->
	<div class="contact-hero">
		<div class="container">
			<h1><i class="fas fa-headset"></i> Contact Us</h1>
			<p class="lead">We'd love to hear from you. Get in touch with any
				questions or feedback.</p>
		</div>
	</div>

	<div class="container">
		<div class="contact-card">
			<div class="row">
				<!-- Contact Information -->
				<div class="col-md-4">
					<div class="p-4">
						<h4 class="mb-4">Get In Touch</h4>

						<div class="contact-info-box info-email">
							<div class="contact-icon">
								<i class="fas fa-envelope"></i>
							</div>
							<h5>Email Us</h5>
							<p>support@ebookstore.com</p>
							<p>info@ebookstore.com</p>
						</div>

						<div class="contact-info-box info-phone">
							<div class="contact-icon">
								<i class="fas fa-phone"></i>
							</div>
							<h5>Call Us</h5>
							<p>+1 (555) 123-4567</p>
							<p>+1 (555) 987-6543</p>
						</div>

						<div class="contact-info-box info-address">
							<div class="contact-icon">
								<i class="fas fa-map-marker-alt"></i>
							</div>
							<h5>Visit Us</h5>
							<p>123 Book Street<br>Knowledge City, KC 12345</p>
						</div>

						
					</div>
				</div>

				<!-- Contact Form -->
				<div class="col-md-8">
					<div class="contact-form">
						<h4 class="mb-4">Send us a Message</h4>

						<c:if test="${not empty succMsg}">
							<div class="alert alert-success">${succMsg}</div>
							<c:remove var="succMsg" scope="session" />
						</c:if>

						<form action="sendMessage" method="post">
							<div class="row">
								<div class="col-md-6">
									<div class="form-group">
										<label>Your Name *</label>
										<input type="text" class="form-control" name="name" value="${userobj.name}" required>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group">
										<label>Your Email *</label>
										<input type="email" class="form-control" name="email" value="${userobj.email}" required>
									</div>
								</div>
							</div>

							<div class="form-group">
								<label>Subject *</label>
								<select class="form-control" name="subject" required>
									<option value="">Select a subject</option>
									<option value="general">General Inquiry</option>
									<option value="technical">Technical Support</option>
									<option value="billing">Billing Issue</option>
									<option value="feature">Feature Request</option>
									<option value="bug">Report a Bug</option>
									<option value="other">Other</option>
								</select>
							</div>

							<div class="form-group">
								<label>Message *</label>
								<textarea class="form-control" name="message" rows="6"
									placeholder="Please describe your issue or question in detail..." required></textarea>
							</div>

							<div class="form-group form-check">
								<input type="checkbox" class="form-check-input" id="newsletter" name="newsletter">
								<label class="form-check-label" for="newsletter">
									Subscribe to our newsletter for updates and promotions
								</label>
							</div>

							<button type="submit" class="btn btn-primary btn-lg">
								<i class="fas fa-paper-plane"></i> Send Message
							</button>
						</form>
					</div>
				</div>
			</div>

			<!-- Map Section -->
			<div class="row">
				<div class="col-12">
					<div class="map-container">
						<iframe
							src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3651.862833878461!2d90.38831431543127!3d23.750923884588!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3755b8bd552c2b3b%3A0x4e70f1178561322e!2sBangladesh%20University%20of%20Professionals!5e0!3m2!1sen!2sbd!4v1642162356785!5m2!1sen!2sbd"
							width="100%" height="300" style="border:0;" allowfullscreen=""
							loading="lazy"></iframe>
					</div>
				</div>
			</div>
		</div>
	</div>
<%@include file="allcomponent/Footer.jsp"%>
</body>
</html>
