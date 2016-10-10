package ldap.service;

import java.util.List;

import ldap.dao.UserDao;
import ldap.entity.User;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

 
public interface UserService {
	  
	public boolean updateUser(User user);
	
	public List<User> searchUser(String uid,String title,String mobile);

	public boolean updatePassword(String eruid);
}
