 package com.solar.tech.controller;
 
 import com.solar.tech.bean.AbstractUser;
 import com.solar.tech.users.AbstractUserService;
 import java.io.IOException;
 import java.util.HashMap;
 import java.util.Map;
 import org.springframework.beans.factory.annotation.Autowired;
 import org.springframework.web.bind.annotation.RequestMapping;
 import org.springframework.web.bind.annotation.RequestParam;
 import org.springframework.web.bind.annotation.ResponseBody;
 import org.springframework.web.multipart.MultipartFile;
 
 public class AbstractUserController
 {
 
   @Autowired
   private AbstractUserService userService;
 
   @RequestMapping({"/index.action"})
   public String index()
   {
     return "/framework/user/shows";
   }
   @RequestMapping({"/shows.action"})
   @ResponseBody
   public Map<String, Object> shows(int page, int rows) {
     Map dataResult = this.userService.shows(page, rows);
     dataResult.put("success", Boolean.valueOf(true));
     return dataResult;
   }
 
   @RequestMapping({"/add.action"})
   @ResponseBody
   public String addUser(@RequestParam("userName") String userName, @RequestParam("password") String password, String userType, String userClass, Integer userStatus, String email, MultipartFile headImgFile, String mobile, String userExtProps, String description)
     throws IllegalStateException, IOException
   {
     AbstractUser user = new AbstractUser();
     user.setUserName(userName);
     user.setPassword(password);
     user.setUserType(userType);
     user.setUserClass(userClass);
     user.setUserStatus(userStatus);
     user.setEmail(email);
     user.setMobile(mobile);
     user.setUserExtProps(userExtProps);
     user.setDescription(description);
     this.userService.addUser(user, headImgFile);
     Map dataResult = new HashMap();
     dataResult.put("success", Boolean.valueOf(true));
     return "";
   }
 
   @RequestMapping({"/update.action"})
   @ResponseBody
   public String updateUser(String userUID, @RequestParam("userName") String userName, String password, String userType, String userClass, Integer userStatus, String email, String headImg, MultipartFile headImgFile, String mobile, String userExtProps, String description)
     throws IllegalStateException, IOException
   {
     Map dataResult = new HashMap();
     AbstractUser user = this.userService.get(userUID);
     user.setUserUID(userUID);
     user.setUserName(userName);
     user.setPassword(password);
     user.setUserType(userType);
     if (userClass != null) user.setUserClass(userClass);
     user.setUserStatus(userStatus);
     user.setEmail(email);
     user.setMobile(mobile);
     user.setUserExtProps(userExtProps);
     user.setDescription(description);
     user.setHeadImg(headImg);
     this.userService.updateUser(user, headImgFile);
     dataResult.put("success", Boolean.valueOf(true));
     return "";
   }
   @RequestMapping({"/delete.action"})
   @ResponseBody
   public Map<String, Object> deleteUser(String userUID) {
     Map dataResult = new HashMap();
     try {
       this.userService.deleteUser(userUID);
       dataResult.put("success", Boolean.valueOf(true));
     } catch (Exception e) {
       dataResult.put("success", Boolean.valueOf(false));
       dataResult.put("errorMsg", e.getMessage());
     }
     return dataResult;
   }
 
   @RequestMapping({"/isExist.action"})
   @ResponseBody
   public Boolean isExist(@RequestParam("userUID") String userUID, @RequestParam("userName") String userName) {
     return this.userService.isExist(userUID, userName);
   }
 }

