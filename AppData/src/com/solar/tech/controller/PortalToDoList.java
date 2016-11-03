package com.solar.tech.controller;

import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


@Controller
@RequestMapping("/portal")
public class PortalToDoList {
	   @RequestMapping({"/todo.action"})
	   @ResponseBody
	   @Transactional
	   public Map<String, Object> showsToDo(String name ,int page, int rows) {
			Map<String, Object> dataResult = null;
			dataResult.put("success", true);
			return dataResult;
		} 	
	

}
