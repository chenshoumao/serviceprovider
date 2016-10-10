package ldap.dao;

import java.util.List;

import ldap.bean.CSMUser;
import ldap.entity.User;


public interface CsmUserDao {
	public void saveOrUpdate(CSMUser csmUser);
	
	public void save(CSMUser csmUser);
	public void update(CSMUser csmUser);
	public List getAllUsers();

	public List find(String str);

	public User queryPerson(String string) ;

	public User getPersonDetail(String string);
}
