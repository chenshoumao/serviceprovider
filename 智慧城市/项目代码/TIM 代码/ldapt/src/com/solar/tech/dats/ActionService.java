package com.solar.tech.dats;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.solar.tech.dao.HibernateDao;
import com.solar.tech.dao.IDao;

@Service
@Transactional
public class ActionService {
	
	   @Resource(type=HibernateDao.class)
	   private IDao dao;
	   
	   public void addAction(){
		   
	   }
	   public Map<String, Object> shows(Integer page, Integer rows){
		   
		   return null;
	   }
}
