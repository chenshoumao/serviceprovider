package ldap.control;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import ldap.service.impl.TimUserServiceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/UserInfo")
public class TimUser {
	@Autowired
	private TimUserServiceImpl userService; 
	
	//更改密保
	@RequestMapping("/updateChallengAnswer")
	@ResponseBody
	public Map<String, Object> updateChallengAnswer(String eruid){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			boolean state = this.userService.updateChallengAnswer(eruid);
			map.put("user", state);
		} catch (Exception e) {
				// TODO: handle exception
		}
		return map;
	}
	
	@RequestMapping("/showAccount")
	@ResponseBody
	public Map<String, Object> showAccount(String eruid){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			List list = this.userService.showAccount(eruid);
			map.put("service", list);
		} catch (Exception e) {
				// TODO: handle exception
		}
		return map;
	}
	
	@RequestMapping("/changeChallengeResponse")
	@ResponseBody
	public Map<String, Object> changeChallengeResponse(String username,String password,String answer,String confirmAnswer){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String result = this.userService.changeChallengeResponse(username,password,answer,confirmAnswer);
			map.put("state", result);
		} catch (Exception e) {
				// TODO: handle exception
		}
		return map;
	}
	
	

}
