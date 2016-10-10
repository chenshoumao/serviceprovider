package ldap.service.impl;

import ldap.dao.impl.LoginDaoImpl;
import ldap.service.LoginService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

 
 
@Service
public class LoginServiceImpl implements LoginService{
	@Autowired
	private LoginDaoImpl loginDao;
	
	@Override
	public boolean login(String username, String password) {
		// TODO Auto-generated method stub
		return loginDao.login(username, password); 
	}

}
