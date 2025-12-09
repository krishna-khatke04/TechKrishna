<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Register | Krishna Blog</title>

        <!-- Bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- Icons -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" rel="stylesheet">

        <!-- jQuery -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <!-- SweetAlert -->
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <style>
            body {
                background: url("<%=request.getContextPath()%>/img/lg.jpg");
                background-size: cover;
                background-attachment: fixed;
            }
        </style>
    </head>
    <body>

        <%@ include file="normal_navbar.jsp" %>

        <main class="d-flex justify-content-center align-items-center" style="height: 90vh;">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-6">

                        <div class="card shadow-lg border-0">
                            <div class="card-header text-center py-4 bg-primary text-white">

                                <!-- HOME AND REGISTER ANCHOR BUTTONS -->
                                <div class="d-flex justify-content-between mb-2">
                                    <a href="index.jsp" class="btn btn-light btn-sm">
                                        <i class="fa fa-home"></i> Home
                                    </a>
                                    <a href="Register.jsp" class="btn btn-light btn-sm">
                                        <i class="fa fa-user-plus"></i> Register
                                    </a>
                                </div>

                                <i class="fa fa-user-circle fa-3x mb-2"></i>
                                <h4 class="fw-bold">Create New Account</h4>
                            </div>

                            <div class="card-body p-4">
                                <form id="registerForm" action="RegistreServlet" method="post">

                                    <div class="mb-3">
                                        <label class="form-label">Name</label>
                                        <input type="text" name="name" class="form-control" required>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Email</label>
                                        <input type="email" name="email" class="form-control" required>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Password</label>
                                        <input type="password" name="password" class="form-control" required>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Gender</label>
                                        <select name="gender" class="form-select" required>
                                            <option value="">Select Gender</option>
                                            <option>Male</option>
                                            <option>Female</option>
                                            <option>Other</option>
                                        </select>
                                    </div>

                                    <div class="mb-3 form-check">
                                        <input type="checkbox" class="form-check-input" name="check" required>
                                        <label class="form-check-label">I agree to the terms & conditions</label>
                                    </div>

                                    <!-- FIXED PROPER REGISTER BUTTON -->
                                    <button type="submit" class="btn btn-primary w-100 py-2">
                                        <i class="fa fa-user-plus"></i> Register
                                    </button>

                                </form>

                                <div class="text-center mt-3">
                                    <a href="Login.jsp" class="btn btn-outline-secondary w-100 py-2">
                                        <i class="fa fa-right-to-bracket"></i> Login
                                    </a>
                                </div>

                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </main>

        <!-- SWEETALERT AJAX SCRIPT -->
        <script>
            $(document).ready(function () {

                $("#registerForm").submit(function (e) {
                    e.preventDefault();

                    let formData = $(this).serialize();

                    $.ajax({
                        type: "POST",
                        url: "RegistreServlet",
                        data: formData,
                        success: function (response) {

                            let result = response.trim().toLowerCase();

                            if (result === "done" || result === "success") {
                                Swal.fire({
                                    icon: "success",
                                    title: "Registration Successful!",
                                    timer: 2000,
                                    showConfirmButton: false
                                });
                                $("#registerForm")[0].reset();
                            } else {
                                Swal.fire({
                                    icon: "error",
                                    title: "Registration Failed!",
                                    text: "Something went wrong."
                                });
                            }
                        },
                        error: function () {
                            Swal.fire({
                                icon: "error",
                                title: "Server Error!",
                                text: "Unable to process request."
                            });
                        }
                    });

                });

            });
        </script>

    </body>
</html>
