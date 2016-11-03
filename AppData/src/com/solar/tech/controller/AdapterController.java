package com.solar.tech.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

 




import com.fasterxml.jackson.core.JsonProcessingException;
import com.solar.tech.bean.Adapter;
import com.solar.tech.dao.AdapterDao;


@Controller
@RequestMapping("/adapter")
public class AdapterController {
	@Autowired
	private AdapterDao dao;
	
	 @RequestMapping({"/add.action"}) 
	 @ResponseBody
	 @Transactional
	 public Map<String,Object> add(Adapter adapter){
		 Map<String, Object> map = null;
		try {
			map = dao.add(adapter);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 return map;
	 } 
	 
	 
	 
	 @RequestMapping({"/show.action"}) 
	 @ResponseBody
	 @Transactional
	 public List show(){
		 List list = new ArrayList();
		 
	     list = dao.show();
		 
		 return list;
	 } 
	 
	 @RequestMapping({"/detailInfo.action"}) 
	 @ResponseBody
	 @Transactional
	 public Map<String, Object> show(String systemName){
		 Map<String, Object> map= new HashMap<String, Object>();
		 
		 map = dao.detailInfo(systemName);
		 
		 return map;
	 } 
	 
	 @RequestMapping({"/daibandaiyue.action"}) 
	 @ResponseBody
	 @Transactional
	 public Map<String, Object> daibandaiyue(String sysName,String sysUrl){
		 Map<String, Object> map= new HashMap<String, Object>();
		 
		 map = dao.daibandaiyue(sysName,sysUrl);
		 
		 return map;
	 } 
}
