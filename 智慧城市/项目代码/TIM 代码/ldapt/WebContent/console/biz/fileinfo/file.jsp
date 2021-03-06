<%@page import="com.solar.tech.bean.File_Item"%>
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
#fm .textbox{
	margin-left: 30px;
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
	
	
	$('#dg').datagrid({
	    height: '100%',
	    fit:true,
	    url: '<%=basePath %>framework/file/shows.action',
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
	        { field: '<%=File_Item.From%>', title: 'From', width: 150},
	        { field: '<%=File_Item.File_no%>', title: 'File_no', width: 200},
		    { field: 'proj_no', title: 'proj_no', width: 200},
	        { field: '<%=File_Item.Type%>', title: 'Type', width: 200},
	        { field: '<%=File_Item.Standard%>', title: 'Standard',  width: 200}, 
	        { field: '<%=File_Item.Nast_proj_no%>',title: 'NAST project No', width:200}, 
	        { field: '<%=File_Item.Nast_rep_no%>', title: 'NAST report No', width: 150},
	        { field: '<%=File_Item.Idi_rep_no%>', title: 'IDIADA report No', width: 200},
	        { field: '<%=File_Item.Hest_rep_no%>', title: 'Hestocon report No', width: 200},
	        { field: '<%=File_Item.Hest_or_no%>', title: 'Hestocon order No',  width: 200}, 
	        { field: '<%=File_Item.Category%>',title: 'Category', width:200}, 
	        { field: '<%=File_Item.Cert_no%>',title: 'Certificate No', width:200}, 
	        { field: '<%=File_Item.File_type%>', title: 'File_type', width: 150},
	        { field: '<%=File_Item.Rev_ext%>', title: 'Rev / Ext', width: 200},
	        { field: '<%=File_Item.Status%>', title: 'Status', width: 200},
	        { field: '<%=File_Item.Engineer%>', title: 'Engineer',  width: 200}, 
	        { field: '<%=File_Item.Manage%>',title: 'Manage', width:200},
	        
	        
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
    url = '<%=basePath%>framework/file/add.action';
    $('#ftitle').html("Add A File");
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
        
     
        url = '<%=basePath%>framework/file/update.action';    
        $('#ftitle').html("Modify A File");
    }
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
function destroyBean(){
	var rows = $('#dg').datagrid('getChecked');
    if (rows.length>0){
        $.messager.confirm('温馨提示','你真的要删除么?',function(r){
            if (r){
            	for(var i=0; i<rows.length; i++){
            		var row=rows[i];
            	 
             $.post('<%=basePath%>framework/file/delete.action',{id_file:row.id_file_item},function(result){
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
function searchText(){
	var value = $("input[name=search]").val();
	var svalue = $("input[name=stime]").val();
	var evalue = $("input[name=etime]").val();
	$('#dg').datagrid({
	    height: '100%',
	    fit:true,
	    url: '<%=basePath %>framework/file/search.action?fileno=' + value + '&page=1&rows=10',
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
	        { field: '<%=File_Item.From%>', title: 'From', width: 150},
	        { field: '<%=File_Item.File_no%>', title: 'File_no', width: 200},
	        { field: '<%=File_Item.Type%>', title: 'Type', width: 200},
	        { field: '<%=File_Item.Standard%>', title: 'Standard',  width: 200}, 
	        { field: '<%=File_Item.Nast_proj_no%>',title: 'NAST project No', width:200}, 
	        { field: '<%=File_Item.Nast_rep_no%>', title: 'NAST report No', width: 150},
	        { field: '<%=File_Item.Idi_rep_no%>', title: 'IDIADA report No', width: 200},
	        { field: '<%=File_Item.Hest_rep_no%>', title: 'Hestocon report No', width: 200},
	        { field: '<%=File_Item.Hest_or_no%>', title: 'Hestocon order No',  width: 200}, 
	        { field: '<%=File_Item.Category%>',title: 'Category', width:200}, 
	        { field: '<%=File_Item.Cert_no%>',title: 'Certificate No', width:200}, 
	        { field: '<%=File_Item.File_type%>', title: 'File_type', width: 150},
	        { field: '<%=File_Item.Rev_ext%>', title: 'Rev / Ext', width: 200},
	        { field: '<%=File_Item.Status%>', title: 'Status', width: 200},
	        { field: '<%=File_Item.Engineer%>', title: 'Engineer',  width: 200}, 
	        { field: '<%=File_Item.Manage%>',title: 'Manage', width:200},
	        
	        
	    ]],

	    onDblClickRow :function(rowIndex,rowData){
	    	editBean(rowData);
	   	}
	});
	 
}
        

 
    </script>
</head>
<body>
	<div id="dg" style="width: 100%;height:100%"></div>
	<div id="toolbar">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-add" plain="true" onclick="newBean()">Add File</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-remove" plain="true" onclick="destroyBean()">Delete File</a>
			&nbsp;&nbsp;
		 <input id="sd" name="stime" class="easyui-datebox" data-options="editable:false"></input> &nbsp;&nbsp; 
		 <input id="ed" name="etime"  class="easyui-datebox" data-options="editable:false"></input>  &nbsp;&nbsp; 
			<input name="search" class="easyui-textbox"> 
		<a href="javascript:void(0)"  id="btn" iconCls="icon-search" class="easyui-linkbutton"
		onclick="searchText()">搜索</a>
	</div>

	<div id="dlg" class="easyui-dialog"
		style="width: 580px; height: 450px; padding: 10px 20px" closed="true"
		buttons="#dlg-buttons">
		<div class="ftitle" id="ftitle"></div>
		<form id="fm" method="post" enctype="multipart/form-data" novalidate>
			<input id="<%=File_Item.ID_FILE_ITEM %>" name="<%=File_Item.ID_FILE_ITEM %>"  type="hidden">
			
			<div class="fitem">
				<label>From:</label>
				 <input name="from" class="easyui-textbox"
				 	data-options="validType:['length[3,15]', 'isExist']"  />

			</div>
			
			<div class="fitem">
				<label>File_no:</label>
				 <input name="file_no" class="easyui-textbox"
				 	data-options="validType:['length[3,15]', 'isExist']"  />

			</div>    
		 	
		 	<div class="fitem">
				<label>Type:</label>
				 <input name="type" class="easyui-textbox"
				 	data-options="validType:['length[3,50]', 'isExist']"/>
			</div> 
			 
			<div class="fitem">
				<label>Standard:</label>
				 <input name="standard" class="easyui-textbox"
				 	data-options="validType:['length[3,15]', 'isExist']" />
			</div>
			
			<div class="fitem">
				<label>Nast_Project_No:</label>
				 <input name="nast_proj_no" class="easyui-textbox"
				 	data-options="validType:['length[3,15]', 'isExist']"  />

			</div>    
		 	
		 	<div class="fitem">
				<label>Nast_Report_No:</label>
				 <input name="nast_rep_no" class="easyui-textbox"
				 	data-options="validType:['length[3,15]', 'isExist']"/>
			</div> 
			 
			<div class="fitem">
				<label>Idi_rep_no:</label>
				 <input name="idi_rep_no" class="easyui-textbox"
				 	data-options="validType:['length[3,15]', 'isExist']" />
			</div>  
			
			<div class="fitem">
				<label>Hestocon_order_no:</label>
				 <input name="hest_or_no" class="easyui-textbox"
				 	data-options="validType:['length[3,15]', 'isExist']"  />

			</div>
			
			<div class="fitem">
				<label>Hestocon_report_no:</label>
				 <input name="hest_rep_no" class="easyui-textbox"
				 	data-options="validType:['length[3,15]', 'isExist']"  />

			</div>    
		 	
		 	<div class="fitem">
				<label>Certificate No:</label>
				 <input name="cert_no" class="easyui-textbox"
				 	data-options="validType:['length[3,15]', 'isExist']"/>
			</div> 
			 
			<div class="fitem">
				<label>File type:</label> 
				  <select name="file_type">
				<option value="Base">Base</option>
				<option value="Revision">Revision</option>
				<option value="Extension">Extension</option>
					</select>
			</div>
			
			<div class="fitem">
				<label>Rev / Ext:</label>
				 <input name="rev_ext" class="easyui-textbox"
				 	data-options="validType:['length[3,15]', 'isExist']"  />

			</div>    
		 	
		 	<div class="fitem">
				<label>Status:</label> 
				<select name="status">
					<option value="Open">Open</option>
					<option value="Finalized">Finalized</option>
					<option value="Cancelled">Cancelled</option>
					<option value="Paused">Paused</option>
				</select>
			</div> 
			 
			<div class="fitem">
				<label>Category:</label>
				 <input name="category" class="easyui-textbox"
				 	data-options="validType:['length[3,15]', 'isExist']" />
			</div>   
			
				<div class="fitem">
				<label>Engineer:</label>
				 <input name="engineer" class="easyui-textbox"
				 	data-options="validType:['length[3,15]', 'isExist']" /> 
			</div>
			
			<div class="fitem">
				<label>Manage:</label>
				 <input name="manage" class="easyui-textbox"
				 	data-options="validType:['length[3,15]', 'isExist']"  />

			</div>    
		 	
		 	<div class="fitem">
				<label>Coordinator:</label>
				 <input name="Coordinator" class="easyui-textbox"
				 	data-options="validType:['length[3,15]', 'isExist']"/>
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