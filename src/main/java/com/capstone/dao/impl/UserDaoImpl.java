package com.capstone.dao.impl;

import java.time.LocalDateTime;

import javax.transaction.Transactional;
import javax.validation.Valid;

//import javax.persistence.Query;

import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.capstone.dao.UserDao;
import com.capstone.dto.UserRegisterDTO;
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
    public void saveUser(User user) {
    	user.setCreatedAt(LocalDateTime.now());
        user.setUpdatedAt(LocalDateTime.now());
        sessionFactory.getCurrentSession().save(user);
    }
    
	@Override
	public User findUserById(long id) {
		// TODO Auto-generated method stub
//		Query <User> query = session.createQuery("from User where id= :id", User.class);
//		query.setParameter("id",id);
//		return query.uniqueResult();
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

	@Override
	public void updateUser(User u) {
		// TODO Auto-generated method stub
		sessionFactory.getCurrentSession().merge(u);
		
	}

	
}
