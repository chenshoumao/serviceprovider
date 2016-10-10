package ldap.entity;

import javax.naming.NamingException;
import javax.naming.directory.Attribute;
import javax.naming.directory.Attributes;

import org.springframework.ldap.core.AttributesMapper;

public class ItimAccountMapper implements AttributesMapper {

	@Override
	public Object mapFromAttributes(Attributes attrs)
			throws NamingException {
		// TODO Auto-generated method stub
		//System.out.println(123);
		System.out.println(attrs);
		ItimAccount itim = new ItimAccount();
		Attribute attr = attrs.get("owner");
		if (attr != null)
			itim.setOwner((String) attr.get());
		
		attr = attrs.get("erlostpasswordanswer");
		if (attr != null)
			itim.setErlostpasswordanswer((String) attr.get());
		 
		// if(attr!=null)person.setUserPassword((String)attr.get());
		System.out.println(itim.getOwner());
		return itim; 
	}

}
