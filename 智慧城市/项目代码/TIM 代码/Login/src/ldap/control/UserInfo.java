package ldap.control;

import java.util.HashMap;
import java.util.List;

 



 

 




import java.util.Map;

import ldap.entity.User;
import ldap.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

 


@Controller
@RequestMapping("/UserInfo")
public class UserInfo {
	@Autowired
	private UserService service;
	
	 
	@RequestMapping(value = "/findByDn",method= RequestMethod.POST)
	@ResponseBody
	public List<User> findByDn(User user){
		List<User> list = service.getPersonDetail(user);
		return list;
	} 
	
	@RequestMapping(value = "/search",method= RequestMethod.POST)
	@ResponseBody
	public List<User> search(User user){
		List<User> list = service.search(user);
		return list;
	} 
	
	
	
	
	//List list = dao.getPersonList(person);
	//System.out.println(list);
	
	@RequestMapping(value = "/updateUser",method= RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateUser(User user){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			boolean state = service.updateUser(user);
			map.put("state", state);
		} catch (Exception e) {
			// TODO: handle exception
			map.put("state", false);
		}
		
		return map;
	} 
}
