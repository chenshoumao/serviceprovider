package ldap.control;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import ldap.entity.User;
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
	public Map<String, Object> updateChallengAnswer(String username,String question,String answer){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			boolean state = this.userService.updateChallengAnswer(username,question,answer);
			map.put("result", state);
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
	
	
	/**
	 * 
	 * @param 陈守貌
	 * 此接口用来 获取用户是否有密保，有返回 true，没有返回 false
	 * 此接口作用：通过此接口返回接口，决定是否要求用户进行设置密保问题以及答案
	 * @return
	 */
	@RequestMapping("/getChallengAnswer")	
	@ResponseBody
	public Map<String, Object> getChallengAnswer(String username){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String result = this.userService.getChallengAnswer(username);
			map.put("state", result);
		} catch (Exception e) {
				// TODO: handle exception
		}
		return map;
	}
	
	@RequestMapping("/getQuestion")	
	@ResponseBody
	public Map<String, Object> getQuestion(String username){
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String result = this.userService.getQuestion(username);
			map.put("result", result);
		} catch (Exception e) {
				// TODO: handle exception
		}
		return map;
	}
	
	
	@RequestMapping(value = "/editUser") 
	public void search(User user){
		System.out.println(123);
		userService.editUser(user);
		 
	} 
	

}
