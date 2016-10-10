 package com.solar.tech.util;
 
 import com.solar.tech.bean.AbstractUser;
 import java.io.Serializable;
 import java.util.Date;
 import org.hibernate.CallbackException;
 import org.hibernate.EmptyInterceptor;
 import org.hibernate.type.Type;
 import org.springframework.stereotype.Component;
 
 @Component
 public class HibernateInterceptor extends EmptyInterceptor
 {
   private static final long serialVersionUID = 4551346338384554025L;
 
   public boolean onSave(Object entity, Serializable id, Object[] state, String[] propertyNames, Type[] types)
     throws CallbackException
   {
     for (int i = 0; i < propertyNames.length; i++) {
       if ("createTime".equals(propertyNames[i]))
         state[i] = new Date();
       else if ("createBy".equals(propertyNames[i]))
         state[i] = Current.user().getUserName();
       else if ("updateTime".equals(propertyNames[i]))
         state[i] = new Date();
       else if ("updateBy".equals(propertyNames[i])) {
         state[i] = Current.user().getUserName();
       }
     }
     return false;
   }
 
   public boolean onFlushDirty(Object entity, Serializable id, Object[] currentState, Object[] previousState, String[] propertyNames, Type[] types)
   {
     for (int i = 0; i < propertyNames.length; i++) {
       if ("updateTime".equals(propertyNames[i]))
         currentState[i] = new Date();
       else if ("updateBy".equals(propertyNames[i])) {
         currentState[i] = Current.user().getUserName();
       }
     }
     return false;
   }
 }

