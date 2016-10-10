package ldap.control;

import java.util.HashMap;
import java.util.Map;

 




import ldap.service.impl.LoginServiceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.HttpClientErrorException;

 

@Controller
@RequestMapping("/login")
public class LoginControl {
	 
	
	@Autowired
	private LoginServiceImpl loginService;

	@RequestMapping(value = "/login",method= RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> login(String username,String password){
		Map<String, Object> map = new HashMap<String, Object>();
		boolean loginState = loginService.login(username, password);
		map.put("state", loginState);
		return map;
	}
	
}
