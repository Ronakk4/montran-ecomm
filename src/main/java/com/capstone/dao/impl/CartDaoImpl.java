package com.capstone.dao.impl;

import java.util.List;

import javax.transaction.Transactional;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.capstone.dao.CartDao;
import com.capstone.model.Cart;

@Repository
public class CartDaoImpl implements CartDao {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public Cart findByBuyerAndProduct(long buyerId, long prodId) {
		return sessionFactory.getCurrentSession().createQuery("from Cart c where c.buyer.id = :buyerId and c.product.prodId = :prodId", Cart.class)
		.setParameter("buyerId", buyerId)
		.setParameter("prodId", prodId)
		.uniqueResult();
		
	}

	@Override
	public void saveCart(Cart cart) {
		sessionFactory.getCurrentSession().save(cart);
	}

	@Override
	public void updateCart(Cart existingCart) {
		sessionFactory.getCurrentSession().update(existingCart);
		
	}

	@Override
	public void deleteCart(long buyerId, long prodId) {
	    Cart cart = findByBuyerAndProduct(buyerId, prodId);
	    if (cart != null) {
	        sessionFactory.getCurrentSession().delete(cart);
	    } else {
	        // Optional: log or throw exception
	        System.out.println("Cart not found for buyerId: " + buyerId + ", prodId: " + prodId);
	    }
	}

	@Override
	public List<Cart> getCartForBuyer(long buyerId) {
		return sessionFactory.getCurrentSession().createQuery("from Cart c where c.buyer.id = :buyerId order by product_id", Cart.class)
		.setParameter("buyerId", buyerId)
		.list();
		
	}

	@Override
	@Transactional
	public void deleteAllCartItems(long userId) {
	    sessionFactory.getCurrentSession()
	        .createQuery("DELETE FROM Cart c WHERE c.buyer.id = :userId")
	        .setParameter("userId", userId)
	        .executeUpdate();
	}


}
