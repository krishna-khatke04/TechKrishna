<%@page import="java.util.List"%>
<%@page import="com.krishna.dao.PostDao"%>
<%@page import="com.krishna.entity.Post"%>
<%@page import="com.krishna.helper.MyConnector"%>

<div class="row">
    <%
        PostDao postDao = new PostDao(MyConnector.getConnection());
        int cid = Integer.parseInt(request.getParameter("cid"));

        List<Post> list = (cid == 0) ? postDao.getAllPost() : postDao.getPostByCatId(cid);

        if (list == null || list.isEmpty()) {
            out.println("<h3 class='display-5 text-center text-danger'>No Posts Available in This Category!</h3>");
            return;
        }

        for (Post p : list) {
    %>

    <style>
        .post-card {
            border-radius: 15px;
            overflow: hidden;
            transition: 0.35s;
            background: #fff;
            cursor: pointer;
        }

        .post-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 12px 22px rgba(0,0,0,0.18);
        }

        .post-card img {
            transition: 0.4s ease-in-out;
        }

        .post-card:hover img {
            transform: scale(1.05);
            filter: brightness(0.92);
        }

        .post-card .card-title {
            color: #1b4d89;
            font-size: 20px;
        }

        .post-card .card-text {
            font-size: 14px;
            line-height: 1.5;
            height: 85px;
            overflow: hidden;
            color: #444;
        }

        .post-footer-btn {
            border-radius: 30px;
            transition: 0.3s;
            font-size: 14px;
            padding: 5px 12px;
        }

        .post-footer-btn:hover {
            transform: translateY(-2px);
        }

        .like-btn:hover {
            background: #27ae60 !important;
            color: white !important;
        }

        .comment-btn:hover {
            background: #34495e !important;
            color: white !important;
        }

        .read-btn:hover {
            background: #1b4d89 !important;
            color: white !important;
        }
    </style>

    <div class="col-md-6 mt-3">
        <div class="card post-card">

            <% if (p.getpPic() != null && !p.getpPic().trim().isEmpty()) {%>
            <img src="Post_images/<%= p.getpPic()%>"
                 class="card-img-top" style="height:250px; object-fit:cover;">
            <% }%>

            <div class="card-body">
                <h5 class="card-title fw-bold"><%= p.getpTitle()%></h5>

                <p class="card-text">
                    <%= p.getpContent()%>
                </p>

                <p class="text-muted mt-2" style="font-size: 13px;">
                    Posted on <%= p.getpDate()%> by
                    <span class="fw-bold"><%= p.getUserName()%></span>
                </p>
            </div>

            <div class="card-footer d-flex justify-content-between">
                <a href="show_posts.jsp?post_id=<%= p.getPid()%>" 
                   class="btn btn-outline-primary btn-sm post-footer-btn read-btn">
                    Read More
                </a>

                <a href="like?post_id=<%= p.getPid()%>"
                   class="btn btn-outline-success btn-sm post-footer-btn like-btn">
                    <i class="fa fa-thumbs-up"></i> <span>20</span>
                </a>

                <a href="show_posts.jsp?post_id=<%= p.getPid()%>#comments"
                   class="btn btn-outline-secondary btn-sm post-footer-btn comment-btn">
                    <i class="fa fa-commenting-o"></i> <span>10</span>
                </a>
            </div>
        </div>
    </div>

    <%
        } // End for
    %>
</div>
