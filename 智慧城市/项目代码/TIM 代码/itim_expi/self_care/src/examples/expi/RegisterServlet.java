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
 * This servlet contains methods that control the self registration
 * process for the Servlet Portfolio Example.
 *
 * The user must provide a set of attributes that are considered mandatory
 * for the self registration process.  The attributes used are imbedded in the
 * selfregister.jsp.  This example shows the method of using variables directly in the
 * JSP. This contrasts to the method used in the selfCareServlet which uses the
 * <b>itim_expi.properties<b> file to define and autoconfigure the input table.
 *
 * One the user provides the necessary data, it is validated and if it
 * appears correct, the ITIM APIs are used to create the Person object.
 * Note:Account provisioning must be configured for at least the ITIM Accounts for
 * the samples to function correctly and allow the user to logon after
 * creating an account. In additional, TAM accounts can be provisioned to allow
 * control of Applications to which the user may subscribe. (Please refer to the
 * ITIM documentation for Provisioning information).
 *
 ********************************************************************/
package examples.expi;

import java.io.IOException;
import java.io.PrintWriter;
import java.rmi.RemoteException;
import java.util.Enumeration;
 
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ibm.itim.apps.ApplicationException;
import com.ibm.itim.apps.SchemaViolationException;
import com.ibm.itim.apps.identity.SelfRegistrationManager;
import com.ibm.itim.common.AttributeValue;
import com.ibm.itim.common.AttributeValues;
import com.ibm.itim.dataservices.model.domain.Person;
import com.ibm.json.java.JSONObject;

import java.io.BufferedReader; 

import java.io.InputStreamReader;   
import java.util.ArrayList;  
 
import java.util.HashMap;
import java.util.Iterator;  
import java.util.List;   
import java.util.Map.Entry;   

import org.apache.http.HttpResponse;  
import org.apache.http.NameValuePair;  
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;   
import org.apache.http.client.methods.HttpPost;    
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair; 



/**
 * @version 1.0
 * @author Vitek Boruvka
 * 
 * registerServlet: This servlet works in conjuction with the selfRegister.jsp
 * that provides a subset of data for self-registering a user into ITIM.
 * 
 */
public class RegisterServlet extends HttpServlet {

	private static final long serialVersionUID = 434307275461082381L;

	/**
	 * @see javax.servlet.http.HttpServlet#void
	 *      (javax.servlet.http.HttpServletRequest,
	 *      javax.servlet.http.HttpServletResponse)
	 */
	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TBD if anything
		System.out.println("doGet method");
		doPost(req,resp);
	}
	
	public static String httpClientPost(String urlParam, Map<String, Object> params, String charset) {  
        StringBuffer resultBuffer = null;  
        HttpClient client = new DefaultHttpClient();  
        HttpPost httpPost = new HttpPost(urlParam);  
        // 构建请求参数  
        List<NameValuePair> list = new ArrayList<NameValuePair>();  
        Iterator<Entry<String, Object>> iterator = params.entrySet().iterator();  
        while (iterator.hasNext()) {  
            Entry<String, Object> elem = iterator.next();  
            list.add(new BasicNameValuePair(elem.getKey(), String.valueOf(elem.getValue())));  
        }  
        BufferedReader br = null;  
        try {  
            if (list.size() > 0) {  
                UrlEncodedFormEntity entity = new UrlEncodedFormEntity(list, charset);  
                httpPost.setEntity(entity);  
            }  
            HttpResponse response = client.execute(httpPost);  
            // 读取服务器响应数据  
            resultBuffer = new StringBuffer();  
            br = new BufferedReader(new InputStreamReader(response.getEntity().getContent()));  
            String temp;  
            while ((temp = br.readLine()) != null) {  
                resultBuffer.append(temp);  
            }  
        } catch (Exception e) {  
            throw new RuntimeException(e);  
        } finally {  
            if (br != null) {  
                try {  
                    br.close();  
                } catch (IOException e) {  
                    br = null;  
                    throw new RuntimeException(e);  
                }  
            }  
        }  
        return resultBuffer.toString();  
    }  
  

	/**
	 * Self registers a user using the external ITIM API
	 * SelfRegistrationManager.createPerson(). Minor validatation is carried out
	 * to for passwords (attribute=ersharedsecret). If the validation passes the
	 * added to a Person object as AttributeValues. The Person object is used as
	 * the input to the createPerson method on the SelfRegistrationManager.
	 * 
	 * @param req
	 *            Provides access to the form data parametes (data fields).
	 * @exception ServletException
	 * @exception IOException
	 */
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		JSONObject json = new JSONObject(); 
		PrintWriter out = resp.getWriter();
		System.out.println("this is doPost method");
		// check for the attributes and values - we check for the minimum
		// attributes only
		// blank attributes are NOT used in the create Person API (and are left
		// as empty implicitly)

		log("registerServlet:doPost()");

		ExpiUtil utilObject = new ExpiUtil();

		// check if we found a properties file

		if (!utilObject.isProperties()) {
			//ExpiUtil.forward(req, resp,
			//		"Could not initialize: Property file missing?",
			//		ExpiUtil.LOGON_SERVLET);
			json.put("state", false);
			out.print(json); 
			out.flush();
			out.close();
			return;
		}

		// Initialize utilObject's internal data structures.
		utilObject.createClientContext(req);

		String errmsg = validateData(req);
		if (errmsg != null && !errmsg.equals("")) {
			if(utilObject.platform != null) {
				utilObject.platform.close();
				utilObject.platform = null;
			}
			//ExpiUtil.forward(req, resp, errmsg, utilObject
			//		.getProperty(ExpiUtil.SELFREGISTRATION_PAGE));
			json.put("state", false);
			out.print(json); 
			out.flush();
			out.close();
			return;
		}

		log("gatherPersonAttributes()");

		Person person = gatherPersonAttributes(utilObject, req);

		SelfRegistrationManager regManager = new SelfRegistrationManager(
				utilObject.platform);
		
		try {
			log("regManager.createPerson()");

			// create the person in the respective tenant ID (as set in the
			// properties file)
			regManager.createPerson(person);

			log("registerServlet:doPost() - completing - redirecting");
			//resp.sendRedirect(req.getContextPath() + utilObject
			//		.getProperty(ExpiUtil.SELFREGISTRATIONSUB_PAGE));
			json.put("state", true);
			
			//设置新注册用户的密保的问题
			String uid = req.getParameter("uid");
			System.out.println(uid);
			String urlParam = "http://10.161.2.68:9080/Answer/UserInfo/updateChallengAnswer.action";
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("eruid",uid);
			String result = httpClientPost(urlParam, params, "UTF-8");
			System.out.println(result);
			
			out.print(json); 
			out.flush();
			out.close();
		} catch (RemoteException e) {
			e.printStackTrace();
			//ExpiUtil.forward(req, resp,
			//		"Error: Failed on Remote createPerson", utilObject
			//				.getProperty(ExpiUtil.SELFREGISTRATION_PAGE));
			json.put("state", false);
			out.print(json); 
			out.flush();
			out.close();
		} catch (SchemaViolationException e) {
			e.printStackTrace();
			//ExpiUtil.forward(req, resp, "Error: SchemaViolationException",
			//		utilObject.getProperty(ExpiUtil.SELFREGISTRATION_PAGE));
			json.put("state", false);
			out.print(json); 
			out.flush();
			out.close();
		} catch (ApplicationException e) {
			e.printStackTrace();
			//ExpiUtil.forward(req, resp, "Error: ApplicationException",
			//		utilObject.getProperty(ExpiUtil.SELFREGISTRATION_PAGE));
			json.put("state", false);
			out.print(json); 
			out.flush();
			out.close();
		} finally {
			if(utilObject.platform != null) {
				utilObject.platform.close();
				utilObject.platform = null;
			}
		}
	}

	/**
	 * Method validateData. Checks the password and email addresses of the
	 * attributes. This method attempts to hanle minimal validation chores. That
	 * is left to the JSP (which is potentially more accessible to the client).
	 * 
	 * @param req
	 *            Request
	 * @return String Returns an empty string if no errors are found, otherwise
	 *         it contains the error message.
	 */
	private String validateData(HttpServletRequest req) {
		String errmsg = "";

		// check the email address for appropriate characters and format
		String mail = req.getParameter("mail");

		log("validateData: email " + mail);
		if (mail == null)
			errmsg += "Email address must be supplied.<br>";
		else {
			int index = mail.indexOf("@");

			log("index: " + index);
			if (index > 0) {
				int pindex = mail.indexOf(".", index);

				if (!((pindex > index + 1) && (mail.length() > pindex + 1))) {
					errmsg += "Email address is in an invalid format.<br>";
				}
			} else {
				errmsg += "An invalid Email address was supplied.<br>";
			}
		}

		return errmsg;
	}

	/**
	 * Method gatherPersonAttributes. Extracts the form data from the request
	 * (req), creates a Person object with the specified attributes. Note:
	 * special case. A second password attribute is extracted from the attribute
	 * set and discarded. It is mainly used to double check the supplied
	 * password so the user is aware of what they had typed.
	 * 
	 * @param req
	 * @return Person
	 */
	private Person gatherPersonAttributes(ExpiUtil utilObject,
			HttpServletRequest req) {
		AttributeValues attrs = new AttributeValues();

		Enumeration _enum = req.getParameterNames();

		while (_enum.hasMoreElements()) {
			String element = (String) _enum.nextElement();

			// strip out the redundant password attribute - it is not part of
			// the
			// attributes that will be added to the person object.

			if (element.equalsIgnoreCase(ExpiUtil.ITIM_PASSWORD2))
				continue;

			log("EXPI: " + element + ": " + req.getParameter(element));
			attrs.put(new AttributeValue(element, req.getParameter(element)));
		}

		// one last attribute to add..."ou" or default organization unit for the
		// person.
		// This value represents where in the tree the user will be created.

		String locationAttrName = utilObject
				.getProperty(ExpiUtil.SELF_REG_LOCATION_ATTR);

		// if a location attribute was not configured, default to 'l'
		if (locationAttrName == null) {
			locationAttrName = "l";
		}

		String locationName = utilObject
				.getProperty(ExpiUtil.SELF_REG_LOCATION);

		// if the locationName is not specified...default to "selfregisterhere"
		// NOTE: This Location object MUST exist in the ITIM organization before
		// the registration process will function correctly.

		if (locationName == null) {
			locationName = "selfregisterhere";
		}

		log("EXPI: selfreg location (" + locationAttrName + ") " + locationName);

		// set the location attribute that ITIM expects...

		attrs.put(new AttributeValue(locationAttrName, locationName));

		// set the required attributes for creating a person
		Person person = new Person(ExpiUtil.PERSON_DEFAULT_PROFILE);
		person.setAttributes(attrs);

		return person;
	}
}
