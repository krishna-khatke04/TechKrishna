package com.krishna.dao;

import com.krishna.entity.Categories;
import com.krishna.entity.Post;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.sql.*;
import java.util.List;

public class PostDao {

    private Connection con;

    public PostDao(Connection con) {
        this.con = con;
    }

    public ArrayList<Categories> getAllCategories() {
        ArrayList<Categories> list = new ArrayList<>();
        try {
            String q = "SELECT * FROM  CATAGORIES ";
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery(q);

            while (rs.next()) {
                int cid = rs.getInt("cid");
                String name = rs.getString("cname");
                String description = rs.getString("cdescription");

                Categories c = new Categories(cid, name, description);
                list.add(c);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean savePost(Post p) {
        boolean flag = false;
        try {
            String q = "insert into POST(PTITLE,PCONTENT,PCODE,PPIC,CID,USERNAME)values(?,?,?,?,?,?)";
            PreparedStatement psmt = con.prepareStatement(q);
            psmt.setString(1, p.getpTitle());
            psmt.setString(2, p.getpContent());
            psmt.setString(3, p.getpCode());
            psmt.setString(4, p.getpPic());
            psmt.setInt(5, p.getCatId());
            psmt.setString(6, p.getUserName());
            psmt.executeUpdate();
            flag = true;

        } catch (Exception e) {
            e.printStackTrace();

        }

        return flag;

    }

    public List<Post> getAllPost() {
        List<Post> list = new ArrayList<>();
        try {

            PreparedStatement p = con.prepareStatement("select * from POST order by PID desc");
            ResultSet set = p.executeQuery();
            while (set.next()) {
                int pid = set.getInt("PID");
                String pTitle = set.getString("PTITLE");
                String pContent = set.getString("PCONTENT");
                String pCode = set.getString("PCODE");
                String pPic = set.getString("PPIC");
                Timestamp date = set.getTimestamp("PDATE");
                int catId = set.getInt("CID");
                String userName = set.getString("USERNAME");
                Post post = new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userName);

                list.add(post);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;

    }

    public List<Post> getPostByCatId(int catId) {
        List<Post> list = new ArrayList<>();
        //fetch all post by id
        //fetch all the post
        try {

            PreparedStatement p = con.prepareStatement("select * from POST where CID=?");
            p.setInt(1, catId);
            ResultSet set = p.executeQuery();

            while (set.next()) {

                int pid = set.getInt("PID");
                String pTitle = set.getString("PTITLE");
                String pContent = set.getString("PCONTENT");
                String pCode = set.getString("PCODE");
                String pPic = set.getString("PPIC");
                Timestamp date = set.getTimestamp("PDATE");

                String userName = set.getString("USERNAME");
                Post post = new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userName);

                list.add(post);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public Post getPostByPostId(int postId) {
        Post post = null;
        String q = "select * from POST where PID=?";
        try {
            PreparedStatement p = this.con.prepareStatement(q);
            p.setInt(1, postId);

            ResultSet set = p.executeQuery();

            if (set.next()) {

                int pid = set.getInt("PID");
                String pTitle = set.getString("PTITLE");
                String pContent = set.getString("PCONTENT");
                String pCode = set.getString("PCODE");
                String pPic = set.getString("PPIC");
                Timestamp date = set.getTimestamp("PDATE");
                int catId=set.getInt("PID");
                String userName = set.getString("USERNAME");
                 post = new Post(pid, pTitle, pContent, pCode, pPic, date, catId, userName);

                
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return post;
    }

}
