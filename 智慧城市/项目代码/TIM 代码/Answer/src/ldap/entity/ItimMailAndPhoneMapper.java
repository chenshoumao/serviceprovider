package ldap.entity;

import javax.naming.NamingException;
import javax.naming.directory.Attribute;
import javax.naming.directory.Attributes;

import org.springframework.ldap.core.AttributesMapper;

public class ItimMailAndPhoneMapper implements AttributesMapper {

	@Override
	public Object mapFromAttributes(Attributes attrs)
			throws NamingException {
		// TODO Auto-generated method stub
		System.out.println("1111222333");
		System.out.println(attrs);
		ItimMailAndPhone itim = new ItimMailAndPhone();
		Attribute attr = attrs.get("mail");
		if (attr != null)
			itim.setMail((String) attr.get());
		
		attr = attrs.get("telephonenumber");
		if (attr != null)
			itim.setTelephonenumber((String) attr.get());
		System.out.println("12313");
		attr = attrs.get("erlostpasswordanswer");
		if (attr != null)
			System.out.println((String) attr.get());
	
		 
		System.out.println(1235);
		// if(attr!=null)person.setUserPassword((String)attr.get());
		System.out.println(itim.getMail());
		return itim; 
	}

}
