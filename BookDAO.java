package com.DAO;
import com.entity.BookDtls;
import java.util.List;


public interface BookDAO {
	
	public boolean addBooks(BookDtls b);
	public List<BookDtls> getAllBooks();
	
	public BookDtls getBookById(int id);
	public boolean updateEditBooks(BookDtls b);
	
	public boolean deleteBooks(int id);
	
	public List<BookDtls>getFictionBook();
	public List<BookDtls> getNonFictionBook();
	public List<BookDtls> getEducationalBook();
	public List<BookDtls> getProfessionalBook();
	public List<BookDtls> getTechnology();
	public List<BookDtls> getComicsBook();
	
	public List<BookDtls>getAllFictionBook();
	public List<BookDtls> getAllNonFictionBook();
	public List<BookDtls> getAllEducationalBook();
	public List<BookDtls> getAllProfessionalBook();
	public List<BookDtls> getAllTechnology();
	public List<BookDtls> getAllComicsBook();
	
	
	public List<BookDtls> getBookBySerch(String ch);
	

}
