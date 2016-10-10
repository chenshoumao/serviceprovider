<%@page import="com.solar.tech.bean.Project"%>
<%@ page import="com.solar.tech.exception.ResultCode" %>

<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    String ps_no=request.getParameter("ps_no");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>scripts/common/jquery-easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>scripts/common/jquery-easyui/themes/icon.css">
<script type="text/javascript"
	src="<%=basePath%>scripts/common/jquery-easyui/jquery.min.js"></script>
<script type="text/javascript"
	src="<%=basePath%>scripts/common/jquery-easyui/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="<%=basePath%>scripts/common/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
<title>Insert title here</title>
<script type="text/javascript">
var url11 = "<%=basePath %>framework/file/find.action?psno=<%=ps_no %>"; 
$.getJSON(url11, function(res) { 
    document.getElementById("id_project").value=res[0][1].id_project; 
    document.getElementById("11ppo").value=res[0][1].po_no;	
    document.getElementById("sproj_no").value=res[0][1].proj_no;
    document.getElementById("smake").value=res[0][1].make;
    document.getElementById("spdesc").value=res[0][1].proj_desc;	
    document.getElementById("smanu").value=res[0][1].manufacturer;
    document.getElementById("sia").value=res[0][1].ia_status;
 });

var  url = '<%=basePath%>framework/ps/update.action';
function saveBean(){
    $('#fm').form('submit',{
        url: url,
        onSubmit: function(){
            return $(this).form('validate');
        },
        success: function(result){
        alert("Project are edited");
        window.location.href='<%=basePath%>console/biz/ps/shows.jsp';
          // reload the user data 
        }
    });
}

</script>
</head>
<body>


	<div >

		<form id="fm" method="post" enctype="multipart/form-data" novalidate>
			<input id="id_project" name="id_project"  type="hidden">
			<input id="11ppo" name="po_no"  type="hidden">				
			<table>
			<tr><td></td><td></td></tr>
			<tr><td><label>Project No:</label></td>
			<td>
			 <input name="proj_no" id="sproj_no" type="text"  />
			 </td>						
			</tr>				
			<tr><td><label>Project description:</label></td><td><input name="proj_desc"  id="spdesc" type="text"/></td></tr>			
			<tr><td><label>Manufacturer:</label></td><td><input name="manufacturer" type="text" id="smanu" /></td></tr>			
			<tr><td><label>Make:</label></td><td> <input name="make" type="text" id="smake"/></td></tr>			
			<tr><td><label>IA status:</label></td><td> <input name="ia_status" type="text" id="sia" /> </td></tr>			
			</table>			  		 													   
		</form>
	</div>
	
	<div >
		<a href="javascript:void(0)" class="easyui-linkbutton c6"	iconCls="icon-ok" onclick="saveBean()" style="width: 90px">Save</a>
	</div>
	
</body>
</html>