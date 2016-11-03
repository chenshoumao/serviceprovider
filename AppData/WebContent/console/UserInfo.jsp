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
<script type="text/javascript">
	 	$(function(){
	 		 
	 		
	 		
	 		
	 		var inputlist=document.getElementsByTagName("input");
	 		document.getElementById('hehe').onclick=function(){
	 			var check = document.getElementById('hehe').innerHTML;
	            
	 			if(check=='编辑'){
					for(i=0;i<inputlist.length;i++){
					inputlist[i].disabled=false;
					inputlist[i].style.border="1px solid #dcdcdc";
					}
					document.getElementById('hehe').innerHTML='保存';
					document.getElementById('daye').style.display="block";
				}
	 			if(check=='保存'){
	 				
	 				var name = $("#myname").val();
	 				var homePhone = $("#mytel").val();
	 				var mobile = $("#mymobile").val();
	 				var postalCode = $("#mypostalCode").val();
	 				var mail = $("#mymail").val();
	 				var address = $("#myaddress").val();
	 				var staffNumber = $("#mystaffNumber").val();
	 				var department = $("#mydepartment").val();
	 				var profession = $("#myprofession").val();
	 				var title = $("#mytitle").val();
	 				 $.ajax({
	 				 type: "get",
	 				  url: "<%=basePath%>PersonalSpace/update.action",
					data : {
						name : name,
						homePhone : homePhone,
						mobile : mobile,
						postalCode : postalCode,
						mail : mail,
						address : address,
						staffNumber : staffNumber,
						department : department,
						profession : profession,
						title : title
					},
					dataType : "json"
					 
				});
			}
		}
	 		

	});
	 	function upimg(){
 			$("#photoForm").submit();
 		}
</script>
</head>

<body>
	<div class="stations_left">
		<h1 class="wholeh1">
			<span class="blue"><img src="<%=basePath%>/images/q5.png"
				class="wholeimg">个人空间</span>
		</h1>
		<ul class="showpage">
			<!-- 			<li><span>·</span><a href="javascript:;" id="mymessage">个人信息编辑</a></li> -->
			<!-- 			<li><span>·</span><a href="javascript:;" id="mysearch">人员查找</a></li> -->
			<li><FORM method="POST" action="<portlet:actionURL/>">
					<span>·<INPUT value="" type="hidden" name="requestType" /> <INPUT
						value="个人信息编辑" type="submit" class="myedit" /></span>
				</FORM></li>
			<li><FORM method="POST" action="<portlet:actionURL/>">
					<span>·<INPUT value="" type="hidden" name="requestType" /> <INPUT
						value="人员查找" type="submit" class="mysearch" /></span>
				</FORM></li>
		</ul>
	</div>
	<!-- 右边内容 -->
	<div class="stations_right">
		<p class="personal">个人信息</p>
		<div class="personal_left">
			<c:choose>
				<c:when test="${! empty user.imageUrl }">
					<img src="PersonalSpace/get.action?path=${user.imageUrl }" id="myphoto"
				width="152" height="158">
				</c:when>
				<c:otherwise>
					<img src="<%=basePath%>images/information3.png" id="myphoto"
				width="152" height="158">
				</c:otherwise>
			</c:choose>
			 
		<form method="POST" action="PersonalSpace/uploadImage.action" enctype="multipart/form-data" id="photoForm"> 
				<input type="file" name="file">  
				<button type="submit">点击上传</button>
	    </form>
				 
		</form>
			<span class="fileerrorTip"></span>
		</div>



		<span style="margin-left: 27px;">姓名：</span><input type="text"
			disabled="disabled" value="${user.name }" name="name" id="myname"><span>联系电话：</span><input
			type="text" style="margin-right: 0;" disabled="disabled"
			value="${user.homePhone}" name="homePhone" id="mytel"><br>
		<span>手机号码：</span><input type="text" disabled="disabled"
			value="${user.mobile}" name="mobile" id="mymobile"><br>
		<span>邮政编码：</span><input type="text" disabled="disabled"
			value="${user.postalCode}" name="postalCode" id="mypostalCode">电子邮箱：<input
			type="text" style="margin-right: 0;" disabled="disabled"
			value="${user.mail}" name="mail" id="mymail"><br> <span>通讯地址：</span><input
			type="text" disabled="disabled" value="${user.address}"
			name="address" id="myaddress"> <br clear="both">
		<p class="department">部门信息</p>
		<span style="margin-left: 25px;">员工工号：</span> <input type="text"
			disabled="disabled" value="${user.staffNumber}" name="staffNumber"
			id="mystaffNumber"> <span>所属部门：</span> <input type="text"
			disabled="disabled" value="${user.department}" name="department"
			id="mydepartment"> <br> <span style="margin-left: 53px;">职业：</span>
		<input type="text" disabled="disabled" value="${user.profession}"
			name="profession" id="myprofession"> <span>岗位名称：</span> <input
			type="text" disabled="disabled" value="${user.title}" name="title"
			id="mytitle"> <br> <a href="javascript:void(0)"
			class="data" onclick="check()" id="hehe">编辑</a>
	</div>
</body>
</html>
