<%@page import="com.solar.tech.bean.Charge"%>
<%@page import="com.solar.tech.bean.TravelFee"%>
<%@ page import="com.solar.tech.exception.ResultCode" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    String po_no=request.getParameter("pono");
    String price = request.getParameter("contract_price");
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
<title>Insert title here</title>
<style type="text/css">
* { 
	padding: 0px;
	margin: 0px;
}

#fm,#ps {
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
	margin-bottom: 5px;
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
.ee tr td:nth-child(1){padding:6px 0px;}
.ee tr td:nth-child(2){padding-right:30px;}
#ffm{font-size:16px;}
#ffm table tr td{padding-top:14px;}
</style>
<script type="text/javascript">
$(function(){ 
	
	var findInitPriceUrl = '<%=basePath%>framework/po/find.action';
	$.ajax({
		url : findInitPriceUrl,
		data:{'pono':'<%=po_no%>'},
	 
		dataType:'json',
		success:function(data){  
			$("#contract_price").val(data[0].contract_price);
		}
	});
	
	var loadAllNumberUrl = '<%=basePath%>framework/charge/loadAllNumberUrl.action';
	$.ajax({
		url:loadAllNumberUrl,
		data:{'pono':'<%=po_no%>'},
		type:'post',
		dataType:'json',
		success:function(data){ 
			var json = eval(data); 
			if(json.status){   
				var money = parseFloat(json.money); 
				if(money > 0){
					$("#tc").val(money);
				}
				else
					$("#tc").val('<%=price%>');
			}
			else{
				$("#tc").val('<%=price%>');
			}
		}
	});
	
	
	$('#edg').datagrid({
	    height: 'auto',
	    fit:false,
	    url: '<%=basePath %>framework/charge/shows.action?pono=<%=po_no%>',
	    method: 'POST',
	    striped: true,
	    nowrap: true,
	    pageSize: 10,
	    pageNumber:1, 
	    pageList: [10, 20, 50, 100, 150, 200],
	    showFooter: true,
		loadMsg : '数据加载中请稍后……',
		pagination : true,
	    toolbar:"#etoolbar",
	    checkOnSelect:false,
	    selectOnCheck:false,  
	    columns: [[  
	        { field: 'ck', checkbox: true },
	        { field: 'proj_no', title: 'No.', width: '25%',align:'center'},
	        { field: 'originalPrice', title: 'First Price', width: '15%',align:'center'},
	        { field: 'finalPrice', title: 'final Price', width: '15%',align:'center'},
	        { field: 'construction', title: 'Comment',  width: '22%',align:'center'},
	        { field: 'status', title: 'status',  width: '21%',align:'center'}  
	             
	    ]],

	    onDblClickRow :function(rowIndex,rowData){
	    	eeditBean(rowData);
	   	} 
	});
});

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
var eurl;
var user = "<%=com.solar.tech.util.Current.user().getUserName()%>" ; 
function enewBean(){
	
    
    $('#edlg').dialog('open').dialog('setTitle',' ');
    $('#efm').form('clear');  
    $("#chargeSubmitter").val("test");
    
	document.getElementById("epo").value='<%=po_no %>';    
    eurl = '<%=basePath%>framework/charge/add.action';
    $('#eftitle').html("exspense");
}
var furl;
function fnewBean(){ 
    $('#fdlg').dialog('open').dialog('setTitle',' ');
    $('#ffm').form('clear');
    $("#travelSubmitter").val("test"); 
    $("#status").val("未审批");  
    $('input:radio[name="userType"][value="staft"]').prop('checked', true);
    document.getElementById("fpo").value='<%=po_no %>';    
    furl = '<%=basePath%>framework/tra/add.action';
    $('#fftitle').html("Travel fee");
}
function detailCharge(){ 
	$.ajax({
		url:'<%=basePath%>framework/charge/showsSumOfCharge.action',
		dataType:'json',
		data:{'pono':'<%=po_no%>'},
		type:'post',
		success:function(data){ 
			if(data.sum != null)
			  alert("Total money:"+data.sum);
			else
				alert("Total money:0");
		}
	});
}

function detailTravel(){ 
	$.ajax({
		url:'<%=basePath%>framework/tra/showsSumOfTravel.action',
		dataType:'json',
		data:{'pono':'<%=po_no%>'},
		type:'post',
		success:function(data){  
			if(data.sum != null)
				alert("Total money:"+data.sum);
			else
				alert("Total money:0");
		}
	});
}

function eeditBean(row){
    if (row){ 
        $('#edlg').dialog('open').dialog('setTitle','');
        $('#efm').form('load',row); 
        eurl = '<%=basePath%>framework/charge/update.action';    
        $('#eftitle').html("Edit ");
    }
}

function feditBean(row){
    if (row){

        $('#fdlg').dialog('open').dialog('setTitle','');
        $('#ffm').form('load',row);
        furl = '<%=basePath%>framework/tra/update.action';    
        $('#fftitle').html("Edit ");
    }
}

//发送邮件
function sendmail(smto){	 
    var url = '<%=basePath%>framework/mail/send.action';
    $.ajax({
    	url:url,
    	data:{
    	'subject':"charge approving",
    	'body':'Your have a new charge to approve<br><a href="<%=basePath%>framework/index.action">click this to view</a>',
    	'to':smto},
    	type:'post',
    	success:function(data){    		 
    			alert("已通知相关人员审批");
    	}
    });
}
 
var managerUrl = '<%=basePath %>framework/group/showMembers.action?groupId=6';
$.getJSON(managerUrl, function(m) { 
	var json = m.rows; 
	$('#Approver').combobox({
	data : json, 
	valueField:'email',
	textField:'userName'
	});
	});
	
var approveUrl = '<%=basePath %>framework/group/showMembers.action?groupId=6';
$.getJSON(approveUrl, function(m) { 
	var json = m.rows; 
	$('#travelFeeApprover').combobox({
	data : json, 
	valueField:'email',
	textField:'userName'
	});
	});

function esaveBean(){  
	
    $('#efm').form('submit',{
        url: eurl,
        onSubmit: function(){
            return $(this).form('validate');
        }, 
        success: function(result){
        	var json =eval('(' + result + ')');  
        	var itemid = json.chargeId;
        	var todoUrl = "<%=basePath%>framework/todo/add.action";
        	var itemurl = "<%=basePath%>console/biz/po/charge_appro.jsp?chargeId="+itemid;
        	var approver = $("#Approver").combobox('getText');
        	$.ajax({
        		url:todoUrl,
        		data:{"itemname":"Charge","itemid":itemid,"itemurl":itemurl,reviewer:approver,status:"未审批"},
        		type:"post"
        	});
        	sendmail($("#Approver").combobox('getValue'));
        	
            $('#edlg').dialog('close');        // close the dialog
            $('#edg').datagrid('reload');    // reload the user data
        }
    });
}
function fsaveBean(){  
	
	 
    $('#ffm').form('submit',{
        url: furl,
        dataType:'json',
        onSubmit: function(){
            return $(this).form('validate');
        },
        success: function(result){ 
            var json =eval('(' + result + ')'); 
        	var itemid = json.feeId;
        	var todoUrl = "<%=basePath%>framework/todo/add.action";
        	var itemurl = "<%=basePath%>console/biz/po/travel_appro.jsp?feeId="+itemid;
        	var traverfeeApro = $("#travelFeeApprover").combobox('getText');
        	$.ajax({
        		url:todoUrl,
        		data:{"itemname":"Travel","itemid":itemid,"itemurl":itemurl,reviewer:traverfeeApro,status:"未审批"},
        		type:"post"
        	});  
            sendmail($("#travelFeeApprover").combobox('getValue'));
            $('#fdlg').dialog('close');        // close the dialog
            $('#fdg').datagrid('reload');    // reload the user data
        }
    });
	 
}

 

$(function(){
	$('#fdg').datagrid({
	    height: 'auto',
	    fit:false,
	    url: '<%=basePath %>framework/tra/shows.action?po_no=<%=po_no %>' ,
	    method: 'POST',
	    striped: true,
	    nowrap: true,
	    pageSize: 10,
	    pageNumber:1, 
	    pageList: [10, 20, 50, 100, 150, 200],
	    showFooter: true,
		loadMsg : '数据加载中请稍后……',
		pagination : true,
	    toolbar:"#ftoolbar",
	    checkOnSelect:false,
	    selectOnCheck:false,  
	    columns: [[  
	        { field: 'ck', checkbox: true },
	        { field: 'userType', title: 'Type', width: '20%',align:'center'},
	        { field: 'user', title: 'Name', width: '20%',align:'center'},
	        { field: 'fee', title: 'Travel Fee', width: '20%',align:'center'},
	        { field: 'finalFee', title: 'finalFee', width: '20%',align:'center'},
	        { field: 'status', title: 'status', width: '20%',align:'center'}
   	       
	    ]],				
	    onDblClickRow :function(rowIndex,rowData){
	    	feditBean(rowData);
	   	}
	});
	 
})

/**
function  closePo(){
 
  	var rows = $('#dg').datagrid('getChecked');
	  	if (rows.length>0){
 	   if(rows.length==1){
 	        var row=rows[0];
 	          var po_no =row.po_no ;	        
              alert(po_no);
 	   }else{
 	     alert("你的选择了多个选项,请只选择一个");
 	   }
 	
 	  
 	} else{
 	   alert("你没有选择任何一个选项");
 	} 
   
}	*/ 
</script>
</head>
<body>

   <table style="width: 100%;height:100%" >
   <tr>
   <td style="width: 50%;height:100%" >
   	<div id="edg" style="width: 100%;height:100%"></div>		
	<div id="etoolbar"> 
		Init Cost:
		<input style="width: 70px;" readonly="true"	 id="contract_price">
		Total Cost: <input id="tc" style="width: 70px;" name="total" readonly="true" /> 	
		<a href="javascript:void(0)" class="easyui-linkbutton"	iconCls="icon-add" plain="true" onclick="enewBean()">Add Expense</a> 	
		<a href="javascript:void(0)" class="easyui-linkbutton"	iconCls="icon-sum" plain="true" onclick="detailCharge();">Extra Cost</a> 				 
	</div>
   </td>
   
   <td style="width: 50%;height:100%" >
   	
	<div id="fdg" style="width: 100%;height:100%"></div>
	<div id="ftoolbar"> &nbsp;&nbsp;
		<a href="javascript:void(0)" class="easyui-linkbutton"	iconCls="icon-add" plain="true" onclick="fnewBean()">Add Travel Fee</a> &nbsp;&nbsp;
		<a href="javascript:void(0)" class="easyui-linkbutton"	iconCls="icon-sum" plain="true" onclick="detailTravel();">Extra Cost</a>					 
	</div>
   </td>
   </tr></table>



	
	<div id="edlg" class="easyui-dialog"	style="width: 580px; height: 450px; padding: 10px 20px" closed="true"	buttons="#edlg-buttons">
		<div class="ftitle" id="eftitle">Add Expense</div>
		<form id="efm" method="post" enctype="multipart/form-data" novalidate>
			<input  name="po_no" id="epo" type="hidden">
			<input  name="chargeid"  type="hidden">
			<input  name="status"  value="未审批" type="hidden">		
			<input  name="submitter" id="chargeSubmitter" type="hidden">				
			<table class="ee">
			 <tr><td>Porject</td><td>
			 	<select name="proj_no" style="width:173px;">
			      <option value="<%=po_no %>-IDI"><%=po_no %>-IDI</option>
			      <option value="<%=po_no %>-HT"><%=po_no %>-HT</option>
			      <option value="<%=po_no %>-NAST"><%=po_no %>-NAST</option>
			      <option value="<%=po_no %>-ORDER"><%=po_no %>-ORDER</option>
			   </select>			 
			 </td> <td></td><td></td></tr>
			 <tr><td>First Price</td><td> <input  name="originalPrice"  type="text" class="easyui-numberbox" min="0"></td> <td>Evidence</td><td><input  name="file1" id="chargeFile"  type="file"></td></tr>	
			
			 <tr><td>Comment</td><td><input  name="construction"  type="text" ></td> <td></td><td></td></tr>	
			 <tr><td>Approver</td><td><input  name="Approver" style="width:172px"  class="easyui-textbox"   id="Approver"></td> <td></td><td></td></tr>			 		 
			</table>
		</form>
	</div>	
	<div id="edlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" onclick="esaveBean()" style="width: 90px">save</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel" onclick="javascript:$('#edlg').dialog('close')"
			style="width: 90px">cancle</a>
	</div>

	
   <div id="fdlg" class="easyui-dialog"	style="width: 580px; height: 450px; padding: 10px 20px" closed="true"	buttons="#fdlg-buttons">
		<div class="ftitle" id="fftitle"></div>
		<form id="ffm" method="post" enctype="multipart/form-data" novalidate>
			<input  name="feeId" id="feeId"  type="hidden">
			<input  name="po_no" id="fpo"  type="hidden">	
			<input  name="status" id="status"  value="未审批" type="hidden">	
			<input  name="submitter" id="travelSubmitter" type="hidden">			
			<table>
				<input  name="userType"  type="radio" value="staft"  >&nbsp;Staft&nbsp;&nbsp;&nbsp;<input id="" name="userType" value="other"  type="radio">&nbsp;Other
				<tr>
					<td>name </td> 
					<td> 
						<input  name="user" class="easyui-textbox"  type="text">
					</td>
				</tr>
				<tr>
					<td>Fee </td> 
					<td>
						<input  name="fee"  type="text" class="easyui-numberbox"> 
					</td>
					 <td>&nbsp;&nbsp;Evidence</td><td><input  name="file1" id="feeFile" type="file"></td>
				</tr>
				<tr><td>Approver</td><td><input  name="travelFeeApprover" style="width:172px"  class="easyui-textbox"   id="travelFeeApprover"></td> <td></td><td></td></tr>
			</table>
		</form>
	</div>	
	<div id="fdlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6" iconCls="icon-ok" onclick="fsaveBean()" style="width: 90px">Submit</a> 
		<a href="javascript:void(0)" class="easyui-linkbutton"	iconCls="icon-cancel" onclick="javascript:$('#fdlg').dialog('close')" style="width: 90px">cancle</a>
	</div>
</body>
</html>