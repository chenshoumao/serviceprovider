package ldap.dao;

import java.util.List;

import javax.naming.NamingEnumeration;
import javax.naming.NamingException;

 


import ldap.entity.User;

import org.springframework.stereotype.Repository;

 


@Repository
public interface UserDao {
	public List<User> getPersonList(User user) ;

//	public User queryPerson(String string);
//	
//	public void save(CSMUser csmUser);
//
//	public List getAllUsers();
//	
	public boolean updateUser(User user);
//	
//	public List<User> searchUser(String uid,String title,String mobile);
//
//	public boolean updatePassword(String eruid);

	public List<User> search(User user);
}
