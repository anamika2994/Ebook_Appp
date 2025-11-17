<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<%@ page import="com.DAO.BookDAOimpl"%>
<%@ page import="com.DB.DBconnect"%>
<%@ page import="java.util.*"%>
<%@ page import="com.entity.BookDtls"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin: Edit Book</title>
<%@include file="allCSS.jsp"%>
<style>

</style>
</head>
<body style="background-color: #f0f2f2;">
	<%@include file="Navber.jsp"%>
	<c:if test="${empty userobj}">
		<c:redirect url="../login.jsp" />
	</c:if>
	

	<div class="container">
		<div class="row">
			<div class="col-md-6 offset-md-3">
				<div class="card">
					<div class="card-body">
						<h4 class="text-center">Edit Book</h4>
						

						<%
						int id = Integer.parseInt(request.getParameter("id"));
						BookDAOimpl dao = new BookDAOimpl(DBconnect.getConn());
						BookDtls b = dao.getBookById(id);
						%>

						<form action="../editBooks" method="post">
						   <input type="hidden" name="id" value="<%=b.getId()%>">

							<div class="form-group">
								<label for="exampleInputEmail1">Book Name*</label> <input
									name="bname" type="text" class="form-control"
									id="exampleInputEmail1" aria-describedby="emailHelp"
									value="<%=b.getBookName()%>" required>
							</div>

							<div class="form-group">
								<label for="exampleInputEmail1">Author Name*</label> <input
									name="author" type="text" class="form-control"
									id="exampleInputEmail1" aria-describedby="emailHelp"
									value="<%=b.getAuthor()%>" required>
							</div>

							<div class="form-group">
								<label for="exampleInputPassword1">Price*</label> <input
									name="price" type="number" class="form-control"
									id="exampleInputPassword1" value="<%=b.getPrice()%>" required>
							</div>

							<div class="form-group">
								<label for="inputState">Book Status</label> <select
									id="inputState" name="status" class="form-control" required>
									<option value="Active" <%if ("Active".equals(b.getStatus())) {%> selected <%}%>>Active</option>
									<option value="Inactive" <%if ("Inactive".equals(b.getStatus())) {%> selected <%}%>>Inactive</option>
								</select>
							</div>
							
							<div class="text-center">
								<button type="submit" class="btn btn-primary">UPDATE BOOK</button>
								<a href="all_book.jsp" class="btn btn-secondary ml-2">CANCEL</a>
							</div>
						</form>

					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Footer -->
	 <%@include file="Footer.jsp"%>

</body>
</html>