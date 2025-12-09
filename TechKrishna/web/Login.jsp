<%-- 
    Document   : login.jsp
    Created on : 13 Nov 2025
    Author     : Krishna
--%>

<%@page import="com.krishna.entity.Messege"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.krishna.helper.MyConnector" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Login | Krishna Blog</title>

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" rel="stylesheet">

        <!-- Custom CSS -->
        <link href="css/login.css" rel="stylesheet" type="text/css"/>

        <style>
            .banner-background {
                background: linear-gradient(135deg, #007bff, #6610f2);
                color: white;
                padding: 100px 0;
                clip-path: polygon(0 0, 100% 0, 100% 85%, 50% 100%, 0 85%);
            }
            body {
                background: url("<%=request.getContextPath()%>/img/lgin.jpg");
                background-size: cover;
                background-attachment: fixed;
            }
            

       </style>



    </head>
    <body>

        <%@include file="normal_navbar.jsp" %>

        <main class="d-flex justify-content-center align-items-center" style="height: 85vh;">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-5">

                        <div class="card">
                            <div class="card-header text-center py-4">
                                <i class="fa-solid fa-right-to-bracket fa-3x mb-2"></i>
                                <h4 class="fw-bold">Login to Your Account</h4>
                            </div>

                            <%
                                Messege m = (Messege) session.getAttribute("msg");
                                if (m != null) {
                            %>
                            <div class="alert <%= m.getCssclass()%>" role="alert">
                                <%= m.getContent()%>
                            </div> 


                            <%
                                    session.removeAttribute("msg");
                                }

                            %>
                            <div class="card-body p-4">
                                <form action="LoginServlet" method="post">
                                    <div class="mb-3">
                                        <label for="email" class="form-label">Email address</label>
                                        <input type="email" name="email" id="email" class="form-control" required>
                                    </div>

                                    <div class="mb-3">
                                        <label for="password" class="form-label">Password</label>
                                        <input type="password" name="password" id="password" class="form-control" required>
                                    </div>

                                    <div class="text-center mt-4">
                                        <button type="submit" class="btn btn-primary w-100 py-2">
                                            <i class="fa-solid fa-right-to-bracket"></i> Login
                                        </button>
                                    </div>

                                    <!-- Register Button -->
                                    <div class="text-center mt-3">
                                        <a href="Register.jsp" class="btn btn-outline-primary w-100 py-2">
                                            <i class="fa fa-user-plus"></i> Create New Account
                                        </a>
                                    </div>

                                    <!-- Home Button -->
                                    <div class="text-center mt-3">
                                        <a href="index.jsp" class="btn btn-outline-secondary w-100 py-2">
                                            <i class="fa fa-home"></i> Go to Home
                                        </a>
                                    </div>

                                </form>

                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </main>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="js/myjs.js"></script>
    </body>
</html>
