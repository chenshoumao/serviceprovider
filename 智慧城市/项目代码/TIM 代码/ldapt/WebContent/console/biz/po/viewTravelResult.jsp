<%@page import="com.solar.tech.bean.Po_Create"%>
<%@ page import="com.solar.tech.exception.ResultCode" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    String po_no=request.getParameter("po_no");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/icon.css">

<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-easyui/jquery.min.js"></script>
<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-easyui/jquery.easyui.min.js"></script>
<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>

<title></title>
<style type="text/css">
* { 
	padding: 0px;
	margin: 0px;
}


.ftitle {
	font-size: 14px;
	font-weight: bold;
	padding: 5px 0;
	margin-bottom: 10px;
	border-bottom: 1px solid #ccc;
}

.fitem {
	margin-bottom: 5px;
}

.fitem label {

	
	margin-bottom: 5px;
	width:200px;
}

.fitem input {
	width: 180px;
}

.fitem input[type=radio] {
	width: 39px;
}
.textbox .textbox-text{white-space: pre-line;}

table td{ 

 text-width:300px;
 font-size: 20px;
 font-weight: bold;
 text-align:right;
 }
#fm{width:900px;margin:0 auto;}
table tr td:nth-child(2){padding-right:30px;}
</style>
<script type="text/javascript">
 
var url11 = "<%=basePath %>framework/tra/find.action?pono=<%=po_no %>";
$.getJSON(url11, function(res) { 
    document.getElementById("user").value=res[0].user ;  
    document.getElementById("fee").value=res[0].fee; 
    
 });
 
var url12 = "<%=basePath %>framework/todo/find.action?pono=<%=po_no %>";
$.getJSON(url12, function(res) {   
    $("#opinion").val(res.opinion); 
    
 });

</script>   	
</head>
<body style="text-align:center;;background:#F0F0F0;">
	 <div style="width:100%;text-align:center;;background:#F0F0F0;">
	 <div style="width:100%;height:90px;"></div>
	 <div style="width:100%;height:90px;font-size: 28px; font-weight: bold;">view result of Travel</div>
	 <div style="border: 0px solid #ccc;">
	 <form id="fm" method="post" enctype="multipart/form-data" novalidate >
     <input name="approveResult" type="hidden">
	 <table style="margin:0 auto;">
	<tr>
		<td>name </td>
		<td> <input readonly="readonly"  name="user" id="user" type="text"></td>
	 
	 <td>Fee </td> <td><input readonly="readonly"  name="fee"  type="text" id="fee"> </td>
	 </tr>
	 <tr>
	 	<td>Opinion</td>
		<td colspan="3" style="padding-left: 20px;">
			<textarea readonly="readonly" id="opinion" style="width: 365px;"></textarea>
		</td>
	 
	 </tr>
	 </table> 
	 
	  
	 </form>
	 </div>
	</div>
</body>
</html>