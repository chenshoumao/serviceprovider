<%@page import="com.solar.tech.bean.Po_Create"%>
<%@ page import="com.solar.tech.exception.ResultCode" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@page import="com.solar.tech.bean.Custumer"%>

<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    String po_no=request.getParameter("pono");
    String isDraft =request.getParameter("isDraft");
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
.qq tr td{line-height:30px;}
.qq tr td:nth-child(2){padding-right:30px;}
.saveall{    padding: 5px 47px; font-size: 12px; line-height: 20px; border-radius: 3px; color: #fff; background-color: #337ab7; border-color: #2e6da4; border: none; margin-top: 20px; margin-left: 129px;}
#fm table tr td input{text-indent:5px;}
.fitem label{width:100px;text-align:right;display:inline-block;}
</style>
<script type="text/javascript">

var url = "<%=basePath %>framework/cust/cust.action";
$(function(){
	custList();
	loadManu(url);
});
/**
$.getJSON(url, function(json) {
$('#cust').combobox({
data : json,
valueField:'cust_no',
textField:'cust_name',
onChange: function () {
    var cvalue = $('#cust').combobox('getValue'); 
    var ctext = $('#cust').combobox('getText'); 
  //alert(ctext);
  var d = new Date();
var vYear = d.getFullYear();
var vMon = d.getMonth() + 1;
var vDay = d.getDate();

 var s=vYear+(vMon<10 ? "0" + vMon : vMon)+(vDay<10 ? "0"+ vDay : vDay);
//document.write(s);
  $('#po').textbox("setValue",cvalue+s+getRandom(99));
 // $('#Customer').textbox("setValue",);
 }
});
});


$.getJSON(url, function(m) {
$('#manu').combobox({
data : m,
valueField:'cust_name',
textField:'cust_name'
});
});
**/
var url11 = "<%=basePath %>framework/po/find.action?pono=<%=po_no %>";
$.getJSON(url11, function(res) {
 
            
   // document.getElementById("pon").value=res[0].po_no ;
    //document.getElementById("cust").value=res[0].customer;
    custList();
    $("#desc").textbox('setValue',res[0].po_desc);
    console.log(res[0].prod_type_desc);
    $("#contract_price").textbox('setValue',res[0].contract_price);
    var start_time = new Date(res[0].start_time); 
    $("#start").datebox('setValue', start_time.getFullYear()+"-"+(start_time.getMonth()+1)+"-"+start_time.getDate());
    var complete_time = new Date(res[0].start_time); 
   $("#comp").datebox('setValue', complete_time.getFullYear()+"-"+(complete_time.getMonth()+1)+"-"+complete_time.getDate());
 });




function getRandom(n){
        return Math.floor(Math.random()*n+1)
        }


function save(){ 
	po_no = $("input[name=po_no]").val();
    $('#fm').form('submit',{
        url: '<%=basePath %>framework/po/create.action',
        onSubmit: function(){
            return $(this).form('validate');
        },
        success: function(result){        
        	var isDraft = $("input[name=draft]").val();
            if(isDraft == 1){
            		alert("草稿保存成功！");
            		var _url = '<%=basePath %>console/biz/po/edit_po.jsp?po_no='+po_no+'&isDraft=1';
               		todoAdd(_url);
            }  
        }
    });
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

function custList(){
	var url = "<%=basePath %>framework/cust/cust.action"; 
	
	$.getJSON(url, function(json) {
		$('#cust').combobox({
		data : json,
		valueField:'cust_no',
		textField:'cust_name',
		onChange: function () {
			createPoNo();
		}
		});
		//macthCust(res);
	});
}

function macthCust(res){
	var val = $("#cust").combobox('getData');
	  for(var i=0;i<val.length;i++){
			 if(val[i].cust_name == res[0].customer){
			 	$("#cust").textbox('setValue',val[i].cust_no);
			 	$("#cust").textbox('setText',val[i].cust_name);
			 	break;
			 }
		}
	  $("#manu").textbox('setValue',res[0].maufacturer);
		createPoNo();
}

function createPoNo(){
	var cvalue = $('#cust').combobox('getValue'); 
	var d = new Date();
	var vYear = d.getFullYear();
	var vMon = d.getMonth() + 1;
	var s=vYear+(vMon<10 ? "0" + vMon : vMon);
	var povalue=cvalue+"-"+s+"-"+getRandom(99);
	$('#po').textbox("setValue",povalue);
	
}


var url = "<%=basePath %>framework/cust/manu.action";

function sendmail(){	
	//alert("as")
	var isHaveEvidence = $("input[name='contract_upload']").val();
	 if(!isHaveEvidence == ""){
	 $("input[name=draft]").val(0);
		//save();	
	    $('#dlg').dialog('open').dialog('setTitle',' ');  
	    
	    url = '<%=basePath%>framework/mail/send.action';
	    $('#ftitle').html("Send An Email");
	 }
	 else
 		alert("请上传附件！");
}


function back(){
	var urlback="http://localhost:8080/Dats/console/biz/po/shows.jsp";
	window.location.href=urlback;
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
        }
    });
}

function todoAdd(_url){ 
	//预制一些数据
	var itemname = "Porject Order";
	var itemid = $("input[name=po_no]").val();;
	var itemurl = _url;
	var draft = $("input[name=draft]").val();
	var status = '未审批';
	/**var reviewer = "<%=com.solar.tech.util.Current.user().getUserName()%>";	*/					
    $.post('<%=basePath%>framework/todo/add.action',{itemname:itemname,itemid:itemid, itemurl:itemurl, reviewer:reviewer,draft:draft,status:status},function(result){
        if (result.success){ 
        	console.log("进来了没？");
        	//var url='<%=basePath %>console/biz/ps/projectsummary.jsp?pono='+po_no;
            //window.location.href = url;
            if(draft == 0){
            	alert("创建成功，已通知对方");
            	window.location.href='<%=basePath %>console/biz/po/shows.jsp';            	
            }
            $("#dlg").dialog('close'); 
        } else { 
        }
    },'json'); 	
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

function addCustomer(){
	//$("#fitemPassword_addCM").show();
    $('#dlg_addCM').dialog('open').dialog('setTitle',' ');
    $('#fm_addCM').form('clear');    
    $("[name='<%=Custumer.Cust_type %>']").eq(0)[0].checked=true;    
    //$('#headImg_addCM').attr("src","").attr("value","");
    url = '<%=basePath%>framework/cust/add.action';
    $('#ftitle_addCM').html("添加客户");
}

function saveBean_addCM(){
	
    $('#fm_addCM').form('submit',{
        url: url,
        onSubmit: function(){
            return $(this).form('validate');
        },
        success: function(result){
        	alert("添加成功！");
        	var url = "<%=basePath %>framework/cust/cust.action";
        	$("#po").textbox("setValue","");
        	custList();
        	loadManu(url);
            $('#dlg_addCM').dialog('close');        // close the dialog
        }
    });
	
}

function loadManu(url){
	$.getJSON(url, function(m) {
		$('#manu').combobox({
		data : m,
		valueField:'cust_name',
		textField:'cust_name'
		});
	});
}
</script>   	
</head>
<body style="text-align:center;;background:#F0F0F0;">
	 <div style="width:100%;text-align:center;;background:#F0F0F0;">
	 <div style="width:100%;height:90px;"></div>
	 <div style="width:100%;height:90px;font-size: 28px; font-weight: bold;">Create A Project Order</div>
	 <div style="border: 0px solid #ccc;">
	 <form id="fm" method="post" enctype="multipart/form-data" novalidate>
	 <input name="draft" value="1" type="hidden"/>
	 <table style="margin:0 auto;" class="qq">
	 <tr> <td><label >Customer:</label></td><td><input name="customer"  id="cust" data-options="required:true"/></td> <td><label >Manufacturer:</label></td><td><input name="maufacturer" id="manu" data-options="required:true" /></td></tr>	 
	 <tr><td><label >PO No.: </label></td><td> <input name="po_no" id="po" class="easyui-textbox"	data-options="required:true,validType:['length[3,25]', 'isExist']"  /></td><td><label >PO description:</label></td><td><input name="po_desc" id="desc" class="easyui-textbox" data-options="required:true,validType:['length[3,15]']" /></td> </tr>	 
	 <tr> <td><label >Contract Price:</label></td><td><input type="number" name="contract_price" id="contract_price" class="easyui-textbox"	data-options="required:true,validType:['length[3,15]']"/></td><td><label >Evidence:</label></td><td><input type="file" name="contract_upload" id="" style="width:152px;"></td></tr>	 
	 <tr> <td><label >Start time :</label></td ><td> <input name="start_time" id="start" class="easyui-datebox" type="text" data-options="required:true,editable:false" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:mm'})"/>	</td><td><label>Complete time: </label></td><td> <input name="complete_time" id="comp" class="easyui-datebox" type="text" data-options="required:true,editable:false" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:mm'}) "/></td></tr>	 
	 </table>
	 <div  style="margin-top:30px;">
	 	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="addCustomer()">Add Customer Manager</a>        
      	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="save()">Save</a>&nbsp;&nbsp;       	     	 
	    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="sendmail()">Save And SendMail</a>&nbsp;&nbsp;
	    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" plain="true"  onclick="back()">Back</a>&nbsp;&nbsp;
	    <!-- a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="">Approve</a-->&nbsp;&nbsp;	         	    	       	 
     </div>
	 </form>
	 </div>
	</div>
	
	<div id="dlg" class="easyui-dialog"
		style="width: 580px; height: 450px; padding: 10px 20px" closed="true"
		buttons="#dlg-buttons">
		<div class="ftitle" id="ftitle"></div>
		<form id="mfm" method="post" enctype="multipart/form-data" novalidate>
				
			<table>
			<tr><td></td><td></td></tr>
			<tr><td><label>To:</label></td><td> 
					<input name="to" id="smto" type="text" class="easyui-textbox" style="width:350px" /></td></tr>				
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
	
	<div id="dlg_addCM" class="easyui-dialog"
		style="width: 580px; height: 450px; padding: 10px 20px" closed="true"
		buttons="#dlg-buttons_addCM">
		<div class="ftitle" id="ftitle_addCM"></div>
		<form id="fm_addCM" method="post" enctype="multipart/form-data" novalidate>
			<input id="<%=Custumer.ID_CUST %>" name="<%=Custumer.ID_CUST %>"  type="hidden">

			<div class="fitem">
				<label>Name:</label>
				 <input name="cust_name" class="easyui-textbox"
				 	data-options="required:true,validType:['length[3,15]']"  />

			</div>

			<div class="fitem">
				<label>Abbr.:</label>
				 <input name="cust_no" class="easyui-textbox"
				 	data-options="required:true,validType:['length[3,15]']"  />

			</div>			
			<div class="fitem">
				<label>Address:</label>
				 <input name="cust_address43" class="easyui-textbox"
				 	data-options="required:true,validType:['length[6,20]']"  />

			</div>    
			<div class="fitem">
				<label>Contact Person:</label>
				 <input name="cust_type" class="easyui-textbox"
				 	data-options="required:true,validType:['length[3,15]']" />
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
				 	data-options="required:true,validType:['length[5,50]']"/>
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
				 	data-options="required:true,validType:['length[3,15]']"/>
			</div> 			
		 	
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