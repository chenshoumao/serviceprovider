package com.solar.tech.dao;

import java.util.*;
import java.util.Map.Entry;


public class jsonTest {

	

    /** 
     * 动态提取解析成Map集合中的数据 
     * @param map 
     */  
    public void parseMap(Map map){  
        Set entrySet = map.entrySet();  
        Iterator<Entry<String, Object>> it = entrySet.iterator();  
        //最外层提取  
        while(it.hasNext()){  
            Entry<String, Object> e = it.next();  
            //内层提取  
            if(e.getValue() instanceof List){  
                List list = (List)e.getValue();  
                for (int i = 0; i < list.size(); i++) {  
                    System.out.println(list.get(i));  
                    //如何还有，循环提取  
                    parseMap((Map)list.get(i));  
                }  
            }  
            System.out.println("Key 值："+e.getKey()+"     Value 值："+e.getValue());  
        }  
    }
    
    /** 
     * JSON 类型的字符串转换成 Map 集合 
     * @param jsonStr 
     * @return 
     */  
    public Map parseJSON(){  
        Map map = new HashMap();  
        //字符串转换成JSON对象  
   
        //最外层JSON解析  
      
        return map;  
    }  
      
   
    
    
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
