package ldap.dao.impl;

import static org.springframework.ldap.query.LdapQueryBuilder.query;

import java.util.List;

import javax.annotation.Resource;
import javax.naming.Name;
import javax.naming.directory.SearchControls;

import ldap.bean.CSMUser;
import ldap.dao.CsmUserDao;
import ldap.dao.HibernateDao;
import ldap.dao.IDao;
import ldap.entity.PersonAttributeMapper;
import ldap.entity.User;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ldap.core.ContextSource;
import org.springframework.ldap.core.DirContextOperations;
import org.springframework.ldap.core.LdapTemplate;
import org.springframework.ldap.core.support.AbstractContextMapper;
import org.springframework.ldap.filter.AndFilter;
import org.springframework.ldap.filter.EqualsFilter;
import org.springframework.stereotype.Repository;

@Repository
public class CsmUserDaoImpl implements CsmUserDao{
	@Resource
    private LdapTemplate ldapTemplate; 
	
	@Autowired(required = true)
	@Qualifier(value = "contextSource")
	private ContextSource contextSource;
	
	 @Resource(type=HibernateDao.class)
	 private IDao dao; 
	
	@Override
	public void saveOrUpdate(CSMUser csmUser) {
		// TODO Auto-generated method stub
		this.dao.saveOrUpdate(csmUser);
	}

	@Override
	public List getAllUsers() {
		// TODO Auto-generated method stub
		SearchControls controls = new SearchControls();
		controls.setSearchScope(SearchControls.SUBTREE_SCOPE);
	      return ldapTemplate.search(query().where("objectclass").is("top"),  new PersonAttributeMapper());
	    // ldapTemplate.search(query().where("uid").like(""), mapper)
	}

	@Override
	public List find(String str) {
		// TODO Auto-generated method stub
		List list = this.dao.find(str);
		System.out.println(list.size());
		return list;
	}

	@Override
	public User queryPerson(String userId) {
		// TODO Auto-generated method stub
		 try { 
				return (User) ldapTemplate.lookup(getPersonDn(userId),new PersonAttributeMapper());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return null;
	}

	@Override
	public User getPersonDetail(String cn) {
		// TODO Auto-generated method stub
		 User ua = (User)   
				    ldapTemplate.lookup( cn,  
				            new PersonAttributeMapper());  
				return ua;  
	}
	
	  //获取用户uid ；如 uid=test1
	  public Name getPersonDn(String userId) throws Exception {
	        AndFilter andFilter = new AndFilter();
	        andFilter.and(new EqualsFilter("uid", userId));
			List<Name> result = this.ldapTemplate.search("", andFilter.encode(),
	                SearchControls.SUBTREE_SCOPE, new AbstractContextMapper() {
	                    @Override
	                    protected Name doMapFromContext(DirContextOperations adapter) {
	                        return adapter.getDn();
	                    }
	                });
	        if (null == result || result.size() != 1) {
	            throw new Exception();
	        } else {
	        	Name str = result.get(0);
	            return result.get(0);
	        }

	    }

	public void save(CSMUser csmUser) {
		// TODO Auto-generated method stub
		this.dao.save(csmUser);
	}
	
	public void update(CSMUser csmUser) {
		// TODO Auto-generated method stub
		this.dao.update(csmUser);
	}

	public void addUser(User user) {
		// TODO Auto-generated method stub
		
	}


}
