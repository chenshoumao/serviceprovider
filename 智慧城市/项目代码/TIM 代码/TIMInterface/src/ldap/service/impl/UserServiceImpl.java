package ldap.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ldap.dao.UserDao;
import ldap.entity.User;
import ldap.service.UserService;
@Service
public class UserServiceImpl implements UserService{
	@Autowired
	private UserDao userDao;
	
	@Override
	public boolean updateUser(User user) {
		// TODO Auto-generated method stub
		return this.userDao.updateUser(user); 
	}

	@Override
	public List<User> searchUser(String uid,String title,String mobile) {
		// TODO Auto-generated method stub
		return this.userDao.searchUser(uid,title,mobile); 
	}

	@Override
	public boolean updatePassword(String eruid) {
		// TODO Auto-generated method stub
		return this.userDao.updatePassword(eruid);
	}

}
