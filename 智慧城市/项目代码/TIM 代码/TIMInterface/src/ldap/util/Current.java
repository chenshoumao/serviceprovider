 package ldap.util;
 
 
 import java.lang.annotation.Annotation;
 import java.lang.reflect.Field;
 import java.security.MessageDigest;
 import java.security.NoSuchAlgorithmException;
 import java.text.SimpleDateFormat;
 import java.util.Date;
 import java.util.HashMap;
 import java.util.Map;

import ldap.bean.AbstractUser;

 import org.apache.shiro.SecurityUtils;
 import org.apache.shiro.UnavailableSecurityManagerException;
 import org.apache.shiro.subject.Subject;
 import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

 
 public class Current
 {
   public static final String CREATETIME = "createTime";
   public static final String CREATEBY = "createBy";
   public static final String UPDATETIME = "updateTime";
   public static final String UPDATEBY = "updateBy";
   public static final SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
 
   public static String time() { return new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")
       .format(new Date()); }
 
   public static  AbstractUser user()
   {
     try {
       return (AbstractUser)SecurityUtils.getSubject().getPrincipal();
     } catch (UnavailableSecurityManagerException e) {
       log().debug("", e);
       AbstractUser user = new AbstractUser();
       user.setFullName("System");
       user.setUserName("System");
       return user;
     }
   }
 
   public static String md5(String plain) {
     String re_md5 = new String();
     try {
       MessageDigest md = MessageDigest.getInstance("MD5");
       md.update(plain.getBytes());
       byte[] b = md.digest();
 
       StringBuffer buf = new StringBuffer("");
       for (int offset = 0; offset < b.length; offset++) {
         int i = b[offset];
         if (i < 0)
           i += 256;
         if (i < 16)
           buf.append("0");
         buf.append(Integer.toHexString(i));
       }
       re_md5 = buf.toString();
     } catch (NoSuchAlgorithmException e) {
       e.printStackTrace();
     }
     return re_md5;
   }
 
   public static Map<String, Object> objectToFieldValueMapByAnno(Object object, Class<?> annoClass) {
     HashMap fieldValue = new HashMap();
     for (Field field : object.getClass().getDeclaredFields()) {
       for (Annotation anno : field.getAnnotations()) {
         if (anno.annotationType().equals(annoClass)) {
           try {
             field.setAccessible(true);
             fieldValue.put(field.getName(), field.get(object));
             return fieldValue;
           } catch (IllegalArgumentException e) {
             throw new RuntimeException(e);
           } catch (IllegalAccessException e) {
             throw new RuntimeException(e);
           }
         }
       }
     }
     throw new RuntimeException(Error.FIELD_NOT_FOUND(object, annoClass));
   }
 
   public static Logger log() {
     try {
       return LoggerFactory.getLogger(Class.forName(java.lang.Thread.currentThread().getStackTrace()[2].getClassName()));
     } catch (ClassNotFoundException e) {
       throw new RuntimeException(e);
     }
   }
 }

