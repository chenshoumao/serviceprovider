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
<jsp:include page="/resources.jsp"></jsp:include>
<title>Insert title here</title>

<script type="text/javascript">
function showIcons() {
	var dialog = modalDialog({
		title : '浏览小图标',
		url :  '<%=basePath%>styles/framework/treeicon/icons.jsp',
		buttons : [ {
			text : '确定',
			handler : function() {
				var value=dialog.find('iframe').get(0).contentWindow.selectIcon(dialog, $('#menuIcon'));
				$("#menuIcon").textbox('setValue',value);
				dialog.dialog('destroy');
			}
		} ]
	});
}


$(function(){
	$('#dg').datagrid({
	    height: "100%",
	    url: '<%=basePath %>framework/menu/shows.action',
	    method: 'POST',
	    striped: true,
	    nowrap: true,
	    fit:true,
	    pageSize: 20,
	    pageNumber:1, 
	    pageList: [20,  50, 100, 150, 200],
	    showFooter: true,
		loadMsg : '数据加载中请稍后……',
		pagination : true,
	    toolbar:"#toolbar",
	    singleSelect: false,
	    checkOnSelect: false, 
	    selectOnCheck: false,
	    columns: [[
	        { field: 'ck', checkbox: true },
	        { field: 'menuId', title: '菜单id', width: 100},
	        { field: 'menuName', title: '菜单名称', width: 150},
	        { field: 'menuType', title: '菜单类型', width: 100},
	        { field: 'menuStatus', title: '菜单状态', width: 100, formatter:function(value,rec,index){    if(value=="1"){ return "显示";  }else{ return "隐藏";  }  }	 },
	        { field: 'sortNum', title: '排序号', width: 70},
	        { field: 'menuTarget', title: '链接目标', width: 200 },
	        { field: 'menuIcon', title: '菜单图标', width: 200},
	        { field: 'menuUrl', title: '菜单链接', width: 250},
	        { field: 'createTime', title: '创建时间', width: 150,
	        	 formatter:function(value,rec,index){  
	                  //  var s =new Date(value).toLocaleString().replace(/年|月/g, "-").replace(/日/g, " ");  
	                   // return s;  
	        		  var s =new Date(value).pattern("yyyy-MM-dd hh:mm:ss");
	                    return s;  
	                }	
	        },
	        { field: 'createBy', title: '创建者', width: 100 },
	        { field: 'updateTime', title: '最后更新时间', width: 150,
	        	 formatter:function(value,rec,index){  
	                    //var s =new Date(value).toLocaleString().replace(/年|月/g, "-").replace(/日/g, " ");  
	                    var s =new Date(value).pattern("yyyy-MM-dd hh:mm:ss");
	                    return s;  
	                }	
	        },
	        { field: 'updateBy', title: '更新者', width: 100 },
	        { field: 'description', title: '描述', width: 300 }
	    ]],
	   
	   
    onSelect: function (rowData) {
	    	$('#dg').datagrid("unselectAll");
	     },  
	    onDblClickRow :function(rowIndex,rowData){
	    	 //$(this).datagrid('unselectRow', rowIndex);
	    	   var create_time =new Date(rowData.createTime).pattern("yyyy-MM-dd hh:mm:ss");
	    	   var update_time=new Date().pattern("yyyy-MM-dd hh:mm:ss");
	    	   $("#update_time").textbox('setValue',update_time);
	    	   $("#create_time").textbox('setValue',create_time);
	
	    	   $("#create_by").textbox('setValue',rowData.createBy);
	           $("#update_by").textbox('setValue'," <%=com.solar.tech.util.Current.user().getUserName()%>");
	    	    editMenu(rowData);
	    	    
	    	  }
	});
	

	$("#addmember").click(function(){
		var rows = $('#userdg').datagrid('getSelections');
		if(rows.length>0){
			var jsonData={menuId:0, userIds:[]};
			jsonData.menuId=$("#auth_menu_id").val();
			for(var i=0; i<rows.length; i++){
        		jsonData.userIds.push(rows[i].userUID);
			}

			
	         $.post('<%=basePath%>framework/menu/addMenuUser.action',jsonData,function(result){
                 if (result.success){
                	  $('#userdg').datagrid('reload');
						$('#memberdg').datagrid('reload');
                 } else {
                     $.messager.show({    // show error message
                         title: 'Error',
                         msg: result.errorMsg
                     });
                 }
             },'json'); 
		}
	});
	
	$("#deletemember").click(function(){
		var rows = $('#memberdg').datagrid('getSelections');
		if(rows.length>0){
			var jsonData={menuId:0, userIds:[]};
			for(var i=0; i<rows.length; i++){
        		jsonData.userIds.push(rows[i].userUID);
			}
			jsonData.menuId=$("#auth_menu_id").val();
		$.ajax({
				url:"<%=basePath%>framework/menu/delMenuUser.action",
				type:"post",
				data:jsonData,
				dataType:"json",
				success:function(result){
					   if (result.success){
						   $('#userdg').datagrid('reload');
							$('#memberdg').datagrid('reload');
		                 } else {
		                     $.messager.show({    // show error message
		                         title: 'Error',
		                         msg: result.errorMsg
		                     });
		                 }
				}
			}); 
		}
	});
	
	

	

	
	
	
});

var url;
function newMenu(){
    $('#dlg').dialog('open').dialog('setTitle','创建菜单 ');
    $('#fm').form('clear');
    url = '<%=basePath%>framework/menu/add.action';
    $('#menuStatus').combobox('setValue', '1');
   var date=new Date().pattern("yyyy-MM-dd hh:mm:ss");
   $("#update_time").textbox('setValue',date);
   $("#create_time").textbox('setValue',date);
   $("#update_by").textbox('setValue'," <%=com.solar.tech.util.Current.user().getUserName()%>");
   $("#create_by").textbox('setValue'," <%=com.solar.tech.util.Current.user().getUserName()%>");
}
function editMenu(row){
    if (row){
        $('#dlg').dialog('open').dialog('setTitle','修改菜单');
        $('#fm').form('load',row);
        url = '<%=basePath%>framework/menu/updateMenu.action';    
    }
}


function saveMenu(){
    var values=$("#fm").serialize();
    if($("#fm").form('validate')){
    $.ajax({
		url:url,
		type:"post",
		data:values,
		dataType:"json",
		success:function(result){
			   if (result.errorMsg){
	                $.messager.show({
	                    title: 'Error',
	                    msg: result.errorMsg
	                });
	            } else {
	                $('#dlg').dialog('close');        // close the dialog
	                $('#dg').datagrid('reload');    // reload the user data
	            }
		}
	});
    }
}
function destroyMenu(){
	var rows = $('#dg').datagrid('getChecked');
    if (rows.length>0){
        $.messager.confirm('温馨提示','你真的要删除么?',function(r){
            if (r){
            	for(var i=0; i<rows.length; i++){
            		var row=rows[i];
             $.post('<%=basePath%>framework/menu/deleteMenu.action',{id:row.menuId},function(result){
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
        
function editBean(){
	var rows = $('#dg').datagrid('getChecked');
    if (rows.length==1){
    	var row=rows[0];
    	$("#auth_menu_id").val(row.menuId);
    	$("#user_group_menu_id").val(row.menuId);
    	
    	$("#fitem_member").css("display", "");
  	$('#memberdg').datagrid({
    	    url: '<%=basePath %>framework/menu/menuUsers.action?menuId='+row.menuId,
    	    width: 250,
    	    height: 280,
    	    method: 'POST',
    	    striped: true,
    	    nowrap: true,
    		loadMsg : '数据加载中请稍后……',
    	    columns: [[
    	        { field: 'ck', checkbox: true },
    	        { field: 'userName', title: '用户名称'},
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
                        	 return "冻结";
                         }else{
                        	 return "不明";
                         }
                     }	
    	        }
    	    ]]
    	}); 
    	
   	$('#userdg').datagrid({
   	 url: '<%=basePath %>framework/menu/unMenuUsers.action?menuId='+row.menuId,
    	    width: 290,
    	    height: 280,
    	    method: 'POST',
    	    striped: true,
    	    nowrap: true,
    		loadMsg : '数据加载中请稍后……',
    	    columns: [[
    	        { field: 'ck', checkbox: true },
    	        { field: 'userName', title: '用户名称'},
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
                        	 return "冻结";
                         }else{
                        	 return "不明";
                         }
                     }	
    	        }
    	    ]] 
    	});  
   	
   	
	$('#menu_groups').datagrid({
	    url: '<%=basePath %>framework/menu/menuGroups.action?menuId='+row.menuId,
	    width: 250,
	    height: 280,
	    method: 'POST',
	    striped: true,
	    nowrap: true,
		loadMsg : '数据加载中请稍后……',
	    columns: [[
	               { field: 'ck', checkbox: true },
	   	        { field: 'groupId', title: '用户组id'},
	   	        { field: 'groupName', title: '用户组名称'},
	    ]]
	}); 
	
	$('#user_groups').datagrid({
	    url: '<%=basePath %>framework/menu/unMenuGroups.action?menuId='+row.menuId,
	    width: 290,
	    height: 280,
	    method: 'POST',
	    striped: true,
	    nowrap: true,
		loadMsg : '数据加载中请稍后……',
	    columns: [[
	        { field: 'ck', checkbox: true },
	        { field: 'groupId', title: '用户组id'},
	        { field: 'groupName', title: '用户组名称'},
	      
	    ]] 
	});  

    	
    	   $('#user_dlg').dialog('open').dialog('setTitle','菜单名称:'+row.menuName);
 

    }else{
    $.messager.show({  
            title: '温馨提示',
            msg: '请选择一行进行权限分配'
        }); 
    }
}

function addUserGroups(){
	var rows = $('#user_groups').datagrid('getSelections');
	if(rows.length>0){
		var jsonData={menuId:0, groupsId:[]};
		jsonData.menuId=$("#user_group_menu_id").val();
		for(var i=0; i<rows.length; i++){
    		jsonData.groupsId.push(rows[i].groupId);
		}
         $.post('<%=basePath %>framework/menu/addMenuGroup.action',jsonData,function(result){
             if (result.success){
                 $('#menu_groups').datagrid('reload');    // reload the user data
                 $('#user_groups').datagrid('reload');    // reload the user data
             } else {
                 $.messager.show({    // show error message
                     title: 'Error',
                     msg: result.errorMsg
                 });
             }
         },'json'); 
	}
}

function delUserGroups(){
	var rows = $('#menu_groups').datagrid('getSelections');
	if(rows.length>0){
		var jsonData={menuId:0, groupsId:[]};
		jsonData.menuId=$("#user_group_menu_id").val();
		for(var i=0; i<rows.length; i++){
    		jsonData.groupsId.push(rows[i].groupId);
		}
         $.post('<%=basePath %>framework/menu/delMenuGroup.action',jsonData,function(result){
             if (result.success){
                 $('#menu_groups').datagrid('reload');    // reload the user data
                 $('#user_groups').datagrid('reload');    // reload the user data
             } else {
                 $.messager.show({    // show error message
                     title: 'Error',
                     msg: result.errorMsg
                 });
             }
         },'json'); 
	}
}
    </script>
</head>
<body>
	<div id="dg" style="width: 100%;height:100%"></div>
	<div id="toolbar">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-add" plain="true" onclick="newMenu()">创建菜单</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-remove" plain="true" onclick="destroyMenu()">删除菜单</a>
			<a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-man" plain="true" onclick="editBean()">权限</a>
	</div>

	<div id="dlg" class="easyui-dialog"
		style="width: 580px; height: 400px; " closed="true"
		buttons="#dlg-buttons"  modal="true">
		
		<!-- <div class="ftitle" id="ftitle"></div> -->
		
<!-- 		//////////////////////////////////////////////////////////////////////////////////// -->
<div id="tabs" class="easyui-tabs" fit="true" border="false" >
	<div title="菜单信息">
		<form id="fm" method="post" novalidate>
		<input name="menuId"  type="hidden">
			<div class="fitem">
				<label>菜单名称:</label>
				 <input name="menuName" class="easyui-textbox"
					required="true" style="width: 280px;" validtype="length[1,15]" invalidMessage="有效长度1-15" >

			</div>
			<div class="fitem">
				<label>菜单链接:</label>
				 <input name="menuUrl" class="easyui-textbox" validtype="length[0,100]" invalidMessage="有效长度0-100" 
					style="width: 280px;">
			</div>
			<div class="fitem">
				<label>菜单类型:</label> 
				<input name="menuType" class="easyui-textbox" validtype="length[0,25]" invalidMessage="有效长度0-25" 
					style="width: 280px;">
			</div>
			<div class="fitem">
				<label>链接目标:</label> 
				<!-- <input name="menuTarget" class="easyui-textbox" validtype="length[0,50]" invalidMessage="有效长度0-50" 
					style="width: 280px;"> -->
					<select class="easyui-combobox"
					name="menuTarget"  id="menuTarget" style="width: 280px;">
					<option value="self" >选项卡</option>
					<option value="_blank">新窗口</option>
				</select>
			</div>
			<div class="fitem">
				<label>菜单状态:</label>
				 <select class="easyui-combobox" id="menuStatus" name="menuStatus" style="width: 280px;">
					<option value="1" >显示</option>
					<option value="2">隐藏</option>
				</select>
			</div>
			<div class="fitem">
				<label>排序号:</label> 
				<input name="sortNum" type="text"
					class="easyui-numberspinner" value="0" data-options="min:0,max:100,prompt: '0'"
					style="width: 280px">
					
			</div>
			<div class="fitem">
				<label>菜单图标:</label> 
<!-- 				<input name="menuIcon" class="easyui-textbox" validtype="length[0,70]" invalidMessage="有效长度0-70" 
					style="width: 280px;"> -->
			   		<input class="easyui-textbox" name="menuIcon"
					id="menuIcon" type="text" style="width: 280px;"
					data-options="
			prompt: ' ',
		   icons:[{
				 iconCls:'icon-search',
				handler: function(e){
				showIcons();
				}
			}]">
			</div>
			<div class="fitem">
				<label>描述:</label> 
				<textarea  name="description"   style="width: 280px; height: 50px;border: 1px solid #95B8E7;border-radius: 5px 5px 5px 5px;"></textarea>
			</div>
			
			
			
			
		</form>
		</div>
		<div title="附加信息" style="	margin: 0;padding: 10px 30px;">  
				<div class="fitem">
				<label>创建者:</label> 
				<input id="create_by" class="easyui-textbox"
					style="width: 280px;" value="username" disabled="true">
			</div>
				<div class="fitem">
				<label>更新者:</label> 
				<input id="update_by" class="easyui-textbox"
					style="width: 280px;" value="username" disabled="true">
			</div>
				<div class="fitem">
				<label>创建时间:</label> 
				<input  id="create_time" class="easyui-textbox" 
					style="width: 280px;"  disabled="true">
			</div>
				<div class="fitem">
				<label>最后更新时间:</label> 
				<input id="update_time" class="easyui-textbox" 
					style="width: 280px;"disabled="true">
			</div>
			
		
		</div>
	
	</div>
	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" onclick="saveMenu()" style="width: 90px">保存</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')"
			style="width: 90px">取消</a>
	</div>



	<div id="user_dlg" class="easyui-dialog"
		style="width: 800px; height: 500px;"  closed="true"
		buttons="#user_dlg-buttons" modal="true">
	<div id="tabs" class="easyui-tabs" fit="true" border="false">
			<!--  div title="用户">
		<form id="fm" method="post" novalidate>
		<input id="groupId" name="groupId"  type="hidden">
			<div class="fitem">
				<div id="auth_menu_name"></div>
				<input type="hidden" id="auth_menu_id"/>
			</div>
			<div id="fitem_member" class="fitem fitem_member">
				<label style="display:block;margin-bottom:10px">成员:</label>
				<div id="memberdg"></div>
				<div class="memberbutton">
					<input id="addmember" type="button" value="<-"/><br/><br/>
					<input id="deletemember" type="button" value="->"/>
				</div>
				<div id="userdg"></div>
			</div>

		</form>
			
			</div> -->
			<div title="用户组" style="margin-left:20px;margin-rigjt:20px;margin-top:20px;">
				<form id="user_group_fm" method="post" novalidate>
	
			<div class="fitem">
				<input type="hidden" id="user_group_menu_id" name="userGroupMenuId"/>
			</div>
			
			<div id="fitem_member" class="fitem fitem_member">
				<label style="display:block;margin-bottom:10px">用户组:</label>
				<div id="menu_groups"></div>
				<div class="memberbutton">
					<input id="add_menu_group" type="button" value="<-" onclick="addUserGroups()"/><br/><br/>
					<input id="delete_menu_group" type="button" value="->" onclick="delUserGroups()"/>
				</div>
				<div id="user_groups"></div>
			</div>

		</form>
			</div>
				
		</div>
	</div>
	<div id="user_dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" onclick="javascript:$('#user_dlg').dialog('close')" style="width: 90px">保存</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel" onclick="javascript:$('#user_dlg').dialog('close')"
			style="width: 90px">取消</a>
	</div>
</body>
</html>