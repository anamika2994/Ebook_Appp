package com.DAO;

import com.entity.BookRating;
import java.util.List;

public interface RatingDAO {
    public boolean addRating(BookRating rating);
    public boolean updateRating(BookRating rating);
    public boolean deleteRating(int ratingId);
    public BookRating getRatingByUserAndBook(int userId, int bookId);
    public List<BookRating> getRatingsByBook(int bookId);
    public List<BookRating> getRatingsByUser(int userId);
    public double getAverageRating(int bookId);
    public int getRatingCount(int bookId);
}