<%@page import="com.solar.tech.bean.User"%>
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
	margin-top: 10px;
}

.fitem label {
	display: inline-block;
	width: 80px;
}

/* .fitem input {
	width: 160px;
} */

.fitem input[type=radio] {
	width: 39px;
}

.fitem_member .panel:first-of-type, .fitem_member .memberbutton{
	float: left;
}
.fitem_member .memberbutton{
	width:60px;
	text-align: center;
	padding-top: 98px;
}
.textbox .textbox-text{white-space: pre-line;}
</style>
<script type="text/javascript">
$(function(){
	
	
	$('#dg').datagrid({
	    height: '100%',
	    fit:true,
	    url: '<%=basePath %>framework/group/shows.action',
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
	    checkOnSelect :false,
	    columns: [[
	        { field: 'ck', checkbox: true },
	        { field: 'groupId', title: '用户组id', width: 350},
	        { field: 'groupName', title: '用户组名称', width: 350},
	        { field: 'description', title: '描述', width: 450}
	    ]],

	    onDblClickRow :function(rowIndex,rowData){
	    	editBean(rowData);
	   	}
	});
	
	$("#addmember").click(function(){
		var rows = $('#userdg').datagrid('getChecked');
		if(rows.length>0){
			var jsonData={groupId:0, userIds:[]};
			jsonData.groupId=$("#groupId").val();
			for(var i=0; i<rows.length; i++){
        		jsonData.userIds.push(rows[i].userUID);
			}
			$.ajax({
				url:"<%=basePath %>framework/group/addMember.action",
				type:"post",
				data:jsonData,
				dataType:"json",
				success:function(data){
					$('#userdg').datagrid('reload');
					$('#memberdg').datagrid('reload');
				}
			});
		}
	});
	
	$("#deletemember").click(function(){
		var rows = $('#memberdg').datagrid('getSelections');
		if(rows.length>0){
			var jsonData={groupId:0, userIds:[]};
			jsonData.groupId=$("#groupId").val();
			for(var i=0; i<rows.length; i++){
        		jsonData.userIds.push(rows[i].userUID);
			}
			$.ajax({
				url:"<%=basePath %>framework/group/deleteMember.action",
				type:"post",
				data:jsonData,
				dataType:"json",
				success:function(data){
					$('#userdg').datagrid('reload');
					$('#memberdg').datagrid('reload');
				}
			});
		}
	});
	
});

var url;
function newBean(){
	$("#fitem_member").css("display", "none");
    $('#dlg').dialog('open').dialog('setTitle',' ');
    $('#fm').form('clear');
    url = '<%=basePath%>framework/group/add.action';
    $('#ftitle').html("添加用户组");
}
function editBean(row){
    if (row){
    	$("#fitem_member").css("display", "");
    	$('#memberdg').datagrid({
    	    url: '<%=basePath %>framework/group/showMembers.action?groupId='+row.groupId,
    	    width: 220,
    	    height: 280,
    	    method: 'POST',
    	    striped: true,
    	    nowrap: true,
    		loadMsg : '数据加载中请稍后……',
    	    columns: [[
    	        { field: 'ck', checkbox: true },
    	        { field: '<%=User.USERNAME%>', title: '用户名称'},
    	        { field: 'userClass', title: '用户类型',
    	        	 formatter:function(value,rec,index){  
                         if(value=="SYST"){
                        	 return "系统用户";
                         }else if(value="LDAP"){
                        	 return "LDAP用户";
                         }else{
                        	 return "不明";
                         }
                     }	
    	        },
    	        { field: 'userStatus', title: '用户状态',
    	        	 formatter:function(value,rec,index){  
                         if(value==1){
                        	 return "活动";
                         }else if(value=2){
                        	 return "活动";
                         }else{
                        	 return "不明";
                         }
                     }	
    	        }
    	    ]]
    	});
    	
    	$('#userdg').datagrid({
    	    url: '<%=basePath%>framework/group/showLastMembers.action?groupId='+row.groupId,
    	    width: 220,
    	    height: 280,
    	    method: 'POST',
    	    striped: true,
    	    nowrap: true,
    		loadMsg : '数据加载中请稍后……',
    	    columns: [[
    	        { field: 'ck', checkbox: true },
    	        { field: '<%=User.USERNAME%>', title: '用户名称'},
    	        { field: 'userClass', title: '用户类型',
    	        	 formatter:function(value,rec,index){  
                         if(value=="SYST"){
                        	 return "系统用户";
                         }else if(value="LDAP"){
                        	 return "LDAP用户";
                         }else{
                        	 return "不明";
                         }
                     }	
    	        },
    	        { field: 'userStatus', title: '用户状态',
    	        	 formatter:function(value,rec,index){  
                         if(value==1){
                        	 return "活动";
                         }else if(value=2){
                        	 return "活动";
                         }else{
                        	 return "不明";
                         }
                     }	
    	        }
    	    ]]
    	});
    	
        $('#dlg').dialog('open').dialog('setTitle','');
        $('#fm').form('load',row);
        url = '<%=basePath%>framework/group/update.action';    
        $('#ftitle').html("修改用户组信息");
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
	var rows = $('#dg').datagrid('getSelections');
    if (rows.length>0){
        $.messager.confirm('温馨提示','你真的要删除么?',function(r){
            if (r){
            	for(var i=0; i<rows.length; i++){
            		var row=rows[i];
             $.post('<%=basePath%>framework/group/delete.action',{groupId:row.groupId},function(result){
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
    </script>
</head>
<body>
	<div id="dg" style="width: 100%,heigth:100%"></div>
	<div id="toolbar">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-add" plain="true" onclick="newBean()">添加用户组</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-remove" plain="true" onclick="destroyBean()">删除用户组</a>
	</div>

	<div id="dlg" class="easyui-dialog"
		style="width: 640px; height: 500px; padding: 10px 20px" closed="true"
		buttons="#dlg-buttons">
		<div class="ftitle" id="ftitle"></div>
		<form id="fm" method="post" novalidate>
		<input id="groupId" name="groupId"  type="hidden">
			<div class="fitem">
				<label>用户组名称:</label>
				 <input name="groupName" class="easyui-textbox"
				 	data-options="required:true,validType:['length[3,15]']" />

			</div>
			<div id="fitem_member" class="fitem fitem_member">
				<label style="display:block;margin-bottom:10px">用户组成员:</label>
				<div id="memberdg"></div>
				<div class="memberbutton">
					<input id="addmember" type="button" value="<-"/><br/><br/>
					<input id="deletemember" type="button" value="->"/>
				</div>
				<div id="userdg"></div>
			</div>
			<div class="fitem">
				<label>描述:</label>
				 <input name="description" class="easyui-textbox"  style="width:300px;height:100px"
				 	data-options="multiline:true"/>
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