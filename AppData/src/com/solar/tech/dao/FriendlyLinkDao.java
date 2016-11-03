package com.solar.tech.dao;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;

import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.solar.tech.bean.Link;

/**
 * 友情链接Dao层
 * @author ibmchenshoumao
 *
 */
@Repository
public class FriendlyLinkDao {
	
	public Map<String, Object> getLink(String URL){
		//List list = new ArrayList<>();
		
		ResourceBundle resource = ResourceBundle.getBundle("Path");
		String LINKSURL = resource.getString("LINKSURL");
		String linksUrl = URL+LINKSURL;
		
		Map<String, Object> result = new HashMap<String, Object>();
		 
		
		try{
			 StringBuilder sb = new StringBuilder();   
		     URL oracle = new URL(linksUrl);
			    URLConnection yc = oracle.openConnection();
			    BufferedReader in = new BufferedReader(new InputStreamReader(yc.getInputStream(),"UTF-8")); 
			    String inputLine = null; 
			    while ( (inputLine = in.readLine()) != null){ 
			      sb.append(inputLine); 
			    } 
			    in.close();
			    
			    ObjectMapper mapper = new ObjectMapper();
			    ObjectNode rootNode = null;
			    Map<String, Object> map = mapper.readValue(sb.toString(), HashMap.class);
			    /*
			     * 注意:获取到的集合是map,map包含list,list还包含map,map包含list
			     */
			    Map<String, Object> obj = (Map<String, Object>) map.get("obj");
			    List<Map<String, Object>> data = ( List<Map<String, Object>>) obj.get("data");
			    for(int i = 0;i < data.size();i++){
			    	Map<String, Object> data1 = data.get(i);
			    	List<Link> links = (List<Link>) data1.get("links");
			    	String title = data1.get("title").toString(); 
			    	result.put(title,links);
			    } 
			    
		}catch(Exception e){
			e.printStackTrace();
		} 
		return result;
	}
}
