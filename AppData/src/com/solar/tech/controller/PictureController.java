package com.solar.tech.controller;

import java.io.File;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.solar.tech.bean.Img;
import com.solar.tech.bean.Pager;
import com.solar.tech.dao.FindImg;
import com.solar.tech.dao.PictureDao;
import com.solar.tech.dbutil.StringUtil;
import com.solar.tech.util.Constant;
import com.solar.tech.util.RandomNum;

import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.FileItem;

@Controller
@RequestMapping("/picture")
public class PictureController {
	@Autowired
	private PictureDao dao;
	
//	@Autowired
//	private HttpServletRequest request;
//	
	@RequestMapping("/show") 
	public String show(Model model){
		String username = "wpsadmins";
		Map<String,Object> map = this.dao.show(username);
		model.addAttribute("result", map.get("result"));
		model.addAttribute("admin", map.get("isadmin"));
		return "picture/showMore";
	}
	@RequestMapping("/showDetail")
	@ResponseBody
	public Map<String, Object> showDetail(HttpServletRequest request,HttpServletResponse response,String isadmin,String url,
			String pageNum,String pageSize,String imgName,String photo,String newImg){
		  
		Map<String, Object> map = new HashMap<String, Object>();
		// 校验pageNum参数输入合法性
		
		if(pageNum !=null && !StringUtil.isNum(pageNum)){
			 request.setAttribute("errorMsg", "参数传输错误");
			// request.getRequestDispatcher("/showPage.jsp").forward(request, response);
			return null;
		}
		
		int pageNumber = Constant.DEFAULT_PAGE_NUM; //显示第几页数据
		if(pageNum!=null && !"".equals(pageNum.trim())){
			pageNumber = Integer.parseInt(pageNum);
		} 
			
		
//		int pageSize = Constant.DEFAULT_PAGE_SIZE;  // 每页显示多少条记录
		int pageSizeNumber = 1000;
//		String pageSizeStr = request.getParameter("pageSize");
//		String name = request.getParameter("imgName");//相册名称
//		String photo = request.getParameter("photo");//相册名称
		if(photo!=null&&!photo.equals("")){
			imgName = photo;
		}
		if(pageSize!=null && !"".equals(pageSize.trim())){
			pageSizeNumber = Integer.parseInt(pageSize);
		}
//		String newImg = request.getParameter("newImg");
		//调用service 获取查询结果
		FindImg findImg = new FindImg();
		String savePath = request.getServletContext().getRealPath(url);
		Pager<Img> result = findImg.findImg(newImg,imgName,savePath,url,pageNumber, pageSizeNumber);
				
		// 返回结果到页面
		System.out.println("::::::::::result::::::::");
	    if(null!=result){
	    	System.out.println("result::::::::"+result.getTotalRecord());
	    }
//		request.setAttribute("result", result);
//		request.setAttribute("url", url);
	    map.put("result", result);
	    map.put("url", url);
		System.out.println("::::::::::url::::::::"+url);
		if(isadmin!=null){
			if(isadmin.equals("1")){
				System.out.println("::::::::::showPage::::::::");
				//request.getRequestDispatcher("/showPage.jsp").forward(request, response);
				
			}else{
				System.out.println("::::::::::showPageOpen::::::::");
			//	request.getRequestDispatcher("/showPageOpen.jsp").forward(request, response);
			}
		}else{
			System.out.println("::::::::::isadmin------showPageOpen::::::::");
		//	request.getRequestDispatcher("/showPageOpen.jsp").forward(request, response);
		}
		return map;
	}
	
	
	@RequestMapping("/CreatePhoto")
	@ResponseBody
	public void CreatePhoto(HttpServletRequest request,String description){
		 HttpSession session = request.getSession(); 
		 session.setAttribute("description", description);
	}
	
	
	@RequestMapping("/add")
	@ResponseBody
	public Map<String,Object> add(HttpServletRequest request,@RequestParam(value="Filedata")MultipartFile file){ 
		Map<String,Object> map=new HashMap<String, Object>();
        map = this.dao.add(file);
 		return map; 
       
       
	}
	
	@RequestMapping("/edit")
	public void edit(String photo,String nphoto,String url,HttpServletRequest request){ 
 	  
 	    String state = this.dao.edit(photo,nphoto,url);
		request.setAttribute("data", state);
	}
	
	@RequestMapping("/remove")
	public void remove(HttpServletRequest request,String photo,String url){  
	 	  String state = this.dao.remove(request,photo,url);
	 	  request.setAttribute("data", state);
	}
}
