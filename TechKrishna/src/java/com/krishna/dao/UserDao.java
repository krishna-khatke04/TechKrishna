package com.krishna.dao;

import com.krishna.entity.User;
import java.sql.*;

public class UserDao {

    private Connection con;

    public UserDao(Connection con) {
        this.con = con;
    }

    // Save User
    public boolean saveUser(User user) {
        boolean f = false;

        try {

            String sql = "INSERT INTO REGISTERFORM(name, email, password, gender) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getGender());

            int rows = ps.executeUpdate();
            f = rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;
    }

    // Login User
    public User getUserByEmailAndPassword(String email, String password) {
        User user = null;

        try {
            String query = "SELECT * FROM REGISTERFORM WHERE email = ? AND password = ?";
            PreparedStatement ps = con.prepareStatement(query);

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet set = ps.executeQuery();

            if (set.next()) {

                user = new User();

                user.setName(set.getString("name"));
                user.setEmail(set.getString("email"));
                user.setPassword(set.getString("password"));
                user.setGender(set.getString("gender"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }

    public boolean updateUser(User user) {
        boolean f = false;

        try {
            String query = "UPDATE REGISTERFORM SET name=?, email=? WHERE password=?";
            PreparedStatement p = con.prepareStatement(query);

            p.setString(1, user.getName());
            p.setString(2, user.getEmail());
            p.setString(3, user.getPassword());

            int rows = p.executeUpdate();
            f = rows > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;
    }

}
