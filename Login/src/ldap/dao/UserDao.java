package ldap.dao;

import java.util.List;
import java.util.Map;

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

	public Map<String, Object> search(User user, int curPage, int pageSize);

	public List search(int curPage, int pageSize);
	//public long getTotalNumber(User user);

	 
}
