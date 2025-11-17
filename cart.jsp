<%@page import="com.DB.DBconnect"%>
<%@page import="com.DAO.CartDAOimpl"%>
<%@page import="com.entity.user"%>
<%@page import="com.entity.Cart"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cart - Ebook Store</title>
<%@include file="allcomponent/allCSS.jsp"%>
<style>
body {
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	min-height: 100vh;
}

.cart-container {
	margin-top: 30px;
	margin-bottom: 50px;
}

.cart-card {
	border: none;
	border-radius: 15px;
	box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
	overflow: hidden;
	margin-bottom: 25px;
}

.cart-header {
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	color: white;
	padding: 20px;
	text-align: center;
}

.cart-body {
	padding: 30px;
	background: white;
}

.table-custom {
	border-radius: 10px;
	overflow: hidden;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
}

.table-custom thead {
	background: #2c3e50;
	color: white;
}

.table-custom th {
	border: none;
	padding: 15px;
	font-weight: 600;
}

.table-custom td {
	border: none;
	padding: 15px;
	vertical-align: middle;
}

.table-custom tbody tr {
	transition: all 0.3s ease;
}

.table-custom tbody tr:hover {
	background-color: #f8f9fa;
	transform: translateY(-2px);
}

.total-row {
	background: #e8f5e8 !important;
	font-weight: 600;
	font-size: 18px;
}

.empty-cart {
	text-align: center;
	padding: 50px 20px;
}

.empty-cart i {
	font-size: 80px;
	color: #bdc3c7;
	margin-bottom: 20px;
}

.empty-cart h4 {
	color: #7f8c8d;
	margin-bottom: 15px;
}

.payment-section {
	background: white;
	border-radius: 15px;
	padding: 0;
	overflow: hidden;
	box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
}

.payment-header {
	background: linear-gradient(135deg, #00b09b 0%, #96c93d 100%);
	color: white;
	padding: 20px;
	text-align: center;
}

.payment-methods {
	padding: 25px;
}

.payment-option {
	margin-bottom: 20px;
	padding: 15px;
	border: 2px solid #e9ecef;
	border-radius: 12px;
	transition: all 0.3s ease;
	background: #f8f9fa;
}

.payment-option:hover {
	border-color: #667eea;
	background: white;
	transform: translateY(-3px);
	box-shadow: 0 8px 25px rgba(102, 126, 234, 0.15);
}

.payment-option input[type="radio"] {
	display: none;
}

.payment-label {
	display: flex;
	align-items: center;
	cursor: pointer;
	padding: 10px;
	border-radius: 8px;
	transition: all 0.3s ease;
	margin-bottom: 0;
}

.payment-label:hover {
	background-color: rgba(102, 126, 234, 0.1);
}

.payment-label img {
	margin-right: 15px;
	width: 50px;
	height: 50px;
	object-fit: contain;
	border-radius: 8px;
	padding: 5px;
	background: white;
	box-shadow: 0 3px 10px rgba(0, 0, 0, 0.1);
}

.payment-label span {
	font-size: 18px;
	font-weight: 600;
	color: #2c3e50;
}

.payment-option input[type="radio"]:checked+.payment-label {
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	color: white;
}

.payment-option input[type="radio"]:checked+.payment-label span {
	color: white;
}

.payment-details {
	display: none;
	margin-top: 20px;
	padding: 20px;
	background: white;
	border-radius: 10px;
	border-left: 4px solid #667eea;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
	animation: slideDown 0.3s ease;
}

@
keyframes slideDown {from { opacity:0;
	transform: translateY(-10px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}
.payment-option input[type="radio"]:checked ~ .payment-details {
	display: block;
}

.payment-instructions {
	background: linear-gradient(135deg, #e3f2fd 0%, #f3e5f5 100%);
	border: 1px solid #bbdefb;
	border-radius: 10px;
	padding: 15px;
	margin-top: 15px;
}

.payment-instructions strong {
	color: #1976d2;
}

.btn-custom {
	background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
	border: none;
	border-radius: 25px;
	padding: 12px 30px;
	font-weight: 600;
	color: white;
	transition: all 0.3s ease;
	box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
}

.btn-custom:hover {
	transform: translateY(-3px);
	box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
	color: white;
}

.btn-success-custom {
	background: linear-gradient(135deg, #00b09b 0%, #96c93d 100%);
	border: none;
	border-radius: 25px;
	padding: 12px 30px;
	font-weight: 600;
	color: white;
	transition: all 0.3s ease;
}

.btn-success-custom:hover {
	transform: translateY(-3px);
	box-shadow: 0 8px 25px rgba(0, 176, 155, 0.3);
	color: white;
}

.form-control {
	border-radius: 10px;
	border: 2px solid #e9ecef;
	padding: 12px 15px;
	transition: all 0.3s ease;
}

.form-control:focus {
	border-color: #667eea;
	box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
}

.error-message {
	color: #dc3545;
	font-size: 14px;
	margin-top: 5px;
	display: none;
}

@media ( max-width : 768px) {
	.cart-container {
		margin-top: 15px;
	}
	.cart-body {
		padding: 20px;
	}
	.payment-methods {
		padding: 15px;
	}
	.payment-label img {
		width: 40px;
		height: 40px;
	}
	.payment-label span {
		font-size: 16px;
	}
}
</style>
</head>

<body>
	<%@include file="allcomponent/Navber.jsp"%>
	<div class="container-fluid">
    <c:if test="${not empty succMsg}">
        <div class="alert alert-success alert-dismissible fade show text-center" role="alert">
            <i class="fas fa-check-circle"></i> ${succMsg}
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <c:remove var="succMsg" scope="session"/>
    </c:if>

    <c:if test="${not empty failedMsg}">
        <div class="alert alert-danger alert-dismissible fade show text-center" role="alert">
            <i class="fas fa-exclamation-circle"></i> ${failedMsg}
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
        <c:remove var="failedMsg" scope="session"/>
    </c:if>
</div>

<div class="container cart-container">

	<c:if test="${empty userobj}">
		<c:redirect url="login.jsp" />
	</c:if>

	<div class="container cart-container">
		<div class="row">
			<!-- Cart Items Section -->
			<div class="col-lg-6 mb-4">
				<div class="cart-card">
					<div class="cart-header">
						<h3>
							<i class="fas fa-shopping-cart"></i> Your Cart Items
						</h3>
					</div>
					<div class="cart-body">
						<%
						user u = (user) session.getAttribute("userobj");
						CartDAOimpl dao = new CartDAOimpl(DBconnect.getConn());
						List<Cart> cart = dao.getBookByUser(u.getUserid());
						double totalPrice = 0.00;

						if (cart.isEmpty()) {
						%>
						<div class="empty-cart">
							<i class="fas fa-shopping-cart"></i>
							<h4>Your cart is empty</h4>
							<p>Start adding some books to your cart!</p>
							<a href="index.jsp" class="btn btn-custom">Browse Books</a>
						</div>
						<%
						} else {
						%>
						<div class="table-responsive">
							<table class="table table-custom">
								<thead>
									<tr>
										<th>Book Name</th>
										<th>Author</th>
										<th>Price</th>
										<th>Action</th>
									</tr>
								</thead>
								<tbody>
									<%
									for (Cart c : cart) {
										totalPrice += c.getPrice();
									%>
									<tr>
										<td><strong><%=c.getBookName()%></strong></td>
										<td><%=c.getAuthor()%></td>
										<td class="text-success"><strong>৳<%=c.getPrice()%></strong></td>
										<td>
											<form action="CartRemove" method="post"
												style="display: inline;">
												<input type="hidden" name="bookId" value="<%=c.getBid()%>">
												<button type="submit" class="btn btn-danger btn-sm"
													onclick="return confirm('Are you sure you want to remove this book from cart?')">
													<i class="fas fa-trash"></i> Remove
												</button>
											</form>
										</td>
									</tr>
									<%
									}
									%>
									<tr class="total-row">
										<td colspan="2"><strong>Total Amount</strong></td>
										<td colspan="2" class="text-success"><strong>৳<%=String.format("%.2f", totalPrice)%></strong>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
						<%
						}
						%>
					</div>
				</div>
			</div>

			<!-- Order & Payment Section -->
			<div class="col-lg-6 mb-4">
				<div class="payment-section">
					<div class="payment-header">
						<h3>
							<i class="fas fa-credit-card"></i> Order & Payment Details
						</h3>
					</div>
					<%
					if (!cart.isEmpty()) {
					%>
					<form action="processOrder" method="post" class="payment-methods"
						id="orderForm">
						<!-- Personal Information -->
						<h5 class="mb-3">
							<i class="fas fa-user"></i> Personal Information
						</h5>
						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<label>Full Name *</label> <input type="text"
										class="form-control" name="name" value="${userobj.name}"
										required>
									<div class="error-message" id="nameError">Please enter
										your full name</div>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Email *</label> <input type="email" class="form-control"
										name="email" value="${userobj.email}" required readonly>
								</div>
							</div>
						</div>

						<div class="row">
							<div class="col-md-6">
								<div class="form-group">
									<label>Phone Number *</label> <input type="tel"
										class="form-control" name="phno" value="${userobj.phno}"
										required pattern="[0-9]{11}">
									<div class="error-message" id="phoneError">Please enter a
										valid 11-digit phone number</div>
								</div>
							</div>
							<div class="col-md-6">
								<div class="form-group">
									<label>Address *</label> <input type="text"
										class="form-control" name="address" value="${userobj.address}"
										required>
									<div class="error-message" id="addressError">Please enter
										your address</div>
								</div>
							</div>
						</div>

						<!-- Payment Method -->
						<h5 class="mb-3 mt-4">
							<i class="fas fa-wallet"></i> Select Payment Method
						</h5>
						<div class="error-message" id="paymentMethodError">Please
							select a payment method</div>

						<!-- bKash -->
						<div class="payment-option">
							<input type="radio" id="bkash" name="paymentMethod" value="bkash">
							<label for="bkash" class="payment-label"> <img
								src="img/bkash.png" alt="bKash"> <span>bKash</span>
							</label>
							<div class="payment-details" id="bkash-details">
								<div class="form-group">
									<label>bKash Phone Number *</label> <input type="tel"
										class="form-control" name="bkashPhone"
										placeholder="01XXXXXXXXX" pattern="[0-9]{11}">
									<div class="error-message" id="bkashPhoneError">Please
										enter a valid bKash phone number</div>
								</div>
								<div class="form-group">
									<label>Transaction ID *</label> <input type="text"
										class="form-control" name="bkashTransaction"
										placeholder="Enter bKash Transaction ID">
									<div class="error-message" id="bkashTransactionError">Please
										enter bKash transaction ID</div>
								</div>
								<div class="payment-instructions">
									<strong>How to pay with bKash:</strong><br> 1. Go to bKash
									Menu → "Send Money"<br> 2. Send to: <strong>017XXXXXXXX</strong><br>
									3. Amount: <strong>৳<%=totalPrice%></strong><br> 4. Use
									this reference: <strong>ORDER<%=System.currentTimeMillis()%></strong>
								</div>
							</div>
						</div>

						<!-- Nagad -->
						<div class="payment-option">
							<input type="radio" id="nogod" name="paymentMethod" value="nogod">
							<label for="nogod" class="payment-label"> <img
								src="img/nogod.png" alt="Nagad"> <span>Nagad</span>
							</label>
							<div class="payment-details" id="nogod-details">
								<div class="form-group">
									<label>Nagad Phone Number *</label> <input type="tel"
										class="form-control" name="nogodPhone"
										placeholder="01XXXXXXXXX" pattern="[0-9]{11}">
									<div class="error-message" id="nogodPhoneError">Please
										enter a valid Nagad phone number</div>
								</div>
								<div class="form-group">
									<label>Transaction ID *</label> <input type="text"
										class="form-control" name="nogodTransaction"
										placeholder="Enter Nagad Transaction ID">
									<div class="error-message" id="nogodTransactionError">Please
										enter Nagad transaction ID</div>
								</div>
								<div class="payment-instructions">
									<strong>How to pay with Nagad:</strong><br> 1. Go to Nagad
									Menu → "Send Money"<br> 2. Send to: <strong>017XXXXXXXX</strong><br>
									3. Amount: <strong>৳<%=totalPrice%></strong>
								</div>
							</div>
						</div>

						<!-- Card Payment -->
						<div class="payment-option">
							<input type="radio" id="card" name="paymentMethod" value="card">
							<label for="card" class="payment-label"> <img
								src="img/card.png" alt="Card"> <span>Credit/Debit
									Card</span>
							</label>
							<div class="payment-details" id="card-details">
								<div class="form-group">
									<label>Card Number *</label> <input type="text"
										class="form-control" name="cardNumber"
										placeholder="1234 5678 9012 3456" pattern="[0-9\s]{13,19}">
									<div class="error-message" id="cardNumberError">Please
										enter a valid card number</div>
								</div>
								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<label>Expiry Date *</label> <input type="text"
												class="form-control" name="cardExpiry" placeholder="MM/YY"
												pattern="(0[1-9]|1[0-2])\/[0-9]{2}">
											<div class="error-message" id="cardExpiryError">Please
												enter valid expiry date (MM/YY)</div>
										</div>
									</div>
									<div class="col-md-6">
										<div class="form-group">
											<label>CVV *</label> <input type="text" class="form-control"
												name="cardCvv" placeholder="123" pattern="[0-9]{3,4}">
											<div class="error-message" id="cardCvvError">Please
												enter valid CVV</div>
										</div>
									</div>
								</div>
							</div>
						</div>

						<!-- Action Buttons -->
						<div class="text-center mt-4">
							<button type="submit" class="btn btn-custom btn-lg mr-3">
								<i class="fas fa-check-circle"></i> Confirm Order
							</button>
							<a href="index.jsp" class="btn btn-success-custom btn-lg"> <i
								class="fas fa-shopping-bag"></i> Continue Shopping
							</a>
						</div>
					</form>
					<%
					}
					%>
				</div>
			</div>
		</div>
	</div>

	<script>
document.addEventListener('DOMContentLoaded', function() {
    const paymentMethods = document.querySelectorAll('input[name="paymentMethod"]');
    const form = document.getElementById('orderForm');

    // Payment method selection
    paymentMethods.forEach(method => {
        method.addEventListener('change', function() {
            document.querySelectorAll('.payment-details').forEach(detail => {
                detail.style.display = 'none';
            });
            
            document.getElementById('paymentMethodError').style.display = 'none';

            const selectedDetails = document.getElementById(this.value + '-details');
            if (selectedDetails) {
                selectedDetails.style.display = 'block';
            }
        });
    });

    // Form validation
    form.addEventListener('submit', function(e) {
        let isValid = true;

        // Basic information validation
        const name = form.name.value.trim();
        const phone = form.phno.value.trim();
        const address = form.address.value.trim();

        if (name.length < 2) {
            document.getElementById('nameError').style.display = 'block';
            isValid = false;
        }

        if (!/^[0-9]{11}$/.test(phone)) {
            document.getElementById('phoneError').style.display = 'block';
            isValid = false;
        }

        if (address.length < 5) {
            document.getElementById('addressError').style.display = 'block';
            isValid = false;
        }

        // Payment method validation
        const selectedPayment = document.querySelector('input[name="paymentMethod"]:checked');
        if (!selectedPayment) {
            document.getElementById('paymentMethodError').style.display = 'block';
            isValid = false;
        }

        if (!isValid) {
            e.preventDefault();
        }
    });
});
</script>

<%@include file="allcomponent/Footer.jsp"%>
</body>
</html>