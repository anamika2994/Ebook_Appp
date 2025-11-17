package com.entity;



import java.sql.Timestamp;

public class UserBooks {
    private int id;
    private int userId;
    private int bookId;
    private String userNotes;
    private Timestamp purchaseDate;
    private String bookName;
    private String author;
    private String pdfFile;
    
    // Constructors
    public UserBooks() {}
    
    public UserBooks(int userId, int bookId, String userNotes) {
        this.userId = userId;
        this.bookId = bookId;
        this.userNotes = userNotes;
    }
    
    // Getters & Setters (সবগুলো)
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public int getBookId() { return bookId; }
    public void setBookId(int bookId) { this.bookId = bookId; }
    
    public String getUserNotes() { return userNotes; }
    public void setUserNotes(String userNotes) { this.userNotes = userNotes; }
    
    public Timestamp getPurchaseDate() { return purchaseDate; }
    public void setPurchaseDate(Timestamp purchaseDate) { this.purchaseDate = purchaseDate; }
    
    public String getBookName() { return bookName; }
    public void setBookName(String bookName) { this.bookName = bookName; }
    
    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }
    
    public String getPdfFile() { return pdfFile; }
    public void setPdfFile(String pdfFile) { this.pdfFile = pdfFile; }
}