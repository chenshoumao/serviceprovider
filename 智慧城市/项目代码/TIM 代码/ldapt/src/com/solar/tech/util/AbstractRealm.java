 package com.solar.tech.util;
 
 import com.solar.tech.dao.HibernateDao;
 import com.solar.tech.dao.IDao;
 import java.util.Arrays;
 import javax.annotation.Resource;
 import org.apache.shiro.SecurityUtils;
 import org.apache.shiro.authc.AuthenticationException;
 import org.apache.shiro.authc.AuthenticationInfo;
 import org.apache.shiro.authc.AuthenticationToken;
 import org.apache.shiro.authz.AuthorizationException;
 import org.apache.shiro.authz.AuthorizationInfo;
 import org.apache.shiro.authz.SimpleAuthorizationInfo;
 import org.apache.shiro.realm.AuthorizingRealm;
 import org.apache.shiro.session.Session;
 import org.apache.shiro.subject.PrincipalCollection;
 import org.apache.shiro.subject.Subject;
 
 public abstract class AbstractRealm extends AuthorizingRealm
 {
 
   @Resource(type=HibernateDao.class)
   private IDao dao;
 
   protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals)
   {
     Session sess = SecurityUtils.getSubject().getSession();
     String requestUri = sess.getAttribute(ShiroFilter.REQUEST_URI)
       .toString();
     SimpleAuthorizationInfo info = null;
 
     if (requestUri.equals("/solartechfrm/view/index.jsp")) {
       throw new AuthorizationException("没有访问权限");
     }
     info = new SimpleAuthorizationInfo();
     info.addRoles(Arrays.asList(new String[] { "admin" }));
 
     return info;
   }
 
   public AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token)
     throws AuthenticationException
   {
     return _doGetAuthenticationInfo(token);
   }
 
   protected abstract AuthenticationInfo _doGetAuthenticationInfo(AuthenticationToken paramAuthenticationToken);
 
   protected IDao getDao() {
     return this.dao;
   }
 }

