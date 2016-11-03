package com.solar.tech.controller;

import java.net.MalformedURLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.solar.tech.dao.AppLinkDao;

/**
 * 
 * @author ibmchenshoumao
 *应用链接的控制层
 */
@Controller
@RequestMapping("/applink")
public class AppLink {
	
	@Autowired
	private AppLinkDao dao;
	

	/**
	 * 根据用户名，获取该用户的帐户
	 */
	@RequestMapping("/getAccount")
	@ResponseBody
	public List getAccount(){
		String username = "";
		List list = null;
		try {
			list = this.dao.getAccount(username);
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return list;
	}
}




















