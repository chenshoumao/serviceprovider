package examples.expi;

import com.ibm.itim.apps.ApplicationException;
import com.ibm.itim.apps.AuthorizationException;
import com.ibm.itim.apps.PlatformContext;
import com.ibm.itim.apps.SchemaViolationException;
import com.ibm.itim.apps.identity.PersonMO;
import com.ibm.itim.common.AttributeValue;
import com.ibm.itim.dataservices.model.domain.Person;
import java.io.IOException;
import java.io.PrintStream;
import java.rmi.RemoteException;
import java.util.Enumeration;
import java.util.StringTokenizer;
import javax.security.auth.Subject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SelfCareServlet extends HttpServlet
{
  private static final long serialVersionUID = 7193099952158249375L;
  private static ExpiUtil utilObject = null;

  public void doGet(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException
  {
    req.setCharacterEncoding("UTF-8");
    try
    {
      utilObject = new ExpiUtil();
    } catch (Exception e) {
      e.printStackTrace();
    }

    HttpSession session = req.getSession(false);
    if (session == null) {
      System.out.println("EXPI: selfCareServlet:doGet() - no session - redirecting to logon page");

      resp.sendRedirect("logonServlet");
    }

    Subject subject = (Subject)session.getAttribute("subject");

    if (subject == null) {
      System.out.println("EXPI: selfCareServlet:doGet() - no subject - redirecting to logon page");

      resp.sendRedirect("logonServlet");
    }
    PlatformContext platform = (PlatformContext)session.getAttribute("platform");

    if (platform == null) {
      System.out.println("EXPI: selfCareServlet:doGet() - no Platform Context object - redirecting to logon page");

      resp.sendRedirect("logonServlet");
    }

    String userID = (String)session.getAttribute("j_username");
    if (userID == null) {
      System.out.println("EXPI: selfCareServlet:doGet() - no userID found - redirecting to logon page");

      resp.sendRedirect("logonServlet");
    }

    PersonMO personMo = (PersonMO)session.getAttribute("personMO");

    if (personMo == null) {
      System.out.println("EXPI: selfCareServlet:doGet() - no PersonMO object found - redirecting to logon page");

      resp.sendRedirect("logonServlet");
    }
    try
    {
      utilObject.printAttributes(personMo.getData());
    } catch (RemoteException e) {
      e.printStackTrace();
      System.out.println("EXPI: selfCareServlet:doGet() - getData - RemoteException");
    }
    catch (ApplicationException e) {
      e.printStackTrace();
      System.out.println("EXPI: selfCareServlet:doGet() - getData - ApplicationException");
    }

    setRequestAttributes(req, personMo);

    String msg = (String)session.getAttribute("errorMessage");

    if (msg == null) {
      msg = "";
    }
    ExpiUtil.forward(req, resp, msg, utilObject.getProperty("page.selfcare"));
  }

  public void setRequestAttributes(HttpServletRequest req, PersonMO personMo)
  {
    Person person = null;

    String selfcareAttrs = utilObject.getProperty("attributes.selfcare");
    System.out.println("selfcare attrs: " + selfcareAttrs);

    if (selfcareAttrs != null) {
      try {
        person = personMo.getData();
      } catch (RemoteException e) {
        e.printStackTrace();
        System.out.println("EXPI: selfCareServlet:doGet() - getData - RemoteException");
      }
      catch (ApplicationException e) {
        e.printStackTrace();
        System.out.println("EXPI: selfCareServlet:doGet() - getData - ApplicationException");
      }

    }

    utilObject.printAttributes(person);

    StringTokenizer st = new StringTokenizer(selfcareAttrs, ",");
    while (st.hasMoreTokens()) {
      String sAttr = st.nextToken();

      AttributeValue sValue = person.getAttribute(sAttr);
      if ((sValue != null) && (!sValue.isValueEmpty()))
      {
        System.out.println("   Attr: " + sAttr + " = " + sValue.getString());

        req.setAttribute(sAttr, sValue.getString());
      } else {
        req.setAttribute(sAttr, "");
      }
    }
    System.out.println("hhhhhhhhhhhhhhhhhhhhhhh");
  }

  public void doPost(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException
  {
    req.setCharacterEncoding("UTF-8");

    if (utilObject == null) {
      System.out.println("EXPI: selfCareServlet:doPost() - expected a utilObject - redirecting to logon page");

      resp.sendRedirect("logonServlet");
    }

    HttpSession session = req.getSession(false);
    if (session == null) {
      System.out.println("EXPI: selfCareServlet:doPost() - no session - redirecting to logon page");

      resp.sendRedirect("logonServlet");
    }

    PersonMO personMo = (PersonMO)session.getAttribute("personMO");

    if (personMo == null) {
      System.out.println("EXPI: selfCareServlet:doPost() - no PersonMO object found - redirecting to logon page");

      resp.sendRedirect("logonServlet");
    }

    String selfcareAttrs = utilObject.getProperty("attributes.selfcare");
    System.out.println("selfcare attrs: " + selfcareAttrs);

    if (selfcareAttrs != null) {
      Person person = null;
      try
      {
        person = personMo.getData();
      } catch (RemoteException e) {
        e.printStackTrace();
        System.out.println("EXPI: selfCareServlet:doPost() - getData - RemoteException");
      }
      catch (ApplicationException e) {
        e.printStackTrace();
        System.out.println("EXPI: selfCareServlet:doPost() - getData - ApplicationException");
      }

      Enumeration _enum = req.getParameterNames();

      while (_enum.hasMoreElements()) {
        String element = (String)_enum.nextElement();
        String sValue = req.getParameter(element);

        System.out.println("EXPI: selfCareServlet:doPost() - Updating: " + element + ": " + sValue);

        AttributeValue attrValue = new AttributeValue(element, sValue);
        person.setAttribute(attrValue);
      }

      try
      {
        System.out.println("1111111111111111111");
        personMo.update(person, null);
        System.out.println("22222222222222222222222222");

        ExpiUtil.forward(req, resp, "", utilObject.getProperty("page.selfcare.submitted"));
      }
      catch (AuthorizationException e) {
        e.printStackTrace();
        System.out.println("EXPI: personMo.update() - getData - AuthorizationException");

        setRequestAttributes(req, personMo);

        ExpiUtil.forward(req, resp, "Error - AuthorizationException", utilObject.getProperty("page.selfcare"));
      }
      catch (SchemaViolationException e) {
        e.printStackTrace();
        System.out.println("EXPI: personMo.update() - getData - SchemaViolationException");

        ExpiUtil.forward(req, resp, "Error - SchemaViolationException", utilObject.getProperty("page.selfcare"));
      }
      catch (RemoteException e)
      {
        e.printStackTrace();
        System.out.println("EXPI: personMo.update) - getData - RemoteException");

        ExpiUtil.forward(req, resp, "Error - RemoteException", utilObject.getProperty("page.selfcare"));
      }
      catch (ApplicationException e) {
        e.printStackTrace();
        System.out.println("EXPI: personMo.update() - getData - ApplicationException");

        ExpiUtil.forward(req, resp, "Error - ApplicationException", utilObject.getProperty("page.selfcare"));
      }
    }
  }
}