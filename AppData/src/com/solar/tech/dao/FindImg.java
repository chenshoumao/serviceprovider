package com.solar.tech.dao;

 

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import com.solar.tech.bean.Img;
import com.solar.tech.bean.Pager;
 

public class FindImg {
	static int totalRecord;
	/**
	 * 
	 * @Description: TODO
	 * @param @param name       相册名称
	 * @param @param savePath   上传图片路径
	 * @param @param pageNum    第几页
	 * @param @param pageSize   一页显示多少条数据
	 * @param @return   
	 * @return Pager<Img>      
	 * @throws
	 * @author houhuayu
	 * @date 2016-6-20
	 */
	public Pager<Img> findImg(Object newImg ,String name,String savePath,String upurl,int pageNum, int pageSize) {
		//获取总页数
				int totalPage = totalRecord / pageSize;
				if(totalRecord % pageSize !=0){
					totalPage++;
				}
		if(newImg!=null){
			pageNum = totalPage;
		}
		Pager<Img> result=null;
		List<Img> listImg = FindImg.imgPhoto(name, savePath,upurl, pageSize, pageNum);
		
//		//总记录数
//		int totalRecord = 5;
		result = new Pager<Img>(name,pageSize, pageNum, 
				totalRecord, totalPage, listImg,upurl);
		return result;
	}
	
	/**
	 * 
	 * @Description: 读取该相册下的图片
	 * @param @return   
	 * @return List<Img>  
	 * @throws
	 * @author houhuayu
	 * @date 2016-6-16
	 */
	public static List<Img> imgPhoto(String photo,String path,String upurl,int pageSize,int pageNum){
		 File file=new File(path);
		  File[] tempList = file.listFiles();
//		  System.out.println("该目录下对象个数："+tempList.length);
		  List<Img> imgList = new ArrayList<Img>();
		  for (int i = 0; i < tempList.length; i++) { //循环相册
			  if(tempList[i].getName().equals(photo)){
//				  System.out.println("文件夹："+tempList[i]);
				  File imgFile= tempList[i];
				    String photoname = imgFile.getName();
				    File[] tempListImg = imgFile.listFiles();
				    totalRecord = tempListImg.length; 
				    int fromIndex	= pageSize * (pageNum -1);
				    int sizeAll = tempListImg.length;
				    int indexAll = fromIndex+pageSize;
				    if(indexAll>sizeAll){
				    	indexAll = sizeAll;
				    }
				    for(int j=fromIndex;j<indexAll;j++){
				    	 String imgname = tempListImg[j].getName();
						    Img img = new Img();
						    img.setImgName(imgname);
						    img.setPhoto(photo);
						    img.setImgUrl(upurl+"/"+photoname+"/"+imgname);
						    imgList.add(img);
				    }
				   
			  }
		   }
		  return imgList;
	}

}
