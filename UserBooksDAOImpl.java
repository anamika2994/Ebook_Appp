package com.DAO;

import com.entity.UserBooks;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.DB.DBconnect;

public class UserBooksDAOImpl implements UserBooksDAO {
	private Connection conn;

	public UserBooksDAOImpl(Connection conn) {
		this.conn = conn;
	}

	@Override
	public boolean addUserBook(UserBooks userBook) {
		boolean f = false;
		PreparedStatement ps = null;
		try {
			System.out.println("=== DATABASE INSERT START ===");
			System.out.println("UserID: " + userBook.getUserId() + ", BookID: " + userBook.getBookId());

			// Check if already exists
			String checkSql = "SELECT id FROM user_books WHERE user_id = ? AND book_id = ?";
			PreparedStatement checkPs = conn.prepareStatement(checkSql);
			checkPs.setInt(1, userBook.getUserId());
			checkPs.setInt(2, userBook.getBookId());

			ResultSet rs = checkPs.executeQuery();
			if (rs.next()) {
				System.out.println("Book already exists in library");
				f = true;
			} else {
				// Insert with all required fields including purchase_date
				String sql = "INSERT INTO user_books (user_id, book_id, user_notes, purchase_date) VALUES (?, ?, ?, NOW())";
				ps = conn.prepareStatement(sql);
				ps.setInt(1, userBook.getUserId());
				ps.setInt(2, userBook.getBookId());
				ps.setString(3, userBook.getUserNotes() != null ? userBook.getUserNotes() : "");

				int i = ps.executeUpdate();
				System.out.println("Rows affected: " + i);

				if (i == 1) {
					f = true;
					System.out.println("✓ Book successfully inserted into user_books");
				} else {
					System.out.println("✗ Insert failed - no rows affected");
				}
			}
		} catch (SQLException e) {
			System.out.println("SQL Error: " + e.getMessage());
			System.out.println("SQL State: " + e.getSQLState());
			System.out.println("Error Code: " + e.getErrorCode());
			e.printStackTrace();
		} catch (Exception e) {
			System.out.println("General Error: " + e.getMessage());
			e.printStackTrace();
		} finally {
			try {
				if (ps != null)
					ps.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return f;
	}

	@Override
	public List<UserBooks> getUserBooksByUserId(int userId) {
		List<UserBooks> list = new ArrayList<>();
		try {
			String sql = "SELECT ub.*, b.bookname, b.author, b.pdf_file " + "FROM user_books ub "
					+ "JOIN book_details b ON ub.book_id = b.bookId " + "WHERE ub.user_id = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, userId);

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				UserBooks ub = new UserBooks();
				ub.setId(rs.getInt("id"));
				ub.setUserId(rs.getInt("user_id"));
				ub.setBookId(rs.getInt("book_id"));
				ub.setUserNotes(rs.getString("user_notes"));
				ub.setPurchaseDate(rs.getTimestamp("purchase_date"));

				// Additional book details
				ub.setBookName(rs.getString("bookname"));
				ub.setAuthor(rs.getString("author"));
				ub.setPdfFile(rs.getString("pdf_file"));

				list.add(ub);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public UserBooks getUserBook(int userId, int bookId) {
		UserBooks ub = null;
		try {
			String sql = "SELECT * FROM user_books WHERE user_id = ? AND book_id = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, userId);
			ps.setInt(2, bookId);

			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				ub = new UserBooks();
				ub.setId(rs.getInt("id"));
				ub.setUserId(rs.getInt("user_id"));
				ub.setBookId(rs.getInt("book_id"));
				ub.setUserNotes(rs.getString("user_notes"));
				ub.setPurchaseDate(rs.getTimestamp("purchase_date"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return ub;
	}

	@Override
	public boolean updateUserNotes(int userId, int bookId, String notes) {
		boolean f = false;
		try {
			String sql = "UPDATE user_books SET user_notes = ? WHERE user_id = ? AND book_id = ?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, notes);
			ps.setInt(2, userId);
			ps.setInt(3, bookId);

			int i = ps.executeUpdate();
			if (i == 1) {
				f = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}
}