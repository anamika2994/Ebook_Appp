package com.DAO;

import com.entity.UserBooks;
import java.util.List;

public interface UserBooksDAO {
    public boolean addUserBook(UserBooks userBook);
    public List<UserBooks> getUserBooksByUserId(int userId);
    public UserBooks getUserBook(int userId, int bookId);
    public boolean updateUserNotes(int userId, int bookId, String notes);
}