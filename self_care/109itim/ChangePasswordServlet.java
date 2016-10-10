package examples.expi;

import com.ibm.itim.apps.ApplicationException;
import com.ibm.itim.apps.ITIMFailedLoginException;
import com.ibm.itim.apps.PlatformContext;
import com.ibm.itim.apps.identity.InvalidPasswordException;
import com.ibm.itim.apps.identity.PersonMO;
import com.ibm.itim.apps.identity.SelfPasswordManager;
import com.ibm.itim.apps.identity.SelfRequest;
import com.ibm.itim.apps.provisioning.AccountMO;
import com.ibm.itim.apps.provisioning.PasswordManager;
import com.ibm.itim.apps.provisioning.PasswordRuleException;
import com.ibm.itim.apps.provisioning.ServiceMO;
import com.ibm.itim.dataservices.model.domain.Account;
import com.ibm.itim.dataservices.model.domain.Service;
import com.ibm.json.java.JSONObject;
import com.ibm.passwordrules.standard.PasswordRulesInfo;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.rmi.RemoteException;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Vector;
import javax.security.auth.Subject;
import javax.security.auth.login.FailedLoginException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ChangePasswordServlet extends HttpServlet
{
  private static final long serialVersionUID = 5127739637646467706L;
  private static final String INFO_MESSAGE = "infoMessage";
  private static final String PWD_RULES = "passwordRules";
  private String tenantID = "";

  ExpiUtil eu = null;
  private boolean changeOnlyTIMPassword;
  public static String PLATFORM_CONTEXT;
  public static String USERID;
  public static String ERROR_MESSAGE;
  public static String SUBJECT;
  public static String LOGON;
  public static String MAIN;
  public static String CHANGE_PWD;
  public static String CHANGE_PWD_INFO;
  public static String PWD_RULES_INFO;
  public static String SELF_CHANGE_PWD;
  public static String SELF_CHANGE_PWD_INFO;

  public void init()
    throws ServletException
  {
    log("ChangePasswordServlet:init(): start");

    this.eu = new ExpiUtil();
    this.tenantID = this.eu.getTenantID();

    this.changeOnlyTIMPassword = Boolean.parseBoolean(this.eu.getProperty("changeonlytimpassword"));

    log("init(): Only change TIM password: " + this.changeOnlyTIMPassword);

    ERROR_MESSAGE = "errorMessage";
    PLATFORM_CONTEXT = "platform";
    USERID = "userid";
    SUBJECT = "subject";

    LOGON = this.eu.getPropertySSOCheck("page.logon");
    log("init(): logon page: " + LOGON);
    if (isNullOrEmpty(LOGON)) {
      throw new ServletException("Could not load logon page location from properties file");
    }

    MAIN = this.eu.getProperty("page.home");
    log("init(): Home page: " + MAIN);
    if (isNullOrEmpty(MAIN)) {
      throw new ServletException("Could not load home page location from properties file");
    }

    CHANGE_PWD = this.eu.getProperty("page.changepwd");
    log("init(): Change password page: " + CHANGE_PWD);
    if (isNullOrEmpty(CHANGE_PWD)) {
      throw new ServletException("Could not load change password page location from properties file");
    }

    CHANGE_PWD_INFO = this.eu.getProperty("page.changepwdinfo");
    log("init():  Change password info page: " + CHANGE_PWD_INFO);
    if (isNullOrEmpty(CHANGE_PWD_INFO)) {
      throw new ServletException("Could not load change password info page location from properties file");
    }

    PWD_RULES_INFO = this.eu.getProperty("page.pwdrulesinfo");
    log("init(): Change password page: " + PWD_RULES_INFO);
    if (isNullOrEmpty(PWD_RULES_INFO)) {
      throw new ServletException("Could not load password rules info page location from properties file");
    }

    SELF_CHANGE_PWD = this.eu.getProperty("page.selfchangepwd");
    log("init(): Self change password page: " + SELF_CHANGE_PWD);
    if (isNullOrEmpty(SELF_CHANGE_PWD)) {
      throw new ServletException("Could not self change password page location from properties file");
    }

    SELF_CHANGE_PWD_INFO = this.eu.getProperty("page.selfchangepwdinfo");

    log("init(): Self change password page: " + SELF_CHANGE_PWD_INFO);
    if (isNullOrEmpty(SELF_CHANGE_PWD_INFO)) {
      throw new ServletException("Could not self change password info page location from properties file");
    }

    log("init(): complete");
  }

  public void destroy()
  {
  }

  public void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {
    doPost(request, response);
  }

  public void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {
    request.setCharacterEncoding("UTF-8");
    JSONObject json = new JSONObject();
    PrintWriter out = response.getWriter();

    ExpiUtil eu = new ExpiUtil();

    HttpSession session = request.getSession(true);

    System.out.println("1111111");

    PlatformContext platform = (PlatformContext)session.getAttribute(PLATFORM_CONTEXT);

    if (platform == null) {
      try {
        platform = eu.createPlatformContext();
      } catch (Exception e) {
        log("doPost(): Caught Exception trying to create a PlatformContext: " + e.getMessage());
      }

    }

    String action = request.getParameter("action");
    log("doPost(): action = " + action);
    System.out.println("222222222");

    String currentPassword = request.getParameter("currentPassword");
    String newPassword = request.getParameter("newPassword");
    String confirmNewPassword = request.getParameter("confirmNewPassword");

    if (isNullOrEmpty(action)) {
      System.out.println("3333333333333333333");

      json.put("result", "fail");

      out.print(json);
      out.flush();
      out.close();
      return;
    }

    if (action.equals("useSelfPasswordManager")) {
      System.out.println("444444444444444444");
      String logonID = request.getParameter("logonID");
      if (isNullOrEmpty(logonID)) {
        log("doPost(): logonID is null");

        json.put("result", "fail");

        out.print(json);
        out.flush();
        out.close();
        return;
      }
      session.setAttribute("j_username", logonID);

      if (!validateFormData(session, request, response, currentPassword, newPassword, confirmNewPassword, SELF_CHANGE_PWD))
      {
        json.put("result", "fail");

        out.print(json);
        out.flush();
        out.close();
        return;
      }

      noLoginChangePassword(session, request, response, platform, logonID, currentPassword, newPassword);

      if (platform != null) {
        platform.close();
        platform = null;
      }
    }
    else {
      log("doPost():  Unknown action specified");
    }
  }

  private void noLoginChangePassword(HttpSession session, HttpServletRequest request, HttpServletResponse response, PlatformContext platform, String logonID, String currentPassword, String newPassword)
    throws ServletException, IOException
  {
    System.out.println("66666666666666666666");
    JSONObject json = new JSONObject();
    PrintWriter out = response.getWriter();
    SelfPasswordManager spm = new SelfPasswordManager(platform);
    if (spm == null) {
      log("noLoginChangePassword():  Could not get a SelfPasswordManager");
      json.put("result", "fail");

      out.print(json);
      out.flush();
      out.close();
      return;
    }
    try
    {
      SelfRequest sreq = spm.changeExpiredPassword(logonID, currentPassword, newPassword);

      json.put("result", "success");

      out.print(json);
      out.flush();
      out.close();
    } catch (RemoteException e) {
      log("noLoginChangePassword(): Caught RemoteException:" + e.getMessage());

      json.put("result", "fail");

      out.print(json);
      out.flush();
      out.close();
      return;
    }
    catch (FailedLoginException e)
    {
      json.put("result", "fail");

      out.print(json);
      out.flush();
      out.close();
      return;
    } catch (InvalidPasswordException e) {
      String errorMessage = e.getMessage();
      if (isNullOrEmpty(errorMessage))
        errorMessage = "One or more password rules have been violated.";
      log("noLoginChangePassword(): Caught InvalidPasswordException:" + errorMessage);

      json.put("result", "fail");

      out.print(json);
      out.flush();
      out.close();
    } catch (ApplicationException e) {
      log("noLoginChangePassword(): Caught ApplicationException:" + e.getMessage());

      json.put("result", "fail");

      out.print(json);
      out.flush();
      out.close();
    }
  }

  private Collection getAccountsToChange(HttpSession session, HttpServletRequest request, HttpServletResponse response, PasswordManager pm, PersonMO pmo)
    throws ServletException, IOException
  {
    Collection accounts = null;
    try
    {
      accounts = pm.getPasswordAccounts(pmo);
      if (accounts == null) {
        log("getAccountsToChange(): Accounts is null");
        goToPage(LOGON, "Unable to retrieve your accounts, including the account you are currently logged in with.  Please login again.", session, request, response);

        return null;
      }

      if (this.changeOnlyTIMPassword == true) {
        accounts = getTIMAccount(session, request, response, accounts);
      }

      if (accounts == null) {
        log("getAccountsToChange(): Accounts is null");
        goToPage(LOGON, "Your password cannot be changed because your accounts cannot be retrieved, including the account you are currently logged in with. Please login again.", session, request, response);
      }

    }
    catch (ApplicationException e)
    {
      log("getAccountsToChange(): Caught ApplicationException: " + e.getMessage());

      goToPage(LOGON, "Your password cannot be changed because your accounts cannot be retrieved, including the account you are currently logged in with.  Please login again.", session, request, response);
    }
    catch (RemoteException e)
    {
      log("getAccountsToChange(): Caught RemoteException: " + e.getMessage());

      goToPage(CHANGE_PWD, "Unable to retrieve your accounts.  The server may be busy or there may be a more serious problem.  Please try again.  If the problem persists, contact your system administrator.", session, request, response);
    }

    return accounts;
  }

  private void goToPage(String page, String errorMessage, HttpSession session, HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {
    session.setAttribute(ERROR_MESSAGE, errorMessage);

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

  private boolean validateSessionData(HttpSession session, HttpServletRequest request, HttpServletResponse response, Subject subject, PlatformContext platform)
    throws ServletException, IOException
  {
    boolean isValid = true;

    if ((subject == null) || (platform == null)) {
      goToPage(LOGON, "Your session is invalid, please login again.", session, request, response);

      isValid = false;
    }

    return isValid;
  }

  private boolean validateFormData(HttpSession session, HttpServletRequest request, HttpServletResponse response, String currentPassword, String newPassword, String confirmNewPassword, String page)
    throws ServletException, IOException
  {
    if ((isNullOrEmpty(currentPassword)) || (isNullOrEmpty(newPassword)) || (isNullOrEmpty(confirmNewPassword)))
    {
      goToPage(page, "You must fill in all of the fields before clicking OK.", session, request, response);

      return false;
    }

    if (!newPassword.equals(confirmNewPassword)) {
      goToPage(page, "New password does not match confirmed new password.", session, request, response);

      return false;
    }

    return true;
  }

  private void changePassword(HttpSession session, HttpServletRequest request, HttpServletResponse response, PlatformContext platform, Subject subject, String currentPassword, String newPassword)
    throws ServletException, IOException
  {
    SelfPasswordManager spm = new SelfPasswordManager(platform);
    String userID = "";
    if (spm == null) {
      log("changePassword():  Could not get a SelfPasswordManager");
      return;
    }
    try
    {
      userID = (String)session.getAttribute("j_username");
      SelfRequest sreq = spm.changeExpiredPassword(userID, currentPassword, newPassword);

      goToInfoPage(CHANGE_PWD_INFO, "Request ID is: " + sreq.getID() + ".  <br>You will be notified via email when the change is complete.", session, request, response);
    }
    catch (FailedLoginException e)
    {
      handleFailedLoginException(e, session, request, response, currentPassword, userID, platform, CHANGE_PWD);

      return;
    }
    catch (PasswordRuleException e)
    {
      log("changePassword(): Caught PasswordRuleException: " + e.getMessage());
    }
    catch (InvalidPasswordException e)
    {
      String errorMessage = e.getMessage();
      if (isNullOrEmpty(errorMessage))
        errorMessage = "One or more password rules have been violated.";
      log("changePassword(): Caught InvalidPasswordException:" + errorMessage);

      displayPasswordRules(session, request, response, platform, subject, errorMessage);
    }
    catch (RemoteException e)
    {
      log("changePassword(): Caught RemoteException: " + e.getMessage());
      goToPage(CHANGE_PWD, "Error contacting the server.  Please try again.", session, request, response);
    }
    catch (ApplicationException e)
    {
      log("changePassword(): Caught ApplicationException: " + e.getMessage());

      goToPage(CHANGE_PWD, "Error contacting the server.  Please try again.", session, request, response);
    }
  }

  private void displayPasswordRules(HttpSession session, HttpServletRequest request, HttpServletResponse response, PlatformContext platform, Subject subject, String exceptionMessage)
    throws ServletException, IOException
  {
    PasswordManager pm = new PasswordManager(platform, subject);
    if (pm == null) {
      log("changePassword(): Could not get a PasswordManager");
      goToPage(CHANGE_PWD, "Unable to get a connection to the server. Please try again later.", session, request, response);

      return;
    }

    PasswordRulesInfo pri = null;
    try
    {
      ExpiUtil expiu = new ExpiUtil();
      PersonMO pmo = expiu.lookupPerson(platform, subject);
      if (pmo == null) {
        log("changePassword(): PersonMO is null");
        return;
      }

      Collection accounts = null;
      accounts = getAccountsToChange(session, request, response, pm, pmo);
      if (accounts == null) {
        return;
      }
      pri = pm.getRules(accounts);
      log("checkPasswordRules(): Here are the rules: " + pm.getRules(accounts).toString());
    }
    catch (PasswordRuleException e) {
      log("checkPasswordRules(): Caught PasswordRuleException: " + e.getMessage());
    }
    catch (ApplicationException e) {
      log("checkPasswordRules(): Caught ApplicationException: " + e.getMessage());
    }
    catch (RemoteException e) {
      log("checkPasswordRules(): Caught RemoteException: " + e.getMessage());
    }

    Map rules = new HashMap();

    addBooleanRule(rules, "Dictionary words allowed", pri.getAllowInDictionary());

    addBooleanRule(rules, "User ID allowed", pri.getAllowUserID());
    addBooleanRule(rules, "Words present in User ID allowed", pri.getAllowUserIDCaseInsensitive());

    addBooleanRule(rules, "User Name allowed", pri.getAllowUserName());
    addBooleanRule(rules, "Words present in User Name allowed", pri.getAllowUserNameCaseInsensitive());

    addStringRule(rules, "Invalid characters", pri.getInvalidChars());
    addStringRule(rules, "Required characters", pri.getRequiredChars());
    addStringRule(rules, "Must start with these characters", pri.getStartsWithChars());

    addStringRule(rules, "Must only consist of these characters", pri.getRestrictedToChars());

    addNumericRule(rules, "Maximum length", pri.getMaxLength());
    addNumericRule(rules, "Maximum number of sequential characters", pri.getMaxSequentialCharacters());

    addNumericRule(rules, "Minimum number of alphabetic characters", pri.getMinAlphabeticCharacters());

    addNumericRule(rules, "Minimum number of digits", pri.getMinDigitCharacters());

    addNumericRule(rules, "Minimum number of distinct characters", pri.getMinDistinctCharacters());

    addNumericRule(rules, "Miniumum length", pri.getMinLength());
    addNumericRule(rules, "Number of password changes before a password can be re-used", pri.getRepeatedHistoryLength());

    addNumericRule(rules, "Number of password changes before a \"reversed\" password can be re-used", pri.getReversedHistoryLength());

    Map customRules = pri.getCustomRules();
    if ((customRules != null) && (!customRules.isEmpty())) {
      rules.putAll(customRules);
    }
    session.setAttribute(ERROR_MESSAGE, exceptionMessage);
    session.setAttribute("passwordRules", rules);

    RequestDispatcher dispatcher = request.getRequestDispatcher("/" + PWD_RULES_INFO);

    dispatcher.forward(request, response);
  }

  private void addStringRule(Map<String, Object> rules, String label, String value)
  {
    if (!isNullOrEmpty(value))
      rules.put(label, value);
  }

  private void addBooleanRule(Map<String, Object> rules, String label, boolean value)
  {
    if (!value)
      rules.put(label, "No");
  }

  private void addNumericRule(Map<String, Object> rules, String label, long value)
  {
    if (value != -1L)
      rules.put(label, "" + value);
  }

  private Collection<AccountMO> getTIMAccount(HttpSession session, HttpServletRequest request, HttpServletResponse response, Collection accounts)
    throws ServletException, IOException
  {
    String userID = (String)session.getAttribute("j_username");
    log("getTIMAccount(): user ID = " + userID);
    if (userID == null) {
      log("getTIMAccount(): could not get userID from session");
      return null;
    }

    Collection onlyTimAccount = new Vector();
    Iterator it = accounts.iterator();
    try
    {
      while (it.hasNext()) {
        AccountMO amo = (AccountMO)it.next();

        log("getTIMAccount(): Profile name " + amo.getService().getData().getServiceProfileName());

        if (amo.getService().getData().getServiceProfileName().equals("ITIMService"))
        {
          log("getTIMAccount(): AccountMO user ID: " + amo.getData().getUserId());

          String aUserID = amo.getData().getUserId();
          if (aUserID.equals(userID)) {
            onlyTimAccount.add(amo);
            return onlyTimAccount;
          }
        }
      }
    } catch (Exception e) {
      accounts = null;
    }

    if (onlyTimAccount == null) {
      log("getTIMAccount(): Could not find TIM Account for user.");
    }

    return onlyTimAccount;
  }

  private void goToInfoPage(String page, String infoMessage, HttpSession session, HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {
    session.setAttribute("infoMessage", infoMessage);

    RequestDispatcher dispatcher = request.getRequestDispatcher("/" + page);

    dispatcher.forward(request, response);
  }

  private void handleFailedLoginException(FailedLoginException e, HttpSession session, HttpServletRequest request, HttpServletResponse response, String currentPassword, String logonID, PlatformContext platform, String goToPageName)
    throws ServletException, IOException
  {
    String eMsg = "";
    String errorMessage = "";
    if ((e instanceof ITIMFailedLoginException))
      eMsg = ((ITIMFailedLoginException)e).getMessageId();
    else {
      eMsg = e.getMessage();
    }
    if ((eMsg == null) || (eMsg.equals(""))) {
      errorMessage = "An unknown error occurred";
    }
    if (errorMessage.equals("")) {
      errorMessage = e.getMessage();
    }
    log("handleFailedLoginException(): Caught FailedLoginException: " + errorMessage);

    goToPage(goToPageName, errorMessage, session, request, response);
  }
}