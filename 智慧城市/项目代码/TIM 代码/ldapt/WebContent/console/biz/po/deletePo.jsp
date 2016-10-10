<%@page import="com.solar.tech.bean.Po_Create"%>
<%@ page import="com.solar.tech.exception.ResultCode" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    
    String orderBy = request.getParameter("orderBy");
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
</style>
<script type="text/javascript">
$(function(){ 
	var user = "<%=com.solar.tech.util.Current.user().getUserName()%>" ; 
	if(user == 'Samuelzhou'){
	//	$("#emailToDel").hide();
		document.getElementById("emailTodel").style.display = "none";
	}
	else{
	//	$("#deletePo").hide();
		document.getElementById("deletePo").style.display = "none";
	}
	$('#dg').datagrid({
	    height: 'auto',
	    fit:false,
	    url: '<%=basePath %>framework/po/deleteshows.action?orderBy=<%=orderBy%>',
	    method: 'POST',
	    striped: true,
	    remoteSort: false,
	    nowrap: true,
	    pageSize: 10,
	    pageNumber:1, 
	    pageList: [10, 20, 50, 100, 150, 200],
	    showFooter: true,
		loadMsg : '数据加载中请稍后……',
		pagination : true,
	    toolbar:"#toolbar",
	    checkOnSelect:false,
	    selectOnCheck:false,  
	    columns: [[  
	        { field: 'ck', checkbox: true },
	        { field: '<%=Po_Create.Po_no%>', title: 'PO No.', width: '11%',align:'center',sortable:true, sorter:sortt},
	        { field: '<%=Po_Create.Po_desc%>', title: 'PO description', width: '11%',align:'center',sortable:true, sorter:sortt},
	        { field: '<%=Po_Create.Prod_type_desc%>', title: 'Product type description', width: '14%',align:'center',sortable:true, sorter:sortt},
	        { field: '<%=Po_Create.Start_time%>', title: 'Start time (plan)',  width: '11%',align:'center',formatter: formatDatebox}, 
	        { field: '<%=Po_Create.Complete_time%>',title: 'Complete time (plan)', width:'11%',align:'center',formatter: formatDatebox},
	        { field: '<%=Po_Create.Contract_price%>', title: 'Contract Price', width: '9.8%',align:'center'},
	        { field: '<%=Po_Create.Customer%>',title: 'Customer', width:'9.8%',align:'center',sortable:true, sorter:sortt},	
	        { field: 'po_close',title: 'Status', width:'4.8%',align:'center',sortable:true,formatter: function(value,row,index){ 
				return (value == 'false'? 'Open':'Closed');
			 } },
	        { field: 'po_approve',title: 'Approved', width:'9.8%',align:'center',formatter: function(value,row,index){ 
				return (value == 'true'? 'Yes':'No');
			}}
	              		       
	    ]], 

	    onDblClickRow :function(rowIndex,rowData){  
	    	editBean(rowData);
	   	}
	});
});

function newOrder(a){
	 
	if('<%=orderBy%>' == 'null')
		window.location.href = '<%=basePath%>console/biz/po/shows.jsp?orderBy=po_close desc'; 
	else if('<%=orderBy%>' == 'po_close desc')
		window.location.href = '<%=basePath%>console/biz/po/shows.jsp?orderBy=po_close';
	else if('<%=orderBy%>' == 'po_close')
		window.location.href = '<%=basePath%>console/biz/po/shows.jsp';
}

function sortt(a,b){ 
 a = a.split('/'); 
 b = b.split('/');
 if (a[2] == b[2]){
 if (a[0] == b[0]){  return (a[1]>b[1]?1:-1);
 } else { return (a[0]>b[0]?1:-1);}                  
 } else { return (a[2]>b[2]?1:-1);} 
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
var url;
function newBean(){
 	//if(fitemPassword!= undefined){
    //	$("#fitemPassword").append(fitemPassword);
    //}
 	$("#fitemPassword").show();
    $('#dlg').dialog('open').dialog('setTitle',' ');
    $('#fm').form('clear');  
    $('#headImg').attr("src", "").attr("value","");
    url = '<%=basePath%>framework/po/add.action';
    $('#ftitle').html("添加计划");
}

function editBean(row){
    
    if (row){
     	      var po_no =row.po_no ;
     	      var isDraft = row.draft;
     	      var isApp = row.po_approve;
 //	          var url='<%=basePath %>console/biz/ps/projectsummary.jsp?pono='+po_no;
 //             window.location.href = url    
 	          //var url='<%=basePath %>console/biz/po/edit_po.jsp?pono='+po_no;
 	          if(isDraft == 1)
              	window.location.href = '<%=basePath %>console/biz/po/edit_po.jsp?po_no='+po_no+'&isDraft=1';
              else if(isDraft == 0 && isApp != 'false'){
                var url = '<%=basePath %>console/biz/ps/projectsummary.jsp?pono='+po_no;
 	          	var title = "Create Project"; 
 	          	 window.location.href = url;
              }
    }
}



//添加子计划
function newPsBean(){
 	var rows = $('#dg').datagrid('getChecked');
 	var isApprove = rows[0].po_approve;
 	var  isClose = rows[0].po_close;
 	if(isApprove == "false" && rows.length == 1){
 		 alert("此PO暂未通过审批！");
 	}
 	else if(isClose == "true" && rows.length == 1){
 		 alert("此PO已经关闭！");
 	}
 	else if (rows.length>0){
 	   if(rows.length==1){
 	        var row=rows[0];
 	          var po_no =row.po_no ; 	          
 	          var url='<%=basePath %>console/biz/ps/projectsummary.jsp?pono='+po_no;
              window.location.href = url;
 	   }else{
 	     alert("你的选择了多个选项,请只选择一个");
 	   }
 	
 	  
 	} else{
 	   alert("你没有选择任何一个选项");
 	}
 	//var po_no = $(a).parent().parent().siblings().eq(0).children().text();

}

function saveBean(){ 
 
    $('#fm').form('submit',{
        url: url,
        onSubmit: function(){
            return $(this).form('validate');
        },
        success: function(result){
            $('#dlg').dialog('close');        // close the dialog
            $('#dg').datagrid('reload');    // reload the user data
        }
    });
}
function copyBean(){
	var rows = $('#dg').datagrid('getChecked');
	  	if (rows.length>0){
 	   if(rows.length==1){
 	        var row=rows[0];
 	          var po_no =row.po_no ;	        
 	          var url='<%=basePath %>console/biz/po/copy_po.jsp?pono='+po_no;
              window.location.href = url
 	   }else{
 	     alert("你的选择了多个选项,请只选择一个");
 	   }
 	
 	  
 	} else{
 	   alert("你没有选择任何一个选项");
 	} 
}
function changePrice(){
 	var rows = $('#dg').datagrid('getChecked');
 	var isClose = rows[0].po_close;
 	
 	if (rows.length>0){
 	   if(rows.length==1 && isClose == 'true'){
 	   	
 	        var row=rows[0];
 	          var po_no =row.po_no ;  
 	          var price = row.contract_price; 
 	           var url='<%=basePath %>console/biz/po/exspense.jsp?pono='+po_no+'&contract_price='+price;
              window.location.href = url
 	   }
 	   else if(rows.length==1 && isClose != 'true'){
 	   	  alert("Project_Order还未Close");
 	   }
 	   else{
 	     alert("你的选择了多个选项,请只选择一个");
 	   } 	 	  
 	} else{
 	   alert("你没有选择任何一个选项");
 	}
}
function destroyBean(){
	var rows = $('#dg').datagrid('getChecked');
    
}
function searchText(){
	var pvalue = $("input[name=search]").val();
	var svalue = $("input[name=stime]").val();
	var evalue = $("input[name=etime]").val();
	$('#dg').datagrid({
	    height: 'auto',
	    fit:false,
	    url: '<%=basePath %>framework/po/search.action?pono=' + pvalue + '&stime=' + svalue + ' &etime=' + evalue ,
	    method: 'POST',
	    striped: true,
	    remoteSort: false,	    
	    nowrap: true,
	    pageSize: 10,
	    pageNumber:1, 
	    pageList: [10, 20, 50, 100, 150, 200],
	    showFooter: true,
		loadMsg : '数据加载中请稍后……',
		pagination : true,
	    toolbar:"#toolbar",
	    checkOnSelect:false,
	    selectOnCheck:false,  
	    columns: [[  
	        { field: 'ck', checkbox: true },
	        { field: '<%=Po_Create.Po_no%>', title: 'PO No.', width: '11%',align:'center' ,sortable:true, sorter:sortt},
	        { field: '<%=Po_Create.Po_desc%>', title: 'PO description', width: '11%',align:'center',sortable:true, sorter:sortt},
	        { field: '<%=Po_Create.Prod_type_desc%>', title: 'Product type description', width: '14%',align:'center',sortable:true, sorter:sortt},
	        { field: '<%=Po_Create.Start_time%>', title: 'Start time (plan)',  width: '11%',align:'center',formatter: formatDatebox}, 
	        { field: '<%=Po_Create.Complete_time%>',title: 'Complete time (plan)', width:'11%',align:'center',formatter: formatDatebox},
	        { field: '<%=Po_Create.Contract_price%>', title: 'Contract Price', width: '9.8%',align:'center'},
	        { field: '<%=Po_Create.Customer%>',title: 'Customer', width:'9.8%',align:'center',sortable:true, sorter:sortt},
	        { field: '<%=Po_Create.Maufacturer%>', title: 'Maufacturer', width: '9.8%',align:'center',sortable:true, sorter:sortt},	
	        { field: 'po_close',title: 'isClose', width:'9.8%',align:'center'},
	        { field: 'po_approve',title: 'isApproval', width:'9.8%',align:'center'}		              	       
	    ]],				
	    onDblClickRow :function(rowIndex,rowData){
	    	editBean(rowData);
	   	}
	});
	 
}



function  closePo(){
 
  	var rows = $('#dg').datagrid('getChecked');
  	var user = "<%=com.solar.tech.util.Current.user().getUserName()%>" ; 
	  	if (rows.length>0){
 	   if(rows.length==1){
 	   		if(user != "Samuelzhou" && user != "Julieyang"){
 	   			alert("抱歉，您无权限");
 	   		}
 	   		else{
 	        var row=rows[0];
 	          var po_no =row.po_no ;
 	          	        
              $.post('<%=basePath%>framework/po/close.action',{po_no:po_no},function(result){
               if (result.success){
               	  alert("This PO is closeed !");
               	  $('#dg').datagrid('reload'); 
                } else {
                  alert("This PO is not closeed !");
               }
        },'json');
        }

 	   }else{
 	     alert("你的选择了多个选项,请只选择一个");
 	   }
 	
 	  
 	} else{
 	   alert("你没有选择任何一个选项");
 	} 
   
}	 
function deletePo() {
	var rows = $('#dg').datagrid('getChecked');
	var po_no = "";
	if (rows.length>0){
		if (confirm("确定删除？") == true){
	 	   for(var i = 0;i < rows.length;i++){ 
	 	        var row=rows[i];
	 	        po_no +=row.po_no + ",";
	 	   } 
	 	  	$.ajax({
	    		url:'<%=basePath%>framework/po/delete.action',
	    		data:{"po_no":po_no},
	    		type:'post',
	    		dataType:'json',
	    		success:function(data){
	    			$.ajax({
	    	    		url:'<%=basePath%>framework/todo/deleteTodo.action',
	    	    		data:{"itemid":po_no},
	    	    		type:'post',
	    	    		dataType:'json',
	    	    		success:function(data){ 
	    	    		}
	    	    	 });
	    			 $('#dg').datagrid('reload');
	    	    	 
	    		}
	    	 })  
	 	 
		}
	 } 
	else{
	 	   alert("你没有选择任何一个选项");
	 }  
}

function emailTodel() {
	var rows = $('#dg').datagrid('getChecked');
	if (rows.length>0){
		for(var i = 0; i < rows.length;i++){
			var row=rows[i];
	          var po_no =row.po_no ;
	          var url = '<%=basePath %>console/biz/po/shows.jsp';
	          todoAdd(url,po_no); 
		}
		//发送邮件
		var basePath = '<%=basePath%>';	        
	      var mailUrl = '<%=basePath%>framework/mail/send.action';
	        $.ajax({
	    		url:mailUrl,
	    		data:{"subject":'删除请求',
	    			"body":'您有删除请求'+',<br>登陆链接是'
	    			+"<a href='"+ basePath+"framework/index.action"+"'>点此链接去看看！</a>",
	    			'to':'samuel.zhou@datservice.cn'}, 
	    		type:'post',
	    		dataType:'json',
	    		success:function(data){
	    			alert("已发送邮件提醒！");
	    			 $('#dg').datagrid('reload');
	    		}
	    	 }) 
	 	} else{
	 	   alert("你没有选择任何一个选项");
	 	}  
}
function todoAdd(_url,po_no){ 
	//预制一些数据
	var itemname = "Delete PO";
	var itemid = po_no;
	var itemurl = _url;
	var draft = 0;
	var status = '请求删除';
	var reviewer = 'Samuelzhou';
	/**var reviewer = "<%=com.solar.tech.util.Current.user().getUserName()%>";	*/					
    $.post('<%=basePath%>framework/todo/add.action',{itemname:itemname,itemid:itemid, itemurl:itemurl,reviewer:reviewer,draft:draft,status:status},function(result){
        
    },'json'); 	
}
</script>
</head>
<body>
	<div id="dg" style="width: 100%;height:100%"></div>
	<div id="toolbar">
			&nbsp;&nbsp;
		<input id="sd" name="stime" class="easyui-datebox" data-options="editable:false"></input> &nbsp;&nbsp; 
		<input id="ed" name="etime"  class="easyui-datebox" data-options="editable:false"></input>  &nbsp;&nbsp; 
		<input name="search" class="easyui-textbox"> 
		<a href="javascript:void(0)"  id="btn" iconCls="icon-search" class="easyui-linkbutton" onclick="searchText()">search</a>&nbsp;&nbsp;
		<!-- <a href="javascript:void(0)" class="easyui-linkbutton"	iconCls="icon-add" plain="true" onclick="copyBean()">Copy</a> &nbsp;&nbsp;-->
		<a href="javascript:void(0)" class="easyui-linkbutton"	iconCls="icon-add" plain="true" onclick="newPsBean()">Add A Project</a> &nbsp;&nbsp;		
		<a href="javascript:void(0)" class="easyui-linkbutton"	iconCls="icon-remove" plain="true" onclick="changePrice()">Expense</a>	&nbsp;&nbsp;
		<a href="javascript:void(0)" class="easyui-linkbutton"	iconCls="icon-remove" plain="true" onclick="closePo()">Close</a>			
	 
		<a href="javascript:void(0)" class="easyui-linkbutton"	iconCls="icon-remove" plain="true" id="deletePo" onclick="deletePo();">Delete</a>	 
		 
		<a href="javascript:void(0)" class="easyui-linkbutton"	iconCls="icon-tip" plain="true" id="emailTodel" onclick="emailTodel();">EmailToDelete</a>
	 	
		 
		 
		 
		 
	</div>

	<div id="dlg" class="easyui-dialog"
		style="width: 580px; height: 450px; padding: 10px 20px" closed="true"
		buttons="#dlg-buttons">
		<div class="ftitle" id="ftitle">添加子计划</div>
		<form id="fm" method="post" enctype="multipart/form-data" novalidate>
			<input id="<%=Po_Create.ID_PO_CREATE %>" name="<%=Po_Create.ID_PO_CREATE %>"  type="hidden">
			
			<div class="fitem">
				<label>Po_no:</label>
				 <input name="po_no" class="easyui-textbox"
				 	data-options="validType:['length[3,15]']"  />

			</div>
			
			<div class="fitem">
				<label>Po_desc:</label>
				 <input name="po_desc" class="easyui-textbox"
				 	data-options="validType:['length[3,15]']"  />

			</div>    
		 	
		 	<div class="fitem">
				<label>Prod_type_desc:</label>
				 <input name="prod_type_desc" class="easyui-textbox"
				 	data-options="validType:['length[3,15]']"/>
			</div> 
			 
			<div class="fitem">
				<label>Start_time:</label>
				 <input name="start_time" class="Wdate" type="text"
				 onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:mm'})"/>
			</div> 
			<div class="fitem">
				<label>Complete_time:</label>
				 <input name="complete_time" class="Wdate" type="text"
				 onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:mm'})"/>
				 
			</div>    
		 	
		 	<div class="fitem">
				<label>Contract_price:</label>
				 <input name="contract_price" class="easyui-textbox" 
				 	data-options="validType:['length[3,15]']"/>
			</div> 
			 
			 
			
			<div class="fitem">
				<label>Customer:</label>
				 <input name="customer" class="easyui-textbox"
				 	data-options="validType:['length[3,15]']"/>
			</div> 
			 
			<div class="fitem">
				<label>Maufacturer:</label>
				 <input name="maufacturer" class="easyui-textbox"
				 	data-options="validType:['length[3,15]']" />
			</div>




		</form>
	</div>
	

	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" onclick="saveBean()" style="width: 90px">保存</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')"
			style="width: 90px">取消</a>
	</div>

	
</body>
</html>