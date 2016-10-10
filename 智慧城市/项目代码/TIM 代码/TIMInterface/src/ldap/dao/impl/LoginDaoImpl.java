package ldap.dao.impl;

import javax.annotation.Resource;

import ldap.dao.LoginDao;

import org.springframework.ldap.core.LdapTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class LoginDaoImpl implements LoginDao{

	@Resource
    private LdapTemplate ldapTemplate; 
	
	@Override
	public boolean login(String username, String password) {
		// TODO Auto-generated method stub
		boolean bool =ldapTemplate.authenticate("", "uid="+username, password); 
		System.out.println("Login result is :" + bool);
		return bool;
	}

}
