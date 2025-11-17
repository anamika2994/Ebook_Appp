package com.entity;

import java.sql.Timestamp;

public class BookRating {
    private int id;
    private int userId;
    private int bookId;
    private int rating; // 1 to 5
    private String reviewText;
    private Timestamp createdAt;
    private String userName;
    private String bookName;
    
    // Constructors
    public BookRating() {}
    
    public BookRating(int userId, int bookId, int rating) {
        this.userId = userId;
        this.bookId = bookId;
        this.rating = rating;
    }
    
    // Getters & Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public int getBookId() { return bookId; }
    public void setBookId(int bookId) { this.bookId = bookId; }
    
    public int getRating() { return rating; }
    public void setRating(int rating) { this.rating = rating; }
    
    public String getReviewText() { return reviewText; }
    public void setReviewText(String reviewText) { this.reviewText = reviewText; }
    
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    
    public String getUserName() { return userName; }
    public void setUserName(String userName) { this.userName = userName; }
    
    public String getBookName() { return bookName; }
    public void setBookName(String bookName) { this.bookName = bookName; }
}