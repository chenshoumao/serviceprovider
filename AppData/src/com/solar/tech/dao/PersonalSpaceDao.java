package com.solar.tech.dao;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.springframework.stereotype.Repository;

import com.ibm.json.java.JSONObject;
import com.solar.tech.bean.UserInfo;

@Repository
public class PersonalSpaceDao {
	public Map<String, Object> searchPeople(String curPage,UserInfo userInfo) {
		Map<String, Object> resultMap = new HashMap<String, Object>();//返回集合
		List<UserInfo> list = new ArrayList<UserInfo>();
		Map<String, Object> map = new HashMap<String, Object>();
		//System.out.println(name + "1111111111111111");
		map.put("uid", userInfo.getName());
		map.put("mobile", userInfo.getMobile());
		map.put("mail", userInfo.getMail());
		if (null == curPage || curPage.equals("")) {
			map.put("curPage", "1");
		} else {
			map.put("curPage", curPage);
		}
		map.put("pageSize", "5");
		System.out.print(map);
		String result = getInfos(map);
		JSONObject js;
		try {
			js = JSONObject.parse(result);
			Object o_total = js.get("total");
			Integer totalRecord = Integer.valueOf(o_total.toString());
			Integer totalPage = totalRecord % 5 == 0 ? totalRecord / 5
					: totalRecord / 5 + 1;
			resultMap.put("totalPage", totalPage);
			List lists = (List) js.get("result");
			String s_uid = "";
			String s_homePhone = "";
			String s_mobile = "";
			String s_postalCode = "";
			String s_mail = "";
			String s_address = "";
			String s_staffNumber = "";
			String s_department = "";
			String s_duty = "";
			String s_title = "";

			for (int i = 0; i < lists.size(); i++) {
				UserInfo user = new UserInfo();
				JSONObject ob = (JSONObject) lists.get(i);
				Object o_uid = ob.get("uid");
				Object o_homePhone = ob.get("homePhone");
				Object o_mobile = ob.get("mobile");
				Object o_postalCode = ob.get("postalCode");
				Object o_mail = ob.get("mail");
				Object o_address = ob.get("address");
				Object o_staffNumber = ob.get("staffNumber");
				Object o_department = ob.get("department");
				Object o_duty = ob.get("duty");
				Object o_title = ob.get("title");
				if (null == o_uid || o_uid.toString().equals("")) {
					s_uid = "";
				} else {
					s_uid = o_uid.toString();
				}
				if (null == o_homePhone || o_homePhone.toString().equals("")) {
					s_homePhone = "";
				} else {
					s_homePhone = o_homePhone.toString();
				}
				if (null == o_mobile || o_mobile.toString().equals("")) {
					s_mobile = "";
				} else {
					s_mobile = o_mobile.toString();
				}
				if (null == o_postalCode || o_postalCode.toString().equals("")) {
					s_postalCode = "";
				} else {
					s_postalCode = o_postalCode.toString();
				}
				if (null == o_mail || o_mail.toString().equals("")) {
					s_mail = "";
				} else {
					s_mail = o_mail.toString();
				}
				if (null == o_address || o_address.toString().equals("")) {
					s_address = "";
				} else {
					s_address = o_address.toString();
				}
				if (null == o_staffNumber
						|| o_staffNumber.toString().equals("")) {
					s_staffNumber = "";
				} else {
					s_staffNumber = o_staffNumber.toString();
				}

				if (null == o_department || o_department.toString().equals("")) {
					s_department = "";
				} else {
					s_department = o_department.toString();
				}
				if (null == o_duty || o_duty.toString().equals("")) {
					s_duty = "";
				} else {
					s_duty = o_duty.toString();
				}
				if (null == o_title || o_title.toString().equals("")) {
					s_title = "";
				} else {
					s_title = o_title.toString();
				}
				user.setName(s_uid);
				user.setTel(s_homePhone);
				user.setMobile(s_mobile);
				user.setPostalCode(s_postalCode);
				user.setMail(s_mail);
				user.setAddress(s_address);
				user.setStaffNumber(s_staffNumber);
				user.setDepartment(s_department);
				user.setProfession(s_duty);
				user.setTitle(s_title);
				list.add(user);
			}
			resultMap.put("list", list);
		} catch (IOException e) {
			resultMap.put("state", "failed");
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		resultMap.put("state", "success"); 
		return resultMap;

	}
	
	public Map<String, Object> updateUser(UserInfo userInfo){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			
		
		String description = "...";
		String result = "";
		BufferedReader in = null;
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("uid", userInfo.getName());
		map.put("mail", userInfo.getMail());
		map.put("mobile", userInfo.getMobile());
		map.put("title", userInfo.getTitle());
		map.put("department", userInfo.getDepartment());
		map.put("homePhone", userInfo.getHomePhone());
		map.put("postalCode", userInfo.getPostalCode());
		map.put("address", userInfo.getAddress());
		map.put("staffNumber", userInfo.getStaffNumber());
		map.put("duty", userInfo.getProfession());
		map.put("imageUrl", userInfo.getImageUrl());
		upInfo(map);
		resultMap.put("state", "success");
		} catch (Exception e) {
			// TODO: handle exception
			resultMap.put("state", "failed");
		}
		return resultMap;
	}
	
	/**
	 * 
	 * @Description: 更新用户信息
	 * @param @param map
	 * @param @return   
	 * @return String  
	 * @throws
	 * @author 陈守貌
	 * @date 2016年10月31日
	 */
	public String upInfo(Map<String,Object> map) {
		String dataurl = "http://10.161.2.68:9080/Login/UserInfo/updateUser.action";
		try {
			String result = this.httpClientPost(dataurl, map, "UTF-8");
			System.out.println("更新状态………………………………………………………………………………………………………………………………………………………………………………………………………………………………"+result);
			return result;
		} catch (Exception e) {
			return "error";
		}
	}
	
	/**
	 * 获取这个用户的具体信息
	 */
	public UserInfo getInfo(UserInfo user) {
		String dataurl = "http://10.161.2.68:9080/Login/UserInfo/findByDn.action";
		Map<String, Object> map = new HashMap<String, Object>();
		if(user.getName() != null && user.getName() != ""){
			map.put("uid", user.getName());
		}
		System.out.println("参数map是……………………………………………………^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"+map);
		try {
			String result = this.httpClientPost(dataurl, map, "UTF-8");
			
			String array = result.substring(1, result.length()-1); 
			String object = array.substring(0, array.indexOf("}") + 1);
			JSONObject ob = JSONObject.parse(object);
			String s_uid="";
		       
			  
			   user.setName(ob.get("uid") == null ? "" : ob.get("uid").toString());
			   user.setHomePhone(ob.get("homePhone") == null? "":ob.get("homePhone").toString());
	    	   user.setMobile(ob.get("mobile") == null? "":ob.get("mobile").toString());
	    	   user.setPostalCode(ob.get("postalCode") == null? "":ob.get("postalCode").toString());
	    	   user.setMail(ob.get("mail") == null? "":ob.get("mail").toString());
	    	   user.setAddress(ob.get("address") == null?"" : ob.get("address").toString());
	    	   user.setStaffNumber(ob.get("staffNumber") == null?"":ob.get("staffNumber").toString());
	    	   user.setDepartment(ob.get("department") == null?"":ob.get("department").toString());
	    	   user.setProfession(ob.get("duty") == null ?"":ob.get("duty").toString());
	    	   user.setTitle(ob.get("title") == null?"":ob.get("title").toString());
	    	   user.setImageUrl(ob.get("imageUrl") == null?"":ob.get("imageUrl").toString());
			return user;
		} catch (Exception e) {
			return null;
		}
	}
	
	/**
	 * 
	 * @param map
	 * @return
	 * 查找所有的相关用户，即模糊搜索
	 */
	public String getInfos(Map<String, Object> map) {
		String dataurl = "http://10.161.2.68:9080/Login/UserInfo/search.action";
		 
		try {
			String result = this.httpClientPost(dataurl, map, "UTF-8");
			System.out
					.println("模糊查询结果………………………………………………………………………………………………………………………………………………………………………………………………………………………………"
							+ result);
			return result;
		} catch (Exception e) {
			return "error";
		}
	}

	public static String httpClientPost(String urlParam, Map<String, Object> params, String charset) {  
        StringBuffer resultBuffer = null;  
        HttpClient client = new DefaultHttpClient();  
        HttpPost httpPost = new HttpPost(urlParam);  
        // 构建请求参数  
        List<NameValuePair> list = new ArrayList<NameValuePair>();  
        Iterator<Entry<String, Object>> iterator = params.entrySet().iterator();  
        while (iterator.hasNext()) {  
            Entry<String, Object> elem = iterator.next();  
            list.add(new BasicNameValuePair(elem.getKey(), String.valueOf(elem.getValue())));  
        }  
        BufferedReader br = null;  
        try {  
            if (list.size() > 0) {  
                UrlEncodedFormEntity entity = new UrlEncodedFormEntity(list, charset);  
                httpPost.setEntity(entity);  
            }  
            HttpResponse response = client.execute(httpPost);  
            // 读取服务器响应数据  
            resultBuffer = new StringBuffer();  
            br = new BufferedReader(new InputStreamReader(response.getEntity().getContent()));  
            String temp;  
            while ((temp = br.readLine()) != null) {  
                resultBuffer.append(temp);  
            }  
        } catch (Exception e) {  
            throw new RuntimeException(e);  
        } finally {  
            if (br != null) {  
                try {  
                    br.close();  
                } catch (IOException e) {  
                    br = null;  
                    throw new RuntimeException(e);  
                }  
            }  
        }  
        System.out.println(resultBuffer.toString());
        return resultBuffer.toString();  
    }  
}
