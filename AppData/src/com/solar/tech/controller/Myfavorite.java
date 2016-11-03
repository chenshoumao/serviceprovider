package com.solar.tech.controller;

import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonEncoding;
import com.fasterxml.jackson.core.JsonFactory;
import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ArrayNode;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.solar.tech.dao.MyfavoriteDao;

@Controller
@RequestMapping("/myfavorite")
public class Myfavorite {
	
	@Autowired
	private MyfavoriteDao dao;
	
	
	/**
	 * 
	 * @param imageName
	 * @param myName
	 * @param url
	 * @return
	 * 添加收藏夹
	 */
	@RequestMapping("/add")
	@ResponseBody
	public Map<String, Object> add(String imageName,String myName,String url){
		Map<String, Object> map; 
		map = this.dao.add(imageName,myName,url); 
		return map;
	}
	
	/**
	 * 
	 * @return
	 */
	@RequestMapping("/read")
	@ResponseBody
	public List<Map<String, Object>> add(String uid){
		List<Map<String, Object>> list; 
		list = this.dao.read(); 
		return list;
	}
	
	@RequestMapping("/remove")
	@ResponseBody
	public Map<String, Object> remove(String myName){
		Map<String, Object> map;
		map = this.dao.remove(myName);
  
		return map;
	}
	
	@RequestMapping("/edit")
	@ResponseBody
	public Map<String, Object> edit(String imageName,String myName,String url){
		Map<String, Object> map;
		 
		map = this.dao.edit(imageName,myName,url);
		 
  
		return map;
	}
	
	public static void main(String[] args) throws IOException {
		ResourceBundle resource = ResourceBundle.getBundle("Path");
		ObjectMapper mapper = new ObjectMapper();
		System.out.println(resource.getString("url"));
		File jsonFile = new File(resource.getString("url"), "TestJson.json");  
		ObjectNode rootNode = null;
		if(jsonFile.exists()){
			rootNode = (ObjectNode) mapper.readTree(jsonFile);
		}
		else{
			 rootNode = mapper.createObjectNode();
		}
		    
		 
		//rootNode.put("ANumberField1Key2221", 2222);
		
		  ObjectNode node = mapper.createObjectNode();  
		    
		         node.put("nodeA", 1);  
		        node.put("nodeB", 2);  
		        node.put("nodeC",3); 
		
		
		        rootNode.set("1", node);
		 JsonFactory jsonFactory = new JsonFactory();  
		 JsonGenerator jsonGenerator = jsonFactory.createGenerator(  
		         jsonFile, JsonEncoding.UTF8);  
		mapper.writeTree(jsonGenerator, rootNode); 
	//	File jsonFile = new File(System.getProperty("java.io.tmpdir"), "TestJson.json"); 
//		String content = 
//				IOUtils.toString(new URL("http://localhost:8080/AppData/leader1.json").openStream(),"utf-8"); 
//		 
//		//List<Collect> listNow = new ArrayList<Collect>();
//		if(content!=null&&content!=""){
//			listNow = JSONFile.getJavaCollection(new Collect(),content);
//		}
//		File jsonFile = new File(System.getProperty("java.io.tmpdir"), "TestJson.json");  
//		ObjectMapper mapper = new ObjectMapper();  
//		 ObjectNode rootNode = mapper.createObjectNode();  
//		 rootNode.put("ANumberFieldKey", 123456);  
//		 ArrayNode pkgArrayNode = rootNode.putArray("AArrayFieldKey");  
//		  
//		 // save file  
//		 JsonFactory jsonFactory = new JsonFactory();  
//		 JsonGenerator jsonGenerator = jsonFactory.createGenerator(  
//		         jsonFile, JsonEncoding.UTF8);  
//		 mapper.writeTree(jsonGenerator, rootNode);  
		
	}
}
