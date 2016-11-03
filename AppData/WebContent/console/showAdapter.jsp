<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'showAdapter.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript" src="<%=basePath%>scripts/common/jquery-1.8.3.min.js"></script>
	<style type="text/css">
		body{
			width: 600px;
			hight:600px;
			border: 1px silver solid;
		}
		div{
			margin-top:20%;
			margin-left: 40%;
		}
		a{
			text-decoration:none;
		}
	</style>
	<script type="text/javascript">
		$(function(){
			$.ajax({ 
				url:"<%=basePath%>adapter/show.action",
				type : "post",  
				dataType:"json",
				success:function(data){ 
					for(var i = 0;i < data.length;i++){
						var map = data[i];
						var ll = "<li><a href='<%=basePath%>adapter/detailInfo.action?systemName="+map.sysName+
								"'>"+map.sysName+"</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+
								"<a href='<%=basePath%>adapter/daibandaiyue.action?sysUrl="+map.sysUrl+
								"&sysName="+map.sysName+"'>待阅待办</a></li>";
						$("#li").append(ll);
					}
				}
			});
		})
	</script>
  </head>
  
  <body>
  	<div>
  		<label>
  			服务名称
  		</label>
        <ol id="li">
        </ol>
    </div>
  </body>
</html>
