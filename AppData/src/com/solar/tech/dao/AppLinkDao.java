package com.solar.tech.dao;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.solar.tech.bean.UserInfo;
 

/**
 * 
 * @author ibmchenshoumao 应用链接的Dao层
 */
@Controller
@RequestMapping
public class AppLinkDao {

	public List getAccount(String username) throws MalformedURLException {
		ResourceBundle resource = ResourceBundle.getBundle("Path");
		String WebServiceURL = resource.getString("webServiceURL");
		StringBuffer sb = new StringBuffer();
		String url = WebServiceURL + "?eruid=" + username;
		System.out.println("Data Request URL:" + url);
		URL haveURL;
		List list = new ArrayList();
		try {
			haveURL = new URL(url); 
			URLConnection yc = haveURL.openConnection();
			BufferedReader in = new BufferedReader(new InputStreamReader(yc.getInputStream(), "UTF-8"));
			String inputLine = null; 
			while ((inputLine = in.readLine()) != null) {
				sb.append(inputLine);
			} 
			in.close();
			
			ObjectMapper mapper = new ObjectMapper();  
			Map<String, Object> map = mapper.readValue(sb.toString(), HashMap.class);
			String accountStr = map.get("service").toString();
			 
			 
			accountStr = accountStr.substring(1, sb.length()-1);
		 
			String[] str = accountStr.split(",");
			
			for(int i = 0;i <str.length;i++){
				list.add(str[i]);
			}
			
			
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
		return list;
	}
	
//	public static void main(String[] args) {
//		String json = "{\"service\":[\"1111\",\"教育系统\",\"北斗基础定位服务系统\",\"规划管理系统\",\"ITIM Service\"]}";
//		//String json = "{\"service\":[\"aa\",\"2222\"]}";
//		ObjectMapper mapper = new ObjectMapper();  
//		try {
//			Map<String, Object> map = mapper.readValue(json.toString(), HashMap.class);
//			System.out.println(map.get("service"));
//			String sb = map.get("service").toString();
//			 
//			sb = sb.substring(1, sb.length()-1);
//			System.out.println(sb);
//			List str = sb.split(",");
//			System.out.println(str[0]);
//			
//			//System.out.println(list.get(0) + ", " + list.get(1));
//		} catch (JsonParseException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		} catch (JsonMappingException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}  
//	}
}








