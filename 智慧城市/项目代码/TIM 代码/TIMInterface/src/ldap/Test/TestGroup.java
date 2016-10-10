package ldap.Test;

import javax.naming.NamingException;
import javax.naming.directory.Attributes;
import javax.naming.directory.BasicAttributes;

import ldap.dao.impl.GroupDao;

 


public class TestGroup {
	public static void testAddGroup(){
		GroupDao dao = new GroupDao();
		Attributes attrs = new BasicAttributes();
		attrs.put("cn", "t121");
//		attrs.put("sn", "测试");
		try {
			dao.addGroup(attrs);
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	public static void main(String[] args) {
		testAddGroup();
	}
}
