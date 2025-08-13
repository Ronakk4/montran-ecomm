package com.capstone.dao.imp;

//import javax.persistence.Query;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.beans.factory.annotation.Autowired;

import com.capstone.dao.UserDao;
import com.capstone.model.User;

public class UserDaoImpl implements UserDao{

	
	@Autowired
    private static SessionFactory sessionFactory;

    private static Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public void saveUser(User u) {
        getSession().save(u);
    }
    
	@Override
	public User findUser(long id) {
		// TODO Auto-generated method stub
//		Query <User> query = session.createQuery("from User where id= :id", User.class);
//		query.setParameter("id",id);
//		return query.uniqueResult();
		return getSession().get(User.class, id);
	}

	@Override
	public User findUserByEmail(String email) {
		// TODO Auto-generated method stub
		Query <User> query = getSession().createQuery("from User where email= :email", User.class);
		query.setParameter("email",email);
		return query.uniqueResult();
	}


	

	@Override
	public void deleteUser(User u) {
		// TODO Auto-generated method stub
		getSession().delete(u);
	}

	@Override
	public void updateUser(User u) {
		// TODO Auto-generated method stub
		
	}

	
}
