package com.shx.ws.service;

import java.io.IOException;
import java.io.StringReader;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.List;

import javax.ws.*;
import javax.xml.datatype.DatatypeConfigurationException;
import javax.xml.datatype.DatatypeFactory;
import javax.xml.datatype.XMLGregorianCalendar;

import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;
import org.xml.sax.InputSource;

import com.ibm.itim.ws.model.WSPerson;
import com.ibm.itim.ws.model.WSRequest;
import com.ibm.itim.ws.model.WSSession;
import com.ibm.itim.ws.services.WSApplicationException;
import com.ibm.itim.ws.services.WSLoginServiceException;
import com.ibm.itim.ws.services.WSPersonService;
import com.ibm.itim.ws.services.WSPersonServiceService;
import com.ibm.itim.ws.services.WSSessionService;
import com.ibm.itim.ws.services.WSSessionService_Service;
import com.shx.ws.rest.*;


public class SyncManage {
	
	
	 public String syncPerson(String ixml){ 
		 		 
		   CreatePerson cp= new CreatePerson();
		   // System.out.println(ixml);
	    	Document pdoc = CreatePerson.loadXML(ixml);
	    	Element root = pdoc.getRootElement(); 
	    	List<Element>  items= root.getChildren("ITEM");
	    	String result="";   String c="";String m=""; String s="";String r="";	
	    	for(int i=0;i<items.size();i++ ){
	    		Element item=items.get(i);
	    		//System.out.println(i+":   "+ixml);
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
		    		  c= cp.createUser(p );	
		    		  result=result+c;
		    	 }
		    	 if(item.getChildText("STATUS").equals("2")){ 
		    		  
		    		 if(cp.getisPerson(p)){
		    			 m= cp.modify(p );	
		    		 }else{
		    			 m= cp.createUser(p );
		    		 }
		    		  result=result+m;
		    		 System.out.println("modify");
		    	 }
		    	 if(item.getChildText("STATUS").equals("3")) { 
		    		 if(cp.getisPerson(p)){
		    			 s=cp.Suspend( p );	
		    		 }else{
		    			 s= cp.createUser(p );
		    		 }
		    		 
		    		  result=result+s;
		    		 System.out.println("Suspend");
		    	 }
		    	 if(item.getChildText("STATUS").equals("4")){ 
		    		  
		    		 if(cp.getisPerson(p)){
	                	 r=cp.restore( p );
		    		 }else{
		    			 r= cp.createUser(p );
		    		 }
		    		 
		    		
		    		  result=result+r;
		    		 System.out.println("restore");
		    	 }
		    	 
		    	p=null;
		    	
	    	}

	    	 c=null; m=null;  s=null; r=null;
	    	return "<result>"+result+"</result>"; 
	 }
	 
	 	 	 	 	 	 	 
}
