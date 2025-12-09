package com.krishna.servlets;

import com.krishna.dao.UserDao;
import com.krishna.entity.Messege;
import com.krishna.entity.User;
import com.krishna.helper.MyConnector;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.*;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserDao dao = new UserDao(MyConnector.getConnection());
        User user = dao.getUserByEmailAndPassword(email, password);

        if (user == null) {
           // out.print("invalid");
           
           Messege msg =new Messege("Invalid !! Plz Try Agina!!","error","alert-danger");
           HttpSession s= request.getSession();
           s.setAttribute("msg",msg);
           response.sendRedirect("Login.jsp");
    
           
        } else {
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", user);

            response.sendRedirect("profile.jsp");
           
        }

    }
}
