package com.solar.tech.dao;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.solar.tech.bean.Img;
import com.solar.tech.bean.Pager;
import com.solar.tech.util.Constant;
import com.solar.tech.util.RandomNum;

@Repository
public class PictureDao {
	@Autowired
	private HttpServletRequest request;
	public Map<String, Object> show(String username){
		Map<String, Object> map = new HashMap<String, Object>(); //用来返回数据
		
		ResourceBundle resource = ResourceBundle.getBundle("admin");
		String json = resource.getString("admin");
		List<String> list = new ArrayList<String>();
		
		boolean admin = false;//是否是管理员.,wpsadmins 是管理员
		
		ObjectMapper mapper = new ObjectMapper();
		try {
			//此段代码是用来判断用户是否是管理员
			Map<String, Object> tree = mapper.readValue(json.toString(), HashMap.class);
			List<Object> list1 = (List<Object>) tree.get("portal1");
			for(int i = 0;i < list1.size();i++){
				Map<String, Object> listMap = (Map<String, Object>) list1.get(i);
				list.add(listMap.get("name").toString());
			}
			
			List<Object> list2 = (List<Object>) tree.get("portal2");
			for(int i = 0;i < list2.size();i++){
				Map<String, Object> listMap = (Map<String, Object>) list2.get(i);
				list.add(listMap.get("name").toString());
			}
			for(String str:list){
				if(str.contains(username)){
					admin = true;
					break;
				}
			} //判断完毕
			
			 String urlpath =  this.request.getServletContext().getRealPath("/config");
			 List<String> urlList = Constant.urlList(urlpath);//读取配置文件imageConfig.xml获取值
			 List<String> pathList =  testFileIsExit(urlList);
			 int pageNum = Constant.DEFAULT_PAGE_NUM; 
			 int pageSize = Constant.DEFAULT_PAGE_SIZE_FIRST;  
			//循环获取相册
			 Pager<Img> result = ReadFiles.photo(pathList,urlList,pageNum,pageSize); 
			 map.put("result", result);
			 map.put("isadmin", admin); 
		} catch (JsonParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JsonMappingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		return map;
	}
	
	/**
	 * 判断文件是否存在
	 */
	public List<String> testFileIsExit(List<String> urlList){
		 List<String> pathList = new ArrayList<String>();
		for(int i=0;i<urlList.size();i++){
			 String path = this.request.getServletContext().getRealPath(urlList.get(i));//上传图片路径
			 pathList.add(path);
			//判断上传upUrl该文件是否存在
			 File f1 = new File(path);
		        if (!f1.exists()) {
		            f1.mkdirs();
		        }
		 }
		return pathList;
	}

	public String remove(HttpServletRequest request2, String photo, String url) {
		// TODO Auto-generated method stub
		try { 
		 String PhotoPath = request.getServletContext().getRealPath(url+"/"+photo); // 转为物理路径  
	 	   File file  = new File(PhotoPath);
	 	  if (file.exists()) {//判断文件是否存在  
	 	     if (file.isFile()) {//判断是否是文件  
	 	      file.delete();//删除文件   
	 	     } else if (file.isDirectory()) {//否则如果它是一个目录  
	 	      File[] files = file.listFiles();//声明目录下所有的文件 files[];  
	 	      for (int i = 0;i < files.length;i ++) {//遍历目录下所有的文件  
//	 	       this.delete(files[i]);//把每个文件用这个方法进行迭代  
	 	    	 files[i].delete();
	 	      }  
	 	      file.delete();//删除文件夹  
	 	     }  
	 	     return "success";
	 	    } else {  
	 	     System.out.println("所删除的文件不存在");  
	 	     return "failed";
	 	    } 
		} catch (Exception e) {
			// TODO: handle exception
			 return "failed";
		}
	}

	public String edit(String photo, String nphoto, String url) {
		// TODO Auto-generated method stub
	 
		
		 String PhotoPath = request.getServletContext().getRealPath(url+"/"+photo); // 转为物理路径  
	 	   String PhotoPathn = request.getServletContext().getRealPath(url+"/"+nphoto);
	 	   File file  = new File(PhotoPath);
	 	   File f = null;
	       File f1 = null;
		      boolean bool = false;
			 try{      
				 f = new File(PhotoPath);
		         f1 = new File(PhotoPathn);
		         bool = f.renameTo(f1);
		         return "success";
		      }catch(Exception e){
		         e.printStackTrace();
		         return "failed";
		      }
		 
	}

	public Map<String, Object> add(MultipartFile file) {
		// TODO Auto-generated method stub
		Map<String,Object> map=new HashMap<String, Object>();
		System.out.println("开始");
        String description = ""; 
        HttpSession session = request.getSession(); 
        if(session!=null){
        	description = (String) session.getAttribute("description");
        }
       
        String savePath = request.getServletContext().getRealPath("");
        
        String urlpath = request.getServletContext().getRealPath("/config");//配置上传图片路径的配置文件路径
		String url = Constant.upUrl(urlpath);//读取配置文件imageConfig.xml获取值
		String path =request.getServletContext().getRealPath(url);//上传图片路径
		savePath = savePath + "/"+url+"/"+description+"/";
        File f1 = new File(savePath);
//        System.out.println(savePath);
        if (!f1.exists()) {
            f1.mkdirs();
        } 
        String name = file.getOriginalFilename();
        name = RandomNum.getRandomString(5) + name;
        File targetFile = null;
        do {
        	  targetFile = new File(savePath, name);
        } while (targetFile.exists()); 
       
//         保存   
        try {
            file.transferTo(targetFile);//上传 
            map.put("success", true);
            map.put("fileUrl", savePath+"\\"+name);//保存文件路径
            System.out.println(name);
        } catch (Exception e) { 
            e.printStackTrace();
            map.put("success", false);
            map.put("msg", e.getMessage());//保存错误信息
        }  
        map.put("fileName", name);//保存文件名
		return map;
	}
}	
