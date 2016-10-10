<%@page import="com.solar.tech.bean.Po_Create"%>
<%@page import="com.solar.tech.bean.User"%>
<%@ page import="com.solar.tech.exception.ResultCode" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    String isDraft =request.getParameter("isDraft");
    String po_no =request.getParameter("po_no");	
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

.tt td{ 
 font-size: 20px;
 font-weight: bold;
 text-align:right;
 height:30px;
 }
</style>
<script type="text/javascript"> 
var url = "<%=basePath %>framework/cust/cust.action";
$.getJSON(url, function(json) {
 
$('#cust').combobox({
data : json,
valueField:'cust_no',
textField:'cust_name',
onChange: function () {
  var cvalue = $('#cust').combobox('getValue'); 
  var d = new Date();
var vYear = d.getFullYear();
var vMon = d.getMonth() + 1;
var vDay = d.getDate();

 var s=vYear+(vMon<10 ? "0" + vMon : vMon)+(vDay<10 ? "0"+ vDay : vDay);
 var povalue=cvalue+"-"+s+"-"+getRandom(99);
  $('#po').textbox("setValue",povalue);
 }
});

  findLastSave();
});

var url = "<%=basePath %>framework/cust/manu.action";

$.getJSON(url, function(m) {
$('#manu').combobox({
data : m,
valueField:'cust_name',
textField:'cust_name'
});
});

var reviewer;
var meurl = '<%=basePath %>framework/group/showMembers.action?groupId=6';
$.getJSON(meurl, function(m) {
var json = m.rows;
$('#smto').combobox({
data :json,
valueField:'email', 
textField:'userName',
onChange: function () {
  reviewer  = $('#smto').combobox('getText');  
 //alert($('#smto').combobox('getText') + $('#smto').combobox('getValue'));
 }
});
});
 

function findLastSave(){
	var fileurl = "<%=basePath %>framework/po/findLastSave.action?po_no="+'<%=po_no%>';
$.getJSON(fileurl, function(res) { 
   
   $("#po").textbox('setValue',res[0].po_no); 
   $("#po_desc").textbox('setValue',res[0].po_desc);
    var start_time = new Date(res[0].start_time); 
   $("#start_time").datebox('setValue', start_time.getFullYear()+"-"+(start_time.getMonth()+1)+"-"+start_time.getDate());
    var complete_time = new Date(res[0].start_time); 
   $("#complete_time").datebox('setValue', complete_time.getFullYear()+"-"+(complete_time.getMonth()+1)+"-"+complete_time.getDate());
   $("#contract_price").textbox('setValue',res[0].contract_price);
   console.log("文件名："+res[0].contract_upload);
    var val = $("#cust").combobox('getData');
	for(var i=0;i<val.length;i++){
		 if(val[i].cust_name == res[0].customer){
		 	$("#cust").textbox('setValue',val[i].cust_no);
		 	$("#cust").textbox('setText',val[i].cust_name);
		 	break;
		 }
	}
     $("#manu").textbox('setValue',res[0].maufacturer);
   //$("input[name=contract_upload]").val(res[0].contract_upload.toString()); 
  
   
  
 });
}
function getRandom(n){
        return Math.floor(Math.random()*n+1)
        }

var po_no;
function save(){ 
 po_no = $("input[name=po_no]").val(); 
 
 	var isHaveEvidence = $("input[name='contract_upload']").val();
	var isEvidenceExist = false;
	var findEvidence = "<%=basePath %>framework/po/findLastSave.action?po_no="+'<%=po_no%>';
	$.getJSON(findEvidence, function(res) { 
		//(res[0].contract_upload);
		if(res[0].contract_upload != "" || isHaveEvidence != ""){
			isEvidenceExist = true;
		}
			
		if(isEvidenceExist || isHaveEvidence != ""){
			$("input[name=draft]").val(0);
	    	$('#fm').form('submit',{
        url: '<%=basePath %>framework/po/create.action', 
        onSubmit: function(){
            return $(this).form('validate');
        },
        success: function(result){  
           var parsedJson = jQuery.parseJSON(result); 
            po_no= parsedJson.po_no ;   
            var url='<%=basePath %>console/biz/ps/projectsummary.jsp?pono='+parsedJson.po_no;
           //window.location.href = url;
           $.getJSON(url, function(json) {});
           var isDraft = $("input[name=draft]").val();
           if(isDraft == 1){
           		alert("草稿保存成功！");
           		var _url = '<%=basePath %>console/biz/po/edit_po.jsp?po_no='+po_no+'&isDraft=1';
           		todoAdd(_url);
           }  
        }
    });
		}else
			alert("请上传附件！");
	});
   
}

var url;
function sendmail(){	
	var isHaveEvidence = $("input[name='contract_upload']").val();
	var isEvidenceExist = false;
	var findEvidence = "<%=basePath %>framework/po/findLastSave.action?po_no="+'<%=po_no%>';
	$.getJSON(findEvidence, function(res) { 
		//(res[0].contract_upload);
		if(res[0].contract_upload != "" || isHaveEvidence != ""){
			isEvidenceExist = true;
		}
			
		if(isEvidenceExist){
	    	$("input[name=draft]").val(0);
	    	$('#dlg').dialog('open').dialog('setTitle',' ');  
	    	url = '<%=basePath%>framework/mail/send.action';
	    	$('#ftitle').html("Send An Email");
		}else
			alert("请上传附件！");
	});
	
}




function saveBean(){	
	var user = '<%=com.solar.tech.util.Current.user().getUserName()%>';
	var basePath = '<%=basePath%>';
	
	var appendBody = "你有一条来自"+user+"的新记录需要审批，<br>"+user+"的留言是:"+$("#emailBody").val()+"<br>"
		+"<a href='"+ basePath+"framework/index.action"+"'>点此链接去看看！</a>";
	$('#dlg').dialog('close');
	$("#emailBody").val(appendBody);
    $("#mfm").form('submit',{
        url: url,
        onSubmit: function(){			
            return $(this).form('validate'); 
        },
        success: function(result){
        	var po_no = $('#po').textbox('getValue');
        	var submitter = '<%=com.solar.tech.util.Current.user().getUserName()%>';
			var _url = "<%=basePath %>console/biz/po/approve_po.jsp?pono="+po_no+"&submitter="+submitter;
			 
        	save(); 
 			todoAdd(_url);
            $('#dlg').dialog('close');        // close the dialog
            $('#dg').datagrid('reload');    // reload the user data
        }
    });
}
function todoAdd(_url){ 
		//预制一些数据
		var itemname = "Porject Order";
		var itemid = po_no;
		var itemurl = _url;
		var draft = $("input[name=draft]").val();
		var status = '未审批';
		/**var reviewer = "<%=com.solar.tech.util.Current.user().getUserName()%>";	*/					
        $.post('<%=basePath%>framework/todo/add.action',{itemname:itemname,itemid:itemid, itemurl:itemurl, reviewer:reviewer,draft:draft,status:status},function(result){
            if (result.success){ 
            	//var url='<%=basePath %>console/biz/ps/projectsummary.jsp?pono='+po_no;
                //window.location.href = url;
                if(draft == 0){
                	alert("创建成功，已通知对方");
                	window.location.href='<%=basePath %>console/biz/po/shows.jsp';
                }
                  $("#dlg").dialog('close'); 
                  closeWin();
            } else { 
            	  closeWin();
            }
        },'json'); 	
      
        
}
//刷新父页面
function closeWin(){ 
	window.opener.location.reload();
  	window.opener=null;
  	window.open('','_self');
  	window.close();
}


/**
function approve(){ 
 
    $('#fm').form('submit',{
        url: '<%=basePath %>framework/po/create.action',
        onSubmit: function(){
            return $(this).form('validate');
        },
        success: function(result){


        }
    });
}
*/

$.extend($.fn.validatebox.defaults.rules, {  
    isExist: {
        validator:function(value,param){
        	var r=false;
        	$.ajax({  
                type : "post",  
 /**             url : "<%=basePath%>framework/po/isExist.action",
                 data : {id_po_create:'', po_no:value}, */
                 url : "<%=basePath%>framework/cust/isExist.action",
                 data : {id_cust:'', cust_name:value,cust_no:''},                  
                 
                 dataType: 'json',
                 async : false,  
                 success : function(data){
                	 if(data==true) r=true;
                 }  
            }); 
            return r;
        },  message:' Customer is not Exist' }

}); 


</script>   	
</head>
<body style="text-align:center;;background:#F0F0F0;">
	 <div style="width:100%;text-align:center;margin:0 auto;background:#F0F0F0;">
	 <div style="width:100%;height:90px;"></div>
	 <div style="width:100%;height:90px;font-size: 28px; font-weight: bold;">Edit Project Order</div>
	 <div style="border: 0px solid #ccc;width:800px;margin:0 auto;">
	 <form id="fm" method="post" enctype="multipart/form-data" novalidate>
     <input  name="prod_type_desc"  type="hidden">
     <input  name="draft" value="1"  type="hidden">
	 <table style="text-align:center;margin-bottom:20px;" class="tt">
	 <tr> <td><label >Customer:</label></td><td><input name="customer"  id="cust" data-options="required:true,validType:['isExist']"/></td> <td style="padding-left: 90px;"><label >Manufacturer:</label></td><td><input name="maufacturer" id="manu" data-options="required:true" /></td></tr>
	 
	 <tr><td><label >PO No.: </label></td><td> <input name="po_no" id="po" class="easyui-textbox" readonly="true"	data-options="required:true,validType:['length[3,25]']"  /></td><td><label >PO description:</label></td><td><input name="po_desc" id="po_desc" class="easyui-textbox"/></td> </tr>	 
	 <tr> <td><label >Contract Price:</label></td><td><input type="number" name="contract_price" id="contract_price" class="easyui-textbox"	data-options="required:true,validType:['length[3,15]']"/></td><td><label >Evidence:</label></td><td><input type="file" name="contract_upload" id="" style="width:152px;"></td></tr>	 
	 <tr> <td><label >Start time :</label></td ><td> <input name="start_time" id="start_time" class="easyui-datebox" type="text" data-options="required:true,editable:false" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:mm'})"/>	</td><td><label>Complete time: </label></td><td> <input name="complete_time" id="complete_time" class="easyui-datebox" type="text" data-options="required:true,editable:false" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:mm'}) "/></td></tr>	 
	 <tr> <td></td><td ><!-- button type="button" onclick="save()" >Save</button--></td><td></td><td ><!--button type="button" >Approve</button--></tr> 	 
	 </table>
	  <div>        
      	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="save()">save</a>&nbsp;&nbsp;       	     	 
	    <!-- <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="sendmail()">Save And SendMail</a>&nbsp;&nbsp; 
	    a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="">Approve</a-->&nbsp;&nbsp;	         	    	       	 
      </div>
	 </form>
	 </div>
	 
	 
	 <div id="dlg" class="easyui-dialog"
		style="width: 580px; height: 450px; padding: 10px 20px" closed="true"
		buttons="#dlg-buttons">
		<div class="ftitle" id="ftitle"></div>
		<form id="mfm" method="post" enctype="multipart/form-data" novalidate>
				
			<table>
			<tr><td></td><td></td></tr>
			<tr><td><label>To:</label></td><td> 
					<input name="to" id="smto" type="text" class="easyui-textbox" style="width:350px" data-options="required:true"/></td></tr>				
			<tr>
				<td><label>Subject:</label></td>
				<td><input name="subject" type="text" class="easyui-textbox" style="width:350px" /></td></tr>			
			<tr>
				<td align="top">Body:</td>
				<td><textarea name="body" id="emailBody" Columns="50" TextMode="MultiLine" style="width:350px;
				 height:300px; word-wrap:break-word; word-break:break-all;" ></textarea>
				 </td></tr>						
			</table>			  		 													   
		</form>
	</div>

	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" onclick="saveBean()" style="width: 90px">send</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')"
			style="width: 90px">cancle</a>
	</div>	 
	 
	</div>
</body>
</html>