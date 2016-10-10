package examples.expi;

import com.ibm.itim.apps.ApplicationException;
import com.ibm.itim.apps.PlatformContext;
import com.ibm.itim.apps.identity.ChallengeResponseConfiguration;
import com.ibm.itim.apps.identity.ChallengeResponseManager;
import com.ibm.itim.apps.identity.ChallengesAndResponses;
import com.ibm.json.java.JSONObject;
import java.io.IOException;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.rmi.RemoteException;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Locale;
import java.util.Map;
import java.util.Set;
import javax.security.auth.Subject;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ChangeChallengeResponseServlet extends HttpServlet
{
  private static final long serialVersionUID = -3149326538669886990L;
  private static final String NOT_CHANGED = "********";
  private static final String INFO_MESSAGE = "infoMessage";
  private static final String CR_MANAGER = "ChallengeResponseManager";
  private static final String DISPLAYED_CARS = "challengesAndResponses";
  private static final String CURRENT_CARS = "timChallengesAndResponses";
  private static String ERROR_MESSAGE;
  private static String PLATFORM_CONTEXT;
  private static String SUBJECT;
  private static String MAIN;
  private static String LOGON;
  private static String CR_ANSWERS;
  private static String CR_ANSWERS_INFO;

  public void init()
    throws ServletException
  {
    ExpiUtil eu = new ExpiUtil();

    ERROR_MESSAGE = "errorMessage";
    PLATFORM_CONTEXT = "platform";
    SUBJECT = "subject";

    LOGON = eu.getPropertySSOCheck("page.logon");
    log("init(): logon page: " + LOGON);
    if (isNullOrEmpty(LOGON)) {
      throw new ServletException("Could not load logon page location from properties file");
    }

    MAIN = eu.getProperty("page.home");
    log("init(): Home page: " + MAIN);
    if (isNullOrEmpty(MAIN)) {
      throw new ServletException("Could not load home page location from properties file");
    }

    CR_ANSWERS = eu.getProperty("page.cranswers");
    log("init(): Challenge response answer page: " + CR_ANSWERS);
    if (isNullOrEmpty(CR_ANSWERS)) {
      throw new ServletException("Could not load challenge response answer page location from properties file");
    }

    CR_ANSWERS_INFO = eu.getProperty("page.cranswersinfo");
    log("init(): Home page: " + CR_ANSWERS_INFO);
    if (isNullOrEmpty(CR_ANSWERS_INFO))
      throw new ServletException("Could not load challenge response answer info location from properties file");
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

    log("doPost() start");
    String action = request.getParameter("action");

    HttpSession session = request.getSession(true);
    if ((session.isNew()) && (!action.equals("updateAnswer"))) {
      log("doPost(): No previous session; forwarding to logon page");
      goToPage(LOGON, "Your session has expired or is invalid.  Please sign on again.", session, request, response);

      return;
    }

    System.out.println(action + "............................");
    log("ChangeChallengeResponseServlet.doPost(): action = " + action);

	getChallengesAndResponses(request, response, session);
	  
    /*if (isNullOrEmpty(action)) {
      getChallengesAndResponses(request, response, session);
	  setAnswers(request, response, session);
    } else if (action.equals("setAnswers")) {
      setAnswers(request, response, session);
    } else {
      System.out.println("kkkkkkkkkkkkkkkkkkkkkkkkkk");
      updateChallengesResponse(request, response, session);
    }*/

    log("doPost() end");
  }

  private void updateChallengesResponse(HttpServletRequest request, HttpServletResponse response, HttpSession session)
    throws ServletException, IOException
  {
    log("getChallengesAndResponses() begin");
    JSONObject json = new JSONObject();
    PrintWriter out = response.getWriter();

    Subject subject = (Subject)session.getAttribute(SUBJECT);
    PlatformContext platform = (PlatformContext)session.getAttribute(PLATFORM_CONTEXT);

    if (!validateSessionData(session, request, response, subject, platform)) {
      return;
    }

    Map carsToDisplay = new HashMap();
    try {
      ChallengeResponseManager crm = new ChallengeResponseManager(platform, subject);

      session.setAttribute("ChallengeResponseManager", crm);

      ChallengesAndResponses cars = crm.getChallengesAndResponses();
      session.setAttribute("timChallengesAndResponses", cars);

      String question = request.getParameter("question");
      System.out.println("question is :" + question);
      carsToDisplay.put(question, "");
      if ((carsToDisplay != null) && (!carsToDisplay.isEmpty())) {
        session.setAttribute("challengesAndResponses", carsToDisplay);

        log("setAnswers() begin");

        Map submittedCars = validateSubmittedAnswers(request, response, session);
        if (submittedCars == null) {
          log("setAnswers(): Submitted answers were invalid.");
          return;
        }

        ChallengesAndResponses carsToSet = (ChallengesAndResponses)session.getAttribute("timChallengesAndResponses");

        crm = (ChallengeResponseManager)session.getAttribute("ChallengeResponseManager");

        removeOldChallenges(crm, submittedCars, carsToSet);

        updateNewOrModifiedChallenges(submittedCars, carsToSet);

        //crm.setChallengesAndResponses(carsToSet);

        session.setAttribute("updateCRAnswers", new Boolean(false)); 
		
        log("setAnswers() end");

        json.put("state", "success");
        out.print(json);
        out.flush();
        out.close();
        return;
      }

      json.put("state", "fail");
      out.print(json);
      out.flush();
      out.close();
      return;
    }
    catch (ApplicationException e)
    {
      log("getChallenges(): Caught ApplicationException: " + e.getMessage());

      json.put("state", "fail");
      out.print(json);
      out.flush();
      out.close();
      return;
    }
    catch (RemoteException e)
    {
      log("getChallenges(): Caught RemoteException: " + e.getMessage());

      json.put("state", "fail");
      out.print(json);
      out.flush();
      out.close();
    }
  }

  private void setAnswers(HttpServletRequest request, HttpServletResponse response, HttpSession session)
    throws ServletException, IOException
  {
    log("setAnswers() begin");

    Map submittedCars = validateSubmittedAnswers(request, response, session);
    if (submittedCars == null) {
      log("setAnswers(): Submitted answers were invalid.");
      return;
    }

    ChallengesAndResponses carsToSet = (ChallengesAndResponses)session.getAttribute("timChallengesAndResponses");

    ChallengeResponseManager crm = (ChallengeResponseManager)session.getAttribute("ChallengeResponseManager");
    try
    {
      removeOldChallenges(crm, submittedCars, carsToSet);

      updateNewOrModifiedChallenges(submittedCars, carsToSet);

      crm.setChallengesAndResponses(carsToSet);

      session.setAttribute("updateCRAnswers", new Boolean(false));

      goToInfoPage(CR_ANSWERS_INFO, "Your challenge/response answers have been updated.", session, request, response);
    }
    catch (RemoteException e)
    {
      log("setAnswers(): Caught RemoteException: " + e.getMessage());
      goToPage(CR_ANSWERS_INFO, "An error was received while contacting the server.  The error message was:  " + e.getMessage(), session, request, response);
    }
    catch (ApplicationException e)
    {
      log("setAnswers(): Caught ApplicationException: " + e.getMessage());
      goToPage(CR_ANSWERS_INFO, "An error was received while updating the challenge/response answers.  The error message was:  " + e.getMessage(), session, request, response);
    }

    log("setAnswers() end");
  }

  private Map<String, String> validateSubmittedAnswers(HttpServletRequest request, HttpServletResponse response, HttpSession session)
    throws ServletException, IOException
  {
    boolean error = false;
    Map submittedCars = new HashMap();
    Map displayedCars = (Map)session.getAttribute("challengesAndResponses");

    Iterator it = displayedCars.keySet().iterator();
    while (it.hasNext()) {
      String challenge = (String)it.next();
      log("validateSubmittedAnswers(): validating challenge: " + challenge);

      String answer = request.getParameter(challenge + "Answer");
	  System.out.println("answer : " + answer);
      String confirmedAnswer = request.getParameter(challenge + "ConfirmAnswer");
	  System.out.println("confirmedAnswer : " + confirmedAnswer);
      boolean isEmptyResponse = (isNullOrEmpty(answer)) && (isNullOrEmpty(confirmedAnswer));
      if (!isEmptyResponse) {
        if (answer.equals(confirmedAnswer)) {
          submittedCars.put(challenge, answer);
        } else {
          log("\tInvalid answer");
          error = true;
          submittedCars.put(challenge, "");
        }
      }

    }

    if (error) {
      goToPage(CR_ANSWERS, "One or more of the answers did not match the confirmed answer, or the answer was not provided.  You must provide an answer and confirmation of the answer for each challenge.", session, request, response);

      return null;
    }
    session.setAttribute("challengesAndResponses", submittedCars);

    return submittedCars;
  }

  private void getChallengesAndResponses(HttpServletRequest request, HttpServletResponse response, HttpSession session)
    throws ServletException, IOException
  {
    log("getChallengesAndResponses() begin");

    Subject subject = (Subject)session.getAttribute(SUBJECT);
    PlatformContext platform = (PlatformContext)session.getAttribute(PLATFORM_CONTEXT);

    if (!validateSessionData(session, request, response, subject, platform)) {
      return;
    }

    Map carsToDisplay = null;
    try {
      ChallengeResponseManager crm = new ChallengeResponseManager(platform, subject);

      session.setAttribute("ChallengeResponseManager", crm);

      ChallengesAndResponses cars = crm.getChallengesAndResponses();
      session.setAttribute("timChallengesAndResponses", cars);

      carsToDisplay = getChallengesAndResponsesToDisplay(request, response, session, crm, cars);

      if ((carsToDisplay != null) && (!carsToDisplay.isEmpty())) {
        session.setAttribute("challengesAndResponses", carsToDisplay);
		log("sdsdsdsdsdsdsdsdsds");
		setAnswers(request, response, session);
        //goToPage(CR_ANSWERS, null, session, request, response);
      }
	  else{
		  String question = request.getParameter("question");
		  System.out.println("question is :" + question);
          carsToDisplay.put(question, "");
		  session.setAttribute("challengesAndResponses", carsToDisplay);
		  setAnswers(request, response, session);
	  }
    }
    catch (ApplicationException e)
    {
      log("getChallenges(): Caught ApplicationException: " + e.getMessage());

      goToPage(MAIN, e.getMessage(), session, request, response);
    }
    catch (RemoteException e)
    {
      log("getChallenges(): Caught RemoteException: " + e.getMessage());
      goToPage(MAIN, e.getMessage(), session, request, response);
    }

    log("getChallengesAndResponses() complete");
  }

  private Map getChallengesAndResponsesToDisplay(HttpServletRequest request, HttpServletResponse response, HttpSession session, ChallengeResponseManager crm, ChallengesAndResponses cars)
    throws ServletException, IOException
  {
    ChallengeResponseConfiguration crc = null;
    Locale locale = null;
    try
    {
      ExpiUtil expiUtilObj = ExpiUtil.getInstance();
      String language = expiUtilObj.getProperty("language");
      String country = expiUtilObj.getProperty("country");
      if ((language != null) && (country != null))
        locale = new Locale(language, country);
      else if (language != null) {
        locale = new Locale(language);
      }
      crc = crm.getChallengeResonseConfiguration(locale);

      if (!crc.isChallengeResponseEnabled()) {
        log("getChallengesAndResponsesToDisplay(): Challenge Response is not enabled");
        goToPage(CR_ANSWERS_INFO, "You cannot use the \"Change Challenge/Response Answers\" feature because the challenge response feature is disabled in enrole application", session, request, response);

        return null;
      }
	   /*
      if (crc.areChallengesUserDefined()) {
        log("getChallengesAndResponsesToDisplay(): Not in admin defined mode");
        goToPage(CR_ANSWERS_INFO, "You cannot use the \"Change Challenge/Response Answers\" feature because the challenge definition mode is \"USER-DEFINED\".  The sample code only supports the \"ADMIN-DEFINED\" challenge definition mode.", session, request, response);

        return null;
      }*/

      Collection adminChallenges = crc.getAdminDefinedChallenges();
      if (locale != null)
      {
        Collection adminChallengesDefLocale = crm.getChallengeResonseConfiguration(null).getAdminDefinedChallenges();

        if (adminChallenges != null) {
          if (adminChallengesDefLocale != null)
            adminChallenges.addAll(adminChallengesDefLocale);
        }
        else {
          adminChallenges = adminChallengesDefLocale;
        }
      }
		/*
      if ((adminChallenges == null) || (adminChallenges.isEmpty())) {
        log("getChallengesAndResponsesToDisplay(): No admin challenges defined");
        goToPage(CR_ANSWERS_INFO, "You cannot use the \"Change Challenge/Response Answers\" feature at this time. The sample code only supports configuring challenge/response answers when the challenges are defined by an Administrator, however, there are no Administrator defined challenges at this time.", session, request, response);

        return null;
      }*/

      Collection userChallenges = cars.getChallenges();
      if ((userChallenges == null) || (userChallenges.isEmpty())) {
        log("getChallengesAndResponsesToDisplay(): user doesn't have challenges defined");
        return collectionToMap(adminChallenges);
      }

      Map carsToDisplay = new HashMap();
      Iterator it = adminChallenges.iterator();
      while (it.hasNext()) {
        String challenge = (String)it.next();
        if (userChallenges.contains(challenge))
          carsToDisplay.put(challenge, "********");
        else {
          carsToDisplay.put(challenge, "");
        }
      }
      return carsToDisplay;
    }
    catch (RemoteException e) {
      log("getChallengesAndResponsesToDisplay(): Caught RemoteException: " + e.getMessage());

      return null;
    } catch (ApplicationException e) {
      log("getChallengesAndResponsesToDisplay(): Caught ApplicationException: " + e.getMessage());

      return null;
    } catch (Exception e) {
      log("getChallengesAndResponsesToDisplay(): Caught Exception: " + e.getMessage());
    }
    return null;
  }

  private Map collectionToMap(Collection<String> c)
  {
    if (c == null) {
      return new HashMap();
    }

    Map map = new HashMap(c.size());

    for (String str : c) {
      map.put(str, "");
    }

    return map;
  }

  private void goToPage(String page, String errorMessage, HttpSession session, HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {
    session.setAttribute(ERROR_MESSAGE, errorMessage);

    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/" + page);

    dispatcher.forward(request, response);
  }

  private void goToInfoPage(String page, String infoMessage, HttpSession session, HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException
  {
    session.setAttribute("infoMessage", infoMessage);

    RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/" + page);

    dispatcher.forward(request, response);
  }

  private boolean isNullOrEmpty(Object o)
  {
    return (o == null) || (o.equals(""));
  }

  private boolean validateSessionData(HttpSession session, HttpServletRequest request, HttpServletResponse response, Subject subject, PlatformContext platform)
    throws ServletException, IOException
  {
    log("ChangeChallengeResponseServlet.validateSessionData()");

    boolean isValid = true;

    if ((subject == null) || (platform == null)) {
      goToPage(LOGON, "Your session is invalid, please login again.", session, request, response);

      isValid = false;
    }

    return isValid;
  }

  private void removeOldChallenges(ChallengeResponseManager crm, Map submittedCars, ChallengesAndResponses carsToSet)
    throws RemoteException, ApplicationException
  {
    ChallengesAndResponses origCars = crm.getChallengesAndResponses();

    Iterator it = origCars.getChallenges().iterator();
    while (it.hasNext()) {
      String challenge = (String)it.next();
      if (!submittedCars.containsKey(challenge)) {
        log("setAnswers(): removing challenge: " + challenge);
        carsToSet.removeChallengeResponse(challenge);
      }
    }
  }

  private void updateNewOrModifiedChallenges(Map submittedCars, ChallengesAndResponses carsToSet)
    throws RemoteException, ApplicationException
  {
    Iterator it = submittedCars.keySet().iterator();
    while (it.hasNext()) {
      String challenge = (String)it.next();
      String response = (String)submittedCars.get(challenge);
	  log("response  " + response);
      if (!response.equals("********")) {
        log("setAnswers(): updating challenge: " + challenge);
        carsToSet.modifyChallengeResponse(challenge, response);
      }
    }
  }
}