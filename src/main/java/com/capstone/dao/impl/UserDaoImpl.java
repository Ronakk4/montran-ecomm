package com.capstone.dao.impl;

import java.time.LocalDateTime;

import javax.transaction.Transactional;

import org.hibernate.Session;

//import javax.persistence.Query;

import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.capstone.dao.UserDao;
import com.capstone.model.User;

@Repository
@Transactional
public class UserDaoImpl implements UserDao{

	
	@Autowired
    private SessionFactory sessionFactory;

//    private static Session getSession() {
//        return sessionFactory.getCurrentSession();
//    }

    @Override
    public void saveUser(User u) {
    	u.setCreatedAt(LocalDateTime.now());
        u.setUpdatedAt(LocalDateTime.now());
        sessionFactory.getCurrentSession().save(u);
    }
    
	@Override
	public User findUserById(long id) {
		// TODO Auto-generated method stub
		return sessionFactory.getCurrentSession().get(User.class, id);
	}

	@Override
	public User findUserByEmail(String email) {
		// TODO Auto-generated method stub
		Query <User> query = sessionFactory.getCurrentSession().createQuery("from User where email= :email", User.class);
		query.setParameter("email",email);
		return query.uniqueResult();
	}


	

	@Override
	public void deleteUser(User u) {
		// TODO Auto-generated method stub
		sessionFactory.getCurrentSession().delete(u);
	}

	@Transactional
	public void updateUser(User updatedUser) {
	    Session session = sessionFactory.getCurrentSession();

	    
	    User existingUser = session.get(User.class, updatedUser.getId());
	    if (existingUser == null) {
	        throw new RuntimeException("User not found with id " + updatedUser.getId());
	    }

	    // Update only fields that are provided
	    if (updatedUser.getName() != null) {
	        existingUser.setName(updatedUser.getName());
	    }
	    if (updatedUser.getEmail() != null) {
	        existingUser.setEmail(updatedUser.getEmail());
	    }
	   

	    
	    if (updatedUser.getPassword() != null && !updatedUser.getPassword().isEmpty()) {
	        existingUser.setPassword(updatedUser.getPassword());
	    }

	  
	    session.merge(existingUser);
	}


	@Override
	public void changePassword(String newPassword, long id) {
		sessionFactory.getCurrentSession().createQuery("update User set password = :newPassword where id = :id")
		.setParameter("id", id)
		.setParameter("newPassword", newPassword).executeUpdate();
	}
	
	
	public String getPassword(long id) {
		return sessionFactory.getCurrentSession().createQuery("select password from User where id=:id").setParameter("id", id).uniqueResult().toString();
	}

	

	

	
}
