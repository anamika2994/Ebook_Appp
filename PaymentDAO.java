package com.DAO;

import com.entity.Payment;
import java.util.List;

public interface PaymentDAO {
    public boolean createPayment(Payment payment);
    public Payment getPaymentByOrderId(String orderId);
    public boolean updatePaymentStatus(String orderId, String status, String transactionId);
    public List<Payment> getUserPayments(int userId);
    
   
}