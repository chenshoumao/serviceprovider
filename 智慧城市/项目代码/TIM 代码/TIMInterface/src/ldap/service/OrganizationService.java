package ldap.service;

import java.util.List;

import ldap.bean.Organization;

public interface OrganizationService {
	public boolean update(Organization organization);

	public List find(String string);

	public void save(Organization organization);
}
