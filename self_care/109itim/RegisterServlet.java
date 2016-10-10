package examples.expi;

import com.ibm.itim.apps.ApplicationException;
import com.ibm.itim.apps.PlatformContext;
import com.ibm.itim.apps.SchemaViolationException;
import com.ibm.itim.apps.identity.SelfRegistrationManager;
import com.ibm.itim.common.AttributeValue;
import com.ibm.itim.common.AttributeValues;
import com.ibm.itim.dataservices.model.domain.Person;
import com.ibm.json.java.JSONObject;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.rmi.RemoteException;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;

public class RegisterServlet extends HttpServlet
{
  private static final long serialVersionUID = 434307275461082381L;

  public void doGet(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException
  {
    System.out.println("doGet method");
    doPost(req, resp);
  }

  public static String httpClientPost(String urlParam, Map<String, Object> params, String charset) {
    StringBuffer resultBuffer = null;
    HttpClient client = new DefaultHttpClient();
    HttpPost httpPost = new HttpPost(urlParam);

    List list = new ArrayList();
    Iterator iterator = params.entrySet().iterator();
    while (iterator.hasNext()) {
      Map.Entry elem = (Map.Entry)iterator.next();
      list.add(new BasicNameValuePair((String)elem.getKey(), String.valueOf(elem.getValue())));
    }
    BufferedReader br = null;
    try {
      if (list.size() > 0) {
        UrlEncodedFormEntity entity = new UrlEncodedFormEntity(list, charset);
        httpPost.setEntity(entity);
      }
      HttpResponse response = client.execute(httpPost);

      resultBuffer = new StringBuffer();
      br = new BufferedReader(new InputStreamReader(response.getEntity().getContent()));
      String temp;
      while ((temp = br.readLine()) != null)
        resultBuffer.append(temp);
    }
    catch (Exception e) {
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

  public void doPost(HttpServletRequest req, HttpServletResponse resp)
    throws ServletException, IOException
  {
    req.setCharacterEncoding("UTF-8");
    JSONObject json = new JSONObject();
    PrintWriter out = resp.getWriter();
    System.out.println("this is doPost method");

    log("registerServlet:doPost()");

    ExpiUtil utilObject = new ExpiUtil();

    if (!utilObject.isProperties())
    {
      json.put("state", Boolean.valueOf(false));
      out.print(json);
      out.flush();
      out.close();
      return;
    }

    utilObject.createClientContext(req);

    String errmsg = validateData(req);
    if ((errmsg != null) && (!errmsg.equals(""))) {
      if (utilObject.platform != null) {
        utilObject.platform.close();
        utilObject.platform = null;
      }

      json.put("state", Boolean.valueOf(false));
      out.print(json);
      out.flush();
      out.close();
      return;
    }

    log("gatherPersonAttributes()");

    Person person = gatherPersonAttributes(utilObject, req);

    SelfRegistrationManager regManager = new SelfRegistrationManager(utilObject.platform);
    try
    {
      log("regManager.createPerson()");

      regManager.createPerson(person);

      log("registerServlet:doPost() - completing - redirecting");

      json.put("state", Boolean.valueOf(true));

      out.print(json);
      out.flush();
      out.close();
    } catch (RemoteException e) {
      e.printStackTrace();

      json.put("state", Boolean.valueOf(false));
      out.print(json);
      out.flush();
      out.close();
    } catch (SchemaViolationException e) {
      e.printStackTrace();

      json.put("state", Boolean.valueOf(false));
      out.print(json);
      out.flush();
      out.close();
    } catch (ApplicationException e) {
      e.printStackTrace();

      json.put("state", Boolean.valueOf(false));
      out.print(json);
      out.flush();
      out.close();
    } finally {
      if (utilObject.platform != null) {
        utilObject.platform.close();
        utilObject.platform = null;
      }
    }
  }

  private String validateData(HttpServletRequest req)
  {
    String errmsg = "";

    String mail = req.getParameter("mail");

    log("validateData: email " + mail);
    if (mail == null) {
      errmsg = errmsg + "Email address must be supplied.<br>";
    } else {
      int index = mail.indexOf("@");

      log("index: " + index);
      if (index > 0) {
        int pindex = mail.indexOf(".", index);

        if ((pindex <= index + 1) || (mail.length() <= pindex + 1))
          errmsg = errmsg + "Email address is in an invalid format.<br>";
      }
      else {
        errmsg = errmsg + "An invalid Email address was supplied.<br>";
      }
    }

    return errmsg;
  }

  private Person gatherPersonAttributes(ExpiUtil utilObject, HttpServletRequest req)
  {
    AttributeValues attrs = new AttributeValues();

    Enumeration _enum = req.getParameterNames();

    while (_enum.hasMoreElements()) {
      String element = (String)_enum.nextElement();

      if (!element.equalsIgnoreCase("erpassword2"))
      {
        log("EXPI: " + element + ": " + req.getParameter(element));
        attrs.put(new AttributeValue(element, req.getParameter(element)));
      }

    }

    String locationAttrName = utilObject.getProperty("orgContainer.selfregister.location.attr");

    if (locationAttrName == null) {
      locationAttrName = "l";
    }

    String locationName = utilObject.getProperty("orgContainer.selfregister.location.org");

    if (locationName == null) {
      locationName = "selfregisterhere";
    }

    log("EXPI: selfreg location (" + locationAttrName + ") " + locationName);

    attrs.put(new AttributeValue(locationAttrName, locationName));

    Person person = new Person("Person");
    person.setAttributes(attrs);

    return person;
  }
}