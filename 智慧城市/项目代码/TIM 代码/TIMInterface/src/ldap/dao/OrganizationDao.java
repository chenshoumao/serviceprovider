package ldap.dao;

import java.util.List;

import ldap.bean.Organization;

public interface OrganizationDao {
	public boolean update(Organization organization);

	public List find(String string);

	public void save(Organization organization);
}
