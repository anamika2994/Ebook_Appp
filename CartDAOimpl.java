package com.DAO;

import com.entity.Cart;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.ArrayList;

public class CartDAOimpl implements CartDAO {

    private Connection conn;

    public CartDAOimpl(Connection conn) {
        this.conn = conn;
    }

    // Add book to cart
    @Override
    public boolean addCart(Cart c) {
        boolean f = false;
        try {
            String sql = "INSERT INTO cart (bid, uid, bookName, author, price, total_price, created_at) VALUES (?,?,?,?,?,?,NOW())";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, c.getBid());
            ps.setInt(2, c.getUserId());
            ps.setString(3, c.getBookName());
            ps.setString(4, c.getAuthor());
            ps.setDouble(5, c.getPrice());
            ps.setDouble(6, c.getTotalPrice());

            int i = ps.executeUpdate();
            if (i == 1) f = true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    // Get all cart books of a user
    @Override
    public List<Cart> getBookByUser(int userid) {
        List<Cart> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM cart WHERE uid=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Cart c = new Cart();
                c.setCid(rs.getInt("cid"));
                c.setBid(rs.getInt("bid"));
                c.setUserId(rs.getInt("uid"));
                c.setBookName(rs.getString("bookName"));
                c.setAuthor(rs.getString("author"));
                c.setPrice(rs.getDouble("price"));
                c.setTotalPrice(rs.getDouble("total_price"));
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Clear cart after purchase
    public boolean clearUserCart(int userId) {
        boolean f = false;
        try {
            String sql = "DELETE FROM cart WHERE uid=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            int rows = ps.executeUpdate();
            if (rows >= 0) f = true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
    
    @Override
    public boolean removeCartItem(int userId, int bookId) {
        boolean f = false;
        try {
            String sql = "DELETE FROM cart WHERE uid = ? AND bid = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);    // user id
            ps.setInt(2, bookId);    // book id
            
            int rows = ps.executeUpdate();
            if (rows > 0) {
                f = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

}
