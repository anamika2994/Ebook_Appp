<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page isELIgnored="false"%>

<style>
.ebook-footer {
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    color: white;
    padding: 3rem 0 1.5rem;
    margin-top: auto;
}

.ebook-footer h5 {
    font-weight: 600;
    margin-bottom: 1.2rem;
    color: white;
    font-size: 1.2rem;
}

.ebook-footer p {
    color: rgba(255,255,255,0.9);
    line-height: 1.6;
    margin-bottom: 1rem;
}

.footer-links {
    list-style: none;
    padding: 0;
    margin: 0;
}

.footer-links li {
    margin-bottom: 0.5rem;
}

.footer-links a {
    color: rgba(255,255,255,0.8);
    text-decoration: none;
    transition: all 0.3s ease;
    display: block;
    padding: 0.2rem 0;
}

.footer-links a:hover {
    color: #ffd700;
    padding-left: 5px;
    text-decoration: none;
}

.footer-contact-info {
    color: rgba(255,255,255,0.9);
}

.footer-contact-info i {
    width: 20px;
    margin-right: 10px;
    color: #ffd700;
}

.social-icons {
    margin-top: 1rem;
}

.social-icons a {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 40px;
    height: 40px;
    background: rgba(255,255,255,0.2);
    border-radius: 50%;
    color: white;
    margin-right: 10px;
    transition: all 0.3s ease;
    text-decoration: none;
}

.social-icons a:hover {
    background: #ffd700;
    transform: translateY(-3px);
    color: #764ba2;
}

.footer-divider {
    border-color: rgba(255,255,255,0.3);
    margin: 2rem 0 1.5rem;
}

.footer-bottom {
    text-align: center;
    padding-top: 1.5rem;
    border-top: 1px solid rgba(255,255,255,0.3);
}

.footer-bottom p {
    margin: 0;
    color: rgba(255,255,255,0.8);
    font-size: 0.9rem;
}

/* Responsive Design */
@media (max-width: 768px) {
    .ebook-footer {
        padding: 2rem 0 1rem;
        text-align: center;
    }
    
    .ebook-footer .col-md-3,
    .ebook-footer .col-md-2 {
        margin-bottom: 2rem;
    }
    
    .social-icons {
        justify-content: center;
    }
}

/* Animation for footer elements */
.footer-animate {
    animation: fadeInUp 0.6s ease;
}

@keyframes fadeInUp {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}
</style>

<footer class="ebook-footer">
    <div class="container">
        <div class="row">
            <!-- Company Info -->
            <div class="col-lg-4 col-md-6 mb-4 footer-animate">
                <h5>
                    <i class="fas fa-book me-2"></i>Ebook Store
                </h5>
                <p>
                    Your premier destination for digital books. Discover, read, and learn 
                    with our extensive collection of books across all genres.
                </p>
                <div class="social-icons d-flex">
                    <a href="#" title="Facebook">
                        <i class="fab fa-facebook-f"></i>
                    </a>
                    <a href="#" title="Twitter">
                        <i class="fab fa-twitter"></i>
                    </a>
                    <a href="#" title="Instagram">
                        <i class="fab fa-instagram"></i>
                    </a>
                    <a href="#" title="LinkedIn">
                        <i class="fab fa-linkedin-in"></i>
                    </a>
                </div>
            </div>

            <!-- Quick Links -->
            <div class="col-lg-2 col-md-3 mb-4 footer-animate">
                <h5>Quick Links</h5>
                <ul class="footer-links">
                    <li><a href="index.jsp">Home</a></li>
                    <li><a href="all_fictionbook.jsp">Fiction</a></li>
                    <li><a href="all_nonfictionbook.jsp">Non-Fiction</a></li>
                    <li><a href="all_Educationalbook.jsp">Educational</a></li>
                    <li><a href="all_profesionalbook.jsp">Professional</a></li>
                </ul>
            </div>

            <!-- Categories -->
            <div class="col-lg-2 col-md-3 mb-4 footer-animate">
                <h5>Categories</h5>
                <ul class="footer-links">
                    <li><a href="all_Technology.jsp">Technology</a></li>
                    <li><a href="all_comiesbook.jsp">Comics</a></li>
                    <li><a href="search_results.jsp">Search</a></li>
                    <li><a href="contact.jsp">Contact Us</a></li>
                    <li><a href="contact.jsp">About Us</a></li>
                </ul>
            </div>

            <!-- Contact Info -->
            <div class="col-lg-4 col-md-6 mb-4 footer-animate">
                <h5>Contact Info</h5>
                <div class="footer-contact-info">
                    <p>
                        <i class="fas fa-map-marker-alt"></i>
                        123 Book Street, Knowledge City, KC 12345
                    </p>
                    <p>
                        <i class="fas fa-phone"></i>
                        +1 (555) 123-4567
                    </p>
                    <p>
                        <i class="fas fa-envelope"></i>
                        support@ebookstore.com
                    </p>
                    <p>
                        <i class="fas fa-clock"></i>
                        Mon - Fri: 9:00 AM - 6:00 PM
                    </p>
                </div>
            </div>
        </div>

        <hr class="footer-divider">

        <!-- Bottom Footer - Centered Copyright -->
        <div class="footer-bottom">
            <p>&copy; 2025 Ebook Store. All rights reserved.</p>
        </div>
    </div>
</footer>

<script>
// Simple animation for footer elements
document.addEventListener('DOMContentLoaded', function() {
    const footerElements = document.querySelectorAll('.footer-animate');
    
    footerElements.forEach((element, index) => {
        element.style.animationDelay = (index * 0.2) + 's';
    });
});
</script>