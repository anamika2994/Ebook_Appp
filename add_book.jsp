<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin: Add Book</title>
<%@include file="allCSS.jsp"%>

<style>
body {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    min-height: 100vh;
    font-family: Arial, sans-serif;
}

/* Labels */
label {
    color: #000 !important;
    font-weight: 500;
    font-size: 13px;
    margin-bottom: 2px;
}

/* Card */
.card {
    border-radius: 10px;
    box-shadow: 0 3px 10px rgba(0,0,0,0.1);
    transition: all 0.3s ease;
    padding: 10px;
}
.card:hover {
    transform: translateY(-1px);
    box-shadow: 0 5px 15px rgba(0,0,0,0.15);
}

/* Heading */
.card-body h4 {
    font-size: 16px;
    margin-bottom: 8px;
    text-align: center;
}

/* Inputs & Textareas */
input.form-control,
textarea.form-control {
    height: 30px !important;
    font-size: 13px;
    padding: 4px 8px !important;
    border-radius: 8px !important;
    margin-bottom: 6px;
}

/* Select */
select.form-control {
    height: 30px !important;
    font-size: 13px;
    padding: 4px 8px !important;
    border-radius: 8px !important;
    margin-bottom: 6px;
}

/* File Input */
input.form-control-file {
    padding: 3px 0;
    margin-bottom: 6px;
}

/* Button */
.btn-primary.btn-block {
    padding: 6px 0;
    font-size: 13px;
    border-radius: 8px;
    margin-top: 6px;
}

/* Form group spacing */
.form-group {
    margin-bottom: 6px;
}

/* Messages */
.text-success, .text-danger {
    font-size: 13px;
    margin-bottom: 6px;
}

/* Responsive */
@media (max-width: 768px) {
    .col-md-4 { margin-bottom: 10px; }
    input.form-control, select.form-control, textarea.form-control { font-size: 12px; height: 28px; }
    .btn-block { font-size: 12px; padding: 5px 0; }
    .card-body h4 { font-size: 15px; }
}
</style>
</head>

<body>
    <%@include file="Navber.jsp"%>

    <c:if test="${empty userobj}">
        <c:redirect url="../login.jsp" />
    </c:if>

    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h4>Add Books</h4>

                        <c:if test="${not empty succMsg}">
                            <p class="text-success">${succMsg}</p>
                            <c:remove var="succMsg" scope="session" />
                        </c:if>

                        <c:if test="${not empty failedMsg}">
                            <p class="text-danger">${failedMsg}</p>
                            <c:remove var="failedMsg" scope="session" />
                        </c:if>

                        <form action="../add_book" method="post" enctype="multipart/form-data">
                            <div class="form-group">
                                <label>Book Name*</label>
                                <input name="bname" type="text" class="form-control" required>
                            </div>

                            <div class="form-group">
                                <label>Author Name*</label>
                                <input name="author" type="text" class="form-control" required>
                            </div>

                            <div class="form-group">
                                <label>Price*</label>
                                <input name="price" type="number" class="form-control" required>
                            </div>

                            <div class="form-group">
                                <label>Book Categories*</label>
                                <select name="btype" class="form-control" required>
                                    <option value="" disabled selected>Select Category</option>
                                    <option value="Fiction">Fiction</option>
                                    <option value="Non-Fiction">Non-Fiction</option>
                                    <option value="Educational">Educational</option>
                                    <option value="Professional">Professional</option>
                                    <option value="Children">Technology</option>
                                    <option value="Comics">Comics</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label>Book Status*</label>
                                <select name="bstatus" class="form-control" required>
                                    <option value="" disabled selected>Select Status</option>
                                    <option value="Active">Active</option>
                                    <option value="Inactive">Inactive</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label>Upload Photo*</label>
                                <input name="bimg" type="file" class="form-control-file" required accept="image/*">
                            </div>

                            <div class="form-group">
                                <label>Upload PDF File</label>
                                <input name="bpdf" type="file" class="form-control-file" accept=".pdf">
                                <small class="form-text text-muted">Optional: Upload PDF version</small>
                            </div>

                            <button type="submit" class="btn btn-primary btn-block">Add Book</button>
                        </form>

                    </div>
                </div>
            </div>
        </div>
    </div>

   <%@include file="Footer.jsp"%>
</body>
</html>
