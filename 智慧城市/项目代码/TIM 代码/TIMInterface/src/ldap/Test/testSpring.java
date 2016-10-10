package ldap.Test;

import java.util.List;

import ldap.dao.UserDao;
import ldap.dao.impl.UserDaoImpl;
import ldap.entity.User;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

 
 

 
 

public class testSpring {
	
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
	public static void getAllUser(){
		ApplicationContext ctx = new ClassPathXmlApplicationContext("applicationContext.xml");
		UserDaoImpl dao = ctx.getBean("userDaoImpl",UserDaoImpl.class);
		List list =dao.getAllUsers();
		System.out.println(list.size());
	}
	
	public static void findAllUsers(int page,int row){
		ApplicationContext ctx = new ClassPathXmlApplicationContext("applicationContext.xml");
		UserDaoImpl dao = ctx.getBean("userDaoImpl",UserDaoImpl.class);
		List list =dao.findAllUsers(page,row);
		System.out.println(list.size());
	}
	
	public static void addUser(){
		
		ApplicationContext ctx = new ClassPathXmlApplicationContext("applicationContext.xml");
		UserDaoImpl dao = ctx.getBean("userDaoImpl",UserDaoImpl.class);
		User user = new User();
		user.setCn("test3");
		user.setSn("test3");
		user.setDescription("这是我自己的个人测试");
		user.setUid("test3");
		user.setAddress("漳州开发区");
		dao.addUser(user);
		
	}
	public static void updateUser(){
		
		ApplicationContext ctx = new ClassPathXmlApplicationContext("applicationContext.xml");
		UserDaoImpl dao = ctx.getBean("userDaoImpl",UserDaoImpl.class);
		User user = new User();
		user.setCn("test313");
		user.setSn("test3122");
		user.setDescription("这是我自己的个人测试1121");
		user.setUid("test3");
		user.setAddress("漳州开发区11");
		//dao.updateUser(user);
		
	}
	
	public static void deleteUser(String username){
		ApplicationContext ctx = new ClassPathXmlApplicationContext("applicationContext.xml");
		UserDaoImpl dao = ctx.getBean("userDaoImpl",UserDaoImpl.class);
		dao.deleteUser(username);
	}
	
	public static void testQueryPerson(){
		ApplicationContext ctx = new ClassPathXmlApplicationContext("applicationContext.xml");
		UserDao dao = ctx.getBean("userDaoImpl",UserDao.class);
		try {
			User user = dao.queryPerson("test1");
			System.out.println(user);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
 
	public static void main(String[] args) {
		//testGetPersonList();
		//getAllUser();
		//addUser();
		//updateUser();
		//deleteUser("test3");
		testQueryPerson();
	 
	}
	
	
	//List list = dao.getPersonList(person);
	//System.out.println(list);
}
