<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin: Order Management</title>
<%@include file="allCSS.jsp"%>
<style>
.table thead {
    background-color: #263238 !important;
    color: white !important;
}

.badge {
    padding: 5px 10px;
    border-radius: 4px;
    font-size: 12px;
}

.badge-success { background-color: #28a745; color: white; }
.badge-warning { background-color: #ffc107; color: black; }
.badge-danger { background-color: #dc3545; color: white; }
.badge-info { background-color: #17a2b8; color: white; }
</style>
</head>
<body style="background-color: #f0f2f5;">
    <%@include file="Navber.jsp"%>
    
    <c:if test="${empty userobj}">
        <c:redirect url="../login.jsp" />
    </c:if>
    
    <div class="container">
        <h1 class="text-center my-4">ORDER MANAGEMENT</h1>

        <div class="table-responsive">
            <table class="table table-striped table-bordered">
                <thead class="thead-dark">
                    <tr>
                        <th>ORDER ID</th>
                        <th>CUSTOMER NAME</th>
                        <th>EMAIL</th>
                        <th>AMOUNT</th>
                        <th>PAYMENT METHOD</th>
                        <th>STATUS</th>
                        <th>DATE</th>
                        <th>ACTION</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty orderList}">
                            <c:forEach var="order" items="${orderList}">
                                <tr>
                                    <td>${order.orderId}</td>
                                    <td>${order.customerName}</td>
                                    <td>${order.customerEmail}</td>
                                    <td>৳${order.amount}</td>
                                    <td>${order.paymentMethod}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${order.paymentStatus == 'Completed'}">
                                                <span class="badge badge-success">Completed</span>
                                            </c:when>
                                            <c:when test="${order.paymentStatus == 'Pending'}">
                                                <span class="badge badge-warning">Pending</span>
                                            </c:when>
                                            <c:when test="${order.paymentStatus == 'Failed'}">
                                                <span class="badge badge-danger">Failed</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-info">${order.paymentStatus}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>${order.createdAt}</td>
                                    <td>
                                        <button class="btn btn-sm btn-info" 
                                                onclick="viewOrderDetails(${order.id})">
                                            View Details
                                        </button>
                                        <c:if test="${order.paymentStatus == 'Pending'}">
                                            <button class="btn btn-sm btn-success mt-1" 
                                                    onclick="updateOrderStatus(${order.id}, 'Completed')">
                                                Mark Complete
                                            </button>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="8" class="text-center text-danger">
                                    <strong>No orders found!</strong>
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>

    <div class="modal fade" id="orderDetailsModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Order Details</h5>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                <div class="modal-body" id="orderDetailsContent">
                    </div>
            </div>
        </div>
    </div>

    <script>
    function viewOrderDetails(orderId) {
        // FIX: 'admin/' অংশটি বাদ দেওয়া হলো
        fetch('orderDetails?orderId=' + orderId)
            .then(response => response.text())
            .then(data => {
                document.getElementById('orderDetailsContent').innerHTML = data;
                $('#orderDetailsModal').modal('show');
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Error loading order details');
            });
    }
    
    function updateOrderStatus(orderId, status) {
        if(confirm('Are you sure you want to update this order status?')) {
            // FIX: 'admin/' অংশটি বাদ দেওয়া হলো
            fetch('updateOrderStatus?orderId=' + orderId + '&status=' + status)
                .then(response => response.json())
                .then(data => {
                    if(data.success) {
                        alert('Order status updated successfully!');
                        location.reload();
                    } else {
                        alert('Failed to update order status!');
                    }
                })
                .catch(error => {
                    console.error('Error:', error);
                    alert('Error updating order status');
                });
        }
    }
    </script>
     <%@include file="Footer.jsp"%>
</body>
</html>