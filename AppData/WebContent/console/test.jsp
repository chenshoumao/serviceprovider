<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'UserInfo.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

<script type="text/javascript"
	src="<%=basePath%>scripts/common/jquery-1.8.3.min.js"></script>
<style type="text/css">
.personal_left {
	float: left;
	width: 155px;
	position: relative;
}

input {
	border: 1px solid #ffffff;
	text-indent: 8px;
}
/*a  upload */
.a-upload {
	padding: 4px 10px;
	height: 20px;
	line-height: 20px;
	position: absolute;
	cursor: pointer;
	color: #888;
	background: rgba(255, 255, 255, 0.76);
	border: 1px solid #ddd;
	border-radius: 4px;
	overflow: hidden;
	display: inline-block;
	*display: inline;
	*zoom: 1;
	top: -120px;
	left: 10px;
	visibility: hidden;
	display: none;
}

.a-upload  input {
	position: absolute;
	font-size: 100px;
	right: 0;
	top: 0;
	opacity: 0;
	filter: alpha(opacity = 0);
	cursor: pointer
}

.fileerrorTip {
	top: 170px;
	width: 100%;
	left: 0px;
	text-align: center;
	display: inline-block;
	position: absolute;
}

.personal_left:hover.a-upload {
	visibility: visible;
}

.showpage input {
	background: #f6f6f6;
	cursor: pointer;
}

.wptheme1Col .wpthemeCol {
	width: 1100px;
}

.wpthemeOverflowAuto {
	overflow: hidden;
}

.myedit {
	width: 100px;
	height: 35px;
	border: 0px solid #fafafa;
	background-color: #f6f6f6;
	cursor: pointer;
	outline: none;
}

.mysearch {
	width: 100px;
	height: 35px;
	border: 0px solid #fafafa;
	background-color: #f6f6f6;
	outline: none;
	cursor: pointer;
}
</style>

</head>

<body>
	 <div>
	 	 
	 		<c:forEach items="${map}" var="map1" varStatus="status">
				 ${map1.key}
				<select>
				<c:forEach items="${map1.value}" var="list">
				 	<option>
				 		${list.url}
				 	</option>
			
				</c:forEach>
				</select>
				<br>
			</c:forEach>
			 
			 
	 	 
	 </div>
	
</body>
</html>
