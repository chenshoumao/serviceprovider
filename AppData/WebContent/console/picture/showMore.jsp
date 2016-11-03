<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>相册</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="<%=basePath %>styles/css/reset.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath %>styles/css/index_me.css">
    <link rel="stylesheet" type="text/css" href="<%=basePath %>styles/css/pagination.css"/>
	<link rel="stylesheet" type="text/css" href="<%=basePath %>scripts/Uploadify/uploadify.css">
	<script type="text/javascript" src="<%=basePath %>scripts/js/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="<%=basePath %>scripts/Uploadify/jquery.uploadify.min.js"></script>
	<script type="text/javascript" src="<%=basePath %>scripts/js/jquery.pagination.js"></script>
<!-- 	<script type="text/javascript" src="js/HeaderFooter.js"></script> -->
	 <!-- <script src="js/responsiveslides.min.js"></script>banner导航条 -->
	<script src="<%=basePath %>scripts/js/easydialog.js"></script>
    <script type="text/javascript">
	function handlePaginationClick(new_page_index, pagination_container) {
	    $("#stuForm").attr("action", "servlet/ShowImgMore?isadmin=0&pageNum=" + (new_page_index+1));
	    $("#stuForm").submit();
	    return false;
	}
	$(function(){
		$("#News-Pagination").pagination(${result.totalRecord}, {
	        items_per_page:${result.pageSize}, // 每页显示多少条记录
	        current_page:${result.currentPage} - 1, // 当前显示第几页数据
	        num_display_entries:8, // 分页显示的条目数
	        next_text:"下一页",
	        prev_text:"上一页",
	        num_edge_entries:2, // 连接分页主体，显示的条目数
	        callback:handlePaginationClick
		});
		
	});
	</script>
 </head>
  

 <style>
.images_1_of_4 {
    width: 20.8%;
    padding: 1.5%;
    position: relative;
}
.grid_1_of_4 {
    display: block;
    float: left;
    margin: 1% 0 1% 1.6%;
    background: #FFF;
    box-shadow: 0px 0px 5px #999;
    position: relative;
}
.images_1_of_4 img {
    max-width: 100%;
    display: block;
    outline: none;
}
.grid_1_of_4:nth-child(4n+1) {
    margin-left: 0;
}
.grid_1_of_4 p{height: 20px;text-align: center;line-height: 35px;}
#News-Pagination {
    width: 294px;
    height: 25px;
    margin: 0px auto;
    padding-top: 30px;
}
.cb {
    clear: both;
}
#pageGro .pageUp {
    text-indent: 23px;
    background: url(./images/pageUp.png) 5px 7px no-repeat;
}
#pageGro div, #pageGro div ul li {
    font-size: 12px;
    color: #999;
    line-height: 23px;
    float: left;
    margin-left: 5px;
}
#pageGro div ul li.on {
    color: #fff;
    background: #005BC1;
    border: 1px solid #005BC1;
}
#pageGro div ul li {
    width: 22px;
    text-align: center;
    border: 1px solid #999;
    cursor: pointer;
}
#pageGro .pageDown {
    text-indent: 5px;
    background: url(images/pageDown.png) 46px 6px no-repeat;
}
#pageGro .pageUp, #pageGro .pageDown {
    width: 63px;
    border: 1px solid #999;
    cursor: pointer;
}
.transform{display: none;}
.modify{display: inline-block;width: 18px;height: 18px;background: url(<%=basePath %>images/images/calendar_nextmonth.png) no-repeat center #ffffff; cursor: pointer;border: 1px solid #D6D6D6; box-shadow: 0 0 2px rgba(0,0,0,.15);position: absolute;border-radius: 2px;left: 210px;top: 25px;}
.grid_1_of_4:hover .transform{display: block;}
.modify_tow{position: absolute;background: #fff;z-index: 49;border-radius: 4px 0 4px 4px;border: 1px solid #D6D6D6;box-shadow: 0 0 2px rgba(0,0,0,.15);}
.modify_tow{padding: 2px 0px 2px 0px;top: 44px;left: 113px; display: none;}
.modify_tow li{width: 115px;line-height: 28px;text-indent: 15px;}
.modify_tow li:hover{background: #5caae6; color: #fff;text-decoration: none;}
/* .modify_tow li:nth-child(1){background: url(./images/iconfont-xiugai.png) no-repeat 10px;} */
.modify_tow img{display: inline-block;position: relative;top: 3px;margin-right: 25px;}

/*照片信息弹框*/
.easyDialog_wrapper{ width:320px; color:#444; border:3px solid rgba(0,0,0,0); -webkit-border-radius:5px; -moz-border-radius:5px; border-radius:5px; -webkit-box-shadow:0 0 10px rgba(0,0,0,0.4); -moz-box-shadow:0 0 10px rgba(0,0,0,0.4); box-shadow:0 0 10px rgba(0,0,0,0.4); display:none; font-family:"Microsoft yahei", Arial; }

.easyDialog_wrapper .easyDialog_content{ -webkit-border-radius:4px; -moz-border-radius:4px; border-radius:4px; background:#fff; border:1px solid #e5e5e5; }

.easyDialog_wrapper .easyDialog_title{ height:30px; line-height:30px; overflow:hidden; color:#666; padding:0 10px; font-size:14px; border-bottom:1px solid #e5e5e5; background:#f7f7f7; border-radius:4px 4px 0 0; }

.easyDialog_wrapper .close_btn{ font-family:arial; font-size:18px; _font-size:12px; font-weight:700; color:#999; text-decoration:none; float:right; }

.easyDialog_wrapper .close_btn:hover{ color:#333; }

.easyDialog_wrapper .easyDialog_text{ padding:11px 11px; font-size:13px; line-height:22px; }

.easyDialog_wrapper .easyDialog_footer{ padding:0 10px; *zoom:1; }

.easyDialog_wrapper .easyDialog_footer:after{ content:''; display:block; height:0; overflow:hidden; visibility:hidden; clear:both; }

.easyDialog_wrapper .btn_highlight,
.easyDialog_wrapper .btn_normal{ border:1px solid; border-radius:2px; cursor:pointer; font-family:"Microsoft yahei", Arial; float:right; font-size:12px; padding:0 12px; height:24px; line-height:22px; margin-bottom:10px; }

.easyDialog_wrapper .btn_highlight{ background:#4787ed; background:-webkit-gradient(linear,center bottom,center top,from(#4787ed),to(#4d90fe)); background:-moz-linear-gradient(90deg, #4787ed, #4d90fe); border-color:#3079ed; color:#fff; }

.easyDialog_wrapper .btn_normal{ margin-left:10px; border-color:#c3c3c3; background:#ececec; color:#333; background:-webkit-gradient(linear,center bottom,center top,from(#ececec),to(#f4f4f4)); background:-moz-linear-gradient(90deg,#ececec,#f4f4f4); }
.eject{margin: 0 auto;}

.gb-btn {
    color: #fff;
    border: 1px solid #826bb3;
    background-color: #9c85cc;
    background-position: 0 0!important;
    }
a {
    text-decoration: none;
}
</style>
  <body>
  
  <!--start hender
	<div id="header"></div> -->
   <!-- end hender -->
	<!--start banner
	<div id="banner"></div> -->
	<!-- end banner -->
	
	<!--start container -->	
	<div class="container">
		 <!--start nav 
		<div id="nav"></div>-->
		<!-- end nav -->
		<!-- start main -->
		<c:if test="${admin }">
			<a href="" class="gb-btn" id="js-oper-upload" data-hottag="operationbar.upload"><i class="icon-m icon-upload-m"></i>上传照片</a>
		</c:if>
		
		<div class="main">
		   <c:if test="${fn:length(result.dataList) eq 0 }">
			<span style="display: block;text-align: center">查询的结果不存在</span>
	       </c:if> 
		    <c:if test="${fn:length(result.dataList) gt 0 }">
			  <c:forEach items="${result.dataList }" var="Img">
			       <div class="grid_1_of_4 images_1_of_4">
						<div class="transform">
							 <span class="modify"></span>
							 <ul class="modify_tow">
							 	<li class="added" name="${Img.photo }" myurl="${Img.saveFile }"><img src="<%=basePath %>images/images/iconfont-xiugai.png" alt="">修改</li>
							 	<li class="delete" name="${Img.photo }" myurl="${Img.saveFile }"><img src="<%=basePath %>images/images/delete2.png" alt="" >删除</li>
<!-- 							 	href="servlet/Delete?photo=${Img.photo}&url=${Img.saveFile}&isadmin=1"> -->
							 </ul>
						</div>
					    <a class="fancybox" href="picture/showDetail.action?imgName=${Img.photo}&isadmin=1&url=${Img.saveFile}" data-fancybox-group="gallery">
					   		<img alt="${Img.imgName}" src="${Img.imgUrl}" width="240px" height="180px">
				   		</a>
					    <p>${Img.photo}</p>
			</div>
			  </c:forEach>
			</c:if>  
		</div>
		<!-- end main -->
		<!-- 分页start -->
		<br clear="both">
		<div id="News-Pagination"></div>
		<!-- 分页end -->
	</div>
	<!-- end container -->
	<br clear="both">
	<div id="footer"></div>
	
<!-- 不显示标签 -->		
 <div>
	<font color="red">${errorMsg }</font>
	<form action="servlet/ShowImg?isadmin=0" id="stuForm" method="post">
		<input type="text" name="imgName" id="imgName"
			style="width:120px;display:none;"  />
	</form>
 </div>		
  </body>
  <script type="text/javascript">
  $(".modify").click(function(event){
		$(".modify_tow").toggle("show");
	})


	// 弹框插件

		var $1 = function() {
			return document.getElementById(arguments[0]);
		};
		$(".added").click(function(event) {
			var name = $(this).attr("name");
			var url  = $(this).attr("myurl");
			var btnFn = function() {
				var nphoto = $("#pname").val();
				$.ajax({
					type: "GET",
    				url: "picture/edit.action",
    				data: {photo:name, nphoto:nphoto,url:url},
    				 dataType: "json",
    				 success: function(data){
    					 window.location.reload();
    				 },
    				 error:function(data){
    					 window.location.reload();
    					 
    				 }
				});
			};
			easyDialog.open({
				container: {
					header: '照片信息修改',
					content: '<form action=""><table class="eject"><tr><td>名&nbsp;&nbsp称：</td><td><input type="text" id="pname" value="'+name+'"/></td></tr></table></form>',
					yesFn: btnFn,
					noFn: true
				},
				fixed: false
			});
		});

       
		$(".delete").click(function(event) {
				 var name = $(this).attr("name");
		         var myurl = $(this).attr("myurl");	
		        	var deFn = function() {
		    			$.ajax({
		    				type: "GET",
		    				url: "picture/remove.action",
		    				data: {photo:name, url:myurl},
		    				 dataType: "json",
		    				 success: function(data){
		    					 window.location.reload();
		    				 },
		    				 error:function(data){
		    					 alert("error");
		    					 
		    				 }
		    			});
		    			
		    		};
		      
			easyDialog.open({
				container: {
					header: '照片信息修改',
					content: '<p>你确定要删除这张图片吗？<p>',
					yesFn: deFn,
					noFn: true
				},
				fixed: false
			});
		});
  
  
  
  
	

		
</script>
  
  
</html>
