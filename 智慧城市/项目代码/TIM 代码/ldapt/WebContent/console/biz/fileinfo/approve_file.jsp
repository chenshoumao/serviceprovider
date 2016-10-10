<%@page import="com.solar.tech.bean.Po_Create"%>
<%@ page import="com.solar.tech.exception.ResultCode" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    String fileno=request.getParameter("fileno");
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
.readOnly{
	background-color: #ccc;
}
</style>
<script type="text/javascript"> 
 
var url11 = "<%=basePath %>framework/file/findfile.action?fileno=<%=fileno%>";
$.getJSON(url11, function(res) { 
   $("#from").textbox('setValue',res[0].from); 
    $("#ifileno").textbox('setValue',res[0].file_no); 
    $("#type").textbox('setValue',res[0].type);
    $("#standard").textbox('setValue',res[0].standard); 
    $("#nast_proj_no").textbox('setValue',res[0].nast_proj_no);
    $("#nast_rep_no").textbox('setValue',res[0].nast_rep_no);
   $("#idi_rep_no").textbox('setValue',res[0].idi_rep_no);
    $("#hest_or_no").textbox('setValue',res[0].hest_or_no);	
   $("#hest_rep_no").textbox('setValue',res[0].hest_rep_no);
    $("#cert_no").textbox('setValue',res[0].cert_no);
   $("#file_type").textbox('setValue',res[0].file_type);
    $("#rev_ext").textbox('setValue',res[0].rev_ext);
    $("#status").textbox('setValue',res[0].status);
   $("#category").textbox('setValue',res[0].category);
    $("#engineer").textbox('setValue',res[0].engineer);
    $("#manage").textbox('setValue',res[0].manage);
    
     $("#Coordinator").textbox('setValue',res[0].coordinator);
   $("#deadline").textbox('setValue',res[0].deadline);
   
    
  	
    
    $("#create_time").textbox("setValue",formatDatebox(res[0].create_time)); 
      $("#endtime").textbox("setValue",formatDatebox(res[0].endtime));  

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
     
       var fileno = $("#ifileno").val();  
       var opinion = $("#opinion").val();
       var resultOfApprove = $("#approveResult").combobox("getText");
      
       var url = '<%=basePath %>framework/todo/updateTodoFile.action?fileno='+fileno+'&approveResult='+ resultOfApprove + '&opinion='+opinion;
        $.getJSON(url, function(json) { 
        	var result = eval(json);  
        	if(result.state){ 
       		 url = '<%=basePath%>framework/file/approval.action?file_no='+ fileno+'&approveResult='+resultOfApprove,
       		 $.getJSON(url, function(json) {}); 
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
	 <div style="width:100%;height:90px;font-size: 28px; font-weight: bold;">Check The File</div>
	 <div style="border: 0px solid #ccc;">
	 <form id="fm" method="post" enctype="multipart/form-data" novalidate >
     <input name="approveResult" type="hidden">
	 <table style="margin:0 auto;">
	  <tr>
	  	<td><label >From</label> </td> 
	  	<td><input name="from" id="from" 
	  		class="easyui-textbox" data-options="required:true,validType:['length[3,15]']" />
	  	</td> 
	  	<td><label >File No. </label></td> 
	  	<td><input name="file_no" class="easyui-textbox" id="ifileno"  data-options="validType:['length[3,15]', 'isExist']"/> 
       	 
       
       </td><td><label >Type</label></td> 
       <td> <input class="easyui-textbox" id="type"/></td>
       <td><label >Standard</label></td> 
       <td> <input name="standard" id="standard" class="easyui-textbox"/> </td>
       </tr>
      <tr>
      	<td><label >NAST project No.</label></td> 
      	<td> <input name="nast_proj_no"  id="nast_proj_no" class="easyui-textbox" 
      			data-options="validType:['length[3,15]']"/>
      	</td> 
      	<td><label >NAST report No.</label></td> 
      	<td><input name="nast_rep_no" id="nast_rep_no" class="easyui-textbox"
      		 data-options="validType:['length[3,15]']" /> 
      	</td> 
      	<td><label >IDIADA report No.</label></td> 
      	<td> <input name="idi_rep_no" class="easyui-textbox" id="idi_rep_no" 
      			data-options="validType:['length[3,15]']" />
      	</td> 
      	<td> <label >Hestocon order No.</label> </td> 
      	<td><input name="hest_or_no" id="hest_or_no" class="easyui-textbox" 
      			data-options="validType:['length[3,15]']" /> 
      	</td>
      </tr>
      <tr><td><label >Hestocon report No.</label></td> 
      	  <td> <input name="hest_rep_no" class="easyui-textbox" 
      	  		id="hest_rep_no" data-options="validType:['length[3,15]']"/>
      	  </td> 
      	  <td><label >Certificate No.</label></td> 
      	  <td> <input name="cert_no" class="easyui-textbox" 
      	  		id="cert_no" data-options="validType:['length[3,15]']"/>
      	  </td> 
      	  <td><label >File type</label></td>
      	  <td> <input name="file_type" id="file_type" class="easyui-textbox"
      	  		 data-options="validType:['length[3,15]']"/>
      	  </td>
      	  <td><label >Rev / Ext.</label></td>
      	  <td> <input name="rev_ext" id="rev_ext" class="easyui-textbox"
      	  		 data-options="validType:['length[3,15]']"/> 
      	  </td>
      </tr>
      <tr><td><label >Status</label> </td> 
      	  <td><input name="status" id="status" class="easyui-textbox" data-options="validType:['length[3,15]']"/>
      	  </td> 
      	  <td><label >Category</label></td>
      	  <td> <input name="category" id="category" class="easyui-textbox"/>
      	  </td> 
      	  <td> <label >Engineer</label> </td>
      	  <td><input name="engineer" class="easyui-textbox"
      	  		 id="engineer"/>
      	  </td>
      	  <td> <label >Manager</label> </td>
      	  <td><input name="manage" id="manage" class="easyui-textbox" 
      	  />
      	  </td>
      </tr>
      <tr><td><label >Coordinator</label> </td>
      	  <td><input name="Coordinator" id="Coordinator" class="easyui-textbox" data-options="validType:['length[3,15]']" /></td>
      	  <td><label >Deadline</label></td>
      	  <td> <input name="deadline" id ="deadline" class="easyui-textbox"
      	   /></td>
      	  <td> <label >Create time</label></td>
      	  <td> <input name="create_time" class="easyui-textbox" id="create_time" 
      	  /></td>
      	  <td><label >End time</label></td>
      	  <td> <input name="endtime" id="endtime" class="easyui-textbox"/>
      	  </td>
      </tr>
      	
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
				<td><label>EmailAddress</label></td>
				<td><input name="EmailAddress" id="EmailAddress" readonly="readonly" type="text" class="easyui-textbox" style="width:350px" /></td>
			</tr>
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
      	<!-- a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="save()">Save</a>&nbsp;&nbsp;       	     	 
	    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="sendmail()">Save And SendMail</a>&nbsp;&nbsp; -->
	    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="approve()">Approve</a>&nbsp;&nbsp;	         	    	       	 
      </div>	 
	 </form>
	 </div>
	</div>
</body>
</html>