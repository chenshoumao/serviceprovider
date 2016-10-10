package ldap.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ldap.dao.LoginDao;
import ldap.service.LoginService;
@Service
public class LoginServiceImpl implements LoginService{
	@Autowired
	private LoginDao loginDao;
	
	@Override
	public boolean login(String username, String password) {
		// TODO Auto-generated method stub
		return loginDao.login(username, password); 
	}

}
