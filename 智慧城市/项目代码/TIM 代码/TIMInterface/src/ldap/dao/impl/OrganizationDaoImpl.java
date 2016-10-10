package ldap.dao.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import ldap.bean.Organization;
import ldap.dao.HibernateDao;
import ldap.dao.IDao;
import ldap.dao.OrganizationDao;
@Repository
public class OrganizationDaoImpl implements OrganizationDao{
	
	 @Resource(type=HibernateDao.class)
	 private IDao dao;
	 
	 @Resource 
	 private HibernateDao hdao;

	@Override
	public boolean update(Organization organization) {
		// TODO Auto-generated method stub
		try {
			this.dao.update(organization);
			return true;
		} catch (Exception e) {
			System.out.println(e);
			// TODO: handle exception
			return false;
		}
		
	}

	@Override
	public List find(String string) {
		// TODO Auto-generated method stub
		List list = null;
		try {
			list = this.dao.find(string);
			return list;
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}

	@Override
	public void save(Organization organization) {
		// TODO Auto-generated method stub
		try {
			this.dao.save(organization);
		} catch (Exception e) {
			// TODO: handle exception
		}
	}

}
