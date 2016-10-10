<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>


<link rel="stylesheet" type="text/css"href="<%=basePath%>scripts/common/jquery-easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"href="<%=basePath%>styles/framework/frameset.css">
<link rel="stylesheet" type="text/css"href="<%=basePath%>styles/framework/treeicon/icon.css">
<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/icon.css">

<script type="text/javascript"src="<%=basePath%>scripts/common/jquery-1.8.3.min.js"></script>
<script type="text/javascript"src="<%=basePath%>scripts/common/jquery-easyui/jquery.easyui.min.js"></script>
<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript"src="<%=basePath%>scripts/framework/frameset.js"></script>

