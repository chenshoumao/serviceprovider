<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="com.solar.tech.bean.User"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css"href="<%=basePath%>styles/framework/frameset.css">
<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/icon.css">
<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-easyui/jquery.min.js"></script>
<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-easyui/jquery.easyui.min.js"></script>
<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript"src="<%=basePath%>scripts/framework/frameset.js"></script>

<style type="text/css">
* {
	padding: 0px;
	margin: 0px;
}
body{ text-align:center;background: #F0F0F0;} 
.d{ margin:100px auto; width:400px; height:100px; border:0px solid #F00} 

#fm {
	margin: 0;
	padding: 10px 30px;
}

.ftitle {
	font-size: 14px;
	font-weight: bold;
	padding: 5px 0;
	margin-bottom: 10px;
	border-bottom: 1px solid #ccc;
}

.fitem {
	margin-bottom: 16px;
}

.fitem label {
	display: inline-block;
	width: 80px;
}

.fitem input {
	width: 160px;
}

.fitem input[type=radio] {
	width: 39px;
}
.textbox .textbox-text{white-space: pre-line;}
#submit{width: 108px;
    height: 20px;
    line-height: 20px;
    background: #ff3f08;
    border:none;
    color:#fff;
    margin-left: 83px;}
</style>

<script>
$(document).ready(function(){
 $.extend(
 $.fn.validatebox.defaults.rules, {    
     /*必须和某个字段相等*/  
    equalTo: {    validator:function(value,param){    return $(param[0]).val() == value;    },  
        message:'字段不匹配'  
    }  
             
}
);  


 

	$("#submit").click(function(){
	    if($("#newPass").val()==""){
	    	return false;
	    }

		
		$.ajax({
			url:"<%=basePath %>framework/ldap/updatepass.action",

			type:"post",
			data:{userName:"<%=com.solar.tech.util.Current.user().getUserName()%>", newPass:$("#newPass").val()},
			dataType:"json",
		success:function(data){
		    alert("Your password is changed .");		    
			},
			error:function(rq, status, e){
			alert("We are out service. ");
				console.error(e);
			}
		});

	});

})
</script>
<title>修改密码</title>
</head>
<body>  

  <div class="d">            
		<form id="fm" method="post" enctype="multipart/form-data" >
			<div class="fitem">
				<label>用户名称:</label>
				 <input name="userName" value="<%=com.solar.tech.util.Current.user().getUserName()%>"  readOnly="true"/>

			</div>
			<div id="fitemPassword">
				<div class="fitem fitem_password">
					<label>新密码:</label>
					 <input id="newPass" name="newPass" type="password"  validType="length[4,32]" class="easyui-validatebox" data-options="required:true" />
				</div>
				<div class="newPass2 fitem fitem_password">
					<label>确认密码:</label>
					 <input id="newPass2" name="newPass2" type="password" data-options="required:true" class="easyui-validatebox"  validType="equalTo['#newPass']" invalidMessage="两次输入密码不匹配" />
				</div>                                                                                 
				<input type="button"  id="submit"   value="提交"/>
			</div>
		</form>
		
	</div>	
		
</body>
</html>