package com.DAO;

import com.entity.Order;
import java.util.List;

public interface OrderDAO {
    public List<Order> getAllOrders();
    public List<Order> getOrdersByUserId(int userId);
    public Order getOrderById(int orderId);
    public boolean updateOrderStatus(int orderId, String status);
}