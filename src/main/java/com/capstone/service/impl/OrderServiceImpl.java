
package com.capstone.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.capstone.dao.CartDao;
import com.capstone.dao.OrderHeaderDao;
import com.capstone.dao.OrderItemDao;
import com.capstone.dto.OrderDTO;
import com.capstone.dto.OrderItemDTO;
import com.capstone.dto.SellerOrderDTO;
import com.capstone.model.Buyer;
import com.capstone.model.CartItem;
import com.capstone.model.OrderHeader;
import com.capstone.model.OrderItem;
import com.capstone.model.Product;
import com.capstone.model.Seller;
import com.capstone.service.OrderService;

@Service
public class OrderServiceImpl implements OrderService{
	
	@Autowired
	private OrderItemDao orderItemDao;  
	
	@Autowired
	private OrderHeaderDao orderDao;  
	
	@Autowired
	private CartDao cartDao;
	
	@Autowired
	private SessionFactory sessionFactory;

	@Override
	@Transactional
	public List<OrderHeader> getAllOrders(long id) {
	    return orderDao.getAllOrders(id);
	}

	@Override
	@Transactional
	public OrderHeader getOrder(long id) {
	    return orderDao.getOrder(id);
	}

	@Override
	@Transactional
	public void deleteOrder(long id) {
	    orderDao.deleteOrder(id);
	}

	@Override
	@Transactional
	public void saveOrder(OrderDTO order) {
	    Buyer buyer = sessionFactory.getCurrentSession().get(Buyer.class, order.getBuyerId());

	    // create OrderHeader
	    OrderHeader oh = new OrderHeader();
	    oh.setBuyer(buyer);
	    oh.setStatus(order.getStatus());
	    oh.setTotalAmount(order.getTotalAmount());

	    List<OrderItem> orderItems = new ArrayList<>();

	    for (OrderItemDTO itemOrder : order.getItems()) {
	        Product product = sessionFactory.getCurrentSession().get(Product.class, itemOrder.getProductId());
	        Seller seller = sessionFactory.getCurrentSession().get(Seller.class, itemOrder.getSellerId());

	        OrderItem orderItem = new OrderItem();
	        orderItem.setOrderHeader(oh); // associate with order
	        orderItem.setProduct(product);
	        orderItem.setSeller(seller);
	        orderItem.setQuantity(itemOrder.getQuantity());
	        orderItem.setPrice(itemOrder.getPrice());

	        orderItems.add(orderItem);
	    }

	    oh.setItems(orderItems);

	    // saving orderHeader will cascade to orderItems if mapped correctly
	    orderDao.saveOrder(oh);
	    
	    cartDao.deleteAllCartItems(buyer.getId());
	}

	
	@Override
	@Transactional
	public List<SellerOrderDTO> getOrdersForSeller(long sellerId) {
        List<OrderItem> orderItems = orderItemDao.getAllOrdersForSeller(sellerId);

        Map<Long, SellerOrderDTO> ordersMap = new HashMap<>();

        for (OrderItem item : orderItems) {
            Long orderId = item.getOrderHeader().getOrderId();

            SellerOrderDTO dto = ordersMap.getOrDefault(orderId, new SellerOrderDTO());
            dto.setOrderId(orderId);
            dto.setStatus(item.getOrderHeader().getStatus());
            dto.setTotalAmount(item.getOrderHeader().getTotalAmount());
            dto.setShippingAddress(item.getOrderHeader().getBuyer().getShippingAddress());
            dto.setOrderDate(item.getOrderHeader().getOrderDate());

            if (dto.getItems() == null) {
                dto.setItems(new ArrayList<>());
            }

            OrderItemDTO itemDTO = new OrderItemDTO();
            itemDTO.setProductId(item.getProduct().getProdId());
            itemDTO.setSellerId(item.getSeller().getId());
            itemDTO.setQuantity(item.getQuantity());
            itemDTO.setPrice(item.getPrice());
            itemDTO.setOrderDate(item.getOrderHeader().getOrderDate());

            dto.getItems().add(itemDTO);
            ordersMap.put(orderId, dto);
        }

        return new ArrayList<>(ordersMap.values());
    }

	
	@Override
    public List<OrderHeader> searchOrders(long sellerId, String orderStatus, String startDate, String endDate) {
        return orderDao.searchOrders(sellerId, orderStatus, startDate, endDate);
    }

	@Override
	public OrderHeader placeOrder(List<CartItem> cartItems) {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	@Transactional
	public Map<String, Object> getMonthlySalesAndRevenue(long sellerId) {
	    Object[] result = orderDao.getMonthlySalesAndRevenue(sellerId);

	    Map<String, Object> response = new HashMap<>();

	    // COUNT(*) comes as BigInteger
	    Number totalSales = (Number) result[0];
	    // SUM(total_amount) comes as BigDecimal (or null)
	    Number totalRevenue = (Number) result[1];

	    response.put("totalSales", totalSales != null ? totalSales.longValue() : 0L);
	    response.put("totalRevenue", totalRevenue != null ? totalRevenue.doubleValue() : 0.0);

	    return response;
	}





}
