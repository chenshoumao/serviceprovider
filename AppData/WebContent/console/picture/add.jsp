<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String basePath2 = path+"/";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
      <head>
        <base href="<%=basePath%>">
        <title>上传图片</title>
<link rel="stylesheet" type="text/css" href="<%=basePath %>scripts/Uploadify/uploadify.css">
<script type="text/javascript" src="<%=basePath %>scripts/js/jquery-1.11.3.js"></script>
<script type="text/javascript" src="<%=basePath %>scripts/Uploadify/jquery.uploadify.min.js"></script>
<script type="text/javascript">
$(function() {
	
/*jsessionid=<%=session.getId()%>&sessionobj=<%=session%>*/
    $('#uploadify').uploadify({
        'swf'      : '<%=basePath%>scripts/Uploadify/uploadify.swf',
        'uploader'         : '<%=basePath%>picture/add.action?r='+Math.random(),
        'cancelImg'      : '<%=basePath2%>Uploadify/uploadify-cancel.png',
         'folder'         : 'uploads',
         'fileDataName'   : 'uploadify',//
         "fileObjName ": "Filedata",//传到服务器的参数名
         fileSizeLimit   : 1024,//KB,文件大小
         'queueID'        : 'fileQueue',
         'auto'           : false,//是否选取文件后自动上传
         'multi'          : true,//是否支持多文件上传
         'buttonText'     : '选择文件',
         'buttonImg'      : 'images/uploadify-cancel.png',
         'displayData'    : 'percentage',//有speed和percentage两种，一个显示速度，一个显示完成百分比 
         'fileTypeExts' 		: '*.gif; *.jpg; *.png',
         "onUploadSuccess" : function(file,data,response) {//上传完成时触发（每个文件触发一次）
				var obj=eval("("+data+")");
				var flag=obj.success;
				//alert(flag);	
	        },
			"onQueueComplete":function(queueData){		         	
					//alert("sss");
			}
    });
});

    
    function up(){
    	var photo = $("#description").val();
        if(/[\/\\"<>\?\*]/gi.test(photo)||photo==null||photo==""){
     	   result = photo.replace(/(^\s+)|(\s+$)/g,"");
//      	   alert(result);
     	   alert("相册名称不合法！");
     	   return;
        }
 		 $.ajax({
 		   type:"post",//请求方式
 		  url:"picture/CreatePhoto.action",//发送请求地址
 		   data:{
 			   description:$("#description").val()  
 		   },
 		   //请求成功后的回调函数有两个参数
 		   success:function(){
 			   jQuery('#uploadify').uploadify('upload','*');
 		   }
 		   });

    }
    </script>
    <body>
 <div id="fileQueue"></div>
 <input type="file" name="uploadify" id="uploadify">
相册名称：<input type="text" name="description" id="description">
        <p>
        <input type="button" value="开始上传" onclick="up();"/>
        &nbsp;
         <input type="button" value="取消所有上传" onclick="jQuery('#uploadify').uploadify('cancel','*')"/>
        </p>
        <a href="servlet/ShowImg?isadmin=1">相册</a>
</body>
</html>