package com.solar.tech.ldap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ldap.core.ContextSource;
import org.springframework.ldap.core.LdapTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class GroupRepositoryImpl {
	
	@Autowired(required = true)
	@Qualifier(value = "ldapTemplate")
	private LdapTemplate ldapTemplate;
	
	@Autowired(required = true)
	@Qualifier(value = "contextSource")
	private ContextSource contextSource;
	public void addMember(){
		 
	 }
    public void deleteMember(){
		 
	 }

}
