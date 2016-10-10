<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
				var value=dialog.find('iframe').get(0).contentWindow.selectIcon(dialog, $('#itemIcon'));
				$("#itemIcon").textbox('setValue',value);
				dialog.dialog('destroy');
			}
		} ]
	});
}


$(function(){
	$('#dg').treegrid({
		parentField : 'parentItemId',
		title : '',
		url : '<%=basePath %>framework/menu/item/shows.action?page=1&rows=20',
		 height: "100%",
	method : 'POST',
		striped : true,
		nowrap : true,
		 fit:true,
		 singleSelect: false,
		    checkOnSelect: false, 
		    selectOnCheck: false,
		 idField:'itemId',  
		    treeField:'itemName',
			loadMsg : '数据加载中请稍后……',
			toolbar : "#toolbar",
		    columns:[[  
{
	field : 'ck',
	checkbox : true
},
		        {title:'菜单项名称',field:'itemName',width:180},  
		        {
					field : 'itemId',
					title : '菜单项id',
					width : 100
				},
	
				{
					field : 'menuId',
					title : '所属菜单id',
					hidden:true,
					width : 100
				},
				{
					field : 'menuName',
					title : '所属菜单',
					width : 100
				},
				{
					field : 'parentItemId',
					title : '上级菜单id',
					hidden:true,
					width : 100
					
				},
				{
					field : 'parentItemName',
					title : '上级菜单',
					hidden:true,
					width : 100
				},
				{
					field : 'pageName',					
					title : '导航页面',
					width : 150
				},
				{
					field : 'pageId',
					title : '菜单项链接页面ID',
					hidden:true,
					width : 120
				},
				{
					field : 'itemUrl',
					title : '菜单项链接',
					width : 200
				},
				{
					field : 'itemTarget',
					title : '菜单项链接目标',
					width : 100
				},
			
				{
					field : 'itemType',
					title : '菜单项类型',
					width : 100
				},

				{
					field : 'itemStatus',
					title : '菜单项状态',
					width : 100,
					formatter : function(value, rec, index) {
						if (value == "1") {
							return "显示";
						} else {
							return "隐藏";
						}
					}
				},
				{
					field : 'sortNum',
					title : '排序号',
					width : 70
				},
				{
					field : 'itemIcon',
					title : '菜单项图标',
					hidden:true,
					width : 200
				},
				{
					field : 'createTime',
					title : '创建时间',
					width : 150,
					formatter : function(value, rec, index) {
						//var s = new Date(value).toLocaleString().replace(/年|月/g, "-").replace(/日/g," ");
					var s =new Date(value).pattern("yyyy-MM-dd hh:mm:ss");
					return s;
					}
				},
				{
					field : 'createBy',
					title : '创建者',
					width : 100
				},
				{
					field : 'updateTime',
					title : '最后更新时间',
					width : 150,
					formatter : function(value, rec, index) {
						//var s = new Date(value).toLocaleString().replace(/年|月/g, "-").replace(/日/g," ");
						var s =new Date(value).pattern("yyyy-MM-dd hh:mm:ss");
						return s;
					}
				}, {
					field : 'updateBy',
					title : '更新者',
					width : 100
				}, {
					field : 'description',
					title : '描述',
					hidden:true,
					width : 300
				} 
		    ]]  ,
		  onSelect: function (rowData) {
		    	$('#dg').datagrid("unselectAll");
		     },  
	onDblClickRow : function(rowData) {
  	   var create_time =new Date(rowData.createTime).pattern("yyyy-MM-dd hh:mm:ss");
  	   var update_time=new Date().pattern("yyyy-MM-dd hh:mm:ss");
  	   $("#update_time").textbox('setValue',update_time);
  	   $("#create_time").textbox('setValue',create_time);

  	   $("#create_by").textbox('setValue',rowData.createBy);
         $("#update_by").textbox('setValue'," <%=com.solar.tech.util.Current.user().getUserName()%>");
		editMenuItem(rowData);
	}
	});
	
	
	$("#addmember").click(function(){
		var rows = $('#userdg').datagrid('getSelections');
		if(rows.length>0){
			var jsonData={itemId:0, userIds:[]};
			jsonData.itemId=$("#auth_menu_id").val();
			for(var i=0; i<rows.length; i++){
        		jsonData.userIds.push(rows[i].userUID);
			}

			
	         $.post('<%=basePath%>framework/menu/item/addItemUser.action',jsonData,function(result){
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
			var jsonData={itemId:0, userIds:[]};
			for(var i=0; i<rows.length; i++){
        		jsonData.userIds.push(rows[i].userUID);
			}
			jsonData.itemId=$("#auth_menu_id").val();
		$.ajax({
				url:"<%=basePath%>framework/menu/item/delItemUser.action",
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
        function newMenuItem(){
            $('#dlg').dialog('open').dialog('setTitle','创建菜单项 ');
            $('#fm').form('clear');
            url = '<%=basePath%>framework/menu/item/add.action';
            $('#itemStatus').combobox('setValue', '1');
            $('#itemTarget').combobox('setValue', 'self');
            var date=new Date().pattern("yyyy-MM-dd");
            $("#update_time").textbox('setValue',date);
            $("#create_time").textbox('setValue',date);
            //$('#ftitle').html("修改菜单项");
            var date=new Date().pattern("yyyy-MM-dd hh:mm:ss");
            $("#update_time").textbox('setValue',date);
            $("#create_time").textbox('setValue',date);
            $("#update_by").textbox('setValue'," <%=com.solar.tech.util.Current.user().getUserName()%>");
            $("#create_by").textbox('setValue'," <%=com.solar.tech.util.Current.user().getUserName()%>");
        }
        function editMenuItem(row){
            if (row){
                $('#dlg').dialog('open').dialog('setTitle','修改菜单项');
                $('#fm').form('load',row);
                url = '<%=basePath%>framework/menu/item/update.action';
               // $('#ftitle').html("修改菜单项");
            }
        }
        
        function saveMenuItem(){
/*             $('#fm').form('submit',{
                url: url,
                onSubmit: function(){
                    return $(this).form('validate');
                },
                success: function(result){
                    var result = eval('('+result+')');
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
            }); */
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
        	                $('#dg').treegrid('reload');    // reload the user data
        	            }
        		}
        	});
            }
        }
        function destroyMenuItem(){
        	var rows = $('#dg').datagrid('getChecked');
            if (rows.length>0){
                $.messager.confirm('温馨提示','你真的要删除么?',function(r){
                    if (r){
                    	for(var i=0; i<rows.length; i++){
                    		var row=rows[i];
                     $.post('<%=basePath%>framework/menu/item/delMenuItem.action',{id:row.itemId},function(result){
                            if (result.success){
                                $('#dg').treegrid('reload');    // reload the user data
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
        
        //打卡上级菜单项的树形菜单的dialog 界面
        function  showParentMenuItem(){
        	var  parentMenuId=$('#menuId').combobox('getValue');
        	if(parentMenuId==""){
        		 $.messager.show({    // show error message
                     title: '温馨提示',
                     msg: "请选择所属菜单"
                 });
        	}else{
         	$('#parentMenuItemTreee').tree({   
                url: '<%=basePath %>framework/menu/item/menuItemTree.action?id='+parentMenuId+'&&flag=root',   
                loadMsg: "数据加载中，请稍后...",  	
                onBeforeExpand:function(node,param){  
                    $('#parentMenuItemTreee').tree('options').url = "<%=basePath %>framework/menu/item/menuItemTree.action?id=" + node.id+"&flag="+node.url;
                },               
               onClick:function(node){
                   },
                   onCheck : function(node,checked){
                   }
           });
      	  $('#parentMenuItem').dialog('open').dialog('setTitle',' ');
        	}
      }
        function getTreeNode(){
             if(($('#parentMenuItemTreee').tree('getSelected')!=null)){
        	var id=$('#parentMenuItemTreee').tree('getSelected').id;
        	var url=$('#parentMenuItemTreee').tree('getSelected').url;
        	var name=$('#parentMenuItemTreee').tree('getSelected').text;
        /* 	var parentNode = $('#parentMenuItemTreee').tree('getParent', $('#parentMenuItemTreee').tree('getSelected').target);
          
        	if(parentNode==null){
            	   $("#parentItemName").textbox('setValue',name);
            	   $("#parentItemId").val(0);
               }else{ */
            	   var itemId=$('#itemId').val();
               if(itemId==id){
            	   $.messager.show({    // show error message
                       title: '温馨提示',
                       msg: "不能选择自己作为上级菜单项"
                   });
               }else{
            	   $("#parentItemName").textbox('setValue',name);
            	   $("#parentItemId").val(id);
        	$('#parentMenuItem').dialog('close');
               }
             }else{
            	 $.messager.show({    // show error message
                     title: '温馨提示',
                     msg: "请选择要添加的菜单项"
                 });
             }
        }
        
        function  showPage(){
         	$('#pageTreee').tree({   
         		url: '<%=basePath %>framework/page/group/pageGuid.action?id=0',    
         		loadMsg: "数据加载中，请稍后...",  	
                onBeforeExpand:function(node,param){  
                	  $('#pageTreee').tree('options').url = "<%=basePath %>framework/page/group/pageGuid.action?id=" + node.id;
                },               
               onClick:function(node){
                   },
                   onCheck : function(node,checked){
                   }
           });
      	  $('#page').dialog('open').dialog('setTitle','请选择导航页面');
      }
        
        function getPageTreeNode(){
             if(($('#pageTreee').tree('getSelected')!=null)){
        	var id=$('#pageTreee').tree('getSelected').id;
        	var pageName=$('#pageTreee').tree('getSelected').text;
        	var isGroup=$('#pageTreee').tree('getSelected').attributes.group;
        	if(isGroup=="false"){
            	   $("#pageId").val(id);
            	   $("#pageName").textbox('setValue',pageName);
        	       $('#page').dialog('close');
        	     }else{
        	    	 $.messager.show({    // show error message
                         title: '温馨提示',
                         msg: "只能选择页面"
                     });
        	     }
             }else{
            	 $.messager.show({    // show error message
                     title: '温馨提示',
                     msg: "请选择要添加的页面"
                 });
             }
        }
        
        
        function editBean(){
        	var rows = $('#dg').datagrid('getChecked');
            if (rows.length==1){
            	var row=rows[0];
            	$("#auth_menu_id").val(row.itemId);
            	$("#user_group_menu_id").val(row.itemId);
            	
            	$("#fitem_member").css("display", "");
          	$('#memberdg').datagrid({
            	    url: '<%=basePath %>framework/menu/item/itemUsers.action?itemId='+row.itemId,
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
           	   url: '<%=basePath %>framework/menu/item/unItemUsers.action?itemId='+row.itemId,
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
        	    url: '<%=basePath %>framework/menu/item/itemUserGroups.action?itemId='+row.itemId,
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
        	    url: '<%=basePath %>framework/menu/item/unItemUserGroups.action?itemId='+row.itemId,
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

            	
            	   $('#user_dlg').dialog('open').dialog('setTitle','菜单项名称:'+row.itemName);
         

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
        		var jsonData={itemId:0, groupsId:[]};
        		jsonData.itemId=$("#user_group_menu_id").val();
        		for(var i=0; i<rows.length; i++){
            		jsonData.groupsId.push(rows[i].groupId);
        		}
                 $.post('<%=basePath %>framework/menu/item/addUserGroup.action',jsonData,function(result){
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
        		var jsonData={itemId:0, groupsId:[]};
        		jsonData.itemId=$("#user_group_menu_id").val();
        		for(var i=0; i<rows.length; i++){
            		jsonData.groupsId.push(rows[i].groupId);
        		}
                 $.post('<%=basePath %>framework/menu/item/delItemUserGroup.action',jsonData,function(result){
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
			iconCls="icon-add" plain="true" onclick="newMenuItem()">创建菜单项</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-remove" plain="true" onclick="destroyMenuItem()">删除菜单项</a>
			<a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-man" plain="true" onclick="editBean()">权限</a>
	</div>
	<div id="dlg" class="easyui-dialog"
		style="width: 570px; height: 478px; " closed="true"
		buttons="#dlg-buttons"  modal="true">
	<!-- 	<div class="ftitle" id="ftitle"></div> -->
	<div id="tabs" class="easyui-tabs" fit="true" border="false" >
	<div title="菜单信息">
		<form id="fm" method="post" novalidate>
			<div class="fitem">
				<input type="hidden" name="itemId"  id="itemId"/> <label>菜单项名称:</label> <input
					name="itemName" class="easyui-textbox" required="true"
					style="width: 280px;" validtype="length[1,20]"
					invalidMessage="有效长度1-15">
			</div>
			<div class="fitem">
				<label>所属菜单:</label> <select class="easyui-combobox" 
				id="menuId" name="menuId"
					style="width: 280px;" required="true">

					<c:forEach var="item" items="${menus}" varStatus="s">
						<option value="${item.menuId}"><c:out
								value="${item.menuName}"></c:out></option>

					</c:forEach>

				</select>
			</div>
			<div class="fitem">
				<label>上级菜单项:</label> 
				<input id="parentItemId" name="parentItemId"  type="hidden" value="0" />
				<input class="easyui-textbox"
					id="parentItemName" name="parentItemName" type="text" 
					style="width: 280px;"
					data-options="
			prompt: '第一菜单项',
			icons:[{
				iconCls:'icon-search',
				handler: function(e){
					showParentMenuItem();
				}
			}]">
			</div>
			<div class="fitem">
				<label>导航页面:</label> 
				<input name="pageId"  id="pageId"  type="hidden">
				<input class="easyui-textbox" name="pageName"
					id="pageName" type="text" style="width: 280px;"
					data-options="
			prompt: ' ',
			icons:[{
				iconCls:'icon-search',
				handler: function(e){
				showPage();
				}
			}]">
			</div>
			<div class="fitem">
				<label>菜单项链接:</label> <input name="itemUrl" class="easyui-textbox"
					style="width: 280px;">
			</div>
			<div class="fitem">
				<label>菜单项类型:</label> <input name="itemType" class="easyui-textbox"
					style="width: 280px;">
			</div>
			<div class="fitem">
				<label>链接目标:</label>
					<select class="easyui-combobox"
					name="itemTarget"  id="itemTarget" style="width: 280px;">
					<option value="self" >选项卡</option>
					<option value="_blank">新窗口</option>
				</select>
					
			</div>
			<div class="fitem">
				<label>菜单项状态:</label> <select class="easyui-combobox"
					name="itemStatus"  id="itemStatus" style="width: 280px;">
					<option value="1" selected>显示</option>
					<option value="2">隐藏</option>
				</select>
			</div>
			<div class="fitem">
				<label>排序号:</label> <input name="sortNum"	
					class="easyui-numberspinner" value="0" data-options="min:0,max:100,prompt: '0'"
					style="width: 280px">
			</div>
			<div class="fitem">
				<label>菜单项图标:</label> 
						<input class="easyui-textbox" name="itemIcon"
					id="itemIcon" type="text" style="width: 280px;"
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
		
	</div>


	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" onclick="saveMenuItem()" style="width: 90px">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')"
			style="width: 90px">取消</a>
	</div>

	<div id="parentMenuItem" class="easyui-dialog"
		style="width: 450px; height: 350px; padding: 10px 20px" closed="true"
		buttons="#parentMenuItemButtons">
		<div id="parentMenuItemTreee"></div>
	</div>

	<div id="parentMenuItemButtons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" onclick="getTreeNode()" style="width: 90px">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel"
			onclick="javascript:$('#parentMenuItem').dialog('close')"
			style="width: 90px">取消</a>
	</div>


	<div id="page_buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" onclick="getPageTreeNode()" style="width: 90px">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel" onclick="javascript:$('#page').dialog('close')"
			style="width: 90px">取消</a>
	</div>

	<div id="page" class="easyui-dialog"
		style="width: 450px; height: 350px; padding: 10px 20px" closed="true"
		buttons="#page_buttons">
		<div id="pageTreee"></div>
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
			
			</div-->
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