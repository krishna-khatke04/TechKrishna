package com.krishna.servlets;

import com.krishna.dao.PostDao;
import com.krishna.entity.Post;
import com.krishna.entity.User;
import com.krishna.helper.MyConnector;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig
public class AddPostServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("currentUser");
            
            int cid = Integer.parseInt(request.getParameter("cid"));
            String ptitle = request.getParameter("pTitle");
            String pcontent = request.getParameter("pContent");
            String pcode = request.getParameter("pCode");
            Part part = request.getPart("pic");
            String imageName = part.getSubmittedFileName();

            Post post = new Post(ptitle, pcontent, pcode, imageName, null, cid, user.getName());
            PostDao dao = new PostDao(MyConnector.getConnection());

            boolean saved = dao.savePost(post);

            if (saved) {
                // Save image to folder
                String path = request.getRealPath("/") + "Post_images" + File.separator + imageName;
                part.write(path);
                out.println("success");
            } else {
                out.println("error");
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Add new post servlet";
    }
}
