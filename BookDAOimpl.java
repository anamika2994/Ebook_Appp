package com.DAO;

import com.entity.BookDtls;

import java.util.List;
import java.sql.ResultSet;
import java.util.ArrayList;
import com.DB.DBconnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import com.entity.BookDtls;
import com.DAO.userDAOimpl;

public class BookDAOimpl implements BookDAO {

	private Connection conn;

	public BookDAOimpl(Connection conn) {
		super();
		this.conn = conn;

	}

	@Override
	public boolean addBooks(BookDtls b) {
		boolean f = false;
		try {
			String sql = "insert into book_details(bookname,author,price,bookCategory,status,photo,user_email,pdf_file) values (?,?,?,?,?,?,?,?)";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, b.getBookName());
			ps.setString(2, b.getAuthor());
			ps.setString(3, b.getPrice());
			ps.setString(4, b.getBookCategory());
			ps.setString(5, b.getStatus());
			ps.setString(6, b.getPhotoName());
			ps.setString(7, b.getEmail());
			ps.setString(8, b.getPdfFile()); // New PDF field

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
	public List<BookDtls> getAllBooks() {

		List<BookDtls> list = new ArrayList<BookDtls>();
		BookDtls b = null;

		try {
			String sql = "select * from book_details";
			PreparedStatement ps = conn.prepareStatement(sql);

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				b = new BookDtls();
				b.setId(rs.getInt(1));
				b.setBookName(rs.getString(2));
				b.setAuthor(rs.getString(3));
				b.setPrice(rs.getString(4));
				b.setBookCategory(rs.getString(5));
				b.setStatus(rs.getString(6));
				b.setPhotoName(rs.getString(7));
				b.setEmail(rs.getString(8));
				list.add(b);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public BookDtls getBookById(int id) {
		BookDtls b = null;
		try {
			String sql = "select * from book_details where bookId=?";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setInt(1, id);

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				b = new BookDtls();
				b.setId(rs.getInt(1));
				b.setBookName(rs.getString(2));
				b.setAuthor(rs.getString(3));
				b.setPrice(rs.getString(4));
				b.setBookCategory(rs.getString(5));
				b.setStatus(rs.getString(6));
				b.setPhotoName(rs.getString(7));
				b.setEmail(rs.getString(8));
				b.setPdfFile(rs.getString(9)); // PDF field
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return b;
	}

	@Override
	public boolean updateEditBooks(BookDtls b) {
		boolean f = false;
		try {
			String sql = "update book_details set bookname=?,author=?,price=?,status=? where bookId=?";
			PreparedStatement ps = conn.prepareStatement(sql);

			ps.setString(1, b.getBookName());
			ps.setString(2, b.getAuthor());
			ps.setString(3, b.getPrice());
			ps.setString(4, b.getStatus());
			ps.setInt(5, b.getId());

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
	public boolean deleteBooks(int id) {
	    boolean f = false;
	    try {
	        // 1️⃣ Delete dependent rows from user_books table
	        String deleteUserBooks = "DELETE FROM user_books WHERE book_id=?";
	        PreparedStatement ps1 = conn.prepareStatement(deleteUserBooks);
	        ps1.setInt(1, id);
	        ps1.executeUpdate();

	        // 2️⃣ Delete the book from book_details table
	        String deleteBook = "DELETE FROM book_details WHERE bookId=?";
	        PreparedStatement ps2 = conn.prepareStatement(deleteBook);
	        ps2.setInt(1, id);
	        int i = ps2.executeUpdate();

	        // 3️⃣ Check if book delete was successful
	        if(i == 1){
	            f = true;
	        }

	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return f;
	}


	@Override
	public List<BookDtls> getFictionBook() {
		List<BookDtls> list = new ArrayList<BookDtls>();
		BookDtls b = null;

		try {

			String sql = "SELECT * FROM book_details WHERE bookCategory=? AND status=? ORDER BY bookId DESC LIMIT 4";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, "Fiction");
			ps.setString(2, "Active");
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				b = new BookDtls();
				b.setId(rs.getInt(1));
				b.setBookName(rs.getString(2));
				b.setAuthor(rs.getString(3));
				b.setPrice(rs.getString(4));
				b.setBookCategory(rs.getString(5));
				b.setStatus(rs.getString(6));
				b.setPhotoName(rs.getString(7));
				b.setEmail(rs.getString(8));
				list.add(b);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;

	}

	@Override
	public List<BookDtls> getNonFictionBook() {
		List<BookDtls> list = new ArrayList<BookDtls>();
		BookDtls b = null;

		try {
			String sql = "SELECT * FROM book_details WHERE bookCategory=? AND status=? ORDER BY bookId DESC LIMIT 4";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, "Non-Fiction");
			ps.setString(2, "Active");
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				b = new BookDtls();
				b.setId(rs.getInt(1));
				b.setBookName(rs.getString(2));
				b.setAuthor(rs.getString(3));
				b.setPrice(rs.getString(4));
				b.setBookCategory(rs.getString(5));
				b.setStatus(rs.getString(6));
				b.setPhotoName(rs.getString(7));
				b.setEmail(rs.getString(8));
				list.add(b);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public List<BookDtls> getEducationalBook() {
		List<BookDtls> list = new ArrayList<BookDtls>();
		BookDtls b = null;

		try {
			String sql = "SELECT * FROM book_details WHERE bookCategory=? AND status=? ORDER BY bookId DESC LIMIT 4";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, "Educational");
			ps.setString(2, "Active");
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				b = new BookDtls();
				b.setId(rs.getInt(1));
				b.setBookName(rs.getString(2));
				b.setAuthor(rs.getString(3));
				b.setPrice(rs.getString(4));
				b.setBookCategory(rs.getString(5));
				b.setStatus(rs.getString(6));
				b.setPhotoName(rs.getString(7));
				b.setEmail(rs.getString(8));
				list.add(b);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public List<BookDtls> getProfessionalBook() {
		List<BookDtls> list = new ArrayList<BookDtls>();
		BookDtls b = null;

		try {
			String sql = "SELECT * FROM book_details WHERE bookCategory=? AND status=? ORDER BY bookId DESC LIMIT 4";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, "Professional");
			ps.setString(2, "Active");
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				b = new BookDtls();
				b.setId(rs.getInt(1));
				b.setBookName(rs.getString(2));
				b.setAuthor(rs.getString(3));
				b.setPrice(rs.getString(4));
				b.setBookCategory(rs.getString(5));
				b.setStatus(rs.getString(6));
				b.setPhotoName(rs.getString(7));
				b.setEmail(rs.getString(8));
				list.add(b);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public List<BookDtls> getTechnology() {
		List<BookDtls> list = new ArrayList<BookDtls>();
		BookDtls b = null;

		try {
			String sql = "SELECT * FROM book_details WHERE bookCategory=? AND status=? ORDER BY bookId DESC LIMIT 4";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, "Children");
			ps.setString(2, "Active");
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				b = new BookDtls();
				b.setId(rs.getInt(1));
				b.setBookName(rs.getString(2));
				b.setAuthor(rs.getString(3));
				b.setPrice(rs.getString(4));
				b.setBookCategory(rs.getString(5));
				b.setStatus(rs.getString(6));
				b.setPhotoName(rs.getString(7));
				b.setEmail(rs.getString(8));
				list.add(b);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public List<BookDtls> getComicsBook() {
		List<BookDtls> list = new ArrayList<BookDtls>();
		BookDtls b = null;

		try {
			String sql = "SELECT * FROM book_details WHERE bookCategory=? AND status=? ORDER BY bookId DESC LIMIT 4";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, "Comics");
			ps.setString(2, "Active");
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				b = new BookDtls();
				b.setId(rs.getInt(1));
				b.setBookName(rs.getString(2));
				b.setAuthor(rs.getString(3));
				b.setPrice(rs.getString(4));
				b.setBookCategory(rs.getString(5));
				b.setStatus(rs.getString(6));
				b.setPhotoName(rs.getString(7));
				b.setEmail(rs.getString(8));
				list.add(b);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public List<BookDtls> getAllFictionBook() {
		List<BookDtls> list = new ArrayList<BookDtls>();
		BookDtls b = null;

		try {

			String sql = "SELECT * FROM book_details WHERE bookCategory=? AND status=? ORDER BY bookId DESC";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, "Fiction");
			ps.setString(2, "Active");
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				b = new BookDtls();
				b.setId(rs.getInt(1));
				b.setBookName(rs.getString(2));
				b.setAuthor(rs.getString(3));
				b.setPrice(rs.getString(4));
				b.setBookCategory(rs.getString(5));
				b.setStatus(rs.getString(6));
				b.setPhotoName(rs.getString(7));
				b.setEmail(rs.getString(8));
				list.add(b);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;

	}

	@Override
	public List<BookDtls> getAllNonFictionBook() {
		List<BookDtls> list = new ArrayList<BookDtls>();
		BookDtls b = null;

		try {
			String sql = "SELECT * FROM book_details WHERE bookCategory=? AND status=? ORDER BY bookId DESC";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, "Non-Fiction");
			ps.setString(2, "Active");
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				b = new BookDtls();
				b.setId(rs.getInt(1));
				b.setBookName(rs.getString(2));
				b.setAuthor(rs.getString(3));
				b.setPrice(rs.getString(4));
				b.setBookCategory(rs.getString(5));
				b.setStatus(rs.getString(6));
				b.setPhotoName(rs.getString(7));
				b.setEmail(rs.getString(8));
				list.add(b);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public List<BookDtls> getAllEducationalBook() {
		List<BookDtls> list = new ArrayList<BookDtls>();
		BookDtls b = null;

		try {
			String sql = "SELECT * FROM book_details WHERE bookCategory=? AND status=? ORDER BY bookId DESC";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, "Educational");
			ps.setString(2, "Active");
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				b = new BookDtls();
				b.setId(rs.getInt(1));
				b.setBookName(rs.getString(2));
				b.setAuthor(rs.getString(3));
				b.setPrice(rs.getString(4));
				b.setBookCategory(rs.getString(5));
				b.setStatus(rs.getString(6));
				b.setPhotoName(rs.getString(7));
				b.setEmail(rs.getString(8));
				list.add(b);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public List<BookDtls> getAllProfessionalBook() {
		List<BookDtls> list = new ArrayList<BookDtls>();
		BookDtls b = null;

		try {
			String sql = "SELECT * FROM book_details WHERE bookCategory=? AND status=? ORDER BY bookId DESC";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, "Professional");
			ps.setString(2, "Active");
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				b = new BookDtls();
				b.setId(rs.getInt(1));
				b.setBookName(rs.getString(2));
				b.setAuthor(rs.getString(3));
				b.setPrice(rs.getString(4));
				b.setBookCategory(rs.getString(5));
				b.setStatus(rs.getString(6));
				b.setPhotoName(rs.getString(7));
				b.setEmail(rs.getString(8));
				list.add(b);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public List<BookDtls> getAllTechnology() {
		List<BookDtls> list = new ArrayList<BookDtls>();
		BookDtls b = null;

		try {
			String sql = "SELECT * FROM book_details WHERE bookCategory=? AND status=? ORDER BY bookId DESC ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, "Children");
			ps.setString(2, "Active");
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				b = new BookDtls();
				b.setId(rs.getInt(1));
				b.setBookName(rs.getString(2));
				b.setAuthor(rs.getString(3));
				b.setPrice(rs.getString(4));
				b.setBookCategory(rs.getString(5));
				b.setStatus(rs.getString(6));
				b.setPhotoName(rs.getString(7));
				b.setEmail(rs.getString(8));
				list.add(b);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public List<BookDtls> getAllComicsBook() {
		List<BookDtls> list = new ArrayList<BookDtls>();
		BookDtls b = null;

		try {
			String sql = "SELECT * FROM book_details WHERE bookCategory=? AND status=? ORDER BY bookId DESC ";
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, "Comics");
			ps.setString(2, "Active");
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				b = new BookDtls();
				b.setId(rs.getInt(1));
				b.setBookName(rs.getString(2));
				b.setAuthor(rs.getString(3));
				b.setPrice(rs.getString(4));
				b.setBookCategory(rs.getString(5));
				b.setStatus(rs.getString(6));
				b.setPhotoName(rs.getString(7));
				b.setEmail(rs.getString(8));
				list.add(b);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return list;
	}

	@Override
	public List<BookDtls> getBookBySerch(String ch) {
	    List<BookDtls> list = new ArrayList<BookDtls>();
	    BookDtls b = null;
	    try {
	        String sql = "select * from book_details where (bookname like ? or author like ? or bookCategory like ?) and status=?";
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ps.setString(1, "%" + ch + "%");
	        ps.setString(2, "%" + ch + "%"); 
	        ps.setString(3, "%" + ch + "%");
	        ps.setString(4, "Active");

	        ResultSet rs = ps.executeQuery();
	        while (rs.next()) {
	            b = new BookDtls();
	            b.setId(rs.getInt(1));
	            b.setBookName(rs.getString(2));
	            b.setAuthor(rs.getString(3));
	            b.setPrice(rs.getString(4));
	            b.setBookCategory(rs.getString(5));
	            b.setStatus(rs.getString(6));
	            b.setPhotoName(rs.getString(7));
	            b.setEmail(rs.getString(8));
	            list.add(b);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}
}
