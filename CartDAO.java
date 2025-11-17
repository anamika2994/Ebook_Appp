package com.DAO;

import com.entity.Cart;
import java.util.List;

public interface CartDAO {
	
    public boolean addCart(Cart c);
    public List<Cart> getBookByUser(int userid);
    public boolean removeCartItem(int userId, int bookId);

}
