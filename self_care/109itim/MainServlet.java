package examples.expi;

import com.ibm.itim.apps.PlatformContext;
import com.ibm.itim.apps.identity.PersonMO;
import com.ibm.itim.apps.provisioning.AccountMO;
import com.ibm.itim.dataservices.model.domain.Account;
import java.io.IOException;
import java.io.PrintStream;
import javax.security.auth.Subject;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class MainServlet extends HttpServlet
{
  private static final long serialVersionUID = -3467953916282518352L;
  private HttpSession session;
  private static ExpiUtil utilObject = null;
  private String LOGON_PAGE = "logon.jsp";

  public void init()
  {
    log("mainServlet:init(): start");
    try
    {
      utilObject = new ExpiUtil();
    } catch (Exception e) {
      e.printStackTrace();
    }

    this.LOGON_PAGE = utilObject.getPropertySSOCheck("page.logon");
    log("EXPI: mainServlet:init(): LOGON_PAGE = " + this.LOGON_PAGE);
    log("mainServlet:init(): end");
  }

  public void doGet(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException
  {
    req.setCharacterEncoding("UTF-8");

    System.out.println("doGet(): start");

    this.session = req.getSession(false);
    if (this.session == null) {
      System.out.println("No session");

      String userID = req.getHeader("iv-user");
      if ((userID != null) && (!userID.equals(""))) {
        System.out.println("iv-user = " + userID);
        System.out.println("Forwarding to loginServlet.doPost()");
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(req.getContextPath() + "/jsp/unprotected/logon.jsp");

        dispatcher.forward(req, resp);
      }
      else {
        req.setAttribute("message", "The Session is no longer valid");
        resp.sendRedirect(req.getContextPath() + "/jsp/unprotected/logon.jsp");
      }
      return;
    }

    if (!isSubjectAssigned(req, resp)) {
      return;
    }
    HttpSession session = req.getSession(false);
    if (session == null) {
      System.out.println("EXPI: mainServlet:doGet() - no session - redirecting to logo page");

      resp.sendRedirect(req.getContextPath() + this.LOGON_PAGE);
    }

    Subject subject = (Subject)session.getAttribute("subject");

    if (subject == null) {
      System.out.println("EXPI: mainServlet:doGet() - no subject - redirecting to logon page");

      resp.sendRedirect(req.getContextPath() + this.LOGON_PAGE);
      return;
    }

    PlatformContext platform = (PlatformContext)session.getAttribute("platform");

    if (platform == null) {
      System.out.println("EXPI: mainServlet:doGet() - no Platform Context object - redirecting to logon page");

      resp.sendRedirect(req.getContextPath() + this.LOGON_PAGE);
      return;
    }

    String userID = (String)session.getAttribute("j_username");
    if (userID == null) {
      System.out.println("EXPI: mainServlet:doGet() - no userID found - redirecting to logon.jsp");

      resp.sendRedirect(req.getContextPath() + this.LOGON_PAGE);
      return;
    }

    PersonMO personMo = (PersonMO)session.getAttribute("personMO");

    if (personMo == null) {
      System.out.println("EXPI: mainServlet:doGet() - no PersonMO object found - redirecting to logon page");

      resp.sendRedirect(req.getContextPath() + this.LOGON_PAGE);
      return;
    }

    String serviceDN = utilObject.getProperty("application.service.dn");

    if ((serviceDN == null) || (serviceDN.equals(""))) {
      System.out.println("EXPI: mainServlet:doGet() - TAM Service DN not specified in property file");

      session.setAttribute("tamserviceactive", "false");
    }
    else
    {
      AccountMO acctMO = utilObject.lookupAccounts(platform, subject, personMo, utilObject.getProperty("application.service.dn"));

      Account account = utilObject.account;

      if (account != null) {
        System.out.println("EXPI: mainServlet:doGet() - TAM Service is configured...forwarding to main.jsp");

        session.setAttribute("accountMO", acctMO);
        session.setAttribute("account", account);
        session.setAttribute("tamserviceactive", "true");
      } else {
        System.out.println("EXPI: mainServlet:doGet() - " + utilObject.getProperty("application.service.name") + " is NOT configured...forwarding to main.jsp");

        session.setAttribute("tamserviceactive", "false");
      }

    }

    String action = req.getParameter("action");
    System.out.println(action + ",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,");
    if ((action != null) && (action.equals("updateAnswer"))) {
      System.out.println("mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");
      req.getRequestDispatcher("/ChangeChallengeResponseServlet").forward(req, resp);
    }
    else {
      System.out.println("nnnnnnnnnnnnnnnnnnnnnnnnnnnnnn");
      ExpiUtil.forward(req, resp, "", utilObject.getProperty("page.home"));
    }
  }

  public void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {
    doGet(request, response);
  }

  private boolean isSubjectAssigned(HttpServletRequest req, HttpServletResponse resp)
    throws IOException
  {
    Subject subject = (Subject)this.session.getAttribute("subject");
    if (subject == null) {
      System.out.println("EXPI: mainServlet:isSubjectAssigned() Session is not valid (no subject).");

      this.session.invalidate();

      req.setAttribute("message", "The Session is no longer valid.");
      resp.sendRedirect(req.getContextPath() + this.LOGON_PAGE);
      return false;
    }
    return true;
  }
}