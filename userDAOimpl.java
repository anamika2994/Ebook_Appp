package com.DAO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import com.entity.user;
import com.DB.DBconnect;

public class userDAOimpl implements userDAO {
    private Connection conn;

    public userDAOimpl(Connection conn) {
        this.conn = conn;
    }

    @Override
    public boolean userRegister(user us) {
        boolean f = false;
        try {
            String sql = "insert into user(name,email,phno,password) values(?,?,?,?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, us.getName());
            ps.setString(2, us.getEmail());
            ps.setString(3, us.getPhno());
            ps.setString(4, us.getPassword());

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
    public user login(String email, String password) {
        user us = null;
        try {
            String sql = "select * from user where email=? and password=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                us = new user();
                us.setUserid(rs.getInt(1));
                us.setName(rs.getString(2));
                us.setEmail(rs.getString(3));
                us.setPhno(rs.getString(4));
                us.setPassword(rs.getString(5));
                us.setAddress(rs.getString(6));
                us.setLandmark(rs.getString(7));
                us.setCity(rs.getString(8));
                us.setState(rs.getString(9));
                us.setPincode(rs.getString(10));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return us;
    }

    @Override
    public boolean updateUser(user us) {
        boolean f = false;
        try {
            System.out.println("=== Update User Debug ===");
            System.out.println("User ID: " + us.getUserid());
            System.out.println("Name: " + us.getName());
            System.out.println("Phone: " + us.getPhno());
            System.out.println("Address: " + us.getAddress());
            System.out.println("City: " + us.getCity());
            System.out.println("State: " + us.getState());
            System.out.println("Pincode: " + us.getPincode());
            
            String sql = "UPDATE user SET name=?, phno=?, address=?, city=?, state=?, pincode=? WHERE userid=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, us.getName());
            ps.setString(2, us.getPhno());
            ps.setString(3, us.getAddress());
            ps.setString(4, us.getCity());
            ps.setString(5, us.getState());
            ps.setString(6, us.getPincode());
            ps.setInt(7, us.getUserid());
            
            int i = ps.executeUpdate();
            System.out.println("Rows affected: " + i);
            
            if (i == 1) {
                f = true;
            }
        } catch (Exception e) {
            System.out.println("Error in updateUser: " + e.getMessage());
            e.printStackTrace();
        }
        return f;
    }
    
    @Override
    public boolean updatePassword(int userId, String newPassword) {
        boolean f = false;
        try {
            String sql = "UPDATE user SET password=? WHERE userid=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, newPassword);
            ps.setInt(2, userId);
            
            int i = ps.executeUpdate();
            if (i == 1) {
                f = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return f;
    }
    
    
    public boolean checkUser(String em) {
        boolean f=true;

        try {
            String sql = "select * from user where email=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, em);

            ResultSet rs=ps.executeQuery();
            while(rs.next())
            {
                f=false;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return f; // NOTE: The return statement appears outside the try-catch and returns 'false' regardless of 'f's value.
    }
}