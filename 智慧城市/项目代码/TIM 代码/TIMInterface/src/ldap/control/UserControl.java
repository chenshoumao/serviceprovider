package ldap.control;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import ldap.entity.User;
import ldap.service.UserService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/UserInfo")
public class UserControl {
	@Autowired
	private UserService userService;
	
	@RequestMapping("/updateUser.action")
	@ResponseBody
	public Map<String, Object> updateUser(User user){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			boolean state = this.userService.updateUser(user);
			map.put("state", state);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return map;
	}
	
	@RequestMapping("/searchUser.action")
	@ResponseBody
	public Map<String, Object> searchUser(String uid,String title,String mobile){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			List<User> user = this.userService.searchUser(uid,title,mobile);
			map.put("user", user);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return map;
	}
	
	@RequestMapping("/updatePassword.action")
	@ResponseBody
	public Map<String, Object> updatePassword(String eruid){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			boolean state = this.userService.updatePassword(eruid);
			map.put("user", state);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return map;
	}
}
