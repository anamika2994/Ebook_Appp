package com.DAO;

import com.entity.Payment;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.DB.DBconnect;

public class PaymentDAOImpl implements PaymentDAO {
    private Connection conn;

    public PaymentDAOImpl(Connection conn) {
        this.conn = conn;
    }

    @Override
    public boolean createPayment(Payment payment) {
        boolean f = false;
        try {
            System.out.println("Creating payment for order: " + payment.getOrderId());
            
            String sql = "INSERT INTO payments (user_id, order_id, amount, payment_method, payment_status, transaction_id, phone_number) VALUES (?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, payment.getUserId());
            ps.setString(2, payment.getOrderId());
            ps.setDouble(3, payment.getAmount());
            ps.setString(4, payment.getPaymentMethod());
            ps.setString(5, payment.getPaymentStatus());
            ps.setString(6, payment.getTransactionId());
            ps.setString(7, payment.getPhoneNumber());
            
            int i = ps.executeUpdate();
            System.out.println("Payment record created: " + (i == 1));
            
            if (i == 1) {
                f = true;
            }
        } catch (Exception e) {
            System.out.println("Error creating payment: " + e.getMessage());
            e.printStackTrace();
        }
        return f;
    }

    @Override
    public Payment getPaymentByOrderId(String orderId) {
        Payment payment = null;
        try {
            String sql = "SELECT * FROM payments WHERE order_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, orderId);
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                payment = new Payment();
                payment.setId(rs.getInt("id"));
                payment.setUserId(rs.getInt("user_id"));
                payment.setOrderId(rs.getString("order_id"));
                payment.setAmount(rs.getDouble("amount"));
                payment.setPaymentMethod(rs.getString("payment_method"));
                payment.setPaymentStatus(rs.getString("payment_status"));
                payment.setTransactionId(rs.getString("transaction_id"));
                payment.setPhoneNumber(rs.getString("phone_number"));
                payment.setCreatedAt(rs.getTimestamp("created_at"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return payment;
    }

    @Override
    public boolean updatePaymentStatus(String orderId, String status, String transactionId) {
        boolean f = false;
        try {
            String sql = "UPDATE payments SET payment_status = ?, transaction_id = ? WHERE order_id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, status);
            ps.setString(2, transactionId);
            ps.setString(3, orderId);
            
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
    public List<Payment> getUserPayments(int userId) {
        List<Payment> list = new ArrayList<>();
        try {
            String sql = "SELECT * FROM payments WHERE user_id = ? ORDER BY created_at DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Payment payment = new Payment();
                payment.setId(rs.getInt("id"));
                payment.setUserId(rs.getInt("user_id"));
                payment.setOrderId(rs.getString("order_id"));
                payment.setAmount(rs.getDouble("amount"));
                payment.setPaymentMethod(rs.getString("payment_method"));
                payment.setPaymentStatus(rs.getString("payment_status"));
                payment.setTransactionId(rs.getString("transaction_id"));
                payment.setPhoneNumber(rs.getString("phone_number"));
                payment.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(payment);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    
}