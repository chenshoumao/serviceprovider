package ldap.service;

import java.util.List;
 





import java.util.Map;

import ldap.entity.User;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

 

@Service
public interface UserService {

	//List<User> getPersonDetail(String name, String title, String mobile);

	List<User> getPersonDetail(User user);

	boolean updateUser(User user);

	Map<String, Object> search(User user, int curPage, int pageSize);

	List search(int curPage, int pageSize);

 
	 
	 
}
