package com.solar.tech.dao;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;

import org.springframework.stereotype.Repository;

import com.fasterxml.jackson.core.JsonEncoding;
import com.fasterxml.jackson.core.JsonFactory;
import com.fasterxml.jackson.core.JsonGenerator;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;

@Repository
public class MyfavoriteDao {

	public Map<String, Object> add(String imageName, String myName, String url) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		String username = "TestJson";
		ResourceBundle resource = ResourceBundle.getBundle("Path");
		ObjectMapper mapper = new ObjectMapper();
		System.out.println(resource.getString("url"));
		try {
			File jsonFile = new File(resource.getString("url"), username + ".json");
			ObjectNode rootNode = null;
			if (jsonFile.exists()) {
				rootNode = (ObjectNode) mapper.readTree(jsonFile);
			} else {
				rootNode = mapper.createObjectNode();
			}

			// rootNode.put("ANumberField1Key2221", 2222);

			ObjectNode node = mapper.createObjectNode();

			node.put("imageName", imageName);
			node.put("url", url);

			rootNode.set(myName, node);
			JsonFactory jsonFactory = new JsonFactory();
			JsonGenerator jsonGenerator = jsonFactory.createGenerator(jsonFile, JsonEncoding.UTF8);
			map.put("result", "success");

			mapper.writeTree(jsonGenerator, rootNode);
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			map.put("result", "failed");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			map.put("result", "failed");
		}

		return map;
	}

	public Map<String, Object> remove(String myName) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		String username = "TestJson";
		try {
			ResourceBundle resource = ResourceBundle.getBundle("Path");
			ObjectMapper mapper = new ObjectMapper();
			System.out.println(resource.getString("url"));
			File jsonFile = new File(resource.getString("url"), username + ".json");
			ObjectNode rootNode = null;
			if (jsonFile.exists()) {
				rootNode = (ObjectNode) mapper.readTree(jsonFile);
			} else {
				rootNode = mapper.createObjectNode();
			}

			rootNode.remove(myName);

			JsonFactory jsonFactory = new JsonFactory();
			JsonGenerator jsonGenerator = jsonFactory.createGenerator(jsonFile, JsonEncoding.UTF8);

			mapper.writeTree(jsonGenerator, rootNode);
			map.put("result", "success");
		} catch (JsonProcessingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			map.put("result", "failed");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			map.put("result", "failed");
		}

		return map;
	}

	public Map<String, Object> edit(String imageName, String myName, String url) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		String username = "TestJson";
		ResourceBundle resource = ResourceBundle.getBundle("Path");
		ObjectMapper mapper = new ObjectMapper();
		try {
			System.out.println(resource.getString("url"));
			File jsonFile = new File(resource.getString("url"), username + ".json");
			ObjectNode rootNode = null;
			if (jsonFile.exists()) {
				rootNode = (ObjectNode) mapper.readTree(jsonFile);
			} else {
				rootNode = mapper.createObjectNode();
			}

			// rootNode.put("ANumberField1Key2221", 2222);

			ObjectNode node = mapper.createObjectNode();

			node.put("imageName", imageName);
			node.put("url", url);

			rootNode.set(myName, node);
			JsonFactory jsonFactory = new JsonFactory();
			JsonGenerator jsonGenerator;

			jsonGenerator = jsonFactory.createGenerator(jsonFile, JsonEncoding.UTF8);
			mapper.writeTree(jsonGenerator, rootNode);
			map.put("result", "success");
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			map.put("result", "failed");
		}

		return map;
	}

	public List<Map<String, Object>> read() {
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		
		
		String username = "TestJson";
		ResourceBundle resource = ResourceBundle.getBundle("Path");
		ObjectMapper mapper = new ObjectMapper();
		try {
			System.out.println(resource.getString("url"));
			File jsonFile = new File(resource.getString("url"), username + ".json");
			JsonNode rootNode = null;
			if (jsonFile.exists()) {
				rootNode =  mapper.readTree(jsonFile);
			} else { 
				return null;
			}

			Iterator<String> keys = rootNode.fieldNames();       
	        while(keys.hasNext()){  
	            String fieldName = keys.next();  
	          JsonNode chlidNode = rootNode.path(fieldName); 
	          Map<String, Object> map = new HashMap<String, Object>();
	         // Map<String, Object> data = new HashMap<String, Object>();
	          map.put("myName", fieldName);
	          map.put("imageName", chlidNode.path("imageName").asText());
	          map.put("url", chlidNode.path("url").asText());
	          list.add(map); 
	        }  
			 
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			 
		}

		return list;
		 
	}

}
