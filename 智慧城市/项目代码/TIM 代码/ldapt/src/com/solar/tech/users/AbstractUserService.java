 package com.solar.tech.users;
 
 import com.solar.tech.bean.AbstractUser;
 import com.solar.tech.bean.AbstractUserInGroup;
 import com.solar.tech.dao.HibernateDao;
 import com.solar.tech.dao.IDao;
 import java.io.File;
 import java.io.IOException;
 import java.net.URL;
 import java.util.HashMap;
 import java.util.List;
 import java.util.Map;
 import javax.annotation.Resource;
 import org.springframework.transaction.annotation.Transactional;
 import org.springframework.web.multipart.MultipartFile;
 
 @Transactional
 public class AbstractUserService
 {
   public static final String HEAD_IMG_DIR = Thread.currentThread()
     .getContextClassLoader()
     .getResource("")
     .getPath() + "../../images/framework/headimgs/";
 
   @Resource(type=HibernateDao.class)
   private IDao dao;
 
   public Map<String, Object> shows(int page, int rows) {
	   Map map = new HashMap();
     List users = this.dao.findByPage(AbstractUser.class, Integer.valueOf(page), Integer.valueOf(rows));
     Long total = this.dao.count(AbstractUser.class);
     map.put("rows", users);
     map.put("total", total);
     return map; }
 
   public void updateUser(AbstractUser user, MultipartFile headImgFile) throws IllegalStateException, IOException
   {
     user.setHeadImg(createImg(headImgFile, user.getHeadImg(), user.getUserUID()));
     this.dao.update(user);
   }
 
   public void addUser(AbstractUser user, MultipartFile headImgFile) throws IllegalStateException, IOException {
     user.setHeadImg(createImg(headImgFile, user.getHeadImg(), user.getUserUID()));
     this.dao.save(user);
   }
 
   public void deleteUser(String userUID) {
     AbstractUser user = (AbstractUser)this.dao.findById(AbstractUser.class, userUID);
     deleteImg(user.getHeadImg());
     AbstractUserInGroup uig = new AbstractUserInGroup();
     uig.setUserUID(user.getUserUID());
     this.dao.deleteByExample(uig);
     this.dao.delete(new AbstractUser[] { user });
   }
 
   private static String createImg(MultipartFile headImgFile, String headImg, String userUID) throws IllegalStateException, IOException {
     if ((headImgFile != null) && 
       (headImgFile
       .getOriginalFilename()
       .trim()
       .length() != 0)) {
       if ((headImg != null) && 
         (headImg
         .trim()
         .length() != 0)) {
         File oldFile = new File(HEAD_IMG_DIR + headImg);
         if (oldFile.exists()) {
           oldFile.delete();
         }
 
       }
 
       File newFile = new File(HEAD_IMG_DIR + userUID);
       newFile.mkdirs();
       headImgFile.transferTo(newFile);
       return newFile.getName();
     }
     return headImg;
   }
 
   private static void deleteImg(String headImg) {
     File file = new File(HEAD_IMG_DIR + headImg);
     if (file.exists())
       file.delete();
   }
 
   public AbstractUser get(String userUID) {
     return (AbstractUser)this.dao.findById(AbstractUser.class, userUID);
   }
 
   public Boolean isExist(String userUID, String userName) {
     AbstractUser user = new AbstractUser();
     if ((userUID == null) || (userUID.trim().length() == 0)) {
       user.setUserName(userName);
       return Boolean.valueOf(!this.dao.findExample(user)
         .isEmpty());
     }
     AbstractUser _user = (AbstractUser)this.dao.findById(AbstractUser.class, userUID);
     if (userName.equals(_user.getUserName())) {
       return Boolean.valueOf(false);
     }
     user.setUserName(userName);
     return Boolean.valueOf(!this.dao.findExample(user)
       .isEmpty());
   }
 }

