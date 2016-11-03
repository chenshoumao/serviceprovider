package com.solar.tech.dao;

import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.ResourceBundle;

import com.solar.tech.util.*;
import com.solar.tech.bean.*;
import org.apache.commons.io.IOUtils;
import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;


public class JsonParse {


	public  Map<String, Object>  parseData(Integer page, Integer rows ) {
		JsonNode root= initConfig( );
		List<Count> ct = new ArrayList<Count>();
		List<ToDo> td = new ArrayList<ToDo>();
		Map<String, Object> dataResult = new HashMap<String, Object>();
		 Iterator<String> keys = root.fieldNames();       
	        while(keys.hasNext()){  
	            String fieldName = keys.next();  
	            JsonNode chlidNode = root.path(fieldName);
	            
	  	      Map<String,String> sysmap=new HashMap<String,String>();
		      Map<String,String> countmap=new HashMap<String,String>(); 
		      Map<String,String> todomap=new HashMap<String,String>(); 
		      sysmap.put("EnName", chlidNode.path("EnName").asText());
		      sysmap.put("CnName", chlidNode.path("CnName").asText());
		      //String sysUrl=chlidNode.path("sysUrl").asText();
		     // String jsonroot=chlidNode.path("jsonroot").asText();
		      String  jsondata =chlidNode.path("jsondata").asText();
		      JsonNode countNode = chlidNode.path("countmap");
		      countmap.put("sysCount", countNode.path("sysCount").asText());
		      countmap.put("sysListUrl", countNode.path("sysListUrl").asText());
		      JsonNode todoNode = chlidNode.path("todomap"); 
		      
		      todomap.put("Title", todoNode.path("Title").asText());
		      todomap.put("receiveTime", todoNode.path("receiveTime").asText());
		      todomap.put("PendingName", todoNode.path("PendingName").asText());
		      todomap.put("todoUrl", todoNode.path("todoUrl").asText());
		      //parse remote  application  json
		       try{
				ObjectMapper mapper = new ObjectMapper();				
		        String sysUrl =chlidNode.path("sysUrl").asText(); 
		        //System.out.println(IOUtils.toString(new URL(sysUrl).openStream()));
		        String sysjson = IOUtils.toString(new URL(sysUrl).openStream(),"UTF-8"); 			
				JsonNode sysroot = mapper.readTree(sysjson);				
				JsonNode jsonrootNode = sysroot.path(chlidNode.path("jsonroot").asText());
				SysName sn=getMapSysName(jsonrootNode ,sysmap );//键
				getMapCount(jsonrootNode, countmap, sn, ct);
				JsonNode  datanode= getChildTree(jsonrootNode,jsondata);
				getMapToDo(datanode, todomap,sn,  td);
				 //List Sort
				listSort(td);
				//Pagination
		        Pagination pagiation=new Pagination(td, rows);
		        List sublist = pagiation.getObjects(page);
		       // System.out.println(pagiation.getTotalPages());
		        int totalPages=pagiation.getTotalPages();				
				
				dataResult.put("todo", sublist);
				dataResult.put("count", ct);
				dataResult.put("total", totalPages);
				} catch (JsonGenerationException e) {
					e.printStackTrace();
				} catch (JsonMappingException e) {
					e.printStackTrace();
				} catch (IOException e) {
					e.printStackTrace();
				}
				

	        } 		 
		return dataResult;
	}
	 
	
	public  JsonNode  initConfig( ) {
		JsonNode root=null;
		try{
		ObjectMapper mapper = new ObjectMapper();
		ResourceBundle bundle = ResourceBundle.getBundle("url", new Locale(""));
		String url1 = bundle.getString("url");
		System.out.println(url1);
//        String url1 = "http://localhost:8085/AppData/config.json"; 
        //System.out.println(IOUtils.toString(new URL(url1).openStream())); 
        String json = IOUtils.toString(new URL(url1).openStream(),"utf-8"); 
        System.out.println(json);
	    root = mapper.readTree(json);//mapper.writeValueAsString(arg0);
	     
		} catch (JsonGenerationException e) {
			e.printStackTrace();
		} catch (JsonMappingException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return root;
    }
	
	
		public  SysName getMapSysName(JsonNode jn ,Map map ) {
			SysName sn= new SysName();
			sn.setEnName((String)map.get("EnName"));
			sn.setCnName((String)map.get("CnName"));
			return sn;
	}
	
		public  List<ToDo> getMapToDo(JsonNode jn, Map map,SysName sn, List<ToDo> td) {
			if (jn.isArray()) {
								
				for (JsonNode node : jn) {
					ToDo todo=new ToDo();
					todo.setEnName(sn.getEnName());
					todo.setCnName(sn.getCnName());
					todo.setTitle(node.path((String)map.get("Title")).asText());
					todo.setPendingName(node.path((String)map.get("receiveTime")).asText());
					todo.setReceiveTime(node.path((String)map.get("PendingName")).asText());
					todo.setTodoUrl(node.path((String)map.get("todoUrl")).asText());
					td.add(todo);
				}
			}
			        
		return td;	
	}
		public List<Count> getMapCount(JsonNode jn, Map map,SysName sn, List<Count> ct) {
			Count c= new Count();
            c.setEnName(sn.getEnName());
            c.setCnName(sn.getCnName());
            c.setSysCount(jn.path((String)map.get("sysCount")).asText());
            c.setSysListUrl(jn.path((String)map.get("sysListUrl")).asText());
			ct.add(c);
			return ct;
	}		
		public  JsonNode getChildTree(JsonNode jn,String data) {
			if (jn==null)return null;
			JsonNode chlidNode =null;
			 Iterator<String> keys = jn.fieldNames(); 	
		        while(keys.hasNext()){  
		            String fieldName = keys.next();  
		        	 chlidNode = jn.path(fieldName);
		           if(fieldName.equals(data)||chlidNode.isArray() ) return chlidNode;  
		        }  
			return getChildTree(chlidNode,data);
	}	

		
		
		
		public void listSort(List list){	
        Collections.sort(list,new Comparator<ToDo>(){  
            public int compare(ToDo arg0, ToDo arg1) {  
                 
                	int i=	arg0.getReceiveTime().compareTo(arg1.getReceiveTime());  
                	if(i==0){
                		int j=	arg0.getPendingName().compareTo(arg1.getPendingName());
                        return j;
                	}
                		return i;
            }  
        }); 
		}
}
