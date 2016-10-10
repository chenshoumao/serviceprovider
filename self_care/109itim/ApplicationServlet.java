package examples.expi;

import com.ibm.itim.apps.PlatformContext;
import com.ibm.itim.apps.identity.PersonMO;
import com.ibm.itim.apps.provisioning.AccountMO;
import com.ibm.itim.common.AttributeValue;
import com.ibm.itim.common.AttributeValues;
import com.ibm.itim.dataservices.model.domain.Account;
import java.io.IOException;
import java.io.PrintStream;
import java.util.Collection;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.StringTokenizer;
import java.util.Vector;
import javax.security.auth.Subject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ApplicationServlet extends HttpServlet
{
  private static final long serialVersionUID = -395926710463746600L;
  private HttpSession session;
  private static ExpiUtil utilObject = null;

  private String LOGON_PAGE = "logon.jsp";

  public void init()
  {
    log("applicationServlet:init(): start");
    try
    {
      utilObject = new ExpiUtil();
    } catch (Exception e) {
      e.printStackTrace();
    }

    this.LOGON_PAGE = utilObject.getPropertySSOCheck("page.logon");
    log("EXPI:init(): LOGON_PAGE = " + this.LOGON_PAGE);
    log("applicationServlet:init(): end");
  }

  public void doGet(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException
  {
    req.setCharacterEncoding("UTF-8");
    System.out.println("applicationServlet:doGet()");

    this.session = req.getSession(false);
    if (this.session == null) {
      System.out.println("Session is not valid.");
      req.setAttribute("message", "The Session is no longer valid");
      resp.sendRedirect(req.getContextPath() + "/jsp/unprotected/logon.jsp");
      return;
    }

    if (!isSubjectAssigned(req, resp)) {
      return;
    }
    HttpSession session = req.getSession(false);
    if (session == null) {
      System.out.println("EXPI: applicationServlet:doGet() - no session - redirecting to logo page");

      resp.sendRedirect(req.getContextPath() + this.LOGON_PAGE);
    }

    Subject subject = (Subject)session.getAttribute("subject");

    if (subject == null) {
      System.out.println("EXPI: applicationServlet:doGet() - no subject - redirecting to logon page");

      resp.sendRedirect(req.getContextPath() + this.LOGON_PAGE);
    }

    PlatformContext platform = (PlatformContext)session.getAttribute("platform");

    if (platform == null) {
      System.out.println("EXPI: applicationServlet:doGet() - no Platform Context object - redirecting to logon page");

      resp.sendRedirect(req.getContextPath() + this.LOGON_PAGE);
    }

    String userID = (String)session.getAttribute("j_username");
    if (userID == null) {
      System.out.println("EXPI: applicationServlet:doGet() - no userID found - redirecting to logon.jsp");

      resp.sendRedirect(req.getContextPath() + this.LOGON_PAGE);
    }

    PersonMO personMo = (PersonMO)session.getAttribute("personMO");

    if (personMo == null) {
      System.out.println("EXPI: applicationServlet:doGet() - no PersonMO object found - redirecting to logon page");

      resp.sendRedirect(req.getContextPath() + this.LOGON_PAGE);
    }

    AccountMO acctMO = utilObject.lookupAccounts(platform, subject, personMo, utilObject.getProperty("application.service.dn"));

    Account account = utilObject.account;

    if (account != null)
    {
      session.setAttribute("accountMO", acctMO);
      session.setAttribute("account", account);

      setRequestAttributes(req, account.getAttributes());

      ExpiUtil.forward(req, resp, "", utilObject.getProperty("page.applications"));
    }
    else {
      System.out.println("EXPI: applicationServlet:doGet() - no Account found for Service '" + utilObject.getProperty("application.service.name") + " - redirecting to selfCareServlet");

      ExpiUtil.forward(req, resp, "Application subscriptions have not been configured at this time.", utilObject.getProperty("page.home"));
    }
  }

  public void doPost(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException
  {
    req.setCharacterEncoding("UTF-8");

    this.session = req.getSession(false);
    if (this.session == null) {
      System.out.println("EXPI: applicationServlet:doPost() - Session is not valid.");

      req.setAttribute("message", "The Session is no longer valid");

      if (utilObject.isSSOEnabled())
        resp.sendRedirect(req.getContextPath() + this.LOGON_PAGE);
      else
        resp.sendRedirect("logonServlet");
      return;
    }

    System.out.println("EXPI: applicationServlet:doPost()");
    Enumeration _enum = req.getParameterNames();

    while (_enum.hasMoreElements()) {
      String element = (String)_enum.nextElement();
      String sValue = req.getParameter(element);

      System.out.println("EXPI: Parameter: " + element + ": " + sValue);
    }

    if (!isSubjectAssigned(req, resp)) {
      return;
    }
    AccountMO acctMO = (AccountMO)this.session.getAttribute("accountMO");
    if (acctMO == null) {
      System.out.println("EXPI: applicationServlet:doPost() - no accountMO - redirecting to logon page");

      resp.sendRedirect(req.getContextPath() + this.LOGON_PAGE);
    }

    Account account = (Account)this.session.getAttribute("account");
    if (account == null) {
      System.out.println("EXPI: applicationServlet:doPost() - no account - redirecting to logon page");

      resp.sendRedirect(req.getContextPath() + this.LOGON_PAGE);
    }

    AttributeValues attrValues = account.getAttributes();
    Collection colExistingRoles = utilObject.getTamGroups(attrValues);

    Collection colNewRoles = new Vector(0);

    Collection colDefinedRoles = getDefinedGroups();

    _enum = req.getParameterNames();
    while (_enum.hasMoreElements()) {
      String element = (String)_enum.nextElement();
      String sGroup = req.getParameter(element);
      if (!sGroup.equals("")) {
        if (!colExistingRoles.contains(sGroup)) {
          colNewRoles.add(sGroup);
        }
        colDefinedRoles.remove(sGroup);
      }

    }

    boolean bChanges = false;

    Iterator it = colNewRoles.iterator();
    while (it.hasNext()) {
      String sGroup = (String)it.next();
      colExistingRoles.add(sGroup);
      bChanges = true;
    }

    it = colDefinedRoles.iterator();
    while (it.hasNext()) {
      String sGroup = (String)it.next();
      colExistingRoles.remove(sGroup);
      bChanges = true;
    }

    if (bChanges) {
      System.out.println("EXPI: New Group Attr  = " + colExistingRoles.toString());

      AttributeValue modAttrVal = new AttributeValue(utilObject.getProperty("application.service.attribute"), colExistingRoles);

      account.setAttribute(modAttrVal);

      if (utilObject.updateAccount(acctMO, account)) {
        ExpiUtil.forward(req, resp, "", utilObject.getProperty("page.applications.submitted"));

        return;
      }
    }

    ExpiUtil.forward(req, resp, "Application Subscription failed (please check the server logs).", utilObject.getProperty("page.selfcare"));
  }

  private boolean isSubjectAssigned(HttpServletRequest req, HttpServletResponse resp)
    throws IOException
  {
    Subject subject = (Subject)this.session.getAttribute("subject");
    if (subject == null) {
      System.out.println("EXPI: Session is not valid (no subject).");

      this.session.invalidate();

      req.setAttribute("message", "The Session is no longer valid.");
      resp.sendRedirect(req.getContextPath() + this.LOGON_PAGE);
      return false;
    }
    return true;
  }

  public void setRequestAttributes(HttpServletRequest req, AttributeValues attrValues)
  {
    System.out.println("EXPI: setRequestAttributes - Groups");

    Collection roles = utilObject.getTamGroups(attrValues);

    System.out.println("EXPI: Account contains:: ");
    Iterator iter = roles.iterator();
    while (iter.hasNext()) {
      System.out.println("Group: " + iter.next());
    }

    String groups = utilObject.getProperty("application.list");

    StringTokenizer st = new StringTokenizer(groups, ",");
    while (st.hasMoreTokens()) {
      String sAttr = st.nextToken();
      String appPropertyName = new String("application." + sAttr + ".name");

      String appPropertyDN = new String("application." + sAttr + ".dn");

      if (appPropertyName != null)
      {
        String appName = new String(utilObject.getProperty(appPropertyName));

        if (appName != null) {
          String appNameDN = new String(utilObject.getProperty(appPropertyDN));

          if (roles.contains(appNameDN)) {
            req.setAttribute(sAttr, appName);
            System.out.println("EXPI: sAttr: (dn=" + appNameDN + ") " + sAttr + " - " + appName);
          }
          else {
            System.out.println("EXPI: sAttr: (dn=" + appNameDN + ") " + sAttr + " - (blank)");

            req.setAttribute(sAttr, "");
          }
        } else {
          req.setAttribute(sAttr, "");
        }
      } else { req.setAttribute(sAttr, ""); }

    }
  }

  public Collection<String> getDefinedGroups()
  {
    Collection colRoles = new Vector(0);

    System.out.println("EXPI: getDefinedApplications - Groups: ");

    String appString = utilObject.getProperty("application.list");
    System.out.println("EXPI: Application List: " + appString);

    StringTokenizer st = new StringTokenizer(appString, ",");
    while (st.hasMoreTokens()) {
      String sAttr = st.nextToken();
      String appPropertyName = new String("application." + sAttr + ".name");

      String appPropertyDN = new String("application." + sAttr + ".dn");

      if (appPropertyName != null) {
        System.out.println("EXPI: App Property: " + appPropertyName);

        String appName = new String(utilObject.getProperty(appPropertyName));

        if (appName != null) {
          System.out.println("EXPI: App Name: " + appName);

          String appNameDNStr = new String(utilObject.getProperty(appPropertyDN));

          colRoles.add(new String(appNameDNStr));
        }
      }
    }

    return colRoles;
  }
}