package com.DAO;

import com.entity.BookRating;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RatingDAOImpl implements RatingDAO {
    private Connection conn;

    public RatingDAOImpl(Connection conn) {
        this.conn = conn;
    }

    @Override
    public boolean addRating(BookRating rating) {
        boolean f = false;
        try {
            String sql = "INSERT INTO book_ratings (user_id, book_id, rating, review_text) VALUES (?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, rating.getUserId());
            ps.setInt(2, rating.getBookId());
            ps.setInt(3, rating.getRating());
            ps.setString(4, rating.getReviewText());
            
            int i = ps.executeUpdate();
            if (i == 1) {
                f = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    @Override
    public boolean updateRating(BookRating rating) {
        boolean f = false;
        try {
            String sql = "UPDATE book_ratings SET rating = ?, review_text = ? WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, rating.getRating());
            ps.setString(2, rating.getReviewText());
            ps.setInt(3, rating.getId());
            
            int i = ps.executeUpdate();
            if (i == 1) {
                f = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    @Override
    public boolean deleteRating(int ratingId) {
        boolean f = false;
        try {
            String sql = "DELETE FROM book_ratings WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, ratingId);
            
            int i = ps.executeUpdate();
            if (i == 1) {
                f = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }

    @Override
    public BookRating getRatingByUserAndBook(int userId, int bookId) {
        BookRating rating = null;
        try {
            String sql = "SELECT br.*, u.name as user_name, b.bookname as book_name " +
                        "FROM book_ratings br " +
                        "JOIN user u ON br.user_id = u.userid " +
                        "JOIN book_details b ON br.book_id = b.bookId " +
                        "WHERE br.user_id = ? AND br.book_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, bookId);
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                rating = new BookRating();
                rating.setId(rs.getInt("id"));
                rating.setUserId(rs.getInt("user_id"));
                rating.setBookId(rs.getInt("book_id"));
                rating.setRating(rs.getInt("rating"));
                rating.setReviewText(rs.getString("review_text"));
                rating.setCreatedAt(rs.getTimestamp("created_at"));
                rating.setUserName(rs.getString("user_name"));
                rating.setBookName(rs.getString("book_name"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return rating;
    }

    @Override
    public List<BookRating> getRatingsByBook(int bookId) {
        List<BookRating> list = new ArrayList<>();
        try {
            String sql = "SELECT br.*, u.name as user_name " +
                        "FROM book_ratings br " +
                        "JOIN user u ON br.user_id = u.userid " +
                        "WHERE br.book_id = ? ORDER BY br.created_at DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, bookId);
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                BookRating rating = new BookRating();
                rating.setId(rs.getInt("id"));
                rating.setUserId(rs.getInt("user_id"));
                rating.setBookId(rs.getInt("book_id"));
                rating.setRating(rs.getInt("rating"));
                rating.setReviewText(rs.getString("review_text"));
                rating.setCreatedAt(rs.getTimestamp("created_at"));
                rating.setUserName(rs.getString("user_name"));
                list.add(rating);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<BookRating> getRatingsByUser(int userId) {
        List<BookRating> list = new ArrayList<>();
        try {
            String sql = "SELECT br.*, b.bookname as book_name " +
                        "FROM book_ratings br " +
                        "JOIN book_details b ON br.book_id = b.bookId " +
                        "WHERE br.user_id = ? ORDER BY br.created_at DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                BookRating rating = new BookRating();
                rating.setId(rs.getInt("id"));
                rating.setUserId(rs.getInt("user_id"));
                rating.setBookId(rs.getInt("book_id"));
                rating.setRating(rs.getInt("rating"));
                rating.setReviewText(rs.getString("review_text"));
                rating.setCreatedAt(rs.getTimestamp("created_at"));
                rating.setBookName(rs.getString("book_name"));
                list.add(rating);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public double getAverageRating(int bookId) {
        double avgRating = 0.0;
        try {
            String sql = "SELECT AVG(rating) as avg_rating FROM book_ratings WHERE book_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, bookId);
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                avgRating = rs.getDouble("avg_rating");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return avgRating;
    }

    @Override
    public int getRatingCount(int bookId) {
        int count = 0;
        try {
            String sql = "SELECT COUNT(*) as total FROM book_ratings WHERE book_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, bookId);
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt("total");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }
}