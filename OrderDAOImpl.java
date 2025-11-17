package com.DAO;

import com.entity.Order;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAOImpl implements OrderDAO {
	
	
	
    private Connection conn;

    public OrderDAOImpl(Connection conn) {
        this.conn = conn;
    }

    @Override
    public List<Order> getAllOrders() {
    	
        List<Order> list = new ArrayList<>();
        try {
        	String sql = "SELECT p.*, u.name, u.email " +
                    "FROM payments p " +
                    "LEFT JOIN user u ON p.user_id = u.userid " + 
                    "ORDER BY p.created_at DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setUserId(rs.getInt("user_id"));
                order.setOrderId(rs.getString("order_id"));
                order.setCustomerName(rs.getString("name"));
                order.setCustomerEmail(rs.getString("email"));
                order.setAmount(rs.getDouble("amount"));
                order.setPaymentMethod(rs.getString("payment_method"));
                order.setPaymentStatus(rs.getString("payment_status"));
                order.setTransactionId(rs.getString("transaction_id"));
                order.setPhoneNumber(rs.getString("phone_number"));
                order.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<Order> getOrdersByUserId(int userId) {
        List<Order> list = new ArrayList<>();
        try {
            String sql = "SELECT p.*, u.name, u.email " +
                        "FROM payments p " +
                        "JOIN user u ON p.user_id = u.userid " +
                        "WHERE p.user_id = ? " +
                        "ORDER BY p.created_at DESC";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setUserId(rs.getInt("user_id"));
                order.setOrderId(rs.getString("order_id"));
                order.setCustomerName(rs.getString("name"));
                order.setCustomerEmail(rs.getString("email"));
                order.setAmount(rs.getDouble("amount"));
                order.setPaymentMethod(rs.getString("payment_method"));
                order.setPaymentStatus(rs.getString("payment_status"));
                order.setTransactionId(rs.getString("transaction_id"));
                order.setPhoneNumber(rs.getString("phone_number"));
                order.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Order getOrderById(int orderId) {
        Order order = null;
        try {
            String sql = "SELECT p.*, u.name, u.email " +
                        "FROM payments p " +
                        "JOIN user u ON p.user_id = u.userid " +
                        "WHERE p.id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                order = new Order();
                order.setId(rs.getInt("id"));
                order.setUserId(rs.getInt("user_id"));
                order.setOrderId(rs.getString("order_id"));
                order.setCustomerName(rs.getString("name"));
                order.setCustomerEmail(rs.getString("email"));
                order.setAmount(rs.getDouble("amount"));
                order.setPaymentMethod(rs.getString("payment_method"));
                order.setPaymentStatus(rs.getString("payment_status"));
                order.setTransactionId(rs.getString("transaction_id"));
                order.setPhoneNumber(rs.getString("phone_number"));
                order.setCreatedAt(rs.getTimestamp("created_at"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return order;
    }

    @Override
    public boolean updateOrderStatus(int orderId, String status) {
        boolean f = false;
        try {
            String sql = "UPDATE payments SET payment_status = ? WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, orderId);
            
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