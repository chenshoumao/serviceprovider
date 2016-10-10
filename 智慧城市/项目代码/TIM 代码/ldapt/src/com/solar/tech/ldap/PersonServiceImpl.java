package com.solar.tech.ldap;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

import com.solar.tech.bean.AbstractUserInGroup;
import com.solar.tech.bean.User;
 
import com.solar.tech.dao.HibernateDao;
import com.solar.tech.dao.IDao;

@Service
public class PersonServiceImpl{
	   @Autowired
	   private UserRepositoryImpl userRepository;
	   @Resource(type=HibernateDao.class)
	   private IDao dao;
	


	   
		public List<String> getAllUserNames(){
			return this.userRepository.getAllUserNames();
		}

		public Map<String, Object>  getALLUserInfo(int curPage,int pageSize ) throws Exception{
			 Map map = new HashMap();
			 //List users=this.userRepository.getALLUserInfo(curPage, pageSize);
			 List users=this.userRepository.findAllUsers(curPage, pageSize);
			 
			 List ulist=this.userRepository.getAllUsers();
			// long total=10;
		     map.put("rows", users);
		     map.put("total", ulist.size());
			return map;
		}
		public List<User> getAllPersonNames(){
			return this.userRepository.getAllPersonNames();
		}

	   
	    public List<User> getAllUsers(){
			return this.userRepository.getAllUsers();
		}
		   
	    public User getAllUsers(String userUID){
	    	//List<User> list= new ArrayList<User>();
			return this.userRepository.getUser(userUID);
		}	    


	   
	    public User getUserDetails(String userName){
			return this.userRepository.getUserDetails(userName);
		}


	  
	    public String getUserDetail(String userName){
			return this.userRepository.getUserDetail(userName);
		}


	   
	    public boolean authenticate(String base,String userName, String password){
			return this.userRepository.authenticate(base, userName, password);
		}


	    
	    public User updatePassword(String userName, String newNumber){
			return this.userRepository.updatePassword(userName, newNumber);
		}


	    
	    public boolean createUser(User user){
			return this.userRepository.createUser(user);
		}


	 
	    public boolean remove(String uid){
			return this.userRepository.remove(uid);
		}
	    public void updateUser(String userName, String fullName ,String mail, String mobile, String newPass){
	    	this.userRepository.updateUser(userName, fullName, mail, mobile, newPass);
			 
		 }
	    public Boolean isExist(String userUID){
	    	return  this.userRepository.isExist(userUID);
	    }
	    
//	    public List<User> showApproval() {
//	        AbstractUserInGroup userInGroup = new UserInGroup();
//	        userInGroup.setGroupId(Integer.valueOf(6));
//	        List userInGroups = this.dao.findExample(userInGroup);
//	        ArrayList members = new ArrayList();
//	   
//	        UserInGroup _userInGroup;
//	        for(Iterator iterator = userInGroups.iterator(); iterator.hasNext(); )
//	        {
//	            _userInGroup = (UserInGroup)iterator.next();
//	           if ((_userInGroup.getUserUID()).contains("uid")){
//	           	members.add((User)getAllUsers( _userInGroup.getUserUID()));
//	           }
//	        }
//
//	        return members;
//	      }
}
