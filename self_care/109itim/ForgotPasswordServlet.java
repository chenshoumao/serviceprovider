package examples.expi;

import com.ibm.itim.apps.ApplicationException;
import com.ibm.itim.apps.ITIMFailedLoginException;
import com.ibm.itim.apps.PlatformContext;
import com.ibm.itim.apps.identity.ForgotPasswordManager;
import com.ibm.json.java.JSONObject;
import java.io.IOException;
import java.io.PrintWriter;
import java.rmi.RemoteException;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import javax.security.auth.login.FailedLoginException;
import javax.security.auth.login.LoginException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ForgotPasswordServlet extends HttpServlet
{
  private static final long serialVersionUID = -7947473850048155469L;
  public static String LOGON = "/jsp/unprotected/logon.jsp";
  public static final String FORGOT_PWD = "/jsp/unprotected/forgotpwd.jsp";
  public static final String FORGOT_PWD_INFO = "/jsp/unprotected/forgotpwdinfo.jsp";
  public static final String USERID = "userid";
  public static final String ERROR_MESSAGE = "errorMessage";
  public static final String INFO_MESSAGE = "infoMessage";
  public static final String CHALLENGES = "challenges";
  public static final String FORGOT_PASSWORD_MANAGER = "forgotPasswordManager";
  public static final String PLATFORM_CONTEXT = "platform";
  private static String userIDAttribute;
  private static boolean changeOnlyTIMPassword;
  private static boolean ssoEnabled;

  public void init()
    throws ServletException
  {
    ExpiUtil eu = new ExpiUtil();

    String par = eu.getProperty("changeonlytimpassword").trim();
    changeOnlyTIMPassword = par.compareToIgnoreCase("true") == 0;
    log("init(): changeOnlyTIMPassword = " + changeOnlyTIMPassword);

    LOGON = eu.getPropertySSOCheck("page.logon");
    ssoEnabled = eu.isSSOEnabled();

    if (ssoEnabled)
      userIDAttribute = "username";
    else
      userIDAttribute = "j_username";
    log("init(): userIDAttribute = " + userIDAttribute);

    log("ForgotPasswordServlet.init() complete");
  }

  public void destroy()
  {
  }

  public void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {
    log("ForgotPasswordServlet.doGet() forwarding to doPost()");
    doPost(request, response);
  }

  public void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {
    request.setCharacterEncoding("UTF-8");

    log("ForgotPasswordServlet.doPost()");

    HttpSession session = request.getSession(true);

    String action = request.getParameter("action");
    log("ForgotPasswordServlet.doPost(): action = " + action);

    if (isNullOrEmpty(action)) {
      if (!session.isNew()) {
        log("[ForgotPasswordServlet.doPost:] invalidating previous session");
        session.invalidate();
        session = request.getSession();
      }
      doGetChallenges(request, response, session);
    } else if (action.equals("authenticate")) {
      doAuthenticate(request, response, session);
    }
  }

  private void doAuthenticate(HttpServletRequest request, HttpServletResponse response, HttpSession session)
    throws ServletException, IOException
  {
    JSONObject json = new JSONObject();
    PrintWriter out = response.getWriter();

    Map cars = validateResponses(request, response, session);
    if ((cars == null) || (cars.isEmpty())) {
      json.put("state", "fail");

      out.print(json);
      out.flush();
      out.close();
      return;
    }

    ForgotPasswordManager forgotPwdMgr = (ForgotPasswordManager)session.getAttribute("forgotPasswordManager");

    if (forgotPwdMgr == null) {
      log("doAuthenticate(): No ForgotPasswordManager in the session");

      json.put("state", "fail");

      out.print(json);
      out.flush();
      out.close();
      return;
    }
    try
    {
      String userID = (String)session.getAttribute("j_username");
      forgotPwdMgr.resetPassword(userID, cars);

      String message = "You will be notified via email when the password change is complete. The email message will contain the new password.";

      json.put("state", "success");

      out.print(json);
      out.flush();
      out.close();
      return;
    } catch (LoginException e) {
      String eMsg = "";
      if ((e instanceof ITIMFailedLoginException))
        eMsg = ((ITIMFailedLoginException)e).getMessageId();
      else {
        eMsg = e.getMessage();
      }
      if (isNullOrEmpty(eMsg))
      {
        json.put("state", "fail");

        out.print(json);
        out.flush();
        out.close();
      } else if (eMsg.equals("com.ibm.itim.apps.ejb.home.HomeBean.INVALID_ANSWERS"))
      {
        int remainingAttempts = -1;
        if (remainingAttempts > -1) {
          ITIMFailedLoginException failedLoginException = new ITIMFailedLoginException("com.ibm.itim.apps.ejb.home.HomeBean.INVALID_ANSWERS_ATTEMPTS", new Object[] { Integer.toString(remainingAttempts) });

          log("doAuthenticate(): LoginContext.login() failed with error" + failedLoginException.getMessage());

          json.put("state", "fail");

          out.print(json);
          out.flush();
          out.close();
        }
        else {
          log("doAuthenticate(): LoginContext.login() failed with error" + e.getMessage());

          json.put("state", "fail");

          out.print(json);
          out.flush();
          out.close();
        }

      }
      else
      {
        log("doAuthenticate(): LoginContext.login() failed with error" + e.getMessage());

        json.put("state", "fail");

        out.print(json);
        out.flush();
        out.close();
      }
    }
    catch (ApplicationException e) {
      log("doAuthenticate(): ForgotPasswordManager.resetPassword() failed with error" + e.getMessage());

      json.put("state", "fail");

      out.print(json);
      out.flush();
      out.close();
    }
  }

  private Map<String, String> validateResponses(HttpServletRequest request, HttpServletResponse response, HttpSession session)
    throws ServletException, IOException
  {
    Map cars = (Map)session.getAttribute("challenges");
    Iterator it = cars.keySet().iterator();

    int i = 0;
    while (it.hasNext()) {
      String challenge = (String)it.next();
      log("e(): challenge: " + challenge);
      String responseToChallenge = request.getParameter(challenge);

      log("validateResponses(): response: " + responseToChallenge);
      if (isNullOrEmpty(responseToChallenge)) {
        goToPage("/jsp/unprotected/forgotpwd.jsp", "One or more responses was empty.  You must provide a response for each challenge.", session, request, response);

        return null;
      }
      cars.put(challenge, responseToChallenge);
    }

    return cars;
  }

  private void doGetChallenges(HttpServletRequest request, HttpServletResponse response, HttpSession session)
    throws ServletException, IOException
  {
    log("doGetChallenges() begin");

    String userID = getUserID(request, response, session);
    if (userID == null) {
      return;
    }
    Collection challenges = null;
    Map challengesMap = new HashMap();
    try
    {
      ExpiUtil eu = new ExpiUtil();
      PlatformContext platform = eu.createPlatformContext();
      ForgotPasswordManager forgotPwdMgr = new ForgotPasswordManager(platform);
      challenges = forgotPwdMgr.getSecretQuestion(userID);
      for (Iterator i$ = challenges.iterator(); i$.hasNext(); ) { Object challenge = i$.next();
        String challengeStr = (String)challenge;
        challengesMap.put(challengeStr.trim(), "");
      }

      session.setAttribute("challenges", challengesMap);
      session.setAttribute("forgotPasswordManager", forgotPwdMgr);
      session.setAttribute("platform", platform);
      session.setAttribute("j_username", userID);

      if ((challenges == null) || (challenges.isEmpty())) {
        goToPage(LOGON, "Either you do not have any challenges configured, or challenge-resonse is disabled.", session, request, response);
      }
      else
      {
        doAuthenticate(request, response, session);
      }
    } catch (ApplicationException e) {
      log("getChallenges(): Caught ApplicationException: " + e.getMessage());

      goToPage(LOGON, e.getMessage(), session, request, response);
    } catch (RemoteException e) {
      log("getChallenges(): Caught RemoteException: " + e.getMessage());
      goToPage(LOGON, e.getMessage(), session, request, response);
    } catch (FailedLoginException e) {
      log("getChallenges(): Caught FailedLoginException: " + e.getMessage());
      goToPage(LOGON, e.getMessage(), session, request, response);
    }

    log("doGetChallenges() complete");
  }

  private String getUserID(HttpServletRequest request, HttpServletResponse response, HttpSession session)
    throws ServletException, IOException
  {
    String userID = request.getParameter(userIDAttribute);

    if (userID == null) {
      goToPage(LOGON, "Enter your User ID and then click on the \"Forgot Your Password\" link", session, request, response);
    }

    log("ForgotPasswordServlet.getUserID(): userID = " + userID);

    return userID;
  }

  private void goToPage(String page, String errorMessage, HttpSession session, HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {
    session.setAttribute("errorMessage", errorMessage);

    RequestDispatcher dispatcher = request.getRequestDispatcher("/" + page);

    dispatcher.forward(request, response);
  }

  private void goToInfoPage(String page, String infoMessage, HttpSession session, HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {
    session.setAttribute("infoMessage", infoMessage);

    if (ssoEnabled) {
      request.setAttribute("ERROR", infoMessage);
    }

    RequestDispatcher dispatcher = request.getRequestDispatcher("/" + page);

    dispatcher.forward(request, response);
  }

  private boolean isNullOrEmpty(Object o)
  {
    if ((o == null) || (o.equals(""))) {
      return true;
    }
    return false;
  }
}