package com.capstone.dao.impl;

import javax.transaction.Transactional;

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
        sessionFactory.getCurrentSession().save(u);
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
