package ldap.control;

import java.util.List;

import ldap.bean.CSMUser;
import ldap.dao.UserDao;
import ldap.dao.impl.UserDaoImpl;
import ldap.entity.User;
import ldap.service.CSMUserService;
import ldap.service.impl.CSMUserServiceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

  
@Controller
@RequestMapping("/springLdap")
public class testSpring {
	@Autowired
	private CSMUserServiceImpl service;
	
	@Autowired
	private UserDaoImpl dao;
	
	public static void testGetPersonList(){
		ApplicationContext ctx = new ClassPathXmlApplicationContext("applicationContext.xml");
		UserDaoImpl dao = ctx.getBean("userDaoImpl",UserDaoImpl.class);
		User user = new User();
		user.setCn("test1");
		List list = dao.getPersonList(user);
		System.out.println(list.size());
		User user1 = (User) list.get(0);
		System.out.println(user1);
	}
	
	//获取所有用户 实现方法会根据objectclass来去判断
	@RequestMapping("/showsAllUsers.action")
	@ResponseBody
	public  List getAllUser(){
		//ApplicationContext ctx = new ClassPathXmlApplicationContext("applicationContext.xml");
		//UserDaoImpl dao = ctx.getBean("userDaoImpl",UserDaoImpl.class);
		List list =this.service.getAllUsers();
		System.out.println(list.size());
		return list;
	}
	
	public static void findAllUsers(int page,int row){
		ApplicationContext ctx = new ClassPathXmlApplicationContext("applicationContext.xml");
		UserDaoImpl dao = ctx.getBean("userDaoImpl",UserDaoImpl.class);
		List list =dao.findAllUsers(page,row);
		System.out.println(list.size());
	}
	@RequestMapping("/addUser.action")
	public   void addUser(){
		
		//ApplicationContext ctx = new ClassPathXmlApplicationContext("applicationContext.xml");
		//UserDaoImpl dao = ctx.getBean("userDaoImpl",UserDaoImpl.class);
		User user = new User();
		user.setCn("test55");
		user.setSn("test55");
		user.setDescription("这是我自己的个人测试");
		user.setUid("test555");
		user.setAddress("漳州开发区");
		dao.addUser(user);
		
	}
	
	@RequestMapping("/updateUser.action")
	public  void updateUser(){ 
		//ApplicationContext ctx = new ClassPathXmlApplicationContext("applicationContext.xml");
	 
//		CSMUser user = new CSMUser();
//		user.setCn("test");
//		user.setSn("test");
//		user.setDescription("这是我自己的个人测试");
//		user.setUid("test1");
//		user.setAddress("漳州开发区");
//		dao.updateUser(user);
//		List list = this.service.find("from CSMUser where uid = '" + user.getUid() + "'");
//		if(list.size() == 0)
//		   service.save(user);
//		else{
//			CSMUser userlist = (CSMUser) list.get(0);
//			CSMUser user2 = new CSMUser(userlist,user);
//			this.service.update(user2);
//		}
	}
	
	@RequestMapping("/saveUser.action")
	public void saveUser(){
		
		CSMUser user = new CSMUser();
		user.setAddress("123");
		user.setDescription("sdfsdf");
//		user.setFullname("csm");
		user.setUid("test1");
		 
		this.service.save(user);
		
	}
	
	@RequestMapping("/getCsmUser.action")
	public void getCsmUser(){
		
		String str = "from CSMUser";
		this.service.find(str);
		
	}
	
	public static void deleteUser(String username){
		ApplicationContext ctx = new ClassPathXmlApplicationContext("applicationContext.xml");
		UserDaoImpl dao = ctx.getBean("userDaoImpl",UserDaoImpl.class);
		dao.deleteUser(username);
	}
	
	@RequestMapping("/showsUsers.action")
	@ResponseBody
	public  User testQueryPerson(){
		//ApplicationContext ctx = new ClassPathXmlApplicationContext("applicationContext.xml");
		//UserDao dao = ctx.getBean("userDaoImpl",UserDao.class);
		try {
			User user = service.queryPerson("test1");
			System.out.println(user);
			return user;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	@RequestMapping("/findByDn.action")
	@ResponseBody
	public User findByDn(String name){
		User user = service.getPersonDetail("uid=" + name);
		return user;
	}
	
  
	
	//List list = dao.getPersonList(person);
	//System.out.println(list);
}
