package com.capstone.dao.impl;

import java.time.LocalDateTime;
import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.From;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.transaction.Transactional;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.capstone.model.Product;
import com.capstone.model.ProductHistory;
import com.capstone.model.Seller;
import com.capstone.dao.ProductDao;
import com.capstone.dto.ProductInsertDTO;


@Repository
@Transactional
public class ProductDaoImpl implements ProductDao {
	
	// @PersistenceContext
    // private EntityManager em;

	@Autowired
	private SessionFactory sessionFactory;

//	@Override
//	public List<Product> getAllProducts() {
//		// TODO Auto-generated method stub
//		return sessionFactory.getCurrentSession().createQuery("from Product", Product.class).list();
//	}

	@Override
	public Product getProduct(long id) {
		// TODO Auto-generated method stub
		return sessionFactory.getCurrentSession().get(Product.class, id);
	}

	@Override
	public void saveProduct(Product product) {
//		product.setCreatedAt(LocalDateTime.now());
//	    product.setUpdatedAt(LocalDateTime.now());

	    sessionFactory.getCurrentSession().save(product);
	}


	@Override
	public void deleteProduct(long id) {

		// TODO Auto-generated method stub
		Product product = sessionFactory.getCurrentSession().get(Product.class, id);
        if (product != null) {
            sessionFactory.getCurrentSession().delete(product);
        }
	    sessionFactory.getCurrentSession()
	        .createQuery("DELETE FROM Product p WHERE p.id = :id")
	        .setParameter("id", id)
	        .executeUpdate();

	}

	@Override
	public void updateProduct(Product product) {
	    Product existingProduct = sessionFactory.getCurrentSession().get(Product.class, product.getProdId());
	    if (existingProduct != null) {
	        existingProduct.setProdName(product.getProdName());
	        existingProduct.setProdDescription(product.getProdDescription());
	        existingProduct.setPrice(product.getPrice());
	        existingProduct.setStockQuantity(product.getStockQuantity());
	        existingProduct.setCategory(product.getCategory());
	        existingProduct.setUpdatedAt(LocalDateTime.now());

	        if (product.getImages() != null && !product.getImages().isEmpty()) {
	            existingProduct.setImages(product.getImages());
	        }

	        sessionFactory.getCurrentSession().update(existingProduct);
	    } else {
	        throw new RuntimeException("Product with ID " + product.getProdId() + " not found");
	    }
	}

	
	@Override
    public List<Product> searchProducts(String prodName, String category, Double minPrice, Double maxPrice) {
        CriteriaBuilder criteriaBuilder = sessionFactory.getCurrentSession().getCriteriaBuilder();
        CriteriaQuery<Product> criteriaQuery = criteriaBuilder.createQuery(Product.class);
        Root<Product> root = criteriaQuery.from(Product.class);
        
        Predicate predicate = criteriaBuilder.conjunction();  // Start with a "true" predicate (i.e., no filters)
        
        if (prodName != null && !prodName.isEmpty()) {
            predicate = criteriaBuilder.and(predicate, criteriaBuilder.like(root.get("prodName"), "%" + prodName + "%"));
        }
        
        if (category != null && !category.isEmpty()) {
            predicate = criteriaBuilder.and(predicate, criteriaBuilder.equal(root.get("category"), category));
        }
        
        if (minPrice != null) {
            predicate = criteriaBuilder.and(predicate, criteriaBuilder.ge(root.get("price"), minPrice));
        }

        if (maxPrice != null) {
            predicate = criteriaBuilder.and(predicate, criteriaBuilder.le(root.get("price"), maxPrice));
        }

        criteriaQuery.where(predicate);
        
        return sessionFactory.getCurrentSession().createQuery(criteriaQuery).getResultList();
    }

		


	@Override
	public List<Product> getProductsBySellerId(long sellerId) {
		return sessionFactory.getCurrentSession().createQuery("from Product p where p.seller.id = :sellerId", Product.class)
				.setParameter("sellerId", sellerId)
				.list();
		
	}
	
	public Seller getSellerById(Long id) {
	    return sessionFactory.getCurrentSession().get(Seller.class, id);
	}



	@Override
	public List<String> getAllCategories() {
		return sessionFactory.getCurrentSession().createQuery("select distinct p.category from Product p", String.class)
				.list();
		
	}

	@Override
	public List<Product> getProductsFromCategory(String category) {
		return sessionFactory.getCurrentSession().createQuery("from Product where category = :category", Product.class)
		.setParameter("category", category)
		.list();
		
	}

	@Override
	public boolean existsByProdNameAndSellerId(String prodName, long sellerId) {
	    String hql = "SELECT COUNT(p) FROM Product p WHERE p.prodName = :name AND p.seller.id = :sellerId";
	    Long count = (Long) sessionFactory.getCurrentSession()
	                    .createQuery(hql)
	                    .setParameter("name", prodName)
	                    .setParameter("sellerId", sellerId)
	                    .uniqueResult();
	    return count != null && count > 0;
	}
	
	
	 public List<Product> getProductsByPage(int page, int size, String category, String sort) {
	        CriteriaBuilder cb = sessionFactory.getCurrentSession().getCriteriaBuilder();
	        CriteriaQuery<Product> cq = cb.createQuery(Product.class);
	        Root<Product> root = cq.from(Product.class);

	        // filter by category (case-insensitive match)
	        if (category != null && !category.equalsIgnoreCase("all")) {
	            cq.where(cb.equal(cb.lower(root.get("category")), category.toLowerCase()));
	        }

	        // sorting
	        if ("price-low".equals(sort)) {
	            cq.orderBy(cb.asc(root.get("price")));
	        } else if ("price-high".equals(sort)) {
	            cq.orderBy(cb.desc(root.get("price")));
	        } else if ("name".equals(sort)) {
	            cq.orderBy(cb.asc(root.get("prodName")));
	        } else if ("newest".equals(sort)) {
	            cq.orderBy(cb.desc(root.get("createdAt"))); // assumes you have createdAt field
	        }

	        TypedQuery<Product> query = cb.createQuery(cq);
	        query.setFirstResult((page - 1) * size);
	        query.setMaxResults(size);

	        return query.getResultList();
	    }

	    public long getProductCount(String category) {
	        CriteriaBuilder cb = cb.getCriteriaBuilder();
	        CriteriaQuery<Long> cq = cb.createQuery(Long.class);
	        Root<Product> root = cq.from(Product.class);

	        cq.select(cb.count(root));

	        if (category != null && !category.equalsIgnoreCase("all")) {
	            cq.where(cb.equal(cb.lower(root.get("category")), category.toLowerCase()));
	        }

	        return em.createQuery(cq).getSingleResult();
	    }

		@Override
		public void saveProductToHistory(ProductHistory ph) {
			// TODO Auto-generated method stub
			sessionFactory.getCurrentSession().save(ph);
			
		}

		@Override
		public List<ProductHistory> getDeletedProducts() {
			// TODO Auto-generated method stub
			return sessionFactory.getCurrentSession().createQuery("from ProductHistory", ProductHistory.class ).list();
		}
	

	

}
