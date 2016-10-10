package com.solar.tech.realm;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Query;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.solar.tech.bean.User;
//import com.solar.tech.bean.WebPage;
import com.solar.tech.dao.GenericDao;
@Repository
 public class AuthorityFilter extends HandlerInterceptorAdapter{
	@Autowired
	private GenericDao genericDao;


//	@Override
//	public boolean preHandle(HttpServletRequest request,
//			HttpServletResponse response, Object handler) throws Exception {
//
//		String path=request.getRequestURI() ;
//	    String ContextPath = request.getContextPath();
//	    if(path!=null&&!path.equals("")){
//	    	if(path.endsWith(".js")||path.endsWith(".png")||path.endsWith(".jpg")||path.endsWith(".gif")||path.endsWith(".css")||path.endsWith("/login.action")){
//	    		return true;
//	    	}else{
//	    		String pageurl=path.replace(ContextPath, "");
//	    		if(pageurl.equals("/")){
//	    			return true;
//	    		}else{
//	    			boolean rs=verify(pageurl);
//	    			if(!rs){
//	    				System.out.println("没权限页面url:"+pageurl);
//	    			//	response.sendRedirect("login.jsp");  
//	    			}
//	    			return true;
//	    		}
//	    		
//	    	}
//	    }else{
//	    	return true;
//	    }
//		
//	}

	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		//System.out.println("==============");
	}

	@Override
	public void afterCompletion(HttpServletRequest request,
			HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		
	}

//public boolean verify(String pageUrl){
//	User user=(User)com.solar.tech.util.Current.user();
//	WebPage webPage=genericDao.findSingleByProperty(WebPage.class,"pageUrl",pageUrl); 
//	if(webPage!=null){
//		int pageId=webPage.getPageId();
//		  String needAclCtrl= webPage.getNeedAclCtrl();
//		  if(needAclCtrl.equals("ON")){
//			    if(user.getUserUID()==null){
//			    	// System.out.println("未登陆");
//			    	return false;
//			    }else{
//			    	String uid=user.getUserUID();
//			    	int moduleId=webPage.getModuleId();
//			    		Query q = genericDao.getSession().createSQLQuery("SELECT PageId FROM  fw_userWebPage WHERE USERUID='"+uid+"'  AND PageId="+pageId+" UNION  SELECT PageId FROM FW_UserGroupWebPage WHERE GroupId IN (SELECT GroupId FROM FW_UserInGroup WHERE USERUID='"+uid+"')");
//			    		int size=q.list().size();
//			    		if(size!=0){
//			    			return true;
//			    		}else{
//			    			Query q1 = genericDao.getSession().createSQLQuery("SELECT ModuleId FROM FW_UserPageModule  WHERE USERUID='"+uid+"' AND  ModuleId="+moduleId+"  UNION SELECT ModuleId FROM FW_UserGroupPageModule  WHERE GroupId IN (SELECT GroupId FROM FW_UserInGroup WHERE USERUID='"+uid+"')");
//				    		int size1=q1.list().size();
//			    			if(size1==0){
//			    				return false;
//			    			}else{
//			    				return true;
//			    			}
//			    			
//			    		}
//			    }
//		  }else{
//			//  System.out.println("权限未开启");
//			  return false;
//		  }
//		
//	}else{
//		//System.out.println("页面不存在");
//		return false;
//	}
//	
//}

 }
