<%@page import="com.solar.tech.bean.User"%>
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
	    url: '<%=basePath %>framework/ldap/showsall.action',
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
	        { field: '<%=User.USERNAME%>', title: '用户名称', width: 150},
	        { field: 'email', title: '邮箱地址', width: 200},
	        { field: 'mobile', title: '手机号码', width: 200},
	      	    
	        { field: '<%=User.USERSTATUS %>', title: '用户状态', width: 250,
	        	 formatter:function(value,rec,index){  
                     if(value==<%=User.UserStatus.ACT %>){
                    	 return "活动";
                     }else if(value=<%=User.UserStatus.FRZ %>){
                    	 return "活动";
                     }
                 }	
	        }
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

    url = '<%=basePath%>framework/ldap/add.action';
    $('#ftitle').html("添加用户");
}
var fitemPassword;
function editBean(row){
    if (row){
        if(row.userClass=='SYST'){

        	$("#fitemPassword").show();
        	
        }else{

        	$("#fitemPassword").hide();
        }
        row.password2=row.password="******";
        $('#dlg').dialog('open').dialog('setTitle','');
        $('#fm').form('load',row);
        $("#headImgFile").val("");
        $('#headImg').attr("src", "<%=basePath%>/images/framework/headimgs/"+ $("[name='headImg']").eq(0).val());
        url = '<%=basePath%>framework/user/update.action';    
        $('#ftitle').html("修改用户信息");
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
             $.post('<%=basePath%>framework/ldap/remove.action',{uid:row.userUID},function(result){
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
var pwdurl;
function restpwd(){
 	var rows = $('#dg').datagrid('getChecked');
 	//var isApprove = rows[0].po_approve;
 	//var  isClose = rows[0].po_close;
 	//if(isApprove == "false" && rows.length == 1){
 	//	 alert("此PO暂未通过审批！");
 	//}

 	 if (rows.length>0){
 	   if(rows.length==1){	   
 	       $('#pwddlg').dialog('open').dialog('setTitle',' ');
            $('#fm').form('clear');
 	         var row=rows[0];
 	          var  name=row.<%=User.USERNAME%> ; 	
 	           $("#pwd<%=User.USERNAME%>").textbox('setValue',name);          
 	          pwdurl="<%=basePath %>framework/ldap/updatepass.action";
 	          
 	              $('#ftitle').html("添加用户");
             
 	   }else{
 	     alert("你的选择了多个选项,请只选择一个");
 	   }
 	
 	  
 	} else{
 	   alert("你没有选择任何一个选项");
 	}


} 
 
 function pwdsaveBean(){
    $('#pwdfm').form('submit',{
        url: pwdurl,
        onSubmit: function(){
            return $(this).form('validate');
        },
        success: function(result){
            $('#pwddlg').dialog('close');        // close the dialog
            $('#dg').datagrid('reload');    // reload the user data
        }
    });
}
        

$.extend($.fn.validatebox.defaults.rules, {  
    equalTo: {
        validator:function(value,param){
            return $(param[0]).val() == value;
        },
        message:'两次密码不匹配'
    },
    isExist: {
        validator:function(value,param){
        	var r=false;
        	$.ajax({  
                type : "post",  
                 url : "<%=basePath%>framework/ldap/isExist.action",
                 data : { <%=User.USERNAME%>:value}, 
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
    </script>
</head>
<body>
	<div id="dg" style="width: 100%;height:100%"></div>
	<div id="toolbar">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-add" plain="true" onclick="newBean()">Add</a>
			 <!--  a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-remove" plain="true" onclick="destroyBean()">Delete</a-->
	    <a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-remove" plain="true" onclick="restpwd()">Rest Password</a>
	</div>

	<div id="dlg" class="easyui-dialog"
		style="width: 580px; height: 450px; padding: 10px 20px" closed="true"
		buttons="#dlg-buttons">
		<div class="ftitle" id="ftitle"></div>
		<form id="fm" method="post" enctype="multipart/form-data" novalidate>
			<input id="<%=User.USERUID %>" name="<%=User.USERUID %>"  type="hidden">
			<div class="fitem">
				<label>用户名称:</label>
				 <input name="<%=User.USERNAME%>" class="easyui-textbox"
				 	data-options="required:true,validType:['length[3,15]', 'isExist']"  />

			</div>
			<div id="fitemPassword">
				<div class="fitem fitem_password">
					<label>用户密码:</label>
					 <input id="<%=User.PASSWORD %>" name="<%=User.PASSWORD %>" type="password" class="easyui-textbox" 
					 	data-options="required:true,validType:['length[5,15]']" />
				</div>
				<div class="<%=User.PASSWORD %>2 fitem fitem_password">
					<label>验证密码:</label>
					 <input name="<%=User.PASSWORD %>2" type="password" class="easyui-textbox"
					 	data-options="required:true,validType:['equalTo[\'#password\']']"/>
				</div>
			</div>
			<input name="headImg" type="hidden"/>	
			<input name="<%=User.USERCLASS %>" type="hidden"/>			
			<input name="userType" type="hidden"/>			
			<input name="<%=User.USERSTATUS %>" type="hidden"/>										
			<div class="fitem">
				<label>电子邮件地址:</label>
				 <input name="email" class="easyui-textbox"
				 	data-options="required:true,validType:['email']" style="width:255px;"/>
			</div>
			<div class="fitem">
				<label>手机号码:</label>
				 <input name="mobile" class="easyui-textbox"
				 	data-options="validType:['length[0,25]']" />
			</div>
			<input name="headImg" type="hidden"/>
            <input id="headImgFile"  name="headImgFile" type="hidden"/>
             <input name="userExtProps" type="hidden"/>

			<div class="fitem">
				<label>描述:</label>
				 <input name="description" class="easyui-textbox"  style="width:300px;height:100px;white-space: pre-wrap;"
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

	
	<div id="pwddlg" class="easyui-dialog"
		style="width: 580px; height: 450px; padding: 10px 20px" closed="true"
		buttons="#pwddlg-buttons">
		<div class="ftitle" id="ftitle"></div>
		<form id="pwdfm" method="post" enctype="multipart/form-data" novalidate>
			<input id="<%=User.USERUID %>" name="<%=User.USERUID %>"  type="hidden">
			<div class="fitem">
				<label>用户名称:</label>
				 <input id="pwd<%=User.USERNAME%>" name="<%=User.USERNAME%>" class="easyui-textbox"
				 	data-options="required:true,validType:['length[3,15]']"  />

			</div>
			<div id="fitemPassword">
				<div class="fitem fitem_password">
					<label>用户密码:</label>
					 <input id="<%=User.PASSWORD %>" name="newPass" type="password" class="easyui-textbox" 
					 	data-options="required:true,validType:['length[5,15]']" />
				</div>
			</div>			
		</form>
	</div>
	<div id="pwddlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" onclick="pwdsaveBean()" style="width: 90px">保存</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel" onclick="javascript:$('#pwddlg').dialog('close')"
			style="width: 90px">取消</a>
	</div>


	
	
</body>
</html>