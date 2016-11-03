package com.solar.tech.dbutil;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.Reader;
import java.io.StringReader;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.regex.Matcher;
import java.util.regex.Pattern;
/**
 * 
 * @TaskManager.java
 * 鍔熻兘鎻忚堪锛�宸ュ叿绫�  鐢ㄦ潵 澶勭悊 瀛楃涓茬浉鍏崇殑 鎿嶄綔 
 * 鐗堟湰鍙凤細V1.1 浣滆�锛歺wj
 * 漏 Copyright 缁棩绉戞妧 2015-04-30  鐗堟潈鎵�湁 
 * 浣跨敤鑰呭繀椤荤粡杩囪鍙�
 * @author xwj
 *
 */
public class StringUtil {
	
	/**
	 * 校验字符串是否是大于0的数字
	 * @param string
	 * @return
	 */
	public static boolean isNum(String string){
		Pattern pattern = Pattern.compile("[1-9]{1}\\d*");
		Matcher matcher = pattern.matcher(string);
		return matcher.matches();
	}

	//浠庢祦涓緱鍒�瀛楃涓�  uif-8缂栫爜 
	public static String getStringFromStream(InputStream inStream) {
		BufferedReader buffReader=null;
		StringWriter sw=null;
		try {
			sw=new StringWriter();
			// 瀛楄妭娴佽浆鍖栨垚瀛楃娴佺殑鏃跺�璁剧疆 瀛楃娴佸緱缂栫爜鏍煎紡//
			buffReader = new BufferedReader(new InputStreamReader(inStream,"utf-8"));
			int length = -1;
			char[] buff = new char[1024];
			while ((length=buffReader.read(buff, 0, 1024)) != -1) {
				sw.write(buff, 0, length);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			try {
				if(inStream!=null)
					inStream.close();
				if(buffReader!=null)
					buffReader.close();
				if(inStream!=null)
					inStream.close();
				if(sw!=null)
					sw.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return sw.toString();
	}
	
	public static void putStringToFile(String str,String path){
		OutputStream out=null;
		BufferedWriter writer=null;
		StringReader read=null;
		try {
			out=new FileOutputStream(new File(path));
			writer=new BufferedWriter(new OutputStreamWriter(out,"utf-8"));
			read=new StringReader(str);
			int length = -1;
			char[] buff = new char[1024];
			while ((length=read.read(buff, 0, 1024)) != -1) {
				writer.write(buff, 0, length);
				writer.flush();
			}
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			try {
				if(read!=null)
					read.close();
				if(writer!=null)
					writer.close();
				if(out!=null)
					out.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
	
	//浠庢祦涓緱鍒�瀛楃涓�  uif-8缂栫爜 
	public static String getStringFromReader(Reader reader) {
		BufferedReader buffReader=null;
		StringWriter sw=null;
		try {
			sw=new StringWriter();
			buffReader = new BufferedReader(reader);
			int length = -1;
			char[] buff = new char[1024];
			while ((length=buffReader.read(buff, 0, 1024)) != -1) {
				sw.write(buff, 0, length);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			try {
				
				if(buffReader!=null)
					buffReader.close();
				if(sw!=null)
					sw.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return sw.toString();
	}
	
	
	//灏唈son瀛楃涓茶浆鎹㈡垚map绫诲瀷   鐢ㄤ簬鍓嶅彴椤甸潰灞曠ず
	public static Map<String,Object> parseJsonStringToMap(String jsonString) throws JSONException{
		Map<String,Object> result=new HashMap<String,Object>();
		JSONObject json=new JSONObject(jsonString);
		@SuppressWarnings("unchecked")
		Iterator<String> iter=(Iterator<String>)json.keys();
		while(iter.hasNext()){
			String key=iter.next();
			result.put(key, json.get(key).toString());
		}
		return result;
	}
	
	//java 灏唋ist<String>杞寲涓猴紝闅斿紑鐨剆tring
	 public static String listToString(List<String> stringList){
	        if (stringList==null) {
	            return null;
	        }
	        StringBuilder result=new StringBuilder();
	        boolean flag=false;
	        for (String string : stringList) {
	            if (flag) {
	                result.append(",");
	            }else {
	                flag=true;
	            }
	            result.append("a.data."+string);
	        }
	        return result.toString();
	    }
	 
	 
	 
	
}
