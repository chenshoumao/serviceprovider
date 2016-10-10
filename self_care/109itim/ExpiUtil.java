
package examples.expi;

import com.ibm.itim.apps.ApplicationException;
import com.ibm.itim.apps.AuthorizationException;
import com.ibm.itim.apps.InitialPlatformContext;
import com.ibm.itim.apps.PlatformContext;
import com.ibm.itim.apps.identity.ContainerManager;
import com.ibm.itim.apps.identity.OrganizationalContainerMO;
import com.ibm.itim.apps.identity.PersonMO;
import com.ibm.itim.apps.provisioning.AccountMO;
import com.ibm.itim.apps.provisioning.AccountManager;
import com.ibm.itim.apps.system.SystemSubjectUtil;
import com.ibm.itim.apps.system.SystemUserMO;
import com.ibm.itim.common.AttributeValue;
import com.ibm.itim.common.AttributeValues;
import com.ibm.itim.dataservices.model.DirectoryObject;
import com.ibm.itim.dataservices.model.DistinguishedName;
import com.ibm.itim.dataservices.model.domain.Account;
import com.ibm.itim.dataservices.model.domain.Person;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintStream;
import java.rmi.RemoteException;
import java.util.Collection;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Locale;
import java.util.Map;
import java.util.Properties;
import java.util.Set;
import java.util.StringTokenizer;
import java.util.Vector;
import javax.security.auth.Subject;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ExpiUtil
{
  public static final String EXPI_LOGIN_ERROR = "expiLoginError";
  public static final String ERR_LABEL = "errorMessage";
  public static final String SERVICE_ENROLE_PROFILE_NAME = "ITIMService";
  public static final String LOGON_SERVLET = "logonServlet";
  public static final String LOGON_PAGE = "page.logon";
  public static final String LOGON_ERROR = "logon.error";
  public static final String SSO_ERROR_PAGE = "page.ssoerror";
  public static final String LOGOUT_PAGE = "page.logout";
  public static final String HOME_PAGE = "page.home";
  public static final String SELF_CHANGEPWD_PAGE = "page.selfchangepwd";
  public static final String SELF_CHANGEPWD_INFO_PAGE = "page.selfchangepwdinfo";
  public static final String CHANGEPWD_PAGE = "page.changepwd";
  public static final String CHANGEPWDINFO_PAGE = "page.changepwdinfo";
  public static final String PWDRULESINFO_PAGE = "page.pwdrulesinfo";
  public static final String FORGOTPWD_PAGE = "page.forgotpwd";
  public static final String FORGOTPWDINFO_PAGE = "page.forgotpwdinfo";
  public static final String CRANSWERPAGE_PAGE = "page.cranswers";
  public static final String CRANSWERPAGEINFO_PAGE = "page.cranswersinfo";
  public static final String CRFORGOTPWD_PAGE = "page.crforgotpwd";
  public static final String SELFCARE_PAGE = "page.selfcare";
  public static final String SELFCARESUB_PAGE = "page.selfcare.submitted";
  public static final String SELFCARE_FOOTER_PAGE = "page.selfcare_footer";
  public static final String SELFREGISTRATION_PAGE = "page.selfregister";
  public static final String SELFREGISTRATIONSUB_PAGE = "page.selfregister.submitted";
  public static final String APPLICATIONS_PAGE = "page.applications";
  public static final String APPLICATIONSSUB_PAGE = "page.applications.submitted";
  public static final String SELFCARE_ATTRS = "attributes.selfcare";
  public static final String CHANGEONLYITIMPASSWORD = "changeonlytimpassword";
  public static final String TAM_SERVICE_NAME = "service.tam.name";
  public static final String TAM_SERVICE_ACTIVE = "tamserviceactive";
  public static final String PROPS_FILE = "itim_expi.properties";
  public static final String PLATFORMCONTEXTFACTORY = "platformContextFactory";
  public static final String LOGIN_CONTEXT = "loginContext";
  public static final String PLATFORM_CONTEXT = "platform";
  public static final String SUBJECT = "subject";
  public static final String ITIM_PASSWORD2 = "erpassword2";
  public static final String ITIM_PASSWORD = "erpassword";
  public static final String PERSON_DEFAULT_PROFILE = "Person";
  public static final String PLATFORM_URL = "platform.url";
  public static final String PLATFORM_PRINCIPAL = "platform.principal";
  public static final String PLATFORM_CREDENTIALS = "platform.credentials";
  public static final String APP_SERVICE_NAME = "application.service.name";
  public static final String APP_SERVICE_DN = "application.service.dn";
  public static final String APP_SERVICE_ATTR = "application.service.attribute";
  public static final String APP_LIST = "application.list";
  public static final String TENANT_ID = "tenantid";
  public static final String TENANT_DN = "tenantdn";
  public static final String USER_ID = "userid";
  public static final String LOGON_ID = "j_username";
  public static final String PWD = "password";
  public static final String LOGGED_ON = "loggedOn";
  public static final String PERSONMO = "personMO";
  public static final String ACCOUNTMO = "accountMO";
  public static final String ACCOUNT = "account";
  public static final String SSO_ENABLED = "ssoEnabled";
  public static final String SSO_SESSION_LOGON_ID = "ssoSessionID";
  public static final String SELF_REG_LOCATION = "orgContainer.selfregister.location.org";
  public static final String SELF_REG_LOCATION_ATTR = "orgContainer.selfregister.location.attr";
  public static final String DEFAULT_ORG_NAME = "default.org";
  public static final String GET_PER_ATTR_USERID = "person.getPerson.attr.uid";
  public static final String LANGUAGE = "language";
  public static final String COUNTRY = "country";
  public static String ACCOUNT_ATTR_ROLE = "erroles";

  private static ExpiUtil instance = null;
  private Properties properties = null;

  public PlatformContext platform = null;
  public Account account = null;
  private boolean bTAMInstalled = false;

  public void createClientContext(HttpServletRequest req)
  {
    String password = null;
    String userID = null;

    userID = req.getParameter("logonID");
    password = req.getParameter("password");

    System.out.println("EXPI: User: " + userID + " - pwd: " + password);
    try
    {
      this.platform = createPlatformContext();
    } catch (RemoteException e) {
      e.printStackTrace();
    } catch (ApplicationException e) {
      e.printStackTrace();
    }
  }

  public PlatformContext createPlatformContext()
    throws ApplicationException, RemoteException
  {
    Hashtable env = new Hashtable();
    try {
      env.put("enrole.platform.contextFactory", getProperty("platformContextFactory"));

      env.put("enrole.appServer.url", getProperty("platform.url"));
      env.put("enrole.appServer.ejbuser.principal", getProperty("platform.principal"));

      env.put("enrole.appServer.ejbuser.credentials", getProperty("platform.credentials"));
    }
    catch (RuntimeException e)
    {
      e.printStackTrace();
      return null;
    }
    try
    {
      this.platform = new InitialPlatformContext(env);
    } catch (RemoteException e) {
      e.printStackTrace();
      throw e;
    } catch (ApplicationException e) {
      e.printStackTrace();
      throw e;
    }

    return this.platform;
  }

  public PlatformContext getPlatform()
  {
    return this.platform;
  }

  public void setPlatform(PlatformContext platform)
  {
    this.platform = platform;
  }

  public ExpiUtil()
  {
    instance = this;
    this.properties = null;
    try
    {
      loadProperties();
    } catch (Exception e) {
      System.err.println("expiUtil: Failed to initialize");
      e.printStackTrace();
    }

    if (this.properties == null)
      System.err.println("expiUtil: properties not initialized");
  }

  public static ExpiUtil getInstance()
    throws Exception
  {
    if (instance == null) {
      instance = new ExpiUtil();
    }
    return instance;
  }

  public String getProperty(String key)
  {
    try
    {
      return this.properties.getProperty(key);
    } catch (Exception e) {
      e.printStackTrace();
    }
    return key;
  }

  public String getPropertySSOCheck(String key)
  {
    try
    {
      if ((isSSOEnabled()) && (key.equals("page.logon")))
      {
        key = "page.ssoerror";
        System.out.println("getPropertySSOCheck: remapped - " + key + "=" + this.properties.getProperty(key));
      }

      return this.properties.getProperty(key);
    } catch (Exception e) {
      e.printStackTrace();
    }
    return key;
  }

  public void loadProperties()
    throws Exception
  {
    this.properties = new Properties();
    System.out.println("EXPI: loadProperties:");
    try {
      String dir = findDir();
      this.properties.load(new FileInputStream(dir + File.separator + "itim_expi.properties"));
    }
    catch (IOException ioe) {
      ioe.printStackTrace();

      this.properties = null;
      throw ioe;
    }
  }

  private static String findDir()
    throws Exception
  {
    String dir = "";
    try {
      String classPath = System.getProperty("java.class.path");
      StringTokenizer st = new StringTokenizer(classPath, File.pathSeparator);

      while (st.hasMoreTokens()) {
        String dirName = st.nextToken();

        System.out.println("EXPI: Searching: " + dirName);
        File file = new File(dirName, "itim_expi.properties");
        if (file.isFile()) {
          dir = dirName;
          System.out.println("EXPI: Found property file: " + dirName);
          return dir;
        }
      }
    } catch (Exception e) {
      e.printStackTrace();
      throw e;
    }
    return dir;
  }

  public PersonMO lookupPerson(PlatformContext platformLogin, Subject subject)
  {
    System.out.println("expiUtil.lookupPerson(): start");

    SystemUserMO systemUserMO = null;
    try {
      systemUserMO = SystemSubjectUtil.getSystemUser(platformLogin, subject);
      System.out.println("expiUtil.lookupPerson(): SystemUserMO: " + systemUserMO.toString());
    } catch (ApplicationException e) {
      e.printStackTrace();
      System.out.println("EXPI: SystemSubjectUtil.getSystemUser - ApplicationException");
    }

    if (systemUserMO == null) return null;

    PersonMO personMO = null;
    try {
      personMO = systemUserMO.getOwner();
      System.out.println("expiUtil.lookupPerson(): Got personMO: " + personMO.toString());
    } catch (AuthorizationException e) {
      e.printStackTrace();
      System.out.println("EXPI: accountMO.getOwner - AuthorizationException");
    }
    catch (RemoteException e) {
      e.printStackTrace();
      System.out.println("expiUtil.lookupPerson(): accountMO.getOwner - RemoteException");
    } catch (ApplicationException e) {
      e.printStackTrace();
      System.out.println("EXPI: accountMO.getOwner - ApplicationException");
    }

    if (personMO != null) {
      Person person = null;
      try {
        person = personMO.getData();
        System.out.println("expiUtil.lookupPerson(): Got person: " + person.toString());
      }
      catch (RemoteException e) {
        e.printStackTrace();
        System.out.println("EXPI: personMO.getData - RemoteException");
      } catch (ApplicationException e) {
        e.printStackTrace();
        System.out.println("EXPI: personMO.getData - ApplicationException");
      }

      if (person != null) {
        AttributeValue cnAV = person.getAttribute("cn");
        System.out.println("AttributeValue: cn = " + cnAV.getString());
        return personMO;
      }
    }
    return null;
  }

  public boolean isPasswordChangeRequired(PlatformContext platform, Subject subject)
  {
    boolean isPwdChangeRequired = false;
    try {
      SystemUserMO systemUserMO = SystemSubjectUtil.getSystemUser(platform, subject);
      isPwdChangeRequired = systemUserMO.isChangePasswordRequired();
    } catch (ApplicationException e) {
      e.printStackTrace();
      System.out.println("EXPI: SystemSubjectUtil.isPasswordChangeRequired - ApplicationException");
    }

    return isPwdChangeRequired;
  }

  public AccountMO lookupAccounts(PlatformContext platformLogin, Subject subject, PersonMO personMO, String serviceDN)
  {
    System.out.println("EXPI: lookupAccounts: type " + serviceDN);

    AccountManager acctMgr = new AccountManager(platformLogin, subject);

    Locale locale = Locale.US;

    Collection accountsByOwner = null;
    try
    {
      System.out.println("EXPI: getAccounts");
      accountsByOwner = acctMgr.getAccounts(personMO, locale);
    } catch (RemoteException e) {
      e.printStackTrace();
      System.out.println("EXPI: acctMO.getData - RemoteException");
    } catch (ApplicationException e) {
      e.printStackTrace();
      System.out.println("EXPI: acctMO.getData - ApplicationException");
    }

    if ((accountsByOwner == null) || (accountsByOwner.isEmpty())) {
      System.out.println("EXPI: acctMO.getData - no authorized accounts found.");

      return null;
    }

    Iterator it = accountsByOwner.iterator();

    AccountMO acctMO = null;
    Account anAccount = null;
    int iCount = 1;

    System.out.println("EXPI: Person has " + accountsByOwner.size() + " Accounts");

    while (it.hasNext()) {
      acctMO = (AccountMO)it.next();
      System.out.println("EXPI: checking acctMO " + iCount++);

      anAccount = getAccountByService(acctMO, serviceDN);
      if (anAccount != null) {
        System.out.println("Returning AccountMO:");
        this.account = anAccount;
        return acctMO;
      }
    }

    return null;
  }

  public boolean updateAccount(AccountMO acctMO, Account account)
  {
    try
    {
      System.out.println("EXPI: Calling accountMO update: ");
      acctMO.update(account, null);
      System.out.println("EXPI: Update accountMO returned");
    } catch (Exception e) {
      System.out.println("EXPI: accountMO threw an Exception: ");
      e.printStackTrace();
      return false;
    }

    return true;
  }

  public Account getAccountByService(AccountMO acctMO, String serviceDN)
  {
    System.out.println("EXPI: getAccountByService - entering: " + serviceDN);

    if (acctMO == null) {
      System.out.println("EXPI: getAccountByService - no acctMO");
      return null;
    }

    Account account = null;
    try
    {
      account = acctMO.getData();
    } catch (RemoteException e) {
      e.printStackTrace();
      System.out.println("EXPI: acctMO.getData - RemoteException");
      return null;
    } catch (ApplicationException e) {
      e.printStackTrace();
      System.out.println("EXPI: acctMO.getData - ApplicationException");
      return null;
    }

    System.out.println("EXPI: dn = " + acctMO.getDistinguishedName());

    DistinguishedName dn = account.getServiceDN();

    System.out.println("EXPI: Account: Service DN = " + dn);
    System.out.println("EXPI: Account Name: " + account.getName());

    if (dn.toString().equalsIgnoreCase(serviceDN)) {
      System.out.println("EXPI: Found Group DN");
      printAttributes(account);
      System.out.println("EXPI:returning account ");
      return account;
    }
    System.out.println("EXPI:Service DN not found");

    return null;
  }

  public Collection<String> getTamGroups(AttributeValues attrValues)
  {
    AttributeValue attr = attrValues.get(getProperty("application.service.attribute"));

    if (attr == null) {
      System.out.println("EXPI: No TAM Group members specified");
      return new Vector(0);
    }

    Collection colTamGroups = attr.getValues();

    System.out.println("EXPI: TAM Group(s): ");
    Iterator itc = colTamGroups.iterator();
    while (itc.hasNext()) {
      System.out.println("EXPI: Group: " + itc.next());
    }

    return colTamGroups;
  }

  public void setRoles(AttributeValues attrValues, Collection roles)
  {
    System.out.println("EXPI: setRoles (" + ACCOUNT_ATTR_ROLE + ")");
    Iterator iter = roles.iterator();
    while (iter.hasNext()) {
      System.out.println("Group: " + iter.next());
    }

    AttributeValue attrVal = new AttributeValue(ACCOUNT_ATTR_ROLE, roles);
    attrValues.put(attrVal);
  }

  public static OrganizationalContainerMO getOrganizationContainerbyName(PlatformContext platform, Subject subject, String tenantId, String toOrgName)
    throws RemoteException, ApplicationException
  {
    System.out.println("getOrganizationContainerbyName: " + tenantId + " " + toOrgName);

    ContainerManager cManager = new ContainerManager(platform, subject);
    OrganizationalContainerMO rootOrgContainer = null;
    if (tenantId == null)
      rootOrgContainer = cManager.getRoot();
    else {
      rootOrgContainer = cManager.getRoot(tenantId);
    }
    Collection cColl = cManager.getContainers(rootOrgContainer, "o", toOrgName);

    OrganizationalContainerMO toOrgNameCMO = null;
    if (!cColl.isEmpty()) {
      toOrgNameCMO = (OrganizationalContainerMO)cColl.iterator().next();
      System.out.println("getContainers: " + toOrgNameCMO.getDistinguishedName());
    }
    else {
      System.out.println("getContainers: no data");
    }return toOrgNameCMO;
  }

  public static OrganizationalContainerMO getFirstContainer(Collection collection)
    throws ApplicationException
  {
    Iterator it = collection.iterator();
    if (it.hasNext()) {
      OrganizationalContainerMO po = (OrganizationalContainerMO)it.next();

      return po;
    }
    throw new ApplicationException("Container to be deleted can't be found");
  }

  public String getLoginContextID()
  {
    return getProperty("loginContext");
  }

  public String getTenantID()
  {
    return getProperty("tenantid");
  }

  public static void forward(HttpServletRequest req, HttpServletResponse resp, String msg, String jspPage)
  {
    System.out.println("EXPI: ExpiUtil.forward() - forward: to " + jspPage);

    if (msg != null) {
      System.out.println("EXPI:  ExpiUtil.forward() - forward: Msg = " + msg);
    }
    if (msg != null) {
      HttpSession session = req.getSession(false);

      if (session != null) {
        System.out.println("EXPI:  ExpiUtil.forward() - Msg added to session");
        session.setAttribute("errorMessage", msg);
      }
    } else {
      HttpSession session = req.getSession(false);
      if (session != null) {
        session.setAttribute("errorMessage", "");
      }
    }
    RequestDispatcher rd = req.getRequestDispatcher("/" + jspPage);
    try
    {
      rd.forward(req, resp);
    } catch (IOException e) {
      System.err.println("ExpiUtil.forward() - IO exception on RequestDispatcher.forward because : " + e);
    }
    catch (ServletException e) {
      System.err.println("ExpiUtil.forward() - Servlet exception on RequestDispatcher.forward because: " + e);
    }
  }

  public void printAttributes(DirectoryObject valueObject)
  {
    if (valueObject == null) {
      System.out.println("printAttributes: null object specified");
      return;
    }

    System.out.println("\n---------------------------------------------");
    if (valueObject.getDistinguishedName() != null) {
      System.out.println("DN: " + valueObject.getDistinguishedName().toString());
    }

    Map attributes = valueObject.getRawAttributes().getMap();
    Set keys = attributes.keySet();
    Iterator it = keys.iterator();
    while (it.hasNext()) {
      String name = (String)it.next();
      AttributeValue valu = (AttributeValue)attributes.get(name);
      System.out.println("   " + name + " = " + valu.getValueString());
    }
  }

  public boolean isProperties()
  {
    return (this.properties != null) && (!this.properties.isEmpty());
  }

  public boolean isSSOEnabled()
  {
    String sSSOEnabled = getProperty("ssoEnabled");

    return (sSSOEnabled != null) && (sSSOEnabled.equalsIgnoreCase("true"));
  }

  public void setTAMService(boolean bFlag)
  {
    this.bTAMInstalled = bFlag;
  }

  public boolean isTAMService()
  {
    return this.bTAMInstalled;
  }

  public static void log(Object msg)
  {
    System.out.println("EXPI:" + msg.toString());
  }
}