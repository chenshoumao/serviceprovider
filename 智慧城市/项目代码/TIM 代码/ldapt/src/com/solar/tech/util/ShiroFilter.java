 package com.solar.tech.util;
 
 import java.io.IOException;
 import javax.servlet.FilterChain;
 import javax.servlet.ServletContext;
 import javax.servlet.ServletException;
 import javax.servlet.ServletRequest;
 import javax.servlet.ServletResponse;
 import javax.servlet.http.HttpServletRequest;
 import javax.servlet.http.HttpSession;
 import org.apache.shiro.cache.Cache;
 import org.springframework.web.context.WebApplicationContext;
 import org.springframework.web.context.support.XmlWebApplicationContext;
 import org.springframework.web.filter.DelegatingFilterProxy;
 
 public class ShiroFilter extends DelegatingFilterProxy
 {
   public static final String REQUEST_URI = ShiroFilter.class.getName() + ".REQUEST_URI";
 
   public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
     throws IOException, ServletException
   {
     HttpServletRequest httpReq = (HttpServletRequest)request;
     HttpSession sess = httpReq.getSession();
 
     sess.setAttribute(REQUEST_URI, 
       httpReq.getRequestURI());
 
     super.doFilter(request, response, chain);
 
     ((AbstractRealm)((XmlWebApplicationContext)
       getServletContext()
       .getAttribute(WebApplicationContext.ROOT_WEB_APPLICATION_CONTEXT_ATTRIBUTE))
       .getBean(AbstractRealm.class))
       .getAuthorizationCache()
       .clear();
   }
 }

