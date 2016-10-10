/******************************************************************************
* Licensed Materials - Property of IBM
*
* (C) Copyright IBM Corp. 2005, 2012 All Rights Reserved.
*
* US Government Users Restricted Rights - Use, duplication, or
* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
*
*****************************************************************************/

/********************************************************************
 * FILE: %Z%%M%  %I%  %W% %G% %U%
 * 
 * This servlet contains an initialization method that must be executed
 * before the main.jsp page gains control.  Its responsibility is to check
 * if the TAM Service (as configured in the itim_expi.properties file) 
 * is active on the targetted ITIM Server.
 ********************************************************************/
package examples.expi;

import java.io.IOException;

import javax.security.auth.Subject;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ibm.itim.apps.PlatformContext;
import com.ibm.itim.apps.identity.PersonMO;
import com.ibm.itim.apps.provisioning.AccountMO;
import com.ibm.itim.dataservices.model.domain.Account;

public class MainServlet extends HttpServlet {
	private static final long serialVersionUID = -3467953916282518352L;
	private HttpSession session;
	private static ExpiUtil utilObject = null;
	private String LOGON_PAGE = "logon.jsp";

	/**
	 * Method init
	 * @see javax.servlet.GenericServlet#init()
	 */
	public void init() {
		log("mainServlet:init(): start");

		try {
			utilObject = new ExpiUtil();
		} catch (Exception e) {
			e.printStackTrace();
		}

		LOGON_PAGE = utilObject.getPropertySSOCheck(ExpiUtil.LOGON_PAGE);
		log("EXPI: mainServlet:init(): LOGON_PAGE = " + LOGON_PAGE);
		log("mainServlet:init(): end");
	}

	/**
	 * Method doGet
	 * Obtains the necessary attributes from the Request (user must be authenticated) and all the required
	 * data items provided in the session.  If all items are provided, the list of applications (TAM groups) is
	 * processed and control is forwarded to the applications.jsp page.  The jsp page builds a table of 
	 * Applications that the user may pick (select or un-select).
	 * 
	 * @see javax.servlet.http.HttpServlet#void (javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	*/
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
		throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");

		System.out.println("doGet(): start");

		session = req.getSession(false);
		if (session == null) {
			System.out.println("No session");
			// See if we got here via SSO throgh WebSEAL
			String userID = (String) req.getHeader("iv-user");
			if ( (userID != null) && (! userID.equals("")) ) {
				System.out.println("iv-user = " + userID);
				System.out.println("Forwarding to loginServlet.doPost()");
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(
						req.getContextPath() + "/jsp/unprotected/logon.jsp");
				dispatcher.forward(req, resp);
				
			} else {
				req.setAttribute("message", "The Session is no longer valid");
				resp.sendRedirect(req.getContextPath() + "/jsp/unprotected/logon.jsp");
			}
			return;
		}

		// do we have a valid subject to work with - this will be the case
		// if the logon was successful, otherwise not.

		if (!isSubjectAssigned(req, resp))
			return;

		HttpSession session = (HttpSession) req.getSession(false);
		if (session == null) {
			System.out.println(
				"EXPI: mainServlet:doGet() - no session - redirecting to logo page");
			resp.sendRedirect(req.getContextPath() + LOGON_PAGE);
		}

		Subject subject = (Subject) session.getAttribute(ExpiUtil.SUBJECT);

		if (subject == null) {
			System.out.println(
				"EXPI: mainServlet:doGet() - no subject - redirecting to logon page");
			resp.sendRedirect(req.getContextPath() + LOGON_PAGE);
			return;
		}

		PlatformContext platform =
			(PlatformContext) session.getAttribute(ExpiUtil.PLATFORM_CONTEXT);

		if (platform == null) {
			System.out.println(
				"EXPI: mainServlet:doGet() - no Platform Context object - redirecting to logon page");
			resp.sendRedirect(req.getContextPath() + LOGON_PAGE);
			return;
		}

		String userID = (String) session.getAttribute(ExpiUtil.LOGON_ID);
		if (userID == null) {
			System.out.println(
				"EXPI: mainServlet:doGet() - no userID found - redirecting to logon.jsp");
			resp.sendRedirect(req.getContextPath() + LOGON_PAGE);
			return;
		}

		PersonMO personMo = (PersonMO) session.getAttribute(ExpiUtil.PERSONMO);

		if (personMo == null) {
			System.out.println(
				"EXPI: mainServlet:doGet() - no PersonMO object found - redirecting to logon page");
			resp.sendRedirect(req.getContextPath() + LOGON_PAGE);
			return;
		}

		// load the Account information respective to the person
		String serviceDN = utilObject.getProperty(ExpiUtil.APP_SERVICE_DN);
		
		if (serviceDN == null || serviceDN.equals("")) {
			System.out.println(
				"EXPI: mainServlet:doGet() - TAM Service DN not specified in property file");
			session.setAttribute(ExpiUtil.TAM_SERVICE_ACTIVE, "false");
		}
		else {
			
			AccountMO acctMO =
				utilObject.lookupAccounts(
					platform,
					subject,
					personMo,
					utilObject.getProperty(ExpiUtil.APP_SERVICE_DN));
			Account account = utilObject.account;
	
			if (account != null) {
				System.out.println(
					"EXPI: mainServlet:doGet() - TAM Service is configured...forwarding to main.jsp");
	
				// save off the AccountMO and respective account for this service in order to reduce
				// processing in the doPost...
	
				session.setAttribute(ExpiUtil.ACCOUNTMO, acctMO);
				session.setAttribute(ExpiUtil.ACCOUNT, account);
				session.setAttribute(ExpiUtil.TAM_SERVICE_ACTIVE, "true");
			} else {
				System.out.println(
					"EXPI: mainServlet:doGet() - "
						+ utilObject.getProperty(ExpiUtil.APP_SERVICE_NAME)
						+ " is NOT configured...forwarding to main.jsp");
				session.setAttribute(ExpiUtil.TAM_SERVICE_ACTIVE, "false");
			}
		}

		// always forward to the Home page (main.jsp by default)
		
		//重置密码action = setAnswers
		String action = req.getParameter("action");
		System.out.println(action + ",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,");
		if(action.equals("updateAnswer")){
			System.out.println("mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");
			req.getRequestDispatcher("/ChangeChallengeResponseServlet").forward(req, resp);
		}
		else{
			System.out.println("nnnnnnnnnnnnnnnnnnnnnnnnnnnnnn");
		utilObject.forward(
			req,
			resp,
			"",
			utilObject.getProperty(ExpiUtil.HOME_PAGE));
		} 
	}
	

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

	/**
	 * Method isSubjectAssigned.
	 * Verifies if a Subject is provided in the request.
	 * @param req
	 * @param resp
	 * @return boolean - true if Subject was found, false otherwise
	 * @throws IOException
	 */
	private boolean isSubjectAssigned(
		HttpServletRequest req,
		HttpServletResponse resp)
		throws IOException {
		Subject subject = (Subject) session.getAttribute("subject");
		if (subject == null) {
			System.out.println("EXPI: mainServlet:isSubjectAssigned() Session is not valid (no subject).");

			session.invalidate();

			req.setAttribute("message", "The Session is no longer valid.");
			resp.sendRedirect(req.getContextPath() + LOGON_PAGE);
			return false;
		}
		return true;
	}
}
