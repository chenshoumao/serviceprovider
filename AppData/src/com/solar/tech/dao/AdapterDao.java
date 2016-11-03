package com.solar.tech.dao;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
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

import org.apache.commons.io.IOUtils;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.core.JsonFactory;
import com.fasterxml.jackson.core.JsonGenerationException;
import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.JsonNodeFactory;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.solar.tech.bean.Adapter;
 
import com.solar.tech.bean.Count;
import com.solar.tech.bean.SysName;
import com.solar.tech.bean.ToDo;
import com.solar.tech.controller.OAAdapter;
import com.solar.tech.util.Pagination;
@Repository
public class AdapterDao {
	
	public String getRootString() {
		   try{
				ObjectMapper mapper = new ObjectMapper();
				ResourceBundle bundle = ResourceBundle.getBundle("url", new Locale(""));
				String url1 = bundle.getString("url");
				System.out.println(url1);
//		        String url1 = "http://localhost:8085/AppData/config.json"; 
		        //System.out.println(IOUtils.toString(new URL(url1).openStream())); 
		        String json = IOUtils.toString(new URL(url1).openStream(),"utf-8"); 
		        System.out.println(json);
			   // root = mapper.readTree(json);//mapper.writeValueAsString(arg0);
			    return json;
				} catch (JsonGenerationException e) {
					e.printStackTrace();
					return "";
				} catch (JsonMappingException e) {
					e.printStackTrace();
					return "";
				} catch (IOException e) {
					e.printStackTrace();
					return "";
				}
	   }
	
	
 
	   public Map<String,Object> add(Adapter adapter) throws JsonProcessingException {
		   Map<String,Object> map = new HashMap<String,Object>();
		   String json = getRootString();
		   ObjectMapper mapper = new ObjectMapper();
		   ObjectNode roota = mapper.createObjectNode ();  
		    ObjectNode node = mapper.createObjectNode ();
		    ObjectNode node1 = mapper.createObjectNode ();  
		    ObjectNode node2 = mapper.createObjectNode ();  
		    ObjectNode node3 = mapper.createObjectNode ();  
		    node1.put ("EnName", adapter.getEnName());  
		    node1.put ("CnName", adapter.getCnName());
		    node1.put ("sysUrl",adapter.getSysUrl()); 
		    //node1.put ("sysUrl",sysUrl); 
		    node1.put ("jsonroot", "obj");
		    node1.put ("jsondata", "data");
		    
		    node2.put ("receiveTime",adapter.getReceiveTime());
		    node2.put ("PendingName",adapter.getPendingName());
		    node2.put ("todoUrl",adapter.getTodoUrl());
		    node2.put ("title",adapter.getTitle());
		    
		    node3.put("sysCount","count");
		    node3.put("sysListUrl","pageUrl");
		    node1.put("todomap", node2);
		    node1.put("countmap",node3);
		    node.put(adapter.getSystemName(), node1);
		    String str =  mapper.writeValueAsString(node);
		    str = str.substring(1, str.length());
		    str = str.substring(0, str.length()-1);
		    System.out.println(str); 
			int index = json.lastIndexOf("}");
			if(json.length() != 2){
			StringBuilder sb = new StringBuilder(json);
			json = sb.replace(index, sb.length(), ",").toString();
			json +=  str + "}";
			}
			 FileOutputStream fos = null;// 处理硬盘的低端，输出流
				OutputStreamWriter osw = null;// 处理内存的高端，输出，字符流
				try {
					fos = new FileOutputStream( "C:\\csm\\apache-tomcat-7.0.64\\webapps\\AppData\\config.json");
				
				osw = new OutputStreamWriter( fos );// 高端流绑定低端流
				osw.write(json);// 写数据
				
				osw.flush();// 清空流缓存
				map.put("result", "success");
				} catch (FileNotFoundException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					map.put("result", "failed");
				}catch (IOException e) {
					e.printStackTrace(); 
					map.put("result", "failed");
				} catch ( Exception e ) {
				e.printStackTrace();
				map.put("result", "failed");
				}finally {
					try {osw.close();} catch ( Exception e ) {e.printStackTrace();}
					try {fos.close();} catch ( Exception e ) {e.printStackTrace();}
					}
			 
			
			return map;
	   }



	public List show() {
		// TODO Auto-generated method stub
		ObjectMapper mapper = new ObjectMapper();
		List list = new ArrayList();
		
		String json = getRootString(); 
		JsonNode root;
		try {
			root = mapper.readTree(json);
			Iterator<String> keys = root.fieldNames();
			 while(keys.hasNext()){  
		            String fieldName = keys.next(); 
		            Map<String, Object> map= new HashMap<String, Object>();
		            JsonNode chlidNode = root.path(fieldName);
		            String sysUrl=chlidNode.path("sysUrl").asText();
		            map.put("sysName", fieldName);
		            map.put("sysUrl", sysUrl);
		            list.add(map);
			 }
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		 
		return list;
	}



	public Map<String, Object> detailInfo(String systemName) {
		// TODO Auto-generated method stub
		//Map<String, Object> map = new HashMap<String, Object>();
		Map<String,Object> sysmap=new HashMap<String,Object>();
	    Map<String,Object> countmap=new HashMap<String,Object>(); 
	    Map<String,Object> todomap=new HashMap<String,Object>(); 
		ObjectMapper mapper = new ObjectMapper();
		 
		String json = getRootString(); 
		JsonNode root;
		try {
			root = mapper.readTree(json);
			Iterator<String> keys = root.fieldNames();
			 while(keys.hasNext()){  
		            String fieldName = keys.next(); 
		            if(fieldName.equals(systemName)){
		            	JsonNode chlidNode = root.path(fieldName);
			            
		  	  	      
		  		      sysmap.put("EnName", chlidNode.path("EnName").asText());
		  		      sysmap.put("CnName", chlidNode.path("CnName").asText());
		  		      String sysUrl=chlidNode.path("sysUrl").asText();
		  		      String jsonroot=chlidNode.path("jsonroot").asText();
		  		      String  jsondata =chlidNode.path("jsondata").asText();
		  		      sysmap.put("sysUrl", sysUrl);
		  		      sysmap.put("jsonroot", jsonroot);
		  		      sysmap.put("jsondata",jsondata);
		  		      JsonNode countNode = chlidNode.path("countmap");
		  		      countmap.put("sysCount", countNode.path("sysCount").asText());
		  		      countmap.put("sysListUrl", countNode.path("sysListUrl").asText());
		  		      JsonNode todoNode = chlidNode.path("todomap"); 
		  		      
		  		      todomap.put("Title", todoNode.path("Title").asText());
		  		      todomap.put("receiveTime", todoNode.path("receiveTime").asText());
		  		      todomap.put("PendingName", todoNode.path("PendingName").asText());
		  		      todomap.put("todoUrl", todoNode.path("todoUrl").asText());
		  		      //parse remote  application  json
		  		      sysmap.put("todomap", todomap);
		  		      sysmap.put("countmap", countmap);
		            }
			 }
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		
		return sysmap;
	}



	public Map<String, Object> daibandaiyue(String sysName,String sysUrl) {
		// TODO Auto-generated method stub
		Map<String, Object> result = new HashMap<String, Object>();
		
		Map<String, Object> map = this.detailInfo(sysName);
		   
	     List<ToDo> list = new ArrayList<ToDo>();
	      Map<String,String> countmap=(Map<String, String>) map.get("countmap"); 
	      Map<String,String> todomap=(Map<String, String>) map.get("todomap"); 
		try{
			ObjectMapper mapper = new ObjectMapper();				
	    //    String sysUrl =chlidNode.path("sysUrl").asText(); 
	        //System.out.println(IOUtils.toString(new URL(sysUrl).openStream()));
	        String sysjson = IOUtils.toString(new URL(sysUrl).openStream(),"UTF-8");
	        
			JsonNode sysroot = mapper.readTree(sysjson);
			
			JsonNode jsonrootNode = sysroot.path(map.get("jsonroot").toString());
			SysName sn= new SysName();
			sn.setEnName((String)map.get("EnName"));
			sn.setCnName((String)map.get("CnName"));
			
			Count count = new Count();
			count.setCnName(sn.getCnName());
			count.setEnName(sn.getEnName());
			count.setSysCount(jsonrootNode.path(countmap.get("sysCount").toString()).asText());
			count.setSysListUrl(jsonrootNode.path(countmap.get("sysListUrl").toString()).asText());
			
			ToDo todo =  new ToDo();
			JsonNode jsonNode = getChildTree(jsonrootNode, map.get("jsondata").toString()); 
			
			getMapToDo(jsonNode, todomap,sn,  list);
			 //List Sort
			listSort(list);
			//Pagination
	       
			result.put("todo", list);
			result.put("count", count);
			result.put("total", list.size());
		    result.put("state", "success");
			} catch (JsonGenerationException e) {
				e.printStackTrace();
				result.put("state", "failed");
			} catch (JsonMappingException e) {
				e.printStackTrace();
				result.put("state", "failed");
			} catch (IOException e) {
				e.printStackTrace();
				result.put("state", "failed");
			}
		return result;
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
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
//	public Map<String , Object>	add(Adapter adapter){ 
//		Map<String,Object> map = new HashMap<String,Object>();
//		//创建一个节点工厂,为我们提供所有节点  
//        JsonNodeFactory factory = new JsonNodeFactory(false);  
//        //创建一个json factory来写tree modle为json  
//        JsonFactory jsonFactory = new JsonFactory();  
//        //创建一个json生成器  
//        JsonGenerator generator;
//		try {
//			generator = jsonFactory.createGenerator(new FileWriter(new File("D:\\"+element.getSystemName() + ".json"))); 
//        //注意，默认情况下对象映射器不会指定根节点，下面设根节点为country  
//        ObjectMapper mapper = new ObjectMapper(); 
//        ObjectNode root0 = factory.objectNode();  
//        ObjectNode root = factory.objectNode();  
//        root.put("systemEnName",element.getSystemEnName() );  
//        root.put("systemCnName", element.getSystemCnName()); 
//        root.put("count", element.getCount());  
//        root.put("pageUrl",element.getPageUrl()); 
//        ArrayNode data = factory.arrayNode();  
//        ObjectNode data1 = factory.objectNode();  
//        ObjectNode data2 = factory.objectNode();  
//        data1.put("title",element.getTitle().split(",")[0]);  
//        data1.put("receiveTime", element.getReceiveTime().split(",")[0]); 
//        data1.put("pendingName",element.getPendingName().split(",")[0]);  
//        data1.put("url", element.getUrl().split(",")[0]); 
//        data2.put("title",element.getTitle().split(",")[1]);  
//        data2.put("receiveTime", element.getReceiveTime().split(",")[1]); 
//        data2.put("pendingName",element.getPendingName().split(",")[1]);  
//        data2.put("url", element.getUrl().split(",")[1]); 
//        data.add(data1).add(data2);  
//        root.set("data", data); 
//        root0.put(element.getSystemName(), root);
//        mapper.configure(SerializationFeature.INDENT_OUTPUT, true); 
//		mapper.writeTree(generator, root0);
//		map.put("result", "success");
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//			map.put("result", "failed");
//		}  
//		return map;
//	}
	
	 
}
