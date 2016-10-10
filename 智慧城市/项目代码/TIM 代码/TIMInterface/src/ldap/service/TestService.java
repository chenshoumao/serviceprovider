package ldap.service;

import java.util.List;

import javax.annotation.Resource;

import ldap.dao.HibernateDao;
import ldap.dao.IDao;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


 

@Service
@Transactional
public class TestService {
	 @Resource(type=HibernateDao.class)
	 private IDao dao;
	 
	 public void find(){
		// List list = this.dao.find("select)
	 }
}
