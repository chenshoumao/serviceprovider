package examples.expi;

import com.ibm.itim.apps.ApplicationException;
import com.ibm.itim.apps.PlatformContext;
import com.ibm.itim.apps.identity.ChallengeResponseManager;
import com.ibm.itim.apps.identity.PersonMO;
import com.ibm.websphere.security.WSSecurityException;
import com.ibm.websphere.security.auth.WSLoginFailedException;
import com.ibm.websphere.security.auth.WSSubject;
import java.io.IOException;
import java.io.PrintStream;

import java.io.BufferedReader;

import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.Enumeration;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import javax.security.auth.Subject;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletResponseWrapper;
import javax.servlet.http.HttpSession;

public class ExpiFilter
  implements Filter
{
  private FilterConfig m_filterConfig;
  private ExpiUtil m_expiUtil;
  private static String LOGON_CONTEXT_ID;
  private static String LOGON_PAGE;
  private static String HOME_PAGE;
  private static String SELF_CHANGEPWD_PAGE;
  private boolean bSSOEnabled;

  public ExpiFilter()
  {
    this.m_filterConfig = null;

    this.m_expiUtil = null;

    this.bSSOEnabled = false;
  }

  public void init(FilterConfig filterConfig)
    throws ServletException
  {
    ExpiUtil.log("ExpiFilter.init(): begin");

    this.m_filterConfig = filterConfig;
    this.m_expiUtil = new ExpiUtil();

    this.m_expiUtil = new ExpiUtil();
    if ((this.m_expiUtil != null) && (this.m_expiUtil.isProperties())) {
      LOGON_CONTEXT_ID = this.m_expiUtil.getLoginContextID();
      ExpiUtil.log("ExpiFilter.init(): LOGON_CONTEXT_ID = " + LOGON_CONTEXT_ID);

      LOGON_PAGE = this.m_expiUtil.getPropertySSOCheck("page.logon");
      ExpiUtil.log("ExpiFilter.init(): LOGON_PAGE = " + LOGON_PAGE);

      HOME_PAGE = this.m_expiUtil.getProperty("page.home");
      ExpiUtil.log("ExpiFilter.init(): HOME_PAGE = " + HOME_PAGE);

      this.bSSOEnabled = this.m_expiUtil.isSSOEnabled();
      ExpiUtil.log("ExpiFilter.init(): bSSOEnabled = " + this.bSSOEnabled);

      SELF_CHANGEPWD_PAGE = this.m_expiUtil.getProperty("page.selfchangepwd");

      ExpiUtil.log("ExpiFilter.init(): SELF_CHANGEPWD_PAGE = " + SELF_CHANGEPWD_PAGE);
    }

    ExpiUtil.log("ExpiFilter.init(): end");
  }

  public String doGetMethod(String updataUrl){
		String result = "";
		BufferedReader in = null;  
		
		System.out.println(updataUrl);
		URLConnection con;
		
		try {
			con = new URL(updataUrl).openConnection();

			System.out.println("dataurl-----:" + updataUrl);

			 con.setRequestProperty("accept", "*/*");  
	            con.setRequestProperty("connection", "Keep-Alive");  
	            con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");  
	            con.setRequestProperty("user-agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");  
	            // 发送POST请求必须设置如下两行  
	          //  con.setDoOutput(true);  
	          //  con.setDoInput(true);  
			System.out.println(11111);
			con.connect();
			System.out.println(22222);
			in = new BufferedReader(new InputStreamReader(con.getInputStream()));
			String line;
			while ((line = in.readLine()) != null) {
				result += line;
			}
			System.out.println(result);
			return result;
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
      
	}
  
  public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
    throws IOException, ServletException
  {
    HttpServletRequest req = (HttpServletRequest)request;
    HttpServletResponse res = (HttpServletResponse)response;
    String action = req.getParameter("action");

    if ((this.m_expiUtil == null) || (!this.m_expiUtil.isProperties())) {
      ExpiUtil.log("ExpiFilter.init(): Could not find properties file");
      ExpiUtil.forward(req, res, "Could not initialize: Property file missing?", LOGON_PAGE);

      return;
    }

    String userID = req.getParameter("j_username");
    String password = req.getParameter("j_password");
	/*if(action.equals("updateAnswer")){
		password = doGetMethod("http://10.161.2.67:9080/UsersManagement/UsersServlet?param=getUserPassword&uid="+userID);
		password = password.split(",")[1];
	}*/ 
    System.out.println(userID + "," + password + "," + action);

    HttpSession session = req.getSession(false);
    if (session == null) {
      session = req.getSession(true);
    }

    String sessionValues = sessionToString(session);
    ExpiResponseWrapper responseWrapper = new ExpiResponseWrapper(res);

    chain.doFilter(request, responseWrapper);

    Throwable t = WSSubject.getRootLoginException();
    if (t != null) {
      t = determineCause(t);
      addMessageToCookie(responseWrapper, t.getMessage());
    }
    else
    {
      session.setAttribute("j_username", userID);
      try
      {
        Subject subject = WSSubject.getCallerSubject();
        if ((userID.trim().length() == 0) || (password.length() == 0) ) {
          ExpiUtil.log("ExpiFilter.init(): empty userID or password.");
          addMessageToCookie(responseWrapper, "Empty user ID or password is not allowed");
        }
        else if (subject == null) {
          ExpiUtil.log("ExpiFilter.init(): subject is null");
          addMessageToCookie(responseWrapper, "WAS security is not enabled.");
        }
        else
        {
          session.setAttribute("subject", subject);

          ExpiUtil.log("ExpiFilter.doFilter(): logged user: " + req.getRemoteUser());

          PlatformContext platform = this.m_expiUtil.createPlatformContext();
          session.setAttribute("platform", platform);

          boolean resetPwd = this.m_expiUtil.isPasswordChangeRequired(platform, subject);
          if ((resetPwd) && (!action.equals("updateAnswer"))) {
            session.setAttribute("passwordExpired", new Boolean(true));
            ExpiUtil.log("ExpiFilter.doFilter(): Password is expired, forwarding to expiredpassword page");
            ExpiUtil.forward(req, res, "", SELF_CHANGEPWD_PAGE);
            return;
          }

          PersonMO personMo = this.m_expiUtil.lookupPerson(platform, subject);
          session.setAttribute("personMO", personMo);

          checkChallengeResponse(session, platform, subject);
        }
      } catch (WSSecurityException e) {
        e.printStackTrace();
        ExpiUtil.log("ExpiFilter.init(): " + e.getMessage());
        ExpiUtil.forward(req, res, e.getMessage(), LOGON_PAGE);
        return;
      }
      catch (ApplicationException e) {
        e.printStackTrace();
        ExpiUtil.log("ExpiFilter.init(): " + e.getMessage());
        ExpiUtil.forward(req, res, e.getMessage(), LOGON_PAGE);
        return;
      }

    }

    if ((action != null) && (action.equals("updateAnswer"))) {
      System.out.println("herherherherhereh");
      req.getRequestDispatcher("/mainServlet").forward(req, res);
    }
    else {
      responseWrapper.sendMyRedirect();
    }
  }

  private void addMessageToCookie(ExpiResponseWrapper responseWrapper, String msg) { Cookie c = new Cookie("expiLoginError", msg);
    c.setMaxAge(-1);
    responseWrapper.addCookie(c); }

  private void removeMessageFromCookie(ExpiResponseWrapper responseWrapper)
  {
    Cookie c = new Cookie("expiLoginError", "");
    c.setMaxAge(0);
    responseWrapper.addCookie(c);
  }

  private void checkChallengeResponse(HttpSession session, PlatformContext platform, Subject subject)
  {
    try
    {
      ChallengeResponseManager crm = new ChallengeResponseManager(platform, subject);

      boolean changeNeeded = crm.isEnforceChallengeResponse();
      ExpiUtil.log("ExpiFilter.checkChallengeResponse(): challenge response updated needed = " + changeNeeded);

      session.setAttribute("updateCRAnswers", new Boolean(changeNeeded));
    } catch (Exception e) {
      ExpiUtil.log("EXPI: checkChallengeResponse(): Caught an exception: " + e.getMessage());

      session.setAttribute("errorMessage", e.getMessage());
    }
  }

  private String sessionToString(HttpSession session)
  {
    StringBuffer sb = new StringBuffer("Session:[sessionID:" + session.getId() + "]");
    sb.append("  [isNew:" + session.isNew() + "]\n");
    for (Enumeration e = session.getAttributeNames(); e.hasMoreElements(); ) {
      String attrName = (String)e.nextElement();
      Object attrValue = session.getAttribute(attrName);
      sb.append("  [" + attrName + ":" + attrValue + "]\n");
    }
    return sb.toString();
  }

  public void destroy()
  {
    this.m_filterConfig = null;
  }

  public Throwable determineCause(Throwable e) {
    Throwable rootEx = e; Throwable tempEx = null;
    while (true)
    {
      if ((e instanceof WSLoginFailedException)) {
        tempEx = ((WSLoginFailedException)e).getCause();
      }
      else if ((e instanceof WSSecurityException)) {
        tempEx = ((WSSecurityException)e).getCause();
      }
      else
      {
        return rootEx;
      }

      if (tempEx == null)
        break;
      rootEx = tempEx;
      e = tempEx;
    }

    return rootEx;
  }

  class ExpiResponseWrapper extends HttpServletResponseWrapper
  {
    String m_originalRedirect;
    String m_contextPath;

    public ExpiResponseWrapper(HttpServletResponse response)
    {
      super(response);
    }

    public void sendRedirect(String location)
      throws IOException
    {
      this.m_originalRedirect = location;
    }

    public void sendMyRedirect() throws IOException
    {
      if (this.m_originalRedirect.indexOf("itim_expi") == -1) {
        this.m_originalRedirect = "/itim_expi/mainServlet";
      }
      super.sendRedirect(this.m_originalRedirect);
    }
  }
}