package ldap.service.impl;

import java.util.List;

import ldap.dao.UserDao;
import ldap.entity.User;
import ldap.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

 
@Service
public class UserServiceImpl implements UserService{
	@Autowired
	private UserDao userDao;

	@Override
	public List<User> getPersonDetail(User user) {
		// TODO Auto-generated method stub
		return userDao.getPersonList(user);
	}

	@Override
	public boolean updateUser(User user) {
		// TODO Auto-generated method stub
		return userDao.updateUser(user);
	}

	@Override
	public List<User> search(User user) {
		// TODO Auto-generated method stub
		return userDao.search(user);
	}
 
	
	 

}
