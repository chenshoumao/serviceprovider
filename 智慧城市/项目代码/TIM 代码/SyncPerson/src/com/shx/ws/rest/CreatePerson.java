package com.shx.ws.rest;

import java.io.IOException;
import java.io.StringReader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.GET;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.xml.datatype.DatatypeConfigurationException;
import javax.xml.datatype.DatatypeFactory;
import javax.xml.datatype.XMLGregorianCalendar;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;
import org.xml.sax.InputSource;

import com.ibm.itim.ws.model.WSAttribute;
import com.ibm.itim.ws.model.WSOrganizationalContainer;
import com.ibm.itim.ws.model.WSPerson;
import com.ibm.itim.ws.model.WSRequest;
import com.ibm.itim.ws.model.WSService;
import com.ibm.itim.ws.model.WSSession;
import com.ibm.itim.ws.services.ArrayOfTns1WSAttribute;
import com.ibm.itim.ws.services.ArrayOfXsdString;
import com.ibm.itim.ws.services.WSAccountService;
import com.ibm.itim.ws.services.WSAccountServiceService;
import com.ibm.itim.ws.services.WSApplicationException;
import com.ibm.itim.ws.services.WSInvalidSessionException;
import com.ibm.itim.ws.services.WSLoginServiceException;
import com.ibm.itim.ws.services.WSOrganizationalContainerService;
import com.ibm.itim.ws.services.WSOrganizationalContainerServiceService;
import com.ibm.itim.ws.services.WSPersonService;
import com.ibm.itim.ws.services.WSPersonServiceService;
import com.ibm.itim.ws.services.WSServiceService;
import com.ibm.itim.ws.services.WSServiceServiceService;
import com.ibm.itim.ws.services.WSSessionService;
import com.ibm.itim.ws.services.WSSessionService_Service;
import com.shx.ws.rest.Person;

@Path(value="/create")
public class CreatePerson {
	boolean ispersonexist =true;
	
    @POST
	@Produces("application/xml")
	@Path(value="/addpreson")
		public String dispathAction( String ixml){	
    	System.out.println("csmcsmcsmcsmcsmcsmcsmcsmcsmcsmcsmcs");
    	System.out.println(ixml);
    	Document pdoc = loadXML(ixml);
    	Element root = pdoc.getRootElement(); 
    	List<Element>  items= root.getChildren("ITEM");
    	String result="";   String c="";String m=""; String s="";String r="";	
    	for(int i=0;i<items.size();i++ ){
    		Element item=items.get(i);
    		System.out.println(i+":   "+ixml);
    		Person p=new Person();
    		System.out.println(item.getChildText("ID"));
	    	p.setId(item.getChildText("ID"));
	    	p.setCode(item.getChildText("CODE"));
	    	p.setCompanycode(item.getChildText("COMPANYCODE"));
	    	p.setCompanyname(item.getChildText("COMPANYNAME"));
	    	p.setName(item.getChildText("NAME"));
	    	p.setUnitcode(item.getChildText("UNITCODE"));
	    	p.setUnitname(item.getChildText("UNITNAME"));
	    	p.setPost(item.getChildText("POST"));
	    	p.setStatus(item.getChildText("STATUS"));	
	    	
	    	 if(item.getChildText("STATUS").equals("1")){ 
	    		 System.out.println("createUser");
	    		  c= createUser(p );	
	    		  result=result+c;
	    	 }
	    	 if(item.getChildText("STATUS").equals("2")){ 
	    		// if(getisPerson(p)){
	    		//	 m= modify(p );
	    		// }else{
	    			 m= createUser(p );
	    		// }
	    		  
	    		  result=result+m;
	    		 System.out.println("modify");
	    	 }
	    	 if(item.getChildText("STATUS").equals("3")) { 
	    		 if(getisPerson(p)){
	    			 s=Suspend( p );
	    		 }else{
	    			 s= createUser(p );
	    		 }
	    		  
	    		  result=result+s;
	    		 System.out.println("Suspend");
	    	 }
	    	 if(item.getChildText("STATUS").equals("4")){ 
	    		 
                 if(getisPerson(p)){
                	 r=restore( p );
	    		 }else{
	    			 r= createUser(p );
	    		 }
	    		  
	    		  result=result+r;
	    		 System.out.println("restore");
	    	 }
	    	 
	    	p=null;
	    	
    	}

    	 c=null; m=null;  s=null; r=null;
    	return "<result>"+result+"</result>";

		}

	

	public CreatePerson() {
		super();
		// TODO Auto-generated constructor stub
	}


	public String createUser(Person p){

		  WSSession session=session();
		  
		  WSPersonServiceService pss = new WSPersonServiceService();
		  WSPersonService  ps=pss.getWSPersonService();		    		   		 
		  WSOrganizationalContainerServiceService container = new WSOrganizationalContainerServiceService();
		  WSOrganizationalContainerService containerService=container.getWSOrganizationalContainerService();		    
		  String containerProfile = "Organization";
		 // String containerName = "shccig"; Organization
		  String containerName = "Organization";
		  System.out.println("change");
			List <WSOrganizationalContainer> wsContainers = new ArrayList();
		try {
			wsContainers = containerService.searchContainerByName(session, null,containerProfile, containerName);
		} catch (WSApplicationException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (WSLoginServiceException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println("createUser  b"); 
		String result=null;
		if (wsContainers != null && wsContainers.size() > 0) {
			System.out.println("Found " + wsContainers.size() + " containers for " + containerName);
			WSOrganizationalContainer parentContainer = wsContainers.get(0);
			// Create a person value object.
			WSPerson wsPerson = new WSPerson();			
			Collection attrList = new ArrayList();			
			wsPerson.setProfileName("Person"); 
			
			WSAttribute uid = new WSAttribute();
			ArrayOfXsdString arrUidStringValues = new ArrayOfXsdString();
			arrUidStringValues.getItem().addAll(Arrays.asList((String) p.getCode()));
			uid.setName("uid");uid.setOperation(0);uid.setValues(arrUidStringValues);			
			attrList.add(uid); uid=null;arrUidStringValues=null;
			
			WSAttribute cn = new WSAttribute();
			ArrayOfXsdString arrCnStringValues = new ArrayOfXsdString();
			arrCnStringValues.getItem().addAll(Arrays.asList((String) p.getName()));
			cn.setName("cn");cn.setOperation(0); cn.setValues(arrCnStringValues);
			attrList.add(cn);cn=null;arrCnStringValues=null;
			
			WSAttribute sn = new WSAttribute();		
			ArrayOfXsdString arrSnStringValues = new ArrayOfXsdString();
			arrSnStringValues.getItem().addAll(Arrays.asList((String) p.getName()));
			sn.setName("sn");sn.setOperation(0);sn.setValues(arrSnStringValues);
			attrList.add(sn);sn=null;arrSnStringValues=null;	
			
			WSAttribute given = new WSAttribute();		
			ArrayOfXsdString arrGivenStringValues = new ArrayOfXsdString();
			arrGivenStringValues.getItem().addAll(Arrays.asList((String) p.getCode()));
			given.setName("givenname");given.setOperation(0);given.setValues(arrGivenStringValues);
			attrList.add(given);given=null;arrGivenStringValues=null;	
			
			
			WSAttribute emp = new WSAttribute();		
			ArrayOfXsdString arrEmpStringValues = new ArrayOfXsdString();
			arrEmpStringValues.getItem().addAll(Arrays.asList((String) p.getCode()));
			emp.setName("employeenumber");emp.setOperation(0);emp.setValues(arrEmpStringValues);
			attrList.add(emp);emp=null;arrEmpStringValues=null;	
			
						
			WSAttribute sdn = new WSAttribute();		
			ArrayOfXsdString arrSdnStringValues = new ArrayOfXsdString();
			arrSdnStringValues.getItem().addAll(Arrays.asList((String) p.getCompanycode()));
			sdn.setName("internationalisdnnumber");sdn.setOperation(0);sdn.setValues(arrSdnStringValues);
			attrList.add(sdn);sdn=null;arrSdnStringValues=null;
			
			WSAttribute o = new WSAttribute();		
			ArrayOfXsdString arrOStringValues = new ArrayOfXsdString();
			arrOStringValues.getItem().addAll(Arrays.asList((String) p.getCompanyname()));
			o.setName("o");o.setOperation(0);o.setValues(arrOStringValues);
			attrList.add(o);o=null;arrOStringValues=null;
			
			
			WSAttribute depart = new WSAttribute();		
			ArrayOfXsdString arrDepartStringValues = new ArrayOfXsdString();
			arrDepartStringValues.getItem().addAll(Arrays.asList((String) p.getUnitcode()));
			depart.setName("departmentnumber");depart.setOperation(0);depart.setValues(arrDepartStringValues);
			attrList.add(depart);depart=null;arrDepartStringValues=null;
			
			WSAttribute ou = new WSAttribute();		
			ArrayOfXsdString arrOuStringValues = new ArrayOfXsdString();
			arrOuStringValues.getItem().addAll(Arrays.asList((String) p.getUnitname()));
			ou.setName("ou");ou.setOperation(0);ou.setValues(arrOuStringValues);
			attrList.add(ou);ou=null;arrOuStringValues=null;
			
			WSAttribute title = new WSAttribute();		
			ArrayOfXsdString arrTitleStringValues = new ArrayOfXsdString();
			arrTitleStringValues.getItem().addAll(Arrays.asList((String) p.getPost()));
			title.setName("title");title.setOperation(0);title.setValues(arrTitleStringValues);
			attrList.add(title);title=null;arrTitleStringValues=null;	
																														
			// Add any more attrs to the Collection attrList, and set attributes on person object.
			ArrayOfTns1WSAttribute attrs = new ArrayOfTns1WSAttribute();
			attrs.getItem().addAll(attrList);			
			wsPerson.setAttributes(attrs);   			
			XMLGregorianCalendar date=  getDate();		
			WSRequest request = null;
			
			try {
				request = ps.createPerson(session, parentContainer, wsPerson, date);				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				result="<item><id>"+p.getId()+"</id><state>F</state><message></message><type>9</type></item>";
				e.printStackTrace();
			}
			System.out.println("Submitted person create request id = " + request.getRequestId());
			} else {
			System.out.println("No container found matching " + containerName);		  		     		     
	}
		result="<item><id>"+p.getId()+"</id><state>S</state><message></message><type>9</type></item>";
		return result;
  }
	  
	  
	  
  
	  public String   modify(Person p){
		// This example assumes that wsAttributes contains the modified attributes of a person.
		     WSSession session=session();
			 WSPersonServiceService pss = new WSPersonServiceService();
		     WSPersonService  ps=pss.getWSPersonService();
		     System.out.println("modify  b");
		     String result=null;
		     List<WSAttribute> lstWSAttributes = new ArrayList<WSAttribute>();	
		     
				WSAttribute cn = new WSAttribute();
				ArrayOfXsdString arrCnStringValues = new ArrayOfXsdString();
				arrCnStringValues.getItem().addAll(Arrays.asList((String) p.getName()));
				cn.setName("cn");cn.setOperation(0); cn.setValues(arrCnStringValues);
				lstWSAttributes.add(cn);cn=null;arrCnStringValues=null;
				
				WSAttribute sn = new WSAttribute();		
				ArrayOfXsdString arrSnStringValues = new ArrayOfXsdString();
				arrSnStringValues.getItem().addAll(Arrays.asList((String) p.getName()));
				sn.setName("sn");sn.setOperation(0);sn.setValues(arrSnStringValues);
				lstWSAttributes.add(sn);sn=null;arrSnStringValues=null;	
				
				WSAttribute given = new WSAttribute();		
				ArrayOfXsdString arrGivenStringValues = new ArrayOfXsdString();
				arrGivenStringValues.getItem().addAll(Arrays.asList((String) p.getCode()));
				given.setName("givenname");given.setOperation(0);given.setValues(arrGivenStringValues);
				lstWSAttributes.add(given);given=null;arrGivenStringValues=null;	
				
				
				WSAttribute emp = new WSAttribute();		
				ArrayOfXsdString arrEmpStringValues = new ArrayOfXsdString();
				arrEmpStringValues.getItem().addAll(Arrays.asList((String) p.getCode()));
				emp.setName("employeenumber");emp.setOperation(0);emp.setValues(arrEmpStringValues);
				lstWSAttributes.add(emp);emp=null;arrEmpStringValues=null;	
				
							
				WSAttribute sdn = new WSAttribute();		
				ArrayOfXsdString arrSdnStringValues = new ArrayOfXsdString();
				arrSdnStringValues.getItem().addAll(Arrays.asList((String) p.getCompanycode()));
				sdn.setName("internationalisdnnumber");sdn.setOperation(0);sdn.setValues(arrSdnStringValues);
				lstWSAttributes.add(sdn);sdn=null;arrSdnStringValues=null;
				
				WSAttribute o = new WSAttribute();		
				ArrayOfXsdString arrOStringValues = new ArrayOfXsdString();
				arrOStringValues.getItem().addAll(Arrays.asList((String) p.getCompanyname()));
				o.setName("o");o.setOperation(0);o.setValues(arrOStringValues);
				lstWSAttributes.add(o);o=null;arrOStringValues=null;
				
				
				WSAttribute depart = new WSAttribute();		
				ArrayOfXsdString arrDepartStringValues = new ArrayOfXsdString();
				arrDepartStringValues.getItem().addAll(Arrays.asList((String) p.getUnitcode()));
				depart.setName("departmentnumber");depart.setOperation(0);depart.setValues(arrDepartStringValues);
				lstWSAttributes.add(depart);depart=null;arrDepartStringValues=null;
				
				WSAttribute ou = new WSAttribute();		
				ArrayOfXsdString arrOuStringValues = new ArrayOfXsdString();
				arrOuStringValues.getItem().addAll(Arrays.asList((String) p.getUnitname()));
				ou.setName("ou");ou.setOperation(0);ou.setValues(arrOuStringValues);
				lstWSAttributes.add(ou);ou=null;arrOuStringValues=null;
				
				WSAttribute title = new WSAttribute();		
				ArrayOfXsdString arrTitleStringValues = new ArrayOfXsdString();
				arrTitleStringValues.getItem().addAll(Arrays.asList((String) p.getPost()));
				title.setName("title");title.setOperation(0);title.setValues(arrTitleStringValues);
				lstWSAttributes.add(title);title=null;arrTitleStringValues=null;
								
			    XMLGregorianCalendar date=  getDate();
		        String personDN = getPerson(p).getItimDN(); // This should be set to the DN of the person to be modified.			  
		        WSRequest request = null;
		       try {
		      	request = ps.modifyPerson(session, personDN, lstWSAttributes, date);
		        } catch (Exception e) {
			// TODO Auto-generated catch block
			   result="<item><id>"+p.getId()+"</id><state>F</state><message></message><type>9</type></item>";
		    	e.printStackTrace();
		        } 
		       System.out.println("Request id of modify person request is : " +request.getRequestId());
		 
		        result="<item><id>"+p.getId()+"</id><state>S</state><message></message><type>9</type></item>";
		        return result;
	  }

	  
	  public String  Suspend(Person p){
		// The personDN is assumed to contain the DN of the person to be suspended. Assumes that
		// a previous search or other operation was made to search for the person to be suspended.
		     WSSession session=session();
			 WSPersonServiceService pss = new WSPersonServiceService();
		     WSPersonService  ps=pss.getWSPersonService();
             String result =null;
		     XMLGregorianCalendar date=  getDate();
		     System.out.println("Suspend b");
		String personDN= getPerson(p).getItimDN(); 
		WSRequest request =null;
		
		try {
			
			request = ps.suspendPersonAdvanced(session, personDN, true, date);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			result="<item><id>"+p.getId()+"</id><state>F</state><message></message><type>9</type></item>";
			e.printStackTrace();
		} 
		 System.out.println("Submitted person create request id = " + request.getRequestId()); 
		 
		result="<item><id>"+p.getId()+"</id><state>S</state><message></message><type>9</type></item>";
		return result;
	  }
	  
	  
 
	  public String  restore(Person p){
		// The personDN is assumed to contain the DN of the person to be suspended. Assumes that
		// a previous search or other operation was made to search for the person to be suspended.
		     WSSession session=session();
			 WSPersonServiceService pss = new WSPersonServiceService();
		     WSPersonService  ps=pss.getWSPersonService();		                
		     XMLGregorianCalendar date=  getDate();
		     System.out.println("restore b");
		     String result=null;

		String personDN = getPerson(p).getItimDN(); 
		WSRequest request = null;
		try {
			request = ps.restorePerson(session, personDN, true, null, date);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			result="<item><id>"+p.getId()+"</id><state>F</state><message></message><type>9</type></item>";
			e.printStackTrace();
		} 
		
		 System.out.println("Submitted person create request id = " + request.getRequestId()); 
		 
		result="<item><id>"+p.getId()+"</id><state>S</state><message></message><type>9</type></item>";
		return result;
	  }	 
	  public WSSession  session(){
			
		  WSSessionService_Service service = new WSSessionService_Service();	
	      WSSessionService port = service.getWSSessionServicePort();
	      
	      WSSession session = null;

		     try {
				session = port.login("itim manager", "admin123");		
					
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} 	
		  		  
			 return session; 
		  }	
	  public  XMLGregorianCalendar getDate(){
		     long d=new Date().getTime();
				//XMLGregorianCalendar date = Utils.long2Gregorian(new Date().getTime());
				DatatypeFactory dataTypeFactory = null;
				try {
					dataTypeFactory = DatatypeFactory.newInstance();
				} catch (DatatypeConfigurationException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				GregorianCalendar gc = new GregorianCalendar();
				gc.setTimeInMillis(d);
		  
		  return dataTypeFactory.newXMLGregorianCalendar(gc);
	  }
	  
	  public WSPerson getPerson(Person p){
		  
		  WSPersonServiceService pss = new WSPersonServiceService();
		     WSPersonService  ps=pss.getWSPersonService();
		     WSSession session=session();
		     String filter = "(uid="+p.getCode()+")";
		     WSPerson person = null;
		    // String filter = "(uid=zhongfen)";
		     List<String> attrList = null; // Optional, supply an array of attribute		    
		     List<WSPerson> persons = null;
			try {
				
				persons = ps.searchPersonsFromRoot(session, filter, attrList);
				ispersonexist=true;
				
			} catch (Exception e1) {
				// TODO Auto-generated catch block
				ispersonexist=false;
				e1.printStackTrace();
			} 
		     if(persons==null) return person=null;
		     for (int i = 0; i < persons.size(); i++) {
		     person = persons.get(i);
		     System.out.println( "Name: " + person.getName() + ", dn: "+ person.getItimDN() );
		     }  
		  return person;
	  }
 public boolean getisPerson(Person p){
		  
		  WSPersonServiceService pss = new WSPersonServiceService();
		     WSPersonService  ps=pss.getWSPersonService();
		     WSSession session=session();
		     String filter = "(uid="+p.getCode()+")";
		    
		    // String filter = "(uid=zhongfen)";
		     List<String> attrList = null; // Optional, supply an array of attribute		    
		     List<WSPerson> persons = null;
			try {
				
				persons = ps.searchPersonsFromRoot(session, filter, attrList);
				if(persons.size() == 0)
					ispersonexist=false;
				else
					ispersonexist=true;
				
			} catch (Exception e1) {
				// TODO Auto-generated catch block
				ispersonexist=false;
				e1.printStackTrace();
			} 
		  return ispersonexist;
	  }
		public static Document loadXML(String xmlString)  {
			StringReader read = new StringReader(xmlString);
			InputSource source = new InputSource(read);
			SAXBuilder builder = new SAXBuilder();
			Document doc =null;
			try {
				doc = builder.build(source);
			} catch (JDOMException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return doc;
		}
		
		
		public void createAccount(String str) throws WSApplicationException, WSLoginServiceException{
			WSAccountServiceService WSAss= new WSAccountServiceService();
			WSAccountService  WSAs=WSAss.getWSAccountService();
			WSServiceServiceService WSsss= new WSServiceServiceService();
			WSServiceService  WSss= WSsss.getWSServiceService();
			List<WSService> services = WSss.searchServices(session(), null, "(erservicename=Linux linux64a GV)"); 
			WSService service = services.get(0); //service.getItimDN();
			
			WSPersonServiceService pss = new WSPersonServiceService();
		     WSPersonService  ps=pss.getWSPersonService();
		     WSSession session=session();
		     String filter = "(uid=12345678)";
		     WSPerson person = null;
		    // String filter = "(uid=zhongfen)";
		     List<String> attrList = null; // Optional, supply an array of attribute		    
		     List<WSPerson> persons = null;
			try {
				
				persons = ps.searchPersonsFromRoot(session, filter, attrList);
				ispersonexist=true;
				
			} catch (Exception e1) {
				// TODO Auto-generated catch block
				ispersonexist=false;
				e1.printStackTrace();
			} 
		     
		     for (int i = 0; i < persons.size(); i++) {
		     person = persons.get(i);
		     System.out.println( "Name: " + person.getName() + ", dn: "+ person.getItimDN() );
		     }  
			
			
			ArrayOfTns1WSAttribute wsAttr =person.getAttributes() ; // Set this to contain the account attributes
			// List<WSAttribute> lstWSAttributes = new ArrayList<WSAttribute>();	
			
			
			WSRequest request = WSAs.createAccount(session, service.getItimDN(),wsAttr.getItem(), getDate());
			
			
		}

	/*  public Map getAttrMap(){
		  Map attr=new HashMap();
		  attr.
		  attr.put("CODE", value);attr.put("", value);attr.put("", value);attr.put("", value);attr.put("", value);attr.put("", value);attr.put("", value);attr.put("", value);
		  return null;
	  }
*/
	  
}
