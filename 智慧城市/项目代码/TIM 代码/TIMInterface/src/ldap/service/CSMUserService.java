package ldap.service;

import java.util.List;

import ldap.bean.CSMUser;
import ldap.dao.UserDao;
import ldap.entity.User;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


 
public interface CSMUserService {
	 
	public void saveOrUpdate(CSMUser csmUser);
	public void save(CSMUser csmUser);
	public void update(CSMUser csmUser);
	public List getAllUsers();

	public List find(String str);

	public User queryPerson(String string) ;

	public User getPersonDetail(String string);
}
