package com.solar.tech.dao;

 

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import com.solar.tech.bean.Img;
import com.solar.tech.bean.Pager;
//import java.io.UnsupportedEncodingException;
//import java.net.URLEncoder;
//import java.util.HashMap;
//import java.util.Map;

 

public class ReadFiles {
	static int totalRecord;
	/**
	 * 
	 * @Description: 读取相册和相册代表图片
	 * @param @param path   实际路径
	 * @param @param urlList路径文件名
	 * @param @param pageNum第几页
	 * @param @param pageSize每页显示多少条
	 * @param @return   
	 * @return List<Img>  
	 * @throws
	 * @author houhuayu
	 * @date 2016-6-27
	 */
	public static Pager<Img>  photo(List<String> path,List<String> urlList,int pageNum,int pageSize){
		
		//获取总页数
		int totalPage = totalRecord / pageSize;
		if (totalRecord % pageSize != 0) {
			totalPage++;
		}
		Pager<Img> result = null;
		List<Img> imgList = ReadFiles.photos(path, urlList, pageNum, pageSize);

		// //总记录数
		result = new Pager<Img>(pageSize, pageNum, totalRecord, totalPage, imgList);
		return result;
	}
	
	/**
	 * 
	 * @Description: 相册列表
	 * @param @param path
	 * @param @param urlList
	 * @param @param pageNum
	 * @param @param pageSize
	 * @param @return   
	 * @return List<Img>  
	 * @throws
	 * @author houhuayu
	 * @date 2016-6-27
	 */
	public static List<Img> photos(List<String> path,List<String> urlList,int pageNum,int pageSize){
		  List<Img> imgList = new ArrayList<Img>();
		  List<Img> imgListNew = new ArrayList<Img>();
		  String url ="";
		for(int k=0;k<path.size();k++){
		  File file=new File(path.get(k));
		  File[] tempList = file.listFiles();
		  url = urlList.get(k);
		  for (int i = 0; i < tempList.length; i++) { //循环相册
		    System.out.println("文件夹："+tempList[i]);
		    File imgFile= tempList[i];
		    String photoname = imgFile.getName();
		    File[] tempListImg = imgFile.listFiles();
		    String imgname = tempListImg[0].getName();
		    Img img = new Img();
		    img.setImgName(imgname);
		    img.setPhoto(photoname);
		    img.setImgUrl(url+"/"+photoname+"/"+imgname);
		    img.setSaveFile(url);
		    imgList.add(img);
		   }
		}
		totalRecord = imgList.size();  
	    int fromIndex	= pageSize * (pageNum-1);
	    int sizeAll = imgList.size();
	    int indexAll = fromIndex+pageSize;
	    if(indexAll>sizeAll){
	    	indexAll = sizeAll;
	    }
	    for(int m=fromIndex;m<indexAll;m++){
	    	imgListNew.add(imgList.get(m));
	    }
		  return imgListNew;	
	}



}

