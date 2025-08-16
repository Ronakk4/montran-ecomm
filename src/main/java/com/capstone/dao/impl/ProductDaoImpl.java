package com.capstone.dao.impl;

import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.transaction.Transactional;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.capstone.model.Product;
import com.capstone.dao.ProductDao;
import com.capstone.dto.ProductInsertDTO;

@Repository
@Transactional
public class ProductDaoImpl implements ProductDao {

	@Autowired
	private SessionFactory sessionFactory;

	@Override
	public List<Product> getAllProducts() {
		// TODO Auto-generated method stub
		return sessionFactory.getCurrentSession().createQuery("from Product", Product.class).list();
	}

	@Override
	public Product getProduct(long id) {
		// TODO Auto-generated method stub
		return sessionFactory.getCurrentSession().get(Product.class, id);
	}

	@Override
	public void saveProduct(Product product) {
	    sessionFactory.getCurrentSession().save(product);
	}


	@Override
	public void deleteProduct(long id) {
<<<<<<< HEAD
		// TODO Auto-generated method stub
		Product product = sessionFactory.getCurrentSession().get(Product.class, id);
        if (product != null) {
            sessionFactory.getCurrentSession().delete(product);
        }
=======
	    sessionFactory.getCurrentSession()
	        .createQuery("DELETE FROM Product p WHERE p.id = :id")
	        .setParameter("id", id)
	        .executeUpdate();
>>>>>>> 5631ad52eb4eff248ae2343ad35c8e766c425dab
	}



	@Override
	public List<Product> getProductsFromCategory(String category) {
		return sessionFactory.getCurrentSession().createQuery("from Product where category = :category", Product.class)
		.setParameter("category", category)
		.list();
		
		
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

}
