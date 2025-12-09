package com.krishna.servlets;

import com.krishna.dao.UserDao;
import com.krishna.entity.User;
import com.krishna.helper.MyConnector;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.http.*;

public class RegistreServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String gender = request.getParameter("gender");

        User user = new User(name, email, password, gender);
        UserDao dao = new UserDao(MyConnector.getConnection());

        PrintWriter out = response.getWriter(); // IMPORTANT

        if (dao.saveUser(user)) {
            out.println("success");
        } else {
            out.println("error");
        }
    }
}
