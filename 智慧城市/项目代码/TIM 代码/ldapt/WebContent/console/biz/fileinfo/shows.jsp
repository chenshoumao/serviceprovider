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
	    height: 'auto',
	    fit:false,
	    url: '<%=basePath %>framework/file/shows.action',
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
	        { field: '<%=File_Item.File_no%>', title: 'File_no', width: '11%',align:'center',sortable:true, sorter:sortt},
	        { field: '<%=File_Item.Type%>', title: 'Type', width: '11%',align:'center',sortable:true, sorter:sortt},
	        { field: '<%=File_Item.Standard%>', title: 'Standard',  width: '11%',align:'center',sortable:true, sorter:sortt}, 
	        { field: '<%=File_Item.Status%>', title: 'Status', width: '11%',align:'center',sortable:true, sorter:sortt},
	        { field: '<%=File_Item.Category%>',title: 'Category', width:'11%',align:'center',sortable:true, sorter:sortt}, 
	        { field: '<%=File_Item.Engineer%>', title: 'Engineer',  width: '11%',align:'center',sortable:true, sorter:sortt}, 		                	        	        
	        { field: '<%=File_Item.Create_time%>',title: 'Create Time', width:'11%',align:'center',formatter: formatDatebox}, 
	        { field: '<%=File_Item.Endtime %>', title: 'End Time', width: '11%',align:'center',formatter: formatDatebox},	
	        { field: 'po_close', title: 'isColse', width: '11%',align:'center',sortable:true, sorter:sortt},
	        { field: 'po_approve', title: 'isApproval', width: '11%',align:'center',sortable:true, sorter:sortt}		       
	    ]],


	    onDblClickRow :function(rowIndex,rowData){
	    	if(rowData.po_close != 'true'){
		    	editBean(rowData);
	    	}
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

var fileno;
var pono;
var psno;
 
function editBean(row){
    if (row){        
      //  $('#dlg').dialog('open').dialog('setTitle','Submit A Comment');
      //  $('#fm').form('clear');      
         fileno=row.file_no;
         pono=row.po_no;
         psno=row.proj_no;
         
         var createUser = row.createBy;
         var user = '<%=com.solar.tech.util.Current.user().getUserName()%>';
         if(createUser ==  user && row.fileApprove == "1"){
        	 alert("该条目正在审核，不能编辑！\n请等待审核结束，在查看审核结果。");
         }
         else if(createUser ==  user && row.fileApprove == "2"){
        	 var url='<%=basePath %>console/biz/fileinfo/viewFileResult.jsp?fileno='+fileno+'&po_no='+pono+'&ps_no='+psno+'&isDraft=1' + '&hideSendAction=true';
             window.location.href = url; 
         }
         
         else if(createUser ==  user && row.fileApprove == "0"){
        	 //var url='<%=basePath %>console/biz/fileinfo/viewFileResult.jsp?fileno='+fileno+'&po_no='+pono+'&ps_no='+psno+'&isDraft=1' + '&hideSendAction=true';
           var url='<%=basePath %>console/biz/fileinfo/edit_file.jsp?fileno='+fileno+'&pono='+pono+'&psno='+psno+'&isDraft=1' + '&hideSendAction=true';
           
             window.location.href = url; 
         }
         else{
        	 if(row.fileApprove == '1'){
        		 var url = row.itemurl;
        		 window.location.href = url;  
        	 }
        	 else if(row.fileApprove == '2'){
        		 var url='<%=basePath %>console/biz/fileinfo/fileinfo_ma.jsp?fileno='+fileno+'&po_no='+pono+'&ps_no='+psno+'&isDraft=1' + '&hideSendAction=true';
        		 window.location.href = url;  
        	 }
        	 	
        	 //var url='<%=basePath %>console/biz/fileinfo/fileinfo_ma.jsp?fileno='+fileno+'&po_no='+pono+'&ps_no='+psno+'&isDraft=1' + '&hideSendAction=true';
             
         }
         	
 
         
               
       //  document.getElementById("comfile_no").value=fileno;
       //  document.getElementById("comproj_no").value=psno;
      /**  url = '<%=basePath%>framework/info/addComm.action'; **/
        //  $('#ftitle').html("Submit A Comment");          
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
          //  $('#dg').datagrid('reload');    // reload the user data
          
        var url='<%=basePath %>console/biz/fileinfo/reopen.jsp?fileno='+fileno+'&pono='+pono+'&psno='+psno;
        window.location.href = url;
        }
    });
}

function reopenFile(){
	var rows = $('#dg').datagrid('getChecked');
	var isClose = rows[0].po_close;
	if (rows.length>0){
 	    if(rows.length==1  && isClose != 'false'){
 	    var row=rows[0];
       $('#dlg').dialog('open').dialog('setTitle','Submit A Comment');
        $('#fm').form('clear');      
         fileno=row.file_no;
         pono=row.po_no;
         psno=row.proj_no;
		// alert(psno);
         document.getElementById("comfile_no").value=fileno;
         document.getElementById("comproj_no").value=psno;
        url = '<%=basePath%>framework/info/addComm.action'; 
          $('#ftitle').html("Submit A Comment");               

 	   }else if(isClose == 'false'){
 	   	alert("File 还未关闭!");
 	   }
 	   else{ 	  
 	     alert("你的选择了多个选项,请只选择一个");
 	   }
 	
 	  
 	} else{
 	   alert("你没有选择任何一个选项");
 	}	
	
}


function copyFile(){
	var rows = $('#dg').datagrid('getChecked');
     	if (rows.length>0){
 	    if(rows.length==1){
 	    var row=rows[0];
 	    var fileno=row.file_no;    
 	    var psno=row.proj_no;
 	    var pono=row.po_no;    
        var url='<%=basePath %>console/biz/fileinfo/fileinfo_co.jsp?fileno='+fileno+'&po_no='+pono+'&ps_no='+psno;
        window.location.href = url;

 	   }else{
 	     alert("你的选择了多个选项,请只选择一个");
 	   }
 	
 	  
 	} else{
 	   alert("你没有选择任何一个选项");
 	}	
	
}
function closeFile(){
	var rows = $('#dg').datagrid('getChecked');
     	if (rows.length>0){
 	    if(rows.length==1){
 	        var row=rows[0];
 	       var  fileno = row.file_no;
         $.post('<%=basePath%>framework/file/close.action',{file_no:fileno},function(result){
               if (result.success){
               	  alert("This file is closeed !");
               	  $('#dg').datagrid('reload');  
                } else {
                  alert("This file is not closeed !");
               }
        },'json');
        
 	   }else{
 	     alert("你的选择了多个选项,请只选择一个");
 	   }
 	
 	  
 	} else{
 	   alert("你没有选择任何一个选项");
 	}	

}

function back(){
	var urlback1="<%=basePath%>console/biz/po/shows.jsp";
	window.location.href=urlback1;
}

function sortt(a,b){ 
 a = a.split('/'); 
 b = b.split('/');
 if (a[2] == b[2]){
 if (a[0] == b[0]){  return (a[1]>b[1]?1:-1);
 } else { return (a[0]>b[0]?1:-1);}                  
 } else { return (a[2]>b[2]?1:-1);} 
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
	    height: 'auto',
	    fit:false,
	    url: '<%=basePath %>framework/file/search.action?fileno=' + value + '&stime=' + svalue + ' &etime=' + evalue ,
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
	        { field: '<%=File_Item.File_no%>', title: 'File_no', width: '11%',align:'center',sortable:true, sorter:sortt},
	        { field: '<%=File_Item.Type%>', title: 'Type', width: '11%',align:'center',sortable:true, sorter:sortt},
	        { field: '<%=File_Item.Standard%>', title: 'Standard',  width: '11%',align:'center',sortable:true, sorter:sortt}, 
	        { field: '<%=File_Item.Status%>', title: 'Status', width: '11%',align:'center',sortable:true, sorter:sortt},
	        { field: '<%=File_Item.Category%>',title: 'Category', width:'11%',align:'center',sortable:true, sorter:sortt}, 
	        { field: '<%=File_Item.Engineer%>', title: 'Engineer',  width: '11%',align:'center',sortable:true, sorter:sortt}, 		                	        	        
	        { field: '<%=File_Item.Create_time%>',title: 'Create Time', width:'11%',align:'center',formatter: formatDatebox}, 
	        { field: '<%=File_Item.Endtime %>', title: 'End Time', width: '11%',align:'center',formatter: formatDatebox},	        	        	
	        { field: 'po_close', title: 'isColse', width: '11%',align:'center',sortable:true, sorter:sortt},
	        { field: 'po_approve', title: 'isApproval', width: '11%',align:'center',sortable:true, sorter:sortt}		       
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
		<!--a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-add" plain="true" onclick="newBean()">Add File</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-remove" plain="true" onclick="destroyBean()">Delete File</a-->
			&nbsp;&nbsp; 
		 <input id="sd" name="stime" class="easyui-datebox" data-options="editable:false"></input> &nbsp;&nbsp; 
		 <input id="ed" name="etime"  class="easyui-datebox" data-options="editable:false"></input>  &nbsp;&nbsp; 
			<input name="search" class="easyui-textbox"> 
		<a href="javascript:void(0)"  id="btn" iconCls="icon-search" class="easyui-linkbutton" onclick="searchText()">搜索</a>&nbsp;&nbsp;
		<a href="javascript:void(0)" class="easyui-linkbutton"	iconCls="icon-add" plain="true" onclick="closeFile()">Close File</a>&nbsp;&nbsp;
	    <a	href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="copyFile()">Copy File</a>&nbsp;&nbsp;		
	    <a	href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="reopenFile()">Reopen File</a>&nbsp;&nbsp;		
<!--		<a href="javascript:void(0)" class="easyui-linkbutton"	iconCls="icon-add" plain="true" onclick="">Order From</a>&nbsp;&nbsp;
	    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="">项目进度</a>&nbsp;&nbsp;-->	
	</div>

	<div id="dlg" class="easyui-dialog"
		style="width: 580px; height: 450px; padding: 10px 20px" closed="true" buttons="#dlg-buttons">
		<div class="ftitle" id="ftitle"></div>
		<form id="fm" method="post" enctype="multipart/form-data" novalidate>		
			<input id="comfile_no" name="file_no"   value="" type="hidden">
			<input id="comproj_no" name="proj_no" value="" type="hidden">		
           <table>
           <tr>
            <td><label>Comment:</label></td>
            <td> <input  name="comment"  class="easyui-textbox"style="width:300px;height:100px;white-space: pre-wrap;"  data-options="multiline:true,required:true,validType:['length[3,200]']"  /></td>
            </tr>                      
           </table>
		<!--  	<input id="" name=""  type="hidden">
			
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
			 -->
			 			 
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