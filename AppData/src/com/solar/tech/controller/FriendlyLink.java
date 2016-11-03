package com.solar.tech.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solar.tech.dao.FriendlyLinkDao;

@Controller
@RequestMapping("/friendlyLink")
public class FriendlyLink {
	
	@Autowired
	private FriendlyLinkDao dao;
	
	@Autowired
	private HttpServletRequest request;

	
	@RequestMapping("/getLink") 
	public String getLink(Model model){
		//String URL = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+"/";
		String URL = "http://10.161.2.72:10039/";
		Map<String, Object> map = this.dao.getLink(URL);
		model.addAttribute("map", map);
		return "test";
	}

}
