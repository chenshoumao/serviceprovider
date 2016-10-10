<%@page import="com.solar.tech.bean.Po_Create"%>
<%@ page import="com.solar.tech.exception.ResultCode" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    String chargeId=request.getParameter("chargeId");
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
 
var url11 = "<%=basePath %>framework/charge/find.action?chargeId=<%=chargeId %>";

$.getJSON(url11, function(res) {  
    $("#proj_no").textbox('setValue',res[0].proj_no);
    $("#originalPrice").textbox('setValue',res[0].originalPrice);
    $("#construction").textbox('setValue',res[0].construction);
    $("#chargeId").val(res[0].chargeId); 
    $("#smto").textbox('setText',res[0].submitter);   
    $("#filePath").val(res[0].filePath);   
 });

;


function getRandom(n){
        return Math.floor(Math.random()*n+1)
        }

 
function approve(){   
     var finalPrice = $("#finalPrice").textbox('getValue');
     if(finalPrice == ""){
     	alert("please input the final price");
     }
     else
     	$('#dlg').dialog('open').dialog('setTitle','Detail Of Approving'); 
}
function sendApprove(){
	 
   
       
     //  var obj=eval("(" + result + ")");
     
       var pono = "<%=chargeId%>";  
       var opinion = $("#opinion").val();
       var resultOfApprove = $("#approveResult").combobox("getText");
     
       var url = '<%=basePath %>framework/todo/updateTodoList.action?pono='+pono+'&approveResult='+ resultOfApprove + '&opinion='+opinion+'&url=<%=basePath%>&status=已审批';
        $.getJSON(url, function(json) { 
        	var result = eval(json);  
        	if(result.state){
        		var chargeId = $("#chargeId").val(); 
        		var approveCharge = '<%=basePath%>framework/charge/approve.action?chargeId='+chargeId+'&status=已审批&finalPrice='+$("#finalPrice").textbox('getValue');
        		$.getJSON(approveCharge, function(json) {
        			if(json.success){
        			     var toMail;
        			     var findEmail = '<%=basePath%>framework/ldap/userdetails.action?userName='+$("#smto").textbox('getText');
 							$.getJSON(findEmail,function(jk){ 
 							 toMail = jk.email;
 							 $("input[name=approveResult]").val(resultOfApprove);  
        				 url = '<%=basePath%>framework/mail/send.action?to='+jk.email+'&subject=The result approve of Charge&body='+result.body;
        				  
        				$.getJSON(url, function(json) {
        					alert("已将结果邮件通知"+result.submiter);
        					$('#dlg').dialog('close');
        					closeWin();
        				}); 
 	 
 						});
        				 
        			}
        		});
        	   
        	 
        	}
        }); 
        
        
  
   
    
}
 
/**
$.extend($.fn.validatebox.defaults.rules, {  

    isExist: {
        validator:function(value,param){
        	var r=false;
        	$.ajax({  
                type : "post",  
                 url : "framework/user/isExist.action",
                 data : , 
                 dataType: 'json',
                 async : false,  
                 success : function(data){
                	 if(data==false) r=true;
                 }  
            }); 
            return r;
        },
        message:'用户已存在'
    }

});
**/

Date.prototype.format = function (format) {  
    var o = {  
        "M+": this.getMonth() + 1, // month  
        "d+": this.getDate(), // day  
        "H+": this.getHours(), // hour  
        "m+": this.getMinutes(), // minute  
        "s+": this.getSeconds(), // second  
        "q+": Math.floor((this.getMonth() + 3) / 3), // quarter  
        "S": this.getMilliseconds()  
        // millisecond  
    }  
    if (/(y+)/.test(format))  
        format = format.replace(RegExp.$1, (this.getFullYear() + "")  
            .substr(4 - RegExp.$1.length));  
    for (var k in o)  
        if (new RegExp("(" + k + ")").test(format))  
            format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));  
    return format;  
}  
function formatDatebox(value) {  
    if (value == null || value == '') {  
        return '';  
    }  
    var dt;  
    if (value instanceof Date) {  
        dt = value;  
    } else {  
        dt = new Date(value);  
    }  
  
    return dt.format("yyyy-MM-dd HH:mm"); //扩展的Date的format方法(上述插件实现)  
}
function downloadE() {
	 
	window.location.href = '<%=basePath %>framework/dl/down.action?fileUrl='+$("#filePath").val();
}
function closeWin(){
	window.opener.location.reload();
  	window.opener=null;
  	window.open('','_self');
  	window.close();
}
</script>   	
</head>
<body style="text-align:center;;background:#F0F0F0;">
	 <div style="width:100%;text-align:center;;background:#F0F0F0;">
	 <div style="width:100%;height:90px;"></div>
	 <div style="width:100%;height:90px;font-size: 28px; font-weight: bold;">Approve Charge</div>
	 <div style="border: 0px solid #ccc;">
	 <form id="fm" method="post" enctype="multipart/form-data" novalidate >
	 <input  name="chargeid" id="chargeId" type="hidden" > 
	 <input  name="filePath" id="filePath" type="hidden"> 
	 <input  name="submitter" id="chargeSubmitter" type="hidden">		
     <input name="approveResult" type="hidden">
	 <table style="margin:0 auto;">
	   <tr><td>Project</td><td> 
	       <input  name="proj_no" id="proj_no" type="text" class="easyui-textbox"></td>  
	    <td>First Price</td>
	    <td> 
	        <input  name="originalPrice" id="originalPrice" type="text" class="easyui-textbox"></td> 
	     <td></td><td></td></tr>	
	   <tr> 
	    <td>Final Price</td>
	    <td><input name="finalPrice" id="finalPrice" data-options="required:true" class="easyui-numberbox" min="0"></td> 
	    <td>Comment</td>
	    <td><input name="construction" id="construction" class="easyui-textbox" ></td>
	   <td></td><td></td></tr>	
	    
	 </table> 
	 
	 <div id="dlg" class="easyui-dialog"
		style="width: 580px; height: 450px;padding-top:100px; padding: 10px 20px" closed="true"
		buttons="#dlg-buttons">
		<div class="ftitle" id="ftitle"></div>
		<form id="mfm" method="post" enctype="multipart/form-data" novalidate>
		 
			<table>
			<tr><td></td><td></td></tr>
			<tr><td><label>To:</label></td><td> 
					<input name="to" id="smto" type="text" readonly="readonly" class="easyui-textbox" style="width:350px" /></td></tr>				
			 
			<tr>
				<td><label>PassOrNot</label></td>
				<td>
					<select name="approveResult" id="approveResult" class="easyui-combobox" name="dept" style="width:350px;">   
    					<option value="Pass">Pass</option>   
    					<option value="Not Pass">Not Pass</option>    
					</select>  
				</td>
				
			</tr>		
			<tr>
				<td align="top">YourOpinion:</td>
				<td><textarea name="opinion" id="opinion" Columns="50" TextMode="MultiLine" style="width:350px;
				 height:150px; word-wrap:break-word; word-break:break-all;" ></textarea>
				 </td></tr>						
			</table>			  		 													   
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" onclick="sendApprove()" style="width: 90px">send</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')"
			style="width: 90px">cancle</a>
	</div>	
	  <div>        
      	<!-- a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="save()">Save</a>&nbsp;&nbsp;       	-->     	 
	    <a   class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="downloadE()">Download Evidence</a>&nbsp;&nbsp; 
	    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="approve()">Approve</a>&nbsp;&nbsp;	         	    	       	 
      </div>	 
	 </form>
	 </div>
	</div>
</body>
</html>