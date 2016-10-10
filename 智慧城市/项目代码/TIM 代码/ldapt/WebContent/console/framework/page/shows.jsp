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
<link rel="stylesheet" type="text/css"href="<%=basePath%>styles/framework/frameset.css">
<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/icon.css">
<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-easyui/jquery.min.js"></script>
<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-easyui/jquery.easyui.min.js"></script>
<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript"src="<%=basePath%>scripts/framework/frameset.js"></script>
<title>Insert title here</title>

<script type="text/javascript">

function editBean(){
	 	var checked = $("#parentMenuItemTreee").tree("getSelected");
        	if(checked!=null){
        		var itemId=checked.id;
        			var isGroup=checked.attributes.group;
            	if(isGroup=="true"){
           		 $.messager.show({    // show error message
                        title: '温馨提示',
                        msg: "只能选择页面"
                    });
            	}else{
    	$("#auth_menu_id").val(itemId);
    	$("#user_group_menu_id").val(itemId);
    	
   $("#fitem_member").css("display", "");
  	$('#memberdg').datagrid({
    	    url: '<%=basePath %>framework/page/userWebPage.action?pageModuleId='+itemId,
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
   	 url: '<%=basePath %>framework/page/unUserWebPage.action?pageModuleId='+itemId,
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
	    url: '<%=basePath %>framework/page/userGroupWebPage.action?pageModuleId='+itemId,
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
	    url: '<%=basePath %>framework/page/unUserGroupWebPage.action?pageModuleId='+itemId,
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

    	
    	   $('#user_dlg').dialog('open').dialog('setTitle','页面权限');
 }

    }else{
   
             	 $.messager.show({    // show error message
                   title: '温馨提示',
                   msg: "请选择页面"
               });
           
    }
}

function addUserGroups(){
	var rows = $('#user_groups').datagrid('getSelections');
	if(rows.length>0){
		var jsonData={pageGroupId:0, groupsId:[]};
		jsonData.pageGroupId=$("#user_group_menu_id").val();
		for(var i=0; i<rows.length; i++){
    		jsonData.groupsId.push(rows[i].groupId);
		}
         $.post('<%=basePath %>framework/page/addUserGroupWebPage.action',jsonData,function(result){
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
		var jsonData={pageGroupId:0, groupsId:[]};
		jsonData.pageGroupId=$("#user_group_menu_id").val();
		for(var i=0; i<rows.length; i++){
    		jsonData.groupsId.push(rows[i].groupId);
		}
         $.post('<%=basePath %>framework/page/delUserGroupWebPage.action',jsonData,function(result){
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



$(function(){

	$('#parentMenuItemTreee').tree({   
        url: '<%=basePath %>framework/page/pageTree.action?id=0', 
        animate:true,
        loadMsg: "数据加载中，请稍后...",  	
        onLoadSuccess:function(node, data){
        	ajaxLoadEnd();
        },
     onBeforeLoad:function(node, param){
    	 ajaxLoading();
        },
        onBeforeExpand:function(node,param){  
         $('#parentMenuItemTreee').tree('options').url = "<%=basePath %>framework/page/pageTree.action?id="+node.id;
        },               
       onClick:function(node){
           },
           onCheck : function(node,checked){
           },
           onContextMenu: function (e, title) {
               e.preventDefault();
                  $("#tabsMenu").menu('show', {
                   left: e.pageX,
                   top: e.pageY
               });
      
           }
   });
   
   $("#addmember").click(function(){
		var rows = $('#userdg').datagrid('getSelections');
		if(rows.length>0){
			var jsonData={pageGroupId:0, usersId:[]};
			jsonData.pageGroupId=$("#auth_menu_id").val();
			for(var i=0; i<rows.length; i++){
        		jsonData.usersId.push(rows[i].userUID);
			}

			
	         $.post('<%=basePath %>framework/page/addUserWebPage.action',jsonData,function(result){
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
			var jsonData={pageGroupId:0, usersId:[]};
			for(var i=0; i<rows.length; i++){
        		jsonData.usersId.push(rows[i].userUID);
			}
			jsonData.pageGroupId=$("#auth_menu_id").val();
		$.ajax({
				url:"<%=basePath %>framework/page/delUserWebPage.action",
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
        function newPageGroup(){
        	var checked = $("#parentMenuItemTreee").tree("getSelected");
        	if(checked!=null){
        	   	var isGroup=checked.attributes.group;
            	if(isGroup=="false"){
            		 $.messager.show({    // show error message
                         title: '温馨提示',
                         msg: "只能在页面组下添加页面"
                     });
            	     }else{
            	    		var id=checked.id;
            	            $('#dlg').dialog('open').dialog('setTitle',' ');
            	            $('#fm').form('clear');
            	            url = '<%=basePath%>framework/page/add.action';
            	            $('#ftitle').html("创建页面");
            	                $("[name='needAclCtrl']").eq(0)[0].checked=true;
            	        	if(id=="root"){
            	 			   $("#moduleName").textbox('setValue',"未分类");
            	 			   $("#moduleId").val("0");
            	 		}else{
            	 			  $("#moduleName").textbox('setValue',checked.text);
            				   $("#moduleId").val(id);
            	 		}
            	     }
        	
            
        	}else{
              	 $.messager.show({    // show error message
                    title: '温馨提示',
                    msg: "请选择要添加的上级目录"
                });
            }
        }
        function editPageGroup(){
          	var checked = $("#parentMenuItemTreee").tree("getSelected");
        	if(checked!=null){
        	 	var isGroup=checked.attributes.group;
            	if(isGroup=="true"){
           		 $.messager.show({    // show error message
                        title: '温馨提示',
                        msg: "选择要修改的页面"
                    });
            	}else{
        		var id=checked.id;
                  $.ajax({
              		url: '<%=basePath%>framework/page/detail.action',
              		type:"post",
              		data:{id:id},
              		dataType:"json",
              		success:function(result){
              			   if (result){
              	              $('#dlg').dialog('open').dialog('setTitle','');
              	              $('#fm').form('clear');
              	                $('#fm').form('load',result);
              	                url = '<%=basePath%>framework/page/update.action';
              	                $('#ftitle').html("修改页面")
              	            } else {
              	            	$.messager.show({    // show error message
              	                   title: '温馨提示',
              	                   msg: "数据加载失败"
              	               });
              	            }
              		}
              	});
            	}

        	}else{
             	 $.messager.show({    // show error message
                   title: '温馨提示',
                   msg: "请选择要修改的页面"
               });
           }
        }
        

        
        function savePageGroup(){
        	   var values=$("#fm").serialize();
        	    $.ajax({
        			url:url,
        			type:"post",
        			data:values,
        			dataType:"json",
        			success:function(result){
        				   if (!result.success){
        		                $.messager.show({
        		                    title: 'Error',
        		                    msg: result.errorMsg
        		                });
        		            } else {
        		               	var checked = $("#parentMenuItemTreee").tree("getSelected");
        		           /*         if(result.flag=="add"){
                            	$('#parentMenuItemTreee').tree('append', {parent:checked.target, data:{id:result.module.pageId, text:result.module.pageName}});
        		                   }else{
        		                	
        		                	   $('#parentMenuItemTreee').tree('update', {
        		                			target: checked.target,
        		                			text: result.module.pageName
        		                		});
        		                   } */
                            	$('#dlg').dialog('close');    
        		               
        		                   //$('#parentMenuItemTreee').tree('collapseAll');
        		                   // $('#parentMenuItemTreee').tree('reload');
        		               // $('#parentMenuItemTreee').load();
        		               //    $('#parentMenuItemTreee').tree('expandAll');
                                   $.messager.show({    // show error message
                                    title: '温馨提示',
                                    msg: "操作成功"
                                });
                                window.location.reload();
                          
        		            }
        			}
        		});
        }
        function destroyPageGroup(){
           	var checked = $("#parentMenuItemTreee").tree("getSelected");
        	if(checked!=null){
        		var id=checked.id;
        	 	var isGroup=checked.attributes.group;
            	if(isGroup=="true"){
           		 $.messager.show({    // show error message
                        title: '温馨提示',
                        msg: "只能删除页面"
                    });
            	}else{
        		$.messager.confirm('温馨提示','你真的要删除么?',function(r){
                    if (r){
                        $.post('<%=basePath%>framework/page/del.action',{id:id},function(result){
                            if (result.success){
                            	 $('#parentMenuItemTreee').tree('remove', checked.target); 
                            	   $.messager.show({    // show error message
                                       title: '温馨提示',
                                       msg: "删除成功"
                                   });
                            } else {
                                $.messager.show({    // show error message
                                    title: 'Error',
                                    msg: result.errorMsg
                                });
                            }
                        },'json'); 
                    }
                });
            	}
        	}else{
              	 $.messager.show({    // show error message
                    title: '温馨提示',
                    msg: "请选择要删除的目录"
                });
            }  
        }
        

        //打开页面组的树形菜单的dialog 界面
        function  showParentPageGroup(){
         	$('#parentPageGroupTree').tree({   
         		 url: '<%=basePath %>framework/page/group/parentModul.action?id=0', 
                 animate:true,
                 loadMsg: "数据加载中，请稍后...",  	
                 
                onBeforeExpand:function(node,param){  
                	 $('#parentPageGroupTree').tree('options').url = "<%=basePath %>framework/page/group/parentModul.action?id=" + node.id;
                },               
                 onClick:function(node){
                   },
                   onCheck : function(node,checked){
                   }
           });
      	  $('#parentPageGroup').dialog('open').dialog('setTitle',' 请选择页面组');
      }
      
        function saveCheckedPageGroup(){
        	var checked = $("#parentPageGroupTree").tree("getSelected");
        	if(checked!=null){
        		var id=checked.id;
            	if(id=="root"){
 	 			   $("#moduleName").textbox('setValue',"未分类");
 	 			   $("#moduleId").val("0");
 	 		}else{
 	 			  $("#moduleName").textbox('setValue',checked.text);
 				   $("#moduleId").val(id);
 	 		}
            	$('#parentPageGroup').dialog('close');
        	}else{
              	 $.messager.show({    // show error message
                    title: '温馨提示',
                    msg: "请选择要添加的页面组"
                });
            }
        }
</script>
</head>
<body>
	
		<div id="parentMenuItemTreee" style="padding:20px;"></div>
	<div id="dlg" class="easyui-dialog"
		style="width: 570px; height: 400px; padding: 10px 20px" closed="true" modal="true"
		buttons="#dlg-buttons">
		<div class="ftitle" id="ftitle"></div>
	<form id="fm" method="post" novalidate>
		<input name="pageId"  type="hidden">
			<div class="fitem">
				<label>页面名称:</label>
				 <input name="pageName" class="easyui-textbox"
					required="true" style="width: 280px;" validtype="length[1,15]" invalidMessage="有效长度1-15" >
			</div>
			
			<div class="fitem">
				<label>所属页面组:</label> 
				<input 
					id="moduleId" name="moduleId" type="hidden" value="0">
				<input class="easyui-textbox"
					id="moduleName" name="moduleName" type="text" 
					style="width: 280px;" 
					data-options="
			prompt: '未分类',
			icons:[{
				iconCls:'icon-search',
				handler: function(e){
				showParentPageGroup();
				}
			}]">
			</div>
			
			<div class="fitem">
				<label>页面权限控制:</label>
				 <input name="needAclCtrl" type="radio" value="ON" />开启
				 <input name="needAclCtrl" type="radio" value="OFF" />关闭
			</div>
					<div class="fitem">
				<label>页面类型:</label>
				 <select class="easyui-combobox" id="pageType" name="pageType" style="width: 280px;">
					<option value="BKGPG" >后台系统管理页面</option>
					<option value="FRTPG">前台用户控制面板页面</option>
					<option value="WEBPG">前台网站页面</option>
				</select>
			</div>
					<div class="fitem">
				<label>排序号:</label> <input name="sortNum" type="text"
					class="easyui-numberspinner" value="0" data-options="min:0,max:100,prompt: '0'"
					style="width: 280px">
			</div>
			
			
			<div class="fitem">
				<label>页面编号:</label> 
				<input name="pageNum" class="easyui-textbox" validtype="length[0,25]" invalidMessage="有效长度0-25" 
					style="width: 280px;">
			</div>
			
			<div class="fitem">
				<label>页面链接:</label> <input name="pageUrl" class="easyui-textbox" validtype="length[0,255]" invalidMessage="有效长度0-70" 
					style="width: 280px;">
			</div>
			
			<div class="fitem">
				<label>描述:</label> 
				<textarea  name="description"   style="width: 280px; height: 50px;border: 1px solid #95B8E7;border-radius: 5px 5px 5px 5px;"></textarea>
			</div>
		</form>
	</div>


	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" onclick="savePageGroup()" style="width: 90px">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')"
			style="width: 90px">取消</a>
	</div>



	 <div id="tabsMenu" class="easyui-menu" style="width:120px;">  
    <div id="createPage"  onclick="newPageGroup()">新建</div>  
    <div onclick="destroyPageGroup()">删除</div>  
    <div  onclick="editPageGroup()">更新</div>
    <div  onclick="editBean()">权限</div>
  </div>  
  
  	<div id="parentPageGroup" class="easyui-dialog"
		style="width: 450px; height: 350px; padding: 10px 20px" closed="true"
		buttons="#parentPageGroupButtons">
		<div id="parentPageGroupTree"></div>
	</div>

	<div id="parentPageGroupButtons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" onclick="saveCheckedPageGroup()" style="width: 90px">保存</a>
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel"
			onclick="javascript:$('#parentPageGroup').dialog('close')"
			style="width: 90px">取消</a>
	</div>
	
		<div id="user_dlg" class="easyui-dialog"
		style="width: 800px; height: 500px;"  closed="true"
		buttons="#user_dlg-buttons" modal="true">
	<div id="tabs" class="easyui-tabs" fit="true" border="false">
			<div title="用户">
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
			
			</div>
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