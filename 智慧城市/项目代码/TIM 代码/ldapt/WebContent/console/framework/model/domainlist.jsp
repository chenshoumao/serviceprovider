
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/icon.css">
<link rel="stylesheet" type="text/css"href="<%=basePath %>styles/framework/frameset.css">


<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-1.8.3.min.js"></script>
<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-easyui/jquery.easyui.min.js"></script>
<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript"src="<%=basePath %>scripts/framework/frameset.js"></script>
<script type="text/javascript"src="<%=basePath %>scripts/framework/model/domainlist.js"></script>
<style type="text/css">
	html,body{
	height:100%;width:100%;margin:0px;
}
.fm {margin: 0;padding: 10px 50px;
	}

	.ftitle {font-size: 14px;font-weight: bold;padding: 5px 0;margin-bottom: 10px;border-bottom: 1px solid #ccc;
	}

	.fitem {
	margin-bottom: 10px;padding-left: 0px;
	}

	.fitem label {
		display: inline-block;
		width: 80px;
	}

	.fitem input {width: 160px;
	}
</style>
</head>

<body>
	<div style="text-align:center;width:100%;height:100%">
		
	<table id="datagrid" style="width:100%;height:100%"
       data-options="fitColumns:true,title:'图书管理',toolbar:'#toolbox'">
	</table>
	</div>
	<div id="toolbox" style="padding:5px;height:25px">
		<div style="margin-bottom:5px;float:left">
			<a href="#" class="easyui-linkbutton" id="toolbar_add"  iconCls="icon-add" plain="true">新建数据域</a>
			<a href="#" class="easyui-linkbutton" id="toolbar_delete" iconCls="icon-remove" plain="true">删除数据域</a>
		</div>
	</div>
	
	
		
	<div id="dialog" style="width: 580px; height: 300px; padding: 10px 20px">
		<form id="form" method="post" class="fm" data-options="ajax:true">
			<div class="fitem" style="display:none;">
				<label>数据域ID:</label>
				<input id="domainId" name="domainId" class="easyui-textbox"
					 style="width: 280px;"  >
			</div>
			<div class="fitem">
				<label>数据域中文名:</label>
				<input id="domainCName" name="domainCName" class="easyui-textbox"
					required="true" style="width: 280px;" validtype="length[1,50]" invalidMessage="有效长度1-50" >
			</div>
			<div class="fitem">
				<label>数据域英文名:</label>
				<input id="domainEName" name="domainEName" class="easyui-textbox"
					required="true" style="width: 280px;" validtype="length[1,50]" invalidMessage="有效长度1-50" >
			</div>
			<div class="fitem">
				<label>数据域描述:</label>
				<textarea  id="domainDesc" name="domainDesc"   style="width: 280px; height: 80px;border: 1px solid #95B8E7;border-radius: 5px 5px 5px 5px;"></textarea>
			</div>
		</form>
	</div>
</body>
</html>