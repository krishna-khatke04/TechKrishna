<%-- 
    Document   : index.jsp
    Created on : 13 Nov 2025
    Author     : Krishna
--%>

<%@page import="java.util.List"%>
<%@page import="com.krishna.entity.Post"%>
<%@page import="com.krishna.dao.PostDao"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.krishna.helper.MyConnector" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Krishna Blog</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="css/Mystyle.css" rel="stylesheet" type="text/css">

    <style>
        .banner-background {
            background: linear-gradient(135deg, #007bff, #6610f2);
            color: white;
            padding: 100px 0;
            clip-path: polygon(0 0, 100% 0, 100% 85%, 50% 100%, 0 85%);
        }
        body {
            background: url("<%=request.getContextPath()%>/img/bg.jpg");
            background-size: cover;
            background-attachment: fixed;
        }
        .custom-card {
            background: linear-gradient(145deg, rgba(255,255,255,0.85), rgba(240,240,240,0.55));
            backdrop-filter: blur(8px);
            border-radius: 12px;
            border: 1px solid rgba(255, 255, 255, 0.4);
            transition: transform .3s ease, box-shadow .3s ease;
        }
        .custom-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 10px 25px rgba(0, 0, 0, .25);
        }
        .footer-link {
            color: #bbb;
            text-decoration: none;
        }
        .footer-link:hover {
            color: #fff;
            text-decoration: underline;
        }
        .social {
            color: #bbb;
            margin-right: 12px;
            font-size: 22px;
            transition: 0.3s;
        }
        .social:hover {
            color: #0d6efd;
            transform: scale(1.15);
        }
    </style>

</head>
<body>

    <%@include file="normal_navbar.jsp" %>

    <!-- Banner Section -->
    <section class="banner-background text-center">
        <div class="container">
            <h1 class="display-4 fw-bold">Welcome to Krishna Blog</h1>
            <p class="lead mt-3">
                Dive into the world of technology, programming, and innovation.
            </p>

            <button class="btn btn-outline-light btn-lg">
                <span class="fa fa-user-plus"></span> Start ! It's Free
            </button>
            <a href="Login.jsp" class="btn btn-outline-light btn-lg">
                <span class="fa fa-user-circle"></span> Login
            </a>
        </div>
    </section>

    <!-- Cards Section -->
    <div class="container mt-5">
        <div class="row">
            <%
                PostDao postDao = new PostDao(MyConnector.getConnection());

                String catId = request.getParameter("cid");
                int cid = (catId == null) ? 0 : Integer.parseInt(catId);

                List<Post> list = (cid == 0) ? postDao.getAllPost() : postDao.getPostByCatId(cid);

                if (list == null || list.isEmpty()) {
                    out.println("<h3 class='display-5 text-center text-danger'>No Posts Available in This Category!</h3>");
                    return;
                }

                for (Post p : list) {
            %>

            <div class="col-md-4 mb-3">
                <div class="card shadow-lg custom-card">
                    <img src="Post_images/<%= p.getpPic() %>"
                         class="card-img-top"
                         style="height:200px; object-fit:cover; border-radius: 8px 8px 0 0;">

                    <div class="card-body">
                        <h5 class="card-title text-primary fw-bold"><%= p.getpTitle() %></h5>

                        <p class="card-text">
                            <%= p.getpContent().length() > 100
                                ? p.getpContent().substring(0, 100) + "..."
                                : p.getpContent() %>
                        </p>

                        <p class="text-muted mt-2" style="font-size: 13px;">
                            Posted on <%= p.getpDate() %> by
                            <span class="fw-bold"><%= p.getUserName() %></span>
                        </p>
                    </div>
                </div>
            </div>

            <% } %>
        </div>
    </div>

    <!-- Footer -->
    <footer class="footer bg-dark text-white pt-4 pb-2 mt-5">
        <div class="container">
            <div class="row">

                <div class="col-md-4 mb-3">
                    <h5 class="fw-bold border-bottom pb-2">About Us</h5>
                    <p class="small">
                        Welcome to KrishnaBlog – a platform to learn Java, Web Development, Technology, and Programming Tutorials for free.
                    </p>
                </div>

                <div class="col-md-4 mb-3">
                    <h5 class="fw-bold border-bottom pb-2">Quick Links</h5>
                    <ul class="list-unstyled small">
                        <li><a href="index.jsp" class="footer-link">Home</a></li>
                        <li><a href="Register.jsp" class="footer-link">Register</a></li>
                        <li><a href="Login.jsp" class="footer-link">Login</a></li>
                        <li><a href="#" class="footer-link">Contact Us</a></li>
                    </ul>
                </div>

                <div class="col-md-4 mb-3">
                    <h5 class="fw-bold border-bottom pb-2">Follow Us</h5>
                    <div class="social-icons">
                        <a href="#" class="social"><i class="fab fa-facebook"></i></a>
                        <a href="#" class="social"><i class="fab fa-instagram"></i></a>
                        <a href="#" class="social"><i class="fab fa-linkedin"></i></a>
                        <a href="#" class="social"><i class="fab fa-github"></i></a>
                    </div>
                </div>

            </div>

            <hr class="border-secondary">

            <div class="text-center small">
                © <%= java.time.Year.now() %> • <b>KrishnaBlog</b> — All Rights Reserved.
            </div>
        </div>
    </footer>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="js/myjs.js"></script>
</body>
</html>
