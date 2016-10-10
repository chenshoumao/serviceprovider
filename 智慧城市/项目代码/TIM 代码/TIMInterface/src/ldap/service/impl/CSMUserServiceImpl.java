package ldap.service.impl;

import java.util.List;

import ldap.bean.CSMUser;
import ldap.dao.UserDao;
import ldap.dao.impl.CsmUserDaoImpl;
import ldap.entity.User;
import ldap.service.CSMUserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
@Transactional
public class CSMUserServiceImpl implements CSMUserService{
	@Autowired
	private CsmUserDaoImpl dao;
	
	public void saveOrUpdate(CSMUser csmUser){
		dao.saveOrUpdate(csmUser);
	}
	public void save(CSMUser csmUser){
		dao.save(csmUser);
	}
	
	public void update(CSMUser csmUser){
		dao.update(csmUser);
	}

	public List getAllUsers() {
		// TODO Auto-generated method stub
		return dao.getAllUsers();
	}

	public List find(String str) {
		// TODO Auto-generated method stub
		return this.dao.find(str);
	}

	public User queryPerson(String string) {
		// TODO Auto-generated method stub
		return null;
	}

	public User getPersonDetail(String name) {
		// TODO Auto-generated method stub
		return this.dao.getPersonDetail(name);
	}
	public void addUser(User user) {
		// TODO Auto-generated method stub
		 this.dao.addUser(user);
	}
}
