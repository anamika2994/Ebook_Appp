<%@page import="com.entity.user"%>
<%@page import="com.DAO.userDAOimpl"%>
<%@page import="com.DB.DBconnect"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Settings</title>
<%@include file="allcomponent/allCSS.jsp"%>
<style>
.settings-card {
    background: #fff;
    border-radius: 15px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.1);
    margin-bottom: 30px;
    overflow: hidden;
}

.settings-header {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 25px;
    text-align: center;
}

.settings-body {
    padding: 30px;
}

.profile-pic {
    width: 120px;
    height: 120px;
    border-radius: 50%;
    border: 5px solid #fff;
    margin: -70px auto 20px;
    background: #f8f9fa;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 40px;
    color: #667eea;
    box-shadow: 0 5px 15px rgba(0,0,0,0.1);
}

.tab-content{
    padding: 20px 0;
}

.nav-tabs {
    border-bottom: 2px solid #e9ecef;
}

.nav-tabs .nav-link {
    border: none;
    padding: 12px 25px;
    font-weight: 600;
    color: #66757d;
    border-radius: 0;
}

.nav-tabs .nav-link.active {
    color: #667eea;
    border-bottom: 3px solid #667eea;
    background: none;
}

.nav-tabs .nav-link:hover {
    border-color: transparent;
    color: #667eea;
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

.btn-save {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    border: none;
    border-radius: 25px;
    padding: 12px 30px;
    color: white;
    font-weight: 600;
    transition: all 0.3s ease;
}

.btn-save:hover {
    transform: translateY(-2px);
    box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
    color: white;
}

.section-title {
    color: #667eea;
    border-bottom: 2px solid #e9ecef;
    padding-bottom: 10px;
    margin-bottom: 20px;
}

.password-strength {
    height: 5px;
    border-radius: 5px;
    margin-top: 5px;
    background: #e9ecef;
    transition: all 0.3s ease;
}
</style>
</head>
<body style="background-color: #f8f9fa;">
    <%@include file="allcomponent/Navber.jsp"%>
    <c:if test="${empty userobj}">
        <c:redirect url="login.jsp"/>
    </c:if>

    <div class="container mt-4">
        <c:if test="${not empty succMsg}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${succMsg}
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <c:remove var="succMsg" scope="session"/>
        </c:if>

        <c:if test="${not empty failedMsg}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${failedMsg}
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <c:remove var="failedMsg" scope="session"/>
        </c:if>

        <div class="settings-card">
            <div class="settings-header">
                <h3><i class="fas fa-cogs"></i> Account Settings</h3>
                <p class="mb-0">Manage your profile and preferences</p>
            </div>

            <div class="profile-pic">
                <i class="fas fa-user"></i>
            </div>

            <div class="settings-body">
                <ul class="nav nav-tabs" id="settingsTab" role="tablist">
                    <li class="nav-item">
                        <a class="nav-link active" id="profile-tab" data-toggle="tab" href="#profile" role="tab">
                            <i class="fas fa-user-edit"></i> Profile
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" id="password-tab" data-toggle="tab" href="#password" role="tab">
                            <i class="fas fa-lock"></i> Password
                        </a>
                    </li>
                </ul>

                <div class="tab-content" id="settingsTabContent">
                    <!-- Profile Tab -->
                    <div class="tab-pane fade show active" id="profile" role="tabpanel">
                        <% user u = (user) session.getAttribute("userobj"); %>
                        <form action="updateProfile" method="post">
                            <h5 class="section-title"><i class="fas fa-user-circle"></i> Personal Information</h5>
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Full Name *</label>
                                        <input type="text" class="form-control" name="name" 
                                               value="${userobj.name}" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Email Address</label>
                                        <input type="email" class="form-control" 
                                               value="${userobj.email}" readonly style="background-color: #f8f9fa;">
                                        <small class="form-text text-muted">Email cannot be changed</small>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Phone Number *</label>
                                        <input type="tel" class="form-control" name="phno" 
                                               value="${userobj.phno}" required pattern="[0-9]{11}">
                                        <small class="form-text text-muted">11-digit phone number</small>
                                    </div>
                                </div>
                            </div>

                            <h5 class="section-title mt-4"><i class="fas fa-map-marker-alt"></i> Address Information</h5>
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Address Line 1</label>
                                        <input type="text" class="form-control" name="address" 
                                               value="${userobj.address}" placeholder="Street address">
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Landmark</label>
                                        <input type="text" class="form-control" name="landmark" 
                                               value="${userobj.landmark}" placeholder="Nearby landmark">
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>City</label>
                                        <input type="text" class="form-control" name="city" 
                                               value="${userobj.city}" placeholder="Your city">
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>State</label>
                                        <input type="text" class="form-control" name="state" 
                                               value="${userobj.state}" placeholder="Your state">
                                    </div>
                                </div>
                                <div class="col-md-4">
                                    <div class="form-group">
                                        <label>PIN Code</label>
                                        <input type="text" class="form-control" name="pincode" 
                                               value="${userobj.pincode}" placeholder="Postal code">
                                    </div>
                                </div>
                            </div>

                            <button type="submit" class="btn btn-save">
                                <i class="fas fa-save"></i> Update Profile
                            </button>
                        </form>
                    </div>

                    <!-- Password Tab -->
                    <div class="tab-pane fade" id="password" role="tabpanel">
                        <form action="updatePassword" method="post" id="passwordForm">
                            <h5 class="section-title"><i class="fas fa-key"></i> Change Password</h5>
                            
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Current Password *</label>
                                        <input type="password" class="form-control" name="currentPassword" 
                                               required id="currentPassword">
                                        <div class="invalid-feedback" id="currentPasswordError"></div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>New Password *</label>
                                        <input type="password" class="form-control" name="newPassword" 
                                               required id="newPassword" minlength="6">
                                        <div class="password-strength" id="passwordStrength"></div>
                                        <small class="form-text text-muted">Password must be at least 6 characters long</small>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label>Confirm New Password *</label>
                                        <input type="password" class="form-control" name="confirmPassword" 
                                               required id="confirmPassword">
                                        <div class="invalid-feedback" id="confirmPasswordError"></div>
                                    </div>
                                </div>
                            </div>

                            <button type="submit" class="btn btn-save">
                                <i class="fas fa-key"></i> Change Password
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
    document.addEventListener('DOMContentLoaded', function() {
        const passwordForm = document.getElementById('passwordForm');
        const newPassword = document.getElementById('newPassword');
        const confirmPassword = document.getElementById('confirmPassword');
        const strengthBar = document.getElementById('passwordStrength');

        // Password strength indicator
        newPassword.addEventListener('input', function() {
            const password = this.value;
            let strength = 0;
            
            if (password.length >= 6) strength += 25;
            if (password.match(/[a-z]/) && password.match(/[A-Z]/)) strength += 25;
            if (password.match(/\d/)) strength += 25;
            if (password.match(/[^a-zA-Z\d]/)) strength += 25;
            
            strengthBar.style.width = strength + '%';
            if (strength < 50) {
                strengthBar.style.backgroundColor = '#dc3545';
            } else if (strength < 75) {
                strengthBar.style.backgroundColor = '#ffc107';
            } else {
                strengthBar.style.backgroundColor = '#28a745';
            }
        });

        // Confirm password validation
        confirmPassword.addEventListener('input', function() {
            if (this.value !== newPassword.value) {
                this.classList.add('is-invalid');
                document.getElementById('confirmPasswordError').textContent = 'Passwords do not match';
            } else {
                this.classList.remove('is-invalid');
                document.getElementById('confirmPasswordError').textContent = '';
            }
        });

        // Form validation
        passwordForm.addEventListener('submit', function(e) {
            let isValid = true;

            if (newPassword.value.length < 6) {
                newPassword.classList.add('is-invalid');
                isValid = false;
            } else {
                newPassword.classList.remove('is-invalid');
            }

            if (newPassword.value !== confirmPassword.value) {
                confirmPassword.classList.add('is-invalid');
                document.getElementById('confirmPasswordError').textContent = 'Passwords do not match';
                isValid = false;
            }

            if (!isValid) {
                e.preventDefault();
            }
        });

        // Clear validation on input
        newPassword.addEventListener('input', function() {
            this.classList.remove('is-invalid');
        });

        confirmPassword.addEventListener('input', function() {
            this.classList.remove('is-invalid');
        });
    });
    </script>
    
    <%@include file="allcomponent/Footer.jsp"%>
</body>
</html>