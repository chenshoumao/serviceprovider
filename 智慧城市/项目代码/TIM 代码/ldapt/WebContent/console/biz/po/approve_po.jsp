<%@page import="com.solar.tech.bean.Po_Create"%>
<%@ page import="com.solar.tech.exception.ResultCode" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@page import="java.io.File" %>
<%@page import="java.io.OutputStream" %>
<%@page import="java.io.InputStream" %>
<%@page import="java.io.FileInputStream" %>

<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    String po_no=request.getParameter("pono");
    String submitter=request.getParameter("submitter");
    
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="<%=basePath %>scripts/common/jquery-easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=basePath %>scripts/common/jquery-easyui/themes/icon.css">

<script type="text/javascript" src="<%=basePath %>scripts/common/jquery-easyui/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath %>scripts/common/jquery-easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=basePath %>scripts/common/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>

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

var url = "<%=basePath %>framework/cust/cust.action";
var url = "<%=basePath %>framework/cust/manu.action";
 

var url11 = "<%=basePath %>framework/po/find.action?pono=<%=po_no %>";
$.getJSON(url11, function(res) { 
    // alert(res[0].po_no); 
    document.getElementById("po").value=res[0].po_no ;  
    document.getElementById("cust").value=res[0].customer;
    document.getElementById("manu").value=res[0].maufacturer; 
    document.getElementById("desc").value=res[0].po_desc;
    document.getElementById("pro").value=res[0].prod_type_desc; 
    document.getElementById("start").value=formatDatebox(res[0].start_time);
    document.getElementById("comp").value=formatDatebox(res[0].complete_time); 
    
    //alert(path.substr(path.lastIndexOf("/")+1,path.length)); 
  //  $("#filename").val(path.substr(path.lastIndexOf("/")+1,path.length));
  $("#filename").val(res[0].contract_upload);
   $("#contract_price").val(res[0].contract_price); 
   $("#downPath").val(res[0].quotation_upload);
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
	
   var submiter  = "<%=submitter%>"; 
        
        	 
            $("#smto").textbox("setText",submiter);
            url = '<%=basePath%>framework/ldap/userdetails.action?userName=' + submiter; 
        	$.getJSON(url, function(json) {
        		var email = json.email;
        		$("#EmailAddress").textbox("setText",email);
        		 
        	});
        
  
     $('#dlg').dialog('open').dialog('setTitle','Detail Of Approving'); 
}

function sendApprove(){
       var pono = $("#po").val();  
       var opinion = $("#opinion").val();
       var resultOfApprove = $("#approveResult").combobox("getText");
       var result = $('#approveResult').combobox('getValue');
       var itemurl;
       if(result=='Pass'){
	       itemurl = "<%=basePath %>console/biz/ps/projectsummary.jsp?pono="+pono;
       }else{
    	   itemurl = "<%=basePath %>console/biz/po/viewPoResult.jsp?po_no="+pono;
       }
       var url = '<%=basePath %>framework/todo/updateTodoList.action?pono='+pono+'&approveResult='+ resultOfApprove + '&opinion='+opinion+'&url=<%=basePath%>&status=已审批'+'&itemurl='+itemurl;
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
        			  closeWin();
        		});
        	});
        	}
        }); 
}


function closeWin(){
	window.opener.location.reload();
  	window.opener=null;
  	window.open('','_self');
  	window.close();
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
function down() {
	window.location.href = '<%=basePath %>framework/dl/down.action?fileUrl='+$("#downPath").val()+'&filename='+$("#filename").val();
}
</script>   	
</head>
<body style="text-align:center;;background:#F0F0F0;">
	 <div style="width:100%;text-align:center;;background:#F0F0F0;">
	 <div style="width:100%;height:90px;"></div>
	 <div style="width:100%;height:90px;font-size: 28px; font-weight: bold;">approve Project Order</div>
	 <div style="border: 0px solid #ccc;">
	 <form id="fm" method="post" enctype="multipart/form-data" novalidate >
     <input name="approveResult" type="hidden">
     <input name="downPath" id="downPath" type="hidden">
	 <table style="margin:0 auto;">
	 <tr> <td><label >Customer:</label></td><td><input readonly="readonly" name="customer"  id="cust" data-options="required:true"/></td> <td><label >Manufacturer:</label></td><td><input readonly="readonly" name="maufacturer" id="manu" data-options="required:true" /></td></tr>	 
	 <tr><td><label >PO No.: </label></td><td> <input readonly="readonly" name="po_no" id="po" type="text"	data-options="required:true,validType:['length[3,15]', 'isExist']"  /></td><td><label >PO description:</label></td><td><input readonly="readonly" name="po_desc" id="desc" data-options="required:true"  /></td> </tr>	 
	 <tr> <td><label >Product type description:</label></td><td><input readonly="readonly" name="prod_type_desc" id="pro"	data-options="required:true"/></td><td><label>contract_price: </label></td><td> <input readonly="readonly" name="Contract Price" id="contract_price" type="text" readonly="readonly"/></td></tr>	 
	 <tr> <td><label >Start time :</label></td ><td> <input readonly="readonly" name="start_time" id="start" type="text"data-options="required:true" />	</td><td><label>Complete time: </label></td><td> <input readonly="readonly" name="complete_time" id="comp" type="text" data-options="required:true"/></td></tr>	 
	 <tr> <td><label >Evidence :</label></td ><td> <input   name="filename" id="filename" type="text"data-options="required:true" readonly="readonly"/>	</td><td></td><td> </td></tr>	 
	  		
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
      	<!-- a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="save()">Save</a>&nbsp;&nbsp;       	 -->     	 
	    <a  class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="down()" >Download the Evidence</a>&nbsp;&nbsp;
	    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="approve()">Approve</a>&nbsp;&nbsp;	         	    	       	 
      </div>	 
	 </form>
	 </div>
	</div>
</body>
</html>