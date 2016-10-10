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
 
var url11 = "<%=basePath %>framework/charge/find.action?pono=<%=po_no %>";
$.getJSON(url11, function(res) {
 
    // alert(res[0].po_no);
            
    document.getElementById("project").value=res[0].proj_no ;  
    document.getElementById("originalPrice").value=res[0].originalPrice;
    document.getElementById("finalPrice").value=res[0].finalPrice;
     
    document.getElementById("construction").value=formatDatebox(res[0].construction);
    
 });
 
var url12 = "<%=basePath %>framework/todo/find.action?pono=<%=po_no %>";
$.getJSON(url12, function(res) {   
    $("#opinion").val(res.opinion); 
    
 });
 




function getRandom(n){
        return Math.floor(Math.random()*n+1)
        }


function save(){ 
 
    $('#fm').form('submit',{
        url: '<%=basePath %>framework/po/create.action',
        onSubmit: function(){
            return $(this).form('validate');
        },
        success: function(result){        
           var parsedJson = jQuery.parseJSON(result);    
           var url='<%=basePath %>console/biz/ps/projectsummary.jsp?pono='+parsedJson.po_no;
           window.location.href = url;
        }
    });
}
 
function approve(){  
   var submiter;
       var url = location.search;
			if (url.indexOf("?") != -1) {  
    		  	var index = url.indexOf("&");
      			var str = url.substr(index);
      			index = str.indexOf("=");
      			//获取提交者
      			submiter = str.substr(index+1); 
		}
        	 
            $("#smto").textbox("setText",submiter);
            url = '<%=basePath%>framework/ldap/userdetails.action?userName=' + submiter; 
        	$.getJSON(url, function(json) {
        		var email = json.email;
        		$("#EmailAddress").textbox("setText",email);
        		 
        	});
        
  
     $('#dlg').dialog('open').dialog('setTitle','Detail Of Approving'); 
}
function sendApprove(){
	 
   
       
     //  var obj=eval("(" + result + ")");
     
       var pono = $("#po").val();  
       var opinion = $("#opinion").val();
       var resultOfApprove = $("#approveResult").combobox("getText");
     
       var url = '<%=basePath %>framework/todo/updateTodoList.action?pono='+pono+'&approveResult='+ resultOfApprove + '&opinion='+opinion+'&url=<%=basePath%>&status=已审批';
        $.getJSON(url, function(json) { 
        	var result = eval(json);  
        	if(result.state){
        	$("input[name=approveResult]").val(resultOfApprove);
        	$('#fm').form('submit',{
       		 url: '<%=basePath%>framework/po/approval.action',
       		 onSubmit: function(){
             return $(this).form('validate');
        	}  
        	});
        	
            url = '<%=basePath%>framework/ldap/userdetails.action?userName=' + result.submiter; 
        	$.getJSON(url, function(json) {
        		var email = json.email;
        		url = '<%=basePath%>framework/mail/send.action?to=' + email+'&subject='+result.approveResult+'&body='+result.body;
        		$.getJSON(url, function(json) {
        			alert("已将结果邮件通知"+result.submiter);
        			$('#dlg').dialog('close');
        		});
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
</script>   	
</head>
<body style="text-align:center;;background:#F0F0F0;">
	 <div style="width:100%;text-align:center;;background:#F0F0F0;">
	 <div style="width:100%;height:90px;"></div>
	 <div style="width:100%;height:90px;font-size: 28px; font-weight: bold;">Create A Project Order</div>
	 <div style="border: 0px solid #ccc;">
	 <form id="fm" method="post" enctype="multipart/form-data" novalidate >
     <input name="approveResult" type="hidden">
	 <table style="margin:0 auto;">
	 <tr> <td><label >Porject:</label></td><td><input name="project"  id="project" readonly="readonly"/></td> 
	 	  <td><label >First Price:</label></td><td><input name="originalPrice" id="originalPrice" readonly="readonly"/></td></tr>	 
	 <tr>
	 	<td><label >Final Price:</label></td><td><input name="finalPrice" id="finalPrice" readonly="readonly"/></td>
	 <td><label >Comment: </label></td><td> <input name="construction" id="construction" type="text" readonly="readonly"/></td>
	  </tr>	 
	 <tr>
	 	<td>Opinion</td>
		<td colspan="3" style="padding-left: 20px;">
			<textarea readonly="readonly" id="opinion" style="width:475px;"></textarea>
		</td>
	 
	 </tr>
	 </table> 
	 
	 
	 </form>
	 </div>
	</div>
</body>
</html>