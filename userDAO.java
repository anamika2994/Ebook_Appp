package com.DAO;
import com.entity.user;

public interface userDAO {
   public boolean userRegister(user us);
   public user login(String email, String password);
   public boolean updateUser(user us);        // শুধু signature
   public boolean updatePassword(int userId, String newPassword); // শুধু signature
   
   
   public boolean checkUser(String em);
}