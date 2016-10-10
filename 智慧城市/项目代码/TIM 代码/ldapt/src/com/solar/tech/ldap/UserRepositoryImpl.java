/**
 *
 * Copyright ?Kaustuv Maji , 2014
 * Repos - https://github.com/kaustuvmaji
 * Blog -  http://kaustuvmaji.blogspot.in
 *
 */
package com.solar.tech.ldap;

import static org.springframework.ldap.query.LdapQueryBuilder.query;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.naming.NamingEnumeration;
import javax.naming.NamingException;
import javax.naming.directory.Attribute;
import javax.naming.directory.Attributes;
import javax.naming.directory.BasicAttribute;
import javax.naming.directory.BasicAttributes;
import javax.naming.directory.DirContext;
import javax.naming.directory.ModificationItem;
import javax.naming.directory.SearchControls;
import javax.naming.ldap.PagedResultsResponseControl;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ldap.control.PagedResultsCookie;
import org.springframework.ldap.control.PagedResultsDirContextProcessor;
import org.springframework.ldap.control.PagedResultsRequestControl;
import org.springframework.ldap.core.AttributesMapper;
import org.springframework.ldap.core.AttributesMapperCallbackHandler;
import org.springframework.ldap.core.CollectingNameClassPairCallbackHandler;
import org.springframework.ldap.core.ContextSource;
import org.springframework.ldap.core.DistinguishedName;
import org.springframework.ldap.core.LdapOperations;
import org.springframework.ldap.core.LdapTemplate;
import org.springframework.ldap.core.support.LdapOperationsCallback;
import org.springframework.ldap.core.support.SingleContextSource;
import org.springframework.ldap.query.LdapQuery;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

import com.solar.tech.bean.User;
//import static org.springframework.ldap.query.LdapQueryBuilder.query;

/**
 * This class implements the @see {@link UserRepositoryIntf}.
 *
 * @author KMaji
 *
 */
@Repository
public class UserRepositoryImpl  {

	private static Logger log = Logger.getLogger(UserRepositoryImpl.class);

	public UserRepositoryImpl() {

	}

	@Autowired(required = true)
	@Qualifier(value = "ldapTemplate")
	private LdapTemplate ldapTemplate;
	
	@Autowired(required = true)
	@Qualifier(value = "contextSource")
	private ContextSource contextSource;
	

	/*
	 * (non-Javadoc)
	 *
	 * @see ldap.advance.example.UserRepositoryIntf#getAllUserNames()
	 */
	
	public List<String> getAllUserNames() {
		log.info("executing {getAllUserNames}");
		LdapQuery query = query().base("cn=users");
		List<String> list = ldapTemplate.list(query.base());
		log.info("Users -> " + list);
		return ldapTemplate.search(query().base("cn=users").where("objectClass").is("person"), new SingleAttributesMapper());
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see ldap.advance.example.UserRepositoryIntf#getAllUsers()
	 */

	public List<User> getAllUsers(String userUID) {
		SearchControls controls = new SearchControls();
		controls.setSearchScope(SearchControls.SUBTREE_SCOPE);
		//String base="uid="+userName+",cn=users";
		 String[] str=  userUID.split("=");
		 String name=str[1];
		String base=userUID +",cn=users";		
    	//return ldapTemplate.search(base, "(objectclass=person)", controls, new UserAttributesMapper());		
	    return ldapTemplate.search(query().base("cn=users").where("uid").is(name), new UserAttributesMapper());
	}
	
	
	public User getUser(String userUID) {
		log.info("executing {getUserDetails}");
		 String[] str=  userUID.split("=");
		 String name=str[1];
		List<User> list = ldapTemplate.search(query().base("cn=users").where("uid").is(name), new UserAttributesMapper());
		if (list != null && !list.isEmpty()) {
			return list.get(0);
		}
		return null;
	}	
	
	
	
	
	public List<User> getAllUsers() {
		SearchControls controls = new SearchControls();
		controls.setSearchScope(SearchControls.SUBTREE_SCOPE);
	      return ldapTemplate.search(query().where("objectclass").is("person"),  new UserAttributesMapper());
	}
	public List<User> getAllPersonNames() {
		  final SearchControls searchControls = new SearchControls();
		  searchControls.setSearchScope(SearchControls.SUBTREE_SCOPE);

		  final PagedResultsDirContextProcessor processor =
		        new PagedResultsDirContextProcessor(10);
		  return SingleContextSource.doWithSingleContext(    contextSource, new LdapOperationsCallback<List<User>>() {
		      @Override
		      public List<User> doWithLdapOperations(LdapOperations operations) {
		        List<User> result = new LinkedList<User>();
		        do {
		          List<User> oneResult = operations.search("cn=users", "(&(objectclass=person))", searchControls, new UserAttributesMapper() , processor);
		          result.addAll(oneResult);
		        } while(processor.hasMore());
		        return result;
		      }
		  });
		}
	

	   public List<User> findAllUsers(final int page, int rows)
	    {

	        final SearchControls searchControls = new SearchControls();
			  searchControls.setSearchScope(SearchControls.SUBTREE_SCOPE);

			  final PagedResultsDirContextProcessor processor =
			        new PagedResultsDirContextProcessor(rows);

			  return SingleContextSource.doWithSingleContext(    contextSource, new LdapOperationsCallback<List<User>>() {

			      @Override
			      public List<User> doWithLdapOperations(LdapOperations operations) {
				   Map<String, Object> map = new HashMap<String, Object>();
			        List<User> result = new LinkedList<User>();
                    int i=1;
			        do {
			          List<User> oneResult = operations.search("cn=users", "(&(objectclass=person))", searchControls, new UserAttributesMapper() , processor);
			          map.put(""+i,oneResult);
			          i++;
			        } while(processor.hasMore());
			        result=(List<User>) map.get(""+ page);
			        return result ;
			      }
			  });
			 
	       
	    }   
	

	/*
	 * (non-Javadoc)
	 *
	 * @see ldap.advance.example.UserRepositoryIntf#getUserDetails(java.lang.String)
	 */
	
	public User getUserDetails(String userName) {
		log.info("executing {getUserDetails}");
		List<User> list = ldapTemplate.search(query().base("cn=users").where("uid").is(userName), new UserAttributesMapper());
		if (list != null && !list.isEmpty()) {
			return list.get(0);
		}
		return null;
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see ldap.advance.example.UserRepositoryIntf#getUserDetail(java.lang.String)
	 */

	public String getUserDetail(String userName) {
		log.info("executing {getUserDetails}");
		List<String> results = ldapTemplate.search(query().base("cn=users").where("uid").is(userName), new MultipleAttributesMapper());
		if (results != null && !results.isEmpty()) {
			return results.get(0);
		}
		return " userDetails for " + userName + " not found .";
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see ldap.advance.example.UserRepositoryIntf#authenticate(java.lang.String,
	 * java.lang.String)
	 */
	
	public boolean authenticate(String base, String userName, String password) {
		log.info("executing {authenticate}");
		return ldapTemplate.authenticate(base, "(uid=" + userName + ")", password);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * ldap.advance.example.UserRepositoryIntf#updateTelePhone(java.lang.String)
	 */

	public User updatePassword(String userName, String newPass) {
		log.info("executing {update}");
		ModificationItem item = new ModificationItem(DirContext.REPLACE_ATTRIBUTE, new BasicAttribute("userPassword", newPass));
		ldapTemplate.modifyAttributes("uid=" + userName + ",cn=users", new ModificationItem[]{item});
		return getUserDetails(userName);
	}

	/*
	 * (non-Javadoc)
	 *
	 * @see
	 * ldap.advance.example.UserRepositoryIntf#createUser(ldap.advance.example.User)
	 */
	
	public boolean createUser(User user) {
		log.info("executing {createUser}");
		Attribute objectClass = new BasicAttribute("objectClass");
		{
			objectClass.add("top");
			//objectClass.add("uidObject");
			
			objectClass.add("inetOrgPerson");
			objectClass.add("person");
			objectClass.add("organizationalPerson");
		}
		Attributes userAttributes = new BasicAttributes();
		userAttributes.put(objectClass);
		userAttributes.put("cn", user.getUserName());
		userAttributes.put("sn", user.getUserName());
		userAttributes.put("uid", user.getUserName());
		userAttributes.put("givenName", user.getUserName());
		userAttributes.put("mail", user.getEmail());
		userAttributes.put("mobile", user.getMobile());
		userAttributes.put("userPassword", user.getPassword().getBytes());
		ldapTemplate.bind(bindDN(user.getUserName()), null, userAttributes);
		return true;
	}

	/*
	 * (non-Javadoc)
	 * @see ldap.advance.example.UserRepositoryIntf#remove(java.lang.String)
	 */
	
	public boolean remove(String uid) {
		ldapTemplate.unbind(bindDN(uid));
		return true;
	}

	public static javax.naming.Name bindDN(String _x){
		@SuppressWarnings("deprecation")
		javax.naming.Name name = new DistinguishedName("uid=" + _x + ",cn=users");
		return name;
	}

	/**
	 * This class is responsible to prepare User object after ldap search.
	 *
	 * @author KMaji
	 *
	 */
	private class UserAttributesMapper implements AttributesMapper<User> {

		@Override
		public User mapFromAttributes(Attributes attributes) throws NamingException {
			User user;
			if (attributes == null) {
				return null;
			}
			user = new User();
			user.setFullName(attributes.get("cn").get().toString());
			if (attributes.get("userPassword") != null) {
				String userPassword = null;
				try {
					userPassword = new String((byte[]) attributes.get("userPassword").get(), "UTF-8");
				} catch (UnsupportedEncodingException e) {
					log.error("unable to process", e);
				}
				user.setPassword("");
			}
			
			if (attributes.get("uid") != null) {
				user.setUserName(attributes.get("uid").get().toString());
			}
			if (attributes.get("uid") != null) {
				user.setUserUID("uid=" +attributes.get("uid").get().toString());
			}
		/**	if (attributes.get("sn") != null) {
				user.setSn(attributes.get("sn").get().toString());
			}
			if (attributes.get("givenName") != null) {
				user.setGivenName(attributes.get("givenName").get().toString());
			}*/
			if (attributes.get("mail") != null) {
				user.setEmail(attributes.get("mail").get().toString());
			}
			if (attributes.get("mobile") != null) {
				user.setMobile(attributes.get("mobile").get().toString());
			}
			return user;
		}
	}

	/**
	 * This class is responsible to print only cn .
	 *
	 * @author KMaji
	 *
	 */
	private class SingleAttributesMapper implements AttributesMapper<String> {

		@Override
		public String mapFromAttributes(Attributes attrs) throws NamingException {
			Attribute cn = attrs.get("cn");
			return cn.toString();
		}
	}

	/**
	 * This class is responsible to print all the content in string format.
	 *
	 * @author KMaji
	 *
	 */
	private class MultipleAttributesMapper implements AttributesMapper<String> {

		@Override
		public String mapFromAttributes(Attributes attrs) throws NamingException {
			NamingEnumeration<? extends Attribute> all = attrs.getAll();
			StringBuffer result = new StringBuffer();
			result.append("\n Result { \n");
			while (all.hasMore()) {
				Attribute id = all.next();
				result.append(" \t |_  #" + id.getID() + "= [ " + id.get() + " ]  \n");
				log.info(id.getID() + "\t | " + id.get());
			}
			result.append("\n } ");
			return result.toString();
		}
	}
	 public void updateUser(String userName, String fullName ,String mail, String mobile, String newPass){
			log.info("executing {update}");
			ModificationItem item = new ModificationItem(DirContext.REPLACE_ATTRIBUTE, new BasicAttribute("cn", fullName));
			ModificationItem item1 = new ModificationItem(DirContext.REPLACE_ATTRIBUTE, new BasicAttribute("sn", fullName));
			ModificationItem item2 = new ModificationItem(DirContext.REPLACE_ATTRIBUTE, new BasicAttribute("givenName", fullName));
			ModificationItem item3 = new ModificationItem(DirContext.REPLACE_ATTRIBUTE, new BasicAttribute("mail", mail));
			ModificationItem item4 = new ModificationItem(DirContext.REPLACE_ATTRIBUTE, new BasicAttribute("mobile", mobile));
			ModificationItem item5 = new ModificationItem(DirContext.REPLACE_ATTRIBUTE, new BasicAttribute("userPassword", newPass));

			ldapTemplate.modifyAttributes("uid=" + userName + ",cn=users", new ModificationItem[]{item,item1,item2,item3,item4,item5});
		 
	 }
	 

	 public Boolean isExist(String userUID){
		 boolean u=false;
		List<User> list=getAllUsers("uid="+userUID);
		 if(list.size()>0)u=true;
		 return u;
	 }
}
