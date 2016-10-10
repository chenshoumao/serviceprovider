<%@page import="com.solar.tech.bean.Po_Create"%>
<%@page import="com.solar.tech.bean.User"%>
<%@ page import="com.solar.tech.exception.ResultCode" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@page import="com.solar.tech.bean.Custumer"%>

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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
  display:inline-block;
  width:100px;
  text-align:right;
  margin-bottom:5px;
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
	$(function(){ 
		$("#start_time").datebox({
			onChange:function(n,o){ 
				var startTime = $("#start_time").datebox('getText');
				var complete_time= $("#complete_time").datebox('getText');
				 
				if(complete_time != ""){
					if(!isTimeOk(startTime,complete_time))
						$("#start_time").datebox('setValue','');
				} 
			}
		});
		$("#complete_time").datebox({
			onChange:function(n,o){ 
				var startTime = $("#start_time").datebox('getText');
				var complete_time= $("#complete_time").datebox('getText');
				 
				if(start_time != ""){
					if(!isTimeOk(startTime,complete_time))
						$("#complete_time").datebox('setValue','');
				} 
			}
		});
	})

	var url = "<%=basePath %>framework/cust/cust.action";
	$(function(){
		loadCustomer(url);
		loadManu(url);
	});
	
	function saveBean_addCM(){
		var text = $("#addText").val();
		if(text == ""){
			alert("请输入地址！");
		}
		else{
			$("#cust_address").val(text);
	    $('#fm_addCM').form('submit',{
	        url: url,
	        onSubmit: function(){
	            return $(this).form('validate');
	        },
	        success: function(result){
	        	alert("添加成功！");
	        	var url = "<%=basePath %>framework/cust/cust.action";
	        	loadCustomer(url);
	        	loadManu(url);
	            $('#dlg_addCM').dialog('close');        // close the dialog
	        }
	    });
	    }
		
	}
	
	function addCustomer(){
		//$("#fitemPassword_addCM").show();
	    $('#dlg_addCM').dialog('open').dialog('setTitle',' ');
	    $('#fm_addCM').form('clear');    
	    $("[name='<%=Custumer.Cust_type %>']").eq(0)[0].checked=true;    
	    //$('#headImg_addCM').attr("src","").attr("value","");
	    url = '<%=basePath%>framework/cust/add.action';
	    $('#ftitle_addCM').html("添加客户");
	}
	
	function loadCustomer(url){ 
		$.getJSON(url, function(json) {
			$('#cust').combobox({
			data : json,
			valueField:'cust_no',
			textField:'cust_name',
			onChange: function () {
			  var cvalue = $('#cust').combobox('getValue'); 
		 
		 
		 
			$.getJSON('<%=basePath%>framework/po/getPono.action', function(json) {
				 var povalue=cvalue+"-" + json;
			 	 $('#po').textbox("setValue",povalue);
			}) 
			 }									
			});
			if('<%=isDraft%>' == 1) 
			  findLastSave();
			});
	}
	
	
	var url = "<%=basePath %>framework/cust/manu.action";
	function loadManu(url){
		$.getJSON(url, function(m) {
			$('#manu').combobox({
			data : m,
			valueField:'cust_name',
			textField:'cust_name'
			});
		});
	}
	

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
    
    var val = $("#cust").combobox('getData');
	for(var i=0;i<val.length;i++){
		 
		 if(val[i].cust_name == res[0].customer){
		 	$("#cust").textbox('setValue',val[i].cust_no);
		 	$("#cust").textbox('setText',val[i].cust_name);
		 	break;
		 }
	}
     $("#manu").textbox('setValue',res[0].maufacturer);
  
   
  
 });
}
function getRandom(n){
        return Math.floor(Math.random()*n+1)
        }

var po_no;
function save(){ 
 po_no = $("input[name=po_no]").val(); 
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
           if(isDraft == 1){//保存草稿
           		alert("草稿保存成功！");
           		var _url = '<%=basePath %>console/biz/po/edit_po.jsp?po_no='+po_no+'&isDraft=1';
           		todoAdd(_url);
           		 
           } 
           else{//不是草稿，加入一条代办 TodoList
        		var po_no = $('#po').textbox('getValue');
        	    var submitter = '<%=com.solar.tech.util.Current.user().getUserName()%>';
        		var _url = "<%=basePath %>console/biz/po/approve_po.jsp?pono="+po_no+"&submitter="+submitter;
        		todoAdd(_url);
           }
        }
    });
} 
 


var url;
function sendmail(){	 
 var isHaveEvidence = $("input[name='contract_upload']").val();
 if(!isHaveEvidence == "" &&  $("#fm").form('validate')){
 	$("input[name=draft]").val(0); 
    $('#dlg').dialog('open').dialog('setTitle',' ');  
    url = '<%=basePath%>framework/mail/send.action';
    $('#ftitle').html("Send An Email");
 }
 else if(!$("#fm").form('validate')){
 	alert("资料未全部填完！");
 }
 else
 	alert("请上传附件！");
}

function saveBean(){	
	var user = '<%=com.solar.tech.util.Current.user().getUserName()%>';
	var basePath = '<%=basePath%>';
	
	var appendBody = "你有一条来自"+user+"的新记录需要审批，<br>"+user+"的留言是:"+$("#emailBody").val()+"<br>"
		+"<a href='"+ basePath+"framework/index.action"+"'>点此链接去看看！</a>";
	$('#dlg').dialog('close');
	$("#emailBody").val(appendBody);
	
	

	//保存表单
	save();
	//保存代办
	//todoAdd(_url); 
   
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
                //发送邮件 
                 $("#mfm").form('submit',{
        			url: url,
        			onSubmit: function(){			
            			return $(this).form('validate'); 
        			},
       				success: function(result){ 
            			$('#dlg').dialog('close');        // close the dialog
           	 			$('#dg').datagrid('reload');    // reload the user data
        			}
   	 			});
                
                if(draft == 0)
                	alert("创建成功，已通知对方");
                $("#dlg").dialog('close');
				window.location.href='<%=basePath%>console/biz/po/create_po.jsp';	
                closeWin();
            } else { 
            }
        },'json'); 	
}

//数字格式化
function fmoney(s, n) //s:传入的float数字 ，n:希望返回小数点几位 
{ 
n = n > 0 && n <= 20 ? n : 2; 
s = parseFloat((s + "").replace(/[^\d\.-]/g, "")).toFixed(n) + ""; 
var l = s.split(".")[0].split("").reverse(), 
r = s.split(".")[1]; 
t = ""; 
for(i = 0; i < l.length; i ++ ) 
{ 
t += l[i] + ((i + 1) % 3 == 0 && (i + 1) != l.length ? "," : ""); 
} 
return t.split("").reverse().join("") + "." + r; 
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

function isTimeOk(qian,houh){
    
	var end = new Date(houh.replace(/-/g, "/"));
	var start = new Date(qian.replace(/-/g, "/"));
	
	
	if (Date.parse(start) > Date.parse(end)) {
       alert('请注意时间顺序！');
       return false;
	} 
	return true;
	 
 
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
	 <div style="width:100%;text-align:center;margin:0 auto;background:#F0F0F0;">
	 <div style="width:100%;height:90px;"></div>
	 <div style="width:100%;height:90px;font-size: 28px; font-weight: bold;">Create A Project Order</div>
	 <div style="border: 0px solid #ccc;width:800px;margin:0 auto;">
	 <form id="fm" method="post" enctype="multipart/form-data" novalidate>
     <input  name="prod_type_desc"  type="hidden">
     <input  name="draft" value="1"  type="hidden">
	 <table style="text-align:center;margin-bottom:20px;" class="tt">
	 <tr> <td><label >Customer:</label></td><td><input name="customer"  id="cust" data-options="required:true,validType:['isExist']"/></td> <td style="padding-left: 90px;"><label >Manufacturer:</label></td><td><input name="maufacturer" id="manu" data-options="required:true" /></td></tr>
	 
	 <tr><td><label >PO No.: </label></td><td> <input name="po_no" id="po" class="easyui-textbox" readonly="true"	data-options="required:true,validType:['length[3,25]']"  /></td><td><label >PO description:</label></td><td><input name="po_desc" id="po_desc" class="easyui-textbox" data-options="required:true,validType:['length[3,100]']"  /></td> </tr>	 
	 <tr> <td><label >Contract Price:</label></td><td><input type="number" name="contract_price" id="contract_price" class="easyui-textbox"	data-options="required:true,validType:['length[3,15]']"/></td><td><label >Evidence:</label></td><td><input type="file" name="contract_upload" id="" style="width:152px;"></td></tr>	 
	 <tr> <td><label >Start time :</label></td ><td> <input name="start_time" id="start_time" class="easyui-datebox" type="text" data-options="required:true,editable:false" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:mm'})"/>	</td><td><label>Complete time: </label></td><td> <input name="complete_time" id="complete_time" class="easyui-datebox" type="text" data-options="required:true,editable:false" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:mm'}) "/></td></tr>	 
	 <tr> <td></td><td ><!-- button type="button" onclick="save()" >Save</button--></td><td></td><td ><!--button type="button" >Approve</button--></tr>
	 
	 </table>
	  <div>
	  	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addCustomer()">Customer Management</a>        
      	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="save()">Save</a>&nbsp;&nbsp;       	     	 
	    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="sendmail()">Save And SendMail</a>&nbsp;&nbsp; 
	    <!-- a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="">Approve</a-->&nbsp;&nbsp;	         	    	       	 
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
	
	<div id="dlg_addCM" class="easyui-dialog"
		style="width: 580px; height: 450px; padding: 10px 20px" closed="true"
		buttons="#dlg-buttons_addCM">
		<div class="ftitle" id="ftitle_addCM"></div>
		<form id="fm_addCM" method="post" enctype="multipart/form-data" novalidate>
			<input id="<%=Custumer.ID_CUST %>" name="<%=Custumer.ID_CUST %>"  type="hidden">

			<div class="fitem">
				<label>Name:</label>
				 <input name="cust_name" class="easyui-textbox"
				 	data-options="required:true,validType:['length[3,100]']"  />

			</div>

			<div class="fitem">
				<label>Abbr.:</label>
				 <input name="cust_no" class="easyui-textbox"
				 	data-options="required:true,validType:['length[3,100]']"  />

			</div>			
			<div class="fitem">
				<label>Address:</label>
				<div style="margin-left: 107px;margin-top: -20px;">
				<textarea id="addText" rows="3" cols=""    class="textarea easyui-validatebox"></textarea></div>
				  <input name="cust_address"  type="hidden" id="cust_address"
				 	 /> 

			</div>    
			<div class="fitem">
				<label>Contact Person:</label>
				 <input name="cust_type" class="easyui-textbox"
				 	data-options="required:true,validType:['length[3,100]']" />
			</div>		 	
		 	<div class="fitem">
				<label>Tel:</label>
				 <input name="cust_tel" class="easyui-textbox"
				 	data-options="required:true,validType:['length[8,20]']"/>
			</div> 




		 	<div class="fitem">
				<label>Email:</label>
				 <input name="cust_email" class="easyui-textbox"
				 	data-options="required:true,validType:['email']"/>
			</div> 			 
		 	<div class="fitem">
				<label>Position:</label>
				 <input name="position" class="easyui-textbox"
				 	data-options="required:true,validType:['length[5,100]']"/>
			</div> 
		 	<div class="fitem">
				<label>IA/COP vaild:</label>
				 <!-- input name="cust_iacop" class="easyui-textbox"
				 	data-options="required:true,validType:['length[1,15]'"/-->
			<select name="cust_iacop" style="width:160px">
			      <option    value="Y">Y</option>
			      <option    value="N">N</option>

			   </select> 	
				 	
				 	
			</div> 			
		 	<div class="fitem">
				<label>Make:</label>
				 <input name="cust_make" class="easyui-textbox"
				 	data-options="required:true,validType:['length[3,100]']"/>
			</div> 			
		 	
				<!--div class="fitem">
				<label>Description:</label>
				 <input name="description" class="easyui-textbox"  style="width:300px;height:100px;white-space: pre-wrap;"	data-options="multiline:true"/>
			</div-->
		</form>
	</div>
	
	<div id="dlg-buttons_addCM">
		<a href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" onclick="saveBean_addCM()" style="width: 90px">Save</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel" onclick="javascript:$('#dlg_addCM').dialog('close')"
			style="width: 90px">cancle</a>
	</div>
</body>
</html>