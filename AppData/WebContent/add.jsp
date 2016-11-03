<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'add.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
        <form action="adapter/add.action" method="post">
        	<label>
        		系统名：<input name="systemName">
        	</label>
        	<BR>
        	<label>
        		系统En名：<input name="EnName">
        	</label>
        	
        	<BR>
        	<label>
        		系统Cn名：<input name="CnName">
        	</label>
        	
        	<BR>
        	<label>
        		链接地址：
        		<input name="sysUrl">
        	</label>
        	<BR>
        	 <label>
        		标题：<input name="title">
        	</label>
        	<label>
        		接受时间：<input name="receiveTime">
        	</label>
        	<label>
        		处理人姓名：<input name="PendingName">
        	</label>
        	<label>
        		代办路径：<input name="todoUrl">
        	</label>
        	<BR>
        	 
        	<button type="submit">sure</button>
        </form>
  </body>
</html>
