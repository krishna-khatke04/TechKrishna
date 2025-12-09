<%-- 
    Document   : show_posts.jsp
    Created on : 7 Dec 2025, 6:34:34 pm
    Author     : HP
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="com.krishna.entity.Categories"%>
<%@page import="com.krishna.helper.MyConnector"%>
<%@page import="com.krishna.entity.User"%>
<%@page import="com.krishna.entity.Post"%>
<%@page import="com.krishna.dao.PostDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page errorPage="error_page.jsp" %>
<%
    // Check user session
    User u = (User) session.getAttribute("currentUser");
    if (u == null) {
        response.sendRedirect("Login.jsp");
        return;
    }

    // Get post ID
    int postId = Integer.parseInt(request.getParameter("post_id"));
    PostDao dao = new PostDao(MyConnector.getConnection());
    Post p = dao.getPostByPostId(postId);

    if (p == null) {
        out.println("<h2>Post not found!</h2>");
        return;
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title><%= p.getpTitle()%></title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css" rel="stylesheet">

        <style>
            body {
                background: url("<%=request.getContextPath()%>/img/bg.jpg");
                background-size: cover;
                background-attachment: fixed;
            }
            .c-link.active{
                background: #343a40;
                color: white;
            }
        </style>
    </head>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">

            <a class="navbar-brand fw-bold" href="#">KrishnaBlog</a>

            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#nav">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="nav">

                <!-- LEFT SIDE -->
                <ul class="navbar-nav">
                    <li class="nav-item"><a class="nav-link active" href="index.jsp">Home</a></li>

                    <!-- DROPDOWN -->
                    <li class="nav-item active">
                        <a class="nav-link" href="profile.jsp"> <span class="	fa fa-bell-o"></span> All Posts <span class="sr-only">(current)</span></a>
                    </li>



                    <li class="nav-item">
                        <a class="nav-link" href="#" data-bs-toggle="modal" data-bs-target="#add-post-modal">
                            <span class="fa fa-asterisk"></span> Do Post
                        </a>
                    </li>
                </ul>

                <!-- RIGHT SIDE -->
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="#" data-bs-toggle="modal" data-bs-target="#profile-modal">
                            <span class="fa fa-user-circle"></span> <%= u.getName()%>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="LogoutServlet">
                            <span class="fa fa-sign-out-alt"></span> Logout
                        </a>
                    </li>
                </ul>

            </div>
        </div>
    </nav>
    <body class="bg-light">

        <div class="container mt-5">
            <div class="row justify-content-center">
                <div class="col-lg-8 col-md-10">   <!-- perfect width -->

                    <div class="card border-0 shadow-lg rounded-4">
                        <div class="card-body p-5">

                            <div class="text-center mb-4 ">
                                <h2 class="fw-bold text-white bg-primary mb-4 p-3 rounded" style="font-family: 'Georgia', serif;">
                                    <%= p.getpTitle()%>
                                </h2>

                                <hr>
                                <% if (p.getpPic() != null && !p.getpPic().isEmpty()) {%>
                                <img class="img-fluid rounded-4 shadow-sm"
                                     style="max-height: 420px; object-fit: cover;"
                                     src="Post_images/<%= p.getpPic()%>"
                                     alt="Post Image">
                                <% }%>

                            </div>
                            <hr>
                            <p class="fs-5 lh-lg" style="font-family: 'Cambria', serif;">
                                <%= p.getpContent()%>
                            </p>
                            <hr>
                            <p class="fs-5 lh-lg" style="font-family: 'Cambria', serif;">
                                <%= p.getpCode()%>
                            </p>

                            <hr class="my-4">

                            <div class="text-end text-secondary" style="font-size: 14px;">
                                ✍ Posted by <span class="fw-semibold"><%= p.getUserName()%></span>
                                on <span class="fw-semibold"><%= p.getpDate()%></span>
                            </div>

                        </div>
                    </div>

                </div>
            </div>
        </div>




        <!--                //Profile model-->
        <div class="modal fade" id="profile-modal">
            <div class="modal-dialog">
                <div class="modal-content">

                    <div class="modal-header">
                        <h1 class="modal-title fs-5">TECHKRISH</h1>
                        <button class="btn-close" data-bs-dismiss="modal"></button>
                    </div>

                    <div class="modal-body text-center">
                        <img src="img/default.jpg" class="img-fluid rounded-circle" style="max-width:150px;">
                        <h5 class="mt-3"><%= u.getName()%></h5>

                        <table class="table mt-3">
                            <tr><th>Email</th><td><%= u.getEmail()%></td></tr>
                            <tr><th>Gender</th><td><%= u.getGender()%></td></tr>
                        </table>

                    </div>

                    <div class="modal-footer">
                        <button class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    </div>

                </div>
            </div>
        </div>
        <!--                        end Profile Model-->
        <!-- ADD POST MODAL -->
        <div class="modal fade" id="add-post-modal">
            <div class="modal-dialog">
                <div class="modal-content">

                    <div class="modal-header">
                        <h5>Add New Post</h5>
                        <button class="btn-close" data-bs-dismiss="modal"></button>
                    </div>

                    <div class="modal-body">
                        <form id="add-post-form" action="AddPostServlet" method="post" enctype="multipart/form-data">

                            <select class="form-control m-3" name="cid" required>
                                <option selected disabled>--- Select Category ---</option>
                                <%
                                    PostDao d = new PostDao(MyConnector.getConnection());
                                    ArrayList<Categories> list = d.getAllCategories();
                                    for (Categories c : list) {
                                %>
                                <option value="<%= c.getCid()%>"><%= c.getCname()%></option>
                                <% }%>
                            </select>

                            <input name="pTitle" type="text" class="form-control m-3" placeholder="Post Title" required/>
                            <textarea name="pContent" class="form-control m-3" placeholder="Your Content" required></textarea>
                            <textarea name="pCode" class="form-control m-3" placeholder="Program Code (optional)"></textarea>
                            <input type="file" name="pic" class="form-control m-3">

                            <div class="text-center mb-2">
                                <button type="submit" class="btn btn-outline-primary">Post</button>
                            </div>

                        </form>
                    </div>

                </div>
            </div>
        </div>

        <!-- JS -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

        <script>
            function getPosts(cid, element) {
                $("#loader").show();
                $("#post-container").hide();

                $(".c-link").removeClass("active");
                $(element).addClass("active");

                $.ajax({
                    url: "load_posts.jsp",
                    data: {cid: cid},
                    success: function (data) {
                        $("#loader").hide();
                        $("#post-container").html(data).show();
                    },
                    error: function () {
                        console.log("Error in loading posts");
                    }
                });
            }

            $(document).ready(function () {
                let firstCategory = $(".c-link")[0];
                getPosts(0, firstCategory);
            });

            $("#add-post-form").on("submit", function (event) {
                event.preventDefault();
                let formData = new FormData(this);

                $.ajax({
                    url: "AddPostServlet",
                    type: "POST",
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function (data) {
                        if ($.trim(data) === "success") {
                            swal("Success!", "Post Uploaded!", "success");
                            $("#add-post-form")[0].reset();
                        } else {
                            swal("Oops!", "Post Failed!", "error");
                        }
                    },
                    error: () => swal("Server Error!", "Try Again!", "error")
                });
            });

        </script>
    </body>
</html>
