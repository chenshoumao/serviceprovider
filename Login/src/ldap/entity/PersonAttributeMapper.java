package ldap.entity;

import javax.naming.NamingException;
import javax.naming.directory.Attribute;
import javax.naming.directory.Attributes;

import org.springframework.ldap.core.AttributesMapper;

public class PersonAttributeMapper implements AttributesMapper {

	public Object mapFromAttributes(Attributes attrs) throws NamingException {
		User User = new User();
		Attribute attr = attrs.get("sn");
		if (attr != null)
			User.setSn((String) attr.get());
		attr = attrs.get("cn");
		if (attr != null)
			User.setCn((String) attr.get());
		attr = attrs.get("description");
		if (attr != null)
			User.setDescription((String) attr.get());
		
		attr = attrs.get("address"); 
		if (attr != null)
			User.setAddress((String) attr.get());
		
		attr = attrs.get("title"); 
		if (attr != null)
			User.setTitle((String) attr.get());
		
		attr = attrs.get("mobile"); 
		if (attr != null)
			User.setMobile((String) attr.get());
		
		attr = attrs.get("mail"); 
		if (attr != null)
			User.setMail((String) attr.get());
		
		attr = attrs.get("department"); 
		if (attr != null)
			User.setDepartment((String) attr.get());
		
		attr = attrs.get("duty"); 
		if (attr != null)
			User.setDuty((String) attr.get());
		
		attr = attrs.get("staffNumber"); 
		if (attr != null)
			User.setStaffNumber((String) attr.get());
		
		attr = attrs.get("postalCode"); 
		if (attr != null)
			User.setPostalCode((String) attr.get());
		attr = attrs.get("homePhone"); 
		if (attr != null)
			User.setHomePhone((String) attr.get());
		
		
		
		attr = attrs.get("uid");
		if (attr != null)
			User.setUid((String) attr.get()); 
		// if(attr!=null)person.setUserPassword((String)attr.get());
		System.out.println(User.getUid());
		return User;
	}

}
