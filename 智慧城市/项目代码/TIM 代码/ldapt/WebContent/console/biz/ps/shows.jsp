<%@page import="com.solar.tech.bean.Project"%>
<%@ page import="com.solar.tech.exception.ResultCode" %>

<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
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

#fm ,#file {
	margin: 0;
	padding: 10px 30px;
}
#file .textbox{
	margin-left: 30px;
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
	width: 150px;
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
	    url: '<%=basePath %>framework/ps/shows.action?orderBy=<%=orderBy%>',
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
	        { field: 'proj_no', title: 'Project No.', width: '14.2%',align:'center',sortable:true, sorter:sortt},
	        { field: '<%=Project.Proj_desc%>', title: 'Project description', width: '14.2%',align:'center',sortable:true, sorter:sortt},
	        { field: '<%=Project.Manufacturer%>', title: 'Manufacturer',  width: '14.2%',align:'center',sortable:true, sorter:sortt}, 
	        { field: '<%=Project.Make%>',title: 'Make', width:'10.2%',align:'center',sortable:true, sorter:sortt},
	        { field: '<%=Project.Ia_status%>', title: 'IA status', width: '10.2%',align:'center',sortable:true, sorter:sortt} ,
	        { field: 'createTime', title: 'Create Time', width: '12.2%',align:'center',formatter: formatDatebox},
	        { field: 'proj_close', title: 'Status', width: '12.2%',align:'center',sortable:true, sorter:sortt, sortable:true,formatter: function(value,row,index){ 
				return (value == 'false'? 'Open':'Closed');
			 } } 
	       	        	
	    ]],
	    onDblClickRow :function(rowIndex,rowData){
	    	editBean(rowData);
	   	}
	});
});

function newOrder(a){
	 
	if('<%=orderBy%>' == 'null')
		window.location.href = '<%=basePath%>console/biz/ps/shows.jsp?orderBy=proj_close desc'; 
	else if('<%=orderBy%>' == 'proj_close desc')
		window.location.href = '<%=basePath%>console/biz/ps/shows.jsp?orderBy=proj_close';
	else if('<%=orderBy%>' == 'proj_close')
		window.location.href = '<%=basePath%>console/biz/ps/shows.jsp';
}

function sortt(a,b){ 
 a = a.split('/'); 
 b = b.split('/');
 if (a[2] == b[2]){
 if (a[0] == b[0]){  return (a[1]>b[1]?1:-1);
 } else { return (a[0]>b[0]?1:-1);}                  
 } else { return (a[2]>b[2]?1:-1);} 
 } 

var url;
function newBean(){
    $('#dlg').dialog('open').dialog('setTitle',' ');
   // $('#fm').form('clear');
            $('#fm').form('load',row); 
    url = '<%=basePath%>framework/ps/add.action';
    $('#ftitle').html("Add A Project");
}
function newFileBean(){  
       var rows = $('#dg').datagrid('getChecked'); 
       var isClose = rows[0].proj_close;
       if(isClose == "true" && rows.length == 1){
       		alert("此记录已经关闭!");
       }
       else if (rows.length>0){
 	    if(rows.length==1){
 	        var row=rows[0];
 	         var po_no =row.po_no ;
 	         var ps_no =row.proj_no;
	   var  url2 = "<%=basePath %>console/biz/filelist/shows.jsp?ps_no="+ ps_no +"&po_no="+po_no;
       window.location.href = url2;
 	   }else{
 	     alert("你的选择了多个选项,请只选择一个");
 	   }
 	
 	  
 	} else{
 	   alert("你没有选择任何一个选项");
 	}
    
    
}
function saveFile(){
	 
	$('#file').form('submit',{
        url: url,
        onSubmit: function(){
            return $(this).form('validate');
        },
        success: function(result){
            $('#addFile').dialog('close');        
           
        }
    });
}
function editBean(row){
    if (row){    
       var ps_no = row.proj_no;
       var po_no = row.po_no;
	   var  url2 = "<%=basePath %>console/biz/ps/edit_ps.jsp?ps_no="+ ps_no ; 
       window.location.href = url2;

    }
}
function rrrr(a){
	alert(12);
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

function copyPs(){
	
  	var rows = $('#dg').datagrid('getChecked');
     	if (rows.length>0){
 	    if(rows.length==1){
 	        var row=rows[0];
 	        $('#fm').form('load',row); 
 	        var findCountByPono = '<%=basePath%>framework/ps/getCountByPo.action?po_no=' + row.po_no;
	$.getJSON(findCountByPono,function(res){
		var index = res.sum; 
		
		$("#proj_noSelect").children().remove();
		var text = "<option value='"+ row.po_no +"-"+index+"-IDI'>"+ row.po_no +"-"+index+"-IDI</option>"
		+ "<option    value='"+ row.po_no +"-"+index+"-HT'>"+ row.po_no +"-"+index+"-HT</option>"
		+ "<option    value='"+ row.po_no +"-"+index+"-NAST'>"+row.po_no+"-"+index+"-NAST</option>"
		+ "<option    value='"+ row.po_no +"-"+index+"-ORDER'>"+row.po_no+"-"+index+"-ORDER</option>";
		$("#proj_noSelect").append(text); 
	});
 	       // var po_no =row.po_no ;
 	       // var ps_no =row.ps_no;
 	          $('#dlg').dialog('open').dialog('setTitle',' ');
           // $('#fm').form('clear');
              
              url = '<%=basePath%>framework/ps/add.action';
              $('#ftitle').html("Add A Project");   
 	         

 	   }else{
 	     alert("你的选择了多个选项,请只选择一个");
 	   }
 	
 	  
 	} else{
 	   alert("你没有选择任何一个选项");
 	}
}

function closePs(){
  	var rows = $('#dg').datagrid('getChecked');
  	var user = "<%=com.solar.tech.util.Current.user().getUserName()%>" ; 
     	if (rows.length>0){
 	    if(rows.length==1){
 	    	if(user != "Samuelzhou" && user != "Julieyang"){
 	   			alert("抱歉，您无权限");
 	   		}
 	    	else{
 	        var row=rows[0];
 	         var id_project =row.id_project;
 	         var ps_no =row.proj_no; 
              $.post('<%=basePath%>framework/ps/close.action',{id_project:id_project,proj_no:ps_no},function(result){
               if (result.success){
               	  alert("This Project is closeed !");
                  $('#dg').datagrid('reload');                	  
                } else {
                  alert("This Project is not closeed !");
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

function destroyBean(){
	var rows = $('#dg').datagrid('getChecked');
    if (rows.length>0){
        $.messager.confirm('温馨提示','你真的要删除么?',function(r){
            if (r){
            	for(var i=0; i<rows.length; i++){
            		var row=rows[i];
            	 
             $.post('<%=basePath%>framework/ps/delete.action',{proj_no:row.id_project},function(result){
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
	    height: 'auto',
	    fit:false,
	    url: '<%=basePath %>framework/ps/search.action?proj_no=' + value + '&stime=' + svalue + ' &etime=' + evalue ,
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
	        { field: '<%=Project.Proj_no%>', title: 'Project No.', width: '14.2%',align:'center',sortable:true, sorter:sortt},
	        { field: '<%=Project.Proj_desc%>', title: 'Project description', width: '14.2%',align:'center',sortable:true, sorter:sortt},
	        { field: '<%=Project.Manufacturer%>', title: 'Manufacturer',  width: '14.2%',align:'center',sortable:true, sorter:sortt}, 
	        { field: '<%=Project.Make%>',title: 'Make', width:'14.2%',align:'center',sortable:true, sorter:sortt},
	        { field: '<%=Project.Ia_status%>', title: 'IA status', width: '14.2%',align:'center',sortable:true, sorter:sortt},
	        { field: 'createTime', title: 'Create Time', width: '14.2%',align:'center',formatter: formatDatebox},
	        { field: 'proj_close', title: 'isClose', width: '14.2%',align:'center',sortable:true, sorter:sortt},
	        { field: 'proj_approve', title: 'isApproval', width: '14.2%',align:'center',sortable:true, sorter:sortt}	         
	
	    ]],
	    onDblClickRow :function(rowIndex,rowData){
	    	editBean(rowData);
	   	}
		
	});
	 
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
        

 
    </script>
</head>
<body>
	<div id="dg" style="width: 100%;height:100%"></div>
	<div id="toolbar">

			&nbsp;&nbsp;
		 <input id="sd" name="stime" class="easyui-datebox" data-options="editable:false"></input> &nbsp;&nbsp; 
		 <input id="ed" name="etime"  class="easyui-datebox" data-options="editable:false"></input>  &nbsp;&nbsp; 
			<input name="search" class="easyui-textbox"> 
		<a href="javascript:void(0)"  id="btn" iconCls="icon-search" class="easyui-linkbutton"	onclick="searchText()">搜索</a>&nbsp;&nbsp;
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newFileBean()">File List</a>
	    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="copyPs()" >Copy Project</a>	
	    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="closePs()" >Close Project</a>		    
	    <!--  a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="" >Order From</a>		    
	    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="" >项目进度</a-->	
	</div>

	<div id="dlg" class="easyui-dialog"
		style="width: 580px; height: 450px; padding: 10px 20px" closed="true"
		buttons="#dlg-buttons">
		<div class="ftitle" id="ftitle"></div>
		<form id="fm" method="post" enctype="multipart/form-data" novalidate>
			<input id="<%=Project.ID_PROJECT %>" name="<%=Project.ID_PROJECT %>"  type="hidden">
			
			<div class="fitem">
				<label>Project No:</label>
				 	<select name="proj_no" style="width:180px" id="proj_noSelect">
			    
			   </select>
			  
			</div>
			
			<div class="fitem">
				<label>PO No.:</label>
				 <input name="po_no" class="easyui-textbox"
				 	data-options="validType:['length[3,30]', 'isExist']"  />

			</div>    
		 	
		 	<div class="fitem">
				<label>Project description:</label>
				 <input name="proj_desc" class="easyui-textbox"
				 	data-options="validType:['length[3,15]', 'isExist']"/>
			</div> 
			 
			<div class="fitem">
				<label>Manufacturer:</label>
				 <input name="manufacturer" class="easyui-textbox"
				 	data-options="validType:['length[3,15]', 'isExist']" />
			</div> 
			
			<div class="fitem">
				<label>Make:</label>
				 <input name="make" class="easyui-textbox"
				 	data-options="validType:['length[3,15]', 'isExist']"/>
			</div> 
			 
			<div class="fitem">
				<label>IA status:</label>
				 <input name="ia_status" class="easyui-textbox"
				 	data-options="validType:['length[3,15]', 'isExist']" />
			</div> 
		   
		</form>
	</div>
<div id="addFile" class="easyui-dialog"
		style="width: 580px; height: 450px; padding: 10px 20px" closed="true"
		buttons="#file-buttons">
		<div class="ftitle" id="fileFtitle"></div>
		<form id="file" method="post" enctype="multipart/form-data" novalidate> 
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
				<label>Project_no:</label>
				 <input name="proj_no" class="textbox"/>

			</div>   
		 	
		 	<div class="fitem">
				<label>Type:</label>
				 <input name="type" class="easyui-textbox"
				 	data-options="validType:['length[3,15]', 'isExist']"/>
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
				<select name="file_type" class="textbox">
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
				<select name="status" class="textbox">
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
<div id="file-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" onclick="saveFile()" style="width: 90px">保存</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel" onclick="javascript:$('#addFile').dialog('close')"
			style="width: 90px">取消</a>
	</div>
</body>
</html>