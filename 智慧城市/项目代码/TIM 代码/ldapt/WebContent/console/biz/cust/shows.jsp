<%@page import="com.solar.tech.bean.Custumer"%>
<%@ page import="com.solar.tech.exception.ResultCode" %>

<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
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

#fm {
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
	width:160px;
	text-align:right;
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
		
	$('#dg').datagrid({
	    height: 'auto',
	    fit:false,
	    url: '<%=basePath %>framework/cust/shows.action',
	    method: 'POST',
	    striped: true,
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
	        { field: '<%=Custumer.Cust_name%>', title: 'Name', width: 150},
	        { field: 'cust_no', title: 'Abbr.', width: 150},
	        { field: '<%=Custumer.Cust_address%>', title: 'Address', width: 200},
	        { field: '<%=Custumer.Cust_tel%>', title: 'TEL', width: 200},
	        { field: '<%=Custumer.Cust_type%>', title: 'Contact Person',  width: 200}, 
	        { field: 'cust_email',title: 'Email', width:200},
	        { field: 'position',title: 'Position', width:200},
	        { field: 'cust_iacop',title: 'IA/COP ', width:200},
	        { field: 'cust_make',title: 'Make', width:200}	        
	    ]],

	    onDblClickRow :function(rowIndex,rowData){
	    	editBean(rowData);
	   	}
	});
});

var url;
function newBean(){
 	//if(fitemPassword!= undefined){
    //	$("#fitemPassword").append(fitemPassword);
    //}
 	$("#fitemPassword").show();
    $('#dlg').dialog('open').dialog('setTitle',' ');
    $('#fm').form('clear');    
    $("[name='<%=Custumer.Cust_type %>']").eq(0)[0].checked=true;    
    $('#headImg').attr("src", "").attr("value","");
    url = '<%=basePath%>framework/cust/add.action';
    $('#ftitle').html("添加客户");
}
var fitemPassword;
function editBean(row){
    if (row){
        if(row.userClass=='SYST'){
        	//$("#fitemPassword").append(fitemPassword);
        	$("#fitemPassword").show();
        	
        }else{
        	//fitemPassword=$(".fitem_password").remove();
        	$("#fitemPassword").hide();
        }
        row.password2=row.password="******";
        $('#dlg').dialog('open').dialog('setTitle','');
        $('#fm').form('load',row);
        
     
        url = '<%=basePath%>framework/cust/update.action';    
        $('#ftitle').html("修改客户信息");
    }
}


function saveBean(){
	alert(url);
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
function destroyBean(){
	var rows = $('#dg').datagrid('getChecked');
    if (rows.length>0){
        $.messager.confirm('温馨提示','你真的要删除么?',function(r){
            if (r){
            	for(var i=0; i<rows.length; i++){
            		var row=rows[i];
            	 
             $.post('<%=basePath%>framework/cust/delete.action',{id_cust:row.id_cust},function(result){
                    if (result.success){
                        $('#dg').datagrid('reload');    // reload the user data
                    } else {
                        $.messager.show({    // show error message
                            title: 'Error',
                            msg: result.errorMsg
                        });
                    }
                },'json'); 
            }
            }
        });
    }
}
        
$.extend($.fn.validatebox.defaults.rules, {  
    isExist: {
        validator:function(value,param){
        	var r=false;
        	$.ajax({  
                type : "post",  
                 url : "<%=basePath%>framework/cust/isExist.action",
                 data : {<%=Custumer.ID_CUST %>:$("#Custumer.ID_CUST").val(), cust_name:value,cust_no:value}, 
                 dataType: 'json',
                 async : false,  
                 success : function(data){
                	 if(data==false) r=true;
                 }  
            }); 
            return r;
        },
        message:'this is exist'
    }

}); 
 
    </script>
</head>
<body>
	<div id="dg" style="width: 100%;height:100%"></div>
	<div id="toolbar">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-add" plain="true" onclick="newBean()">Add customer</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-remove" plain="true" onclick="destroyBean()">
			delete </a>
	</div>

	<div id="dlg" class="easyui-dialog"
		style="width: 580px; height: 450px; padding: 10px 20px" closed="true"
		buttons="#dlg-buttons">
		<div class="ftitle" id="ftitle"></div>
		<form id="fm" method="post" enctype="multipart/form-data" novalidate>
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
				 <input name="cust_address" class="easyui-textbox"
				 	data-options="required:true,validType:['length[8,100]']"  />

			</div>    
			<div class="fitem">
				<label>Contact Person:</label>
				 <input name="cust_type" class="easyui-textbox"
				 	data-options="required:true,validType:['length[3,100]']" />
			</div>		 	
		 	<div class="fitem">
				<label>Tel:</label>
				 <input name="cust_tel" class="easyui-textbox"
				 	data-options="required:true,validType:['length[8,200]']"/>
			</div> 




		 	<div class="fitem">
				<label>Email:</label>
				 <input name="cust_email" class="easyui-textbox"
				 	data-options="required:true,validType:['email']"/>
			</div> 			 
		 	<div class="fitem">
				<label>Position:</label>
				 <input name="position" class="easyui-textbox"
				 	data-options="required:true,validType:['length[5,500]']"/>
			</div> 
		 	<div class="fitem">
				<label>IA/COP vaild:</label>
				 <!-- input name="cust_iacop" class="easyui-textbox"
				 	data-options="required:true,validType:['length[1,100]'"/-->
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
		 	
				<!--div class="fitem">
				<label>Description:</label>
				 <input name="description" class="easyui-textbox"  style="width:300px;height:100px;white-space: pre-wrap;"	data-options="multiline:true"/>
			</div-->
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" onclick="saveBean()" style="width: 90px">Save</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')"
			style="width: 90px">cancle</a>
	</div>
</body>
</html>