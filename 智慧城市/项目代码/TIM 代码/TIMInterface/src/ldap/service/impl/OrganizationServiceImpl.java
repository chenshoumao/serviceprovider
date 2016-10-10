package ldap.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ldap.bean.Organization;
import ldap.dao.OrganizationDao;
import ldap.service.OrganizationService;
@Service
public class OrganizationServiceImpl implements OrganizationService{
	@Autowired
	private OrganizationDao organizationDao;
	
	@Override
	public boolean update(Organization organization) {
		// TODO Auto-generated method stub
		try {
			return this.organizationDao.update(organization);
		} catch (Exception e) {
			System.out.println(e);
			// TODO: handle exception
			return false;
		}
	}

	@Override
	public List find(String string) {
		// TODO Auto-generated method stub
		try {
			List list = this.organizationDao.find(string);
			return list;
		} catch (Exception e) {
			return null;
			// TODO: handle exception
		}
	}

	@Override
	public void save(Organization organization) {
		// TODO Auto-generated method stub
		try {
			this.organizationDao.save(organization);
		} catch (Exception e) {
			// TODO: handle exception
		}
		
	}

}
