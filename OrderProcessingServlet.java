package com.user.servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.List;
import java.util.UUID;
import com.DAO.CartDAOimpl;
import com.DAO.PaymentDAOImpl;
import com.DAO.UserBooksDAOImpl;
import com.DB.DBconnect;
import com.entity.Cart;
import com.entity.Payment;
import com.entity.UserBooks;
import com.entity.user;

public class OrderProcessingServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();

		try {
			user currentUser = (user) session.getAttribute("userobj");

			if (currentUser == null) {
				response.sendRedirect("login.jsp");
				return;
			}

			System.out.println("=== ORDER PROCESSING STARTED ===");
			System.out.println("User: " + currentUser.getName() + " (ID: " + currentUser.getUserid() + ")");

			// Get form data
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String phno = request.getParameter("phno");
			String address = request.getParameter("address");
			String paymentMethod = request.getParameter("paymentMethod");

			System.out.println("Payment Method: " + paymentMethod);

			// Generate unique order ID
			String orderId = "ORD-" + UUID.randomUUID().toString().substring(0, 8).toUpperCase();
			System.out.println("Generated Order ID: " + orderId);

			// Get cart items and calculate total
			CartDAOimpl cartDAO = new CartDAOimpl(DBconnect.getConn());
			List<Cart> cartItems = cartDAO.getBookByUser(currentUser.getUserid());
			double totalAmount = 0.0;

			System.out.println("Found " + cartItems.size() + " items in cart");

			for (Cart item : cartItems) {
				totalAmount += item.getPrice();
				System.out.println(" - " + item.getBookName() + ": ৳" + item.getPrice());
			}

			System.out.println("Total Amount: ৳" + totalAmount);

			// Process payment details
			String transactionId = "";
			String phoneNumber = "";

			if ("bkash".equals(paymentMethod)) {
				phoneNumber = request.getParameter("bkashPhone");
				transactionId = request.getParameter("bkashTransaction");
				System.out.println("bKash - Phone: " + phoneNumber + ", TXN: " + transactionId);
			} else if ("nogod".equals(paymentMethod)) {
				phoneNumber = request.getParameter("nogodPhone");
				transactionId = request.getParameter("nogodTransaction");
				System.out.println("Nagad - Phone: " + phoneNumber + ", TXN: " + transactionId);
			} else if ("card".equals(paymentMethod)) {
				String cardNumber = request.getParameter("cardNumber");
				phoneNumber = "Card Payment";
				transactionId = "CARD-" + (cardNumber != null && cardNumber.length() >= 4
						? cardNumber.substring(cardNumber.length() - 4)
						: "XXXX");
				System.out.println("Card - Last 4: " + transactionId);
			}

			// Create payment record
			Payment payment = new Payment();
			payment.setUserId(currentUser.getUserid());
			payment.setOrderId(orderId);
			payment.setAmount(totalAmount);
			payment.setPaymentMethod(paymentMethod);
			payment.setPaymentStatus("completed");
			payment.setTransactionId(transactionId.isEmpty() ? "TXN-" + System.currentTimeMillis() : transactionId);
			payment.setPhoneNumber(phoneNumber.isEmpty() ? "N/A" : phoneNumber);

			PaymentDAOImpl paymentDAO = new PaymentDAOImpl(DBconnect.getConn());
			boolean paymentSuccess = paymentDAO.createPayment(payment);

			System.out.println("Payment record created: " + paymentSuccess);

			// OrderProcessingServlet e ei part replace korun
			if (paymentSuccess) {
				System.out.println("=== ADDING BOOKS TO USER LIBRARY ===");

				// Add books to user's purchased books
				UserBooksDAOImpl userBooksDAO = new UserBooksDAOImpl(DBconnect.getConn());
				boolean allBooksAdded = true;
				int booksAdded = 0;

				for (Cart cartItem : cartItems) {
					try {
						UserBooks userBook = new UserBooks();
						userBook.setUserId(currentUser.getUserid());
						userBook.setBookId(cartItem.getBid());
						userBook.setUserNotes(""); // Empty notes initially

						System.out.println("Attempting to add - UserID: " + currentUser.getUserid() + ", BookID: "
								+ cartItem.getBid() + ", Book: " + cartItem.getBookName());

						boolean bookAdded = userBooksDAO.addUserBook(userBook);

						if (bookAdded) {
							booksAdded++;
							System.out.println("✓ Successfully added: " + cartItem.getBookName());
						} else {
							allBooksAdded = false;
							System.out.println("✗ FAILED to add: " + cartItem.getBookName());
						}
					} catch (Exception ex) {
						System.out.println("ERROR adding book " + cartItem.getBookName() + ": " + ex.getMessage());
						allBooksAdded = false;
					}
				}

				System.out.println("=== LIBRARY UPDATE SUMMARY ===");
				System.out.println("Books successfully added: " + booksAdded + "/" + cartItems.size());

				// Clear the cart
				boolean cartCleared = cartDAO.clearUserCart(currentUser.getUserid());
				System.out.println("Cart cleared: " + cartCleared);

				// Set success message
				if (booksAdded > 0) {
					session.setAttribute("succMsg", "Order placed successfully! " + booksAdded
							+ " books added to your library. Order ID: " + orderId);
					response.sendRedirect("order_success.jsp");
				} else {
					session.setAttribute("failedMsg",
							"Order placed but no books were added to library. Please contact support.");
					response.sendRedirect("cart.jsp");
				}
			}
		} catch (Exception e) {
			System.out.println("ERROR in order processing: " + e.getMessage());
			e.printStackTrace();
			session.setAttribute("failedMsg", "Order processing failed: " + e.getMessage());
			response.sendRedirect("cart.jsp");
		}
	}
}