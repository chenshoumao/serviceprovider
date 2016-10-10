<%@page import="com.solar.tech.bean.File_Item"%>
<%@ page import="com.solar.tech.exception.ResultCode" %>

<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<% 
    String path = request.getContextPath();   
    String basePath = request.getScheme() + "://"  + request.getServerName() + ":" + request.getServerPort() + path + "/";
    String po_no=request.getParameter("po_no");
    String ps_no=request.getParameter("ps_no");
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

.rr table tr td{line-height:25px;text-align:right;}
.rr table tr td:nth-child(2){padding-right:30px;}

.readOnly{
	background-color: #ccc;
}
</style>
<script type="text/javascript">
	$(function(){
		//alert($("input[readonly='true']").length);
		//$("input[readonly='true']").addClass("readOnly");
		//$("input[readonly='readonly']").addClass("readOnly");
	})

var url11 = "<%=basePath %>framework/file/find.action?psno=<%=ps_no %>";
$.getJSON(url11, function(res) {
  	 
    document.getElementById("pon").value=res[0][0].po_no ;
    document.getElementById("cust").value=res[0][0].customer;
    document.getElementById("start").value=formatDatebox(res[0][0].start_time);
    document.getElementById("comp").value=formatDatebox(res[0][0].complete_time);
	
    document.getElementById("sproj_no").value=res[0][1].proj_no;
    document.getElementById("smake").value=res[0][1].make;
    document.getElementById("spdesc").value=res[0][1].proj_desc;	
    document.getElementById("smanu").value=res[0][1].manufacturer;
    document.getElementById("sia").value=res[0][1].ia_status;
     document.getElementById("engineer").value=res[0][1].engineer;
     var emailUrl = '<%=basePath%>framework/ldap/userdetails.action?userName='+ res[0][1].engineer;
   $.getJSON(emailUrl,function(user){
   		$("#engineerEmail").val(user.email);
   		//alert(user.email);
   });
 });



$(function(){
	var user = '<%=com.solar.tech.util.Current.user().getUserName()%>';
	$('#dg').datagrid({
	    height:'auto',
	    fit:false,
	    url: '<%=basePath %>framework/file/showsByPoAndPs.action',
	    queryParams: {psno: '<%=ps_no %>'},
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
	        { field: 'ck', checkbox: true ,width: 50},
	        { field: '<%=File_Item.File_no%>', title: 'File_no', width: '11%',align:'center',sortable:true, sorter:sortt},
	        { field: '<%=File_Item.Type%>', title: 'Type', width: '11%',align:'center',sortable:true, sorter:sortt},
	        { field: '<%=File_Item.Standard%>', title: 'Standard',  width: '11%',align:'center',sortable:true, sorter:sortt}, 
	        { field: '<%=File_Item.Status%>', title: 'Status', width: '11%',align:'center',sortable:true, sorter:sortt},
	        { field: '<%=File_Item.Category%>',title: 'Category', width:'11%',align:'center',sortable:true, sorter:sortt}, 
	       		                	        	        
	        { field: '<%=File_Item.Create_time%>',title: 'Create Time', width:'11%',align:'center',formatter: formatDatebox}, 
	        { field: '<%=File_Item.Endtime %>', title: 'End Time', width: '11%',align:'center',formatter: formatDatebox},
	        { field: 'po_close', title: 'isColse', width: '11%',align:'center',sortable:true, sorter:sortt},
	        { field: 'po_approve', title: 'isApproval', width: '11%',align:'center',sortable:true, sorter:sortt}		        	        	        		       
	    ]],
	    onDblClickRow :function(rowIndex,rowData){
	    	var engineer = $('#engineer').val();
	    	if(rowData.po_close != 'true'){  
	    		//if(engineer==user || user == 'SamuelZhou'){
			    	editBean(rowData);
	    		//}
	    	}else{
	    		alert("此File已关闭");
	    	}
	   	}
	});
});

var url;
function newBean(){
  var url3 = "<%=basePath%>console/biz/fileinfo/fileinfo_co.jsp?ps_no=<%=ps_no %>&po_no=<%=po_no %>";
   window.location.href = url3;

   
   
}
var url;
function back(){
	history.go(-1);
	/*
	var url4 ="<%=basePath%>console/biz/ps/shows.jsp?ps_no=<%=ps_no %>&po_no=<%=po_no %>";
	window.location.href =url4;
	*/
}

var urlmail;
function sendmail(){
	var rows = $('#dg').datagrid('getChecked');
	//if(rows.length>0){
	//	var isClose = rows[0].po_close;
	//	if(rows.length==1  && isClose != 'true'){
			  		$("input[name=draft]").val(0);
			   		$("#smto").textbox('setText',$('#engineer').val()); 
			    	$('#smdlg').dialog('open').dialog('setTitle',' '); 
					$('#dlg').dialog('close');
			    	urlmail = '<%=basePath%>framework/mail/send.action';
			    	$('#smftitle').html("Send An Email");
	//   }else if(isClose == 'true'){
	// 	   	alert("File 已关闭!");
 	/*   }
 	   else{ 	  
 	     alert("你的选择了多个选项,请只选择一个");
 	   }
   }else{
	   alert("你没有选择任何一个选项");
   }*/
}

function email(){	
	$("#smto").textbox('setValue',$('#engineerEmail').val());
	$('#smdlg').dialog('close');
	 var user = '<%=com.solar.tech.util.Current.user().getUserName()%>';
	 var basePath = '<%=basePath%>';
    var appendBody = "你有一条来自"+user+"的新记录需要审批，<br>"+user+"的留言是:"+$("#body").val()+"<br>"
		+"<a href="+basePath+"framework/index.action"+"'>点此链接去看看！</a>";
	$("#body").val(appendBody);
   $("#smfm").form('submit',{
        url: urlmail,
        onSubmit: function(){
            return $(this).form('validate'); 
        },
        success: function(result){
        	alert("已将结果邮件通知"+$("#engineer").val()); 
 			//save1();	
 			todoAdd();
            $('#smdlg').dialog('close'); 
          //  $("#datstab").tabs("select", 'Test Record');       // close the dialog 
        }
    });
}
 
function todoAdd(){
		//预制一些数据
		var itemname = "File List";
		var po_no =  "<%=po_no%>";
		var ps_no = "<%=ps_no%>"; 
		var itemid = ps_no;
		var itemurl = "<%=basePath %>console/biz/filelist/shows.jsp?po_no="+po_no+"&ps_no="+ps_no;
		//var reviewer = "<%=com.solar.tech.util.Current.user().getUserName()%>";
		var reviewer = 	$("#engineer").val();		
		var draft = $("input[name='draft']").val();
		var status = 'To Engineer';
        $.post('<%=basePath%>framework/todo/add.action',{itemname:itemname,itemurl:itemurl,itemid:itemid, reviewer:reviewer,status:status},function(result){
             
        },'json'); 	
}


var fileno;
var pono;
var psno;
function editBean(row){
    if (row){

       // $('#dlg').dialog('open').dialog('setTitle','Submit A Comment');
       // $('#fm').form('clear');      
         fileno=row.file_no;
         pono=row.po_no;
         psno=row.proj_no;
         var isDraft = row.draft;
       
       // var url='<%=basePath %>console/biz/fileinfo/edit_file.jsp?fileno='+fileno+'&pono='+pono+'&psno='+psno;
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
        	 var url = row.itemurl;
        	 //var url='<%=basePath %>console/biz/fileinfo/fileinfo_ma.jsp?fileno='+fileno+'&po_no='+pono+'&ps_no='+psno+'&isDraft=1' + '&hideSendAction=true';
             window.location.href = url;  
         }
       // if(isDraft == 0)
        //	window.location.href = row.itemurl;
      //  else
        //    window.location.href = '<%=basePath %>console/biz/fileinfo/fileinfo_co.jsp?ps_no='+psno+'&isDraft=1&fileno='+fileno;  
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
        var url='<%=basePath %>console/biz/fileinfo/reopen.jsp?fileno='+fileno+'&pono='+pono+'&psno=<%=ps_no%>';
        window.location.href = url;           
           
        }
    });
}

function reopenFile(){
	var rows = $('#dg').datagrid('getChecked');
	var user = "<%=com.solar.tech.util.Current.user().getUserName()%>" ;
	if(rows[0].po_close != 'false'){
	   if (rows.length>0){
 	    if(rows.length==1){
 	    if(user != "Samuelzhou" && user != "Julieyang"){
 	   			alert("抱歉，您无权限");
 	   		}
 	    	else{
 	    var row=rows[0];
       $('#dlg').dialog('open').dialog('setTitle','Submit A Comment');
        $('#fm').form('clear');      
         fileno=row.file_no;
         pono=row.po_no;
         psno=row.ps_no;
         document.getElementById("comfile_no").value=fileno;
         document.getElementById("comproj_no").value=psno;
         url = '<%=basePath%>framework/info/addComm.action'; 
         $('#ftitle').html("Submit A Comment");               
			}
 	   }else{
 	     alert("你的选择了多个选项,请只选择一个");
 	   }
 	} else{
 	   alert("你没有选择任何一个选项");
 	}	
	}else{
		alert('此File未关闭！');
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
	var user = "<%=com.solar.tech.util.Current.user().getUserName()%>" ;
     	if (rows.length>0){
 	    if(rows.length==1){
 	    	if(user != "Samuelzhou" && user != "Julieyang"){
 	   			alert("抱歉，您无权限");
 	   		}
 	    	else{
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
    else{
    	alert("至少选择一个条目!");
    }
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

 
 
    </script>
</head>
<body style="text-align:center;background:#F0F0F0;">
	<input id="engineerEmail" type="hidden">

    <div id="poAndpro" style="width: 100%;height:auto;background:#F0F0F0;margin:0 auto">
     
    <div style="width:100%;text-align:center;">
    	 <div style="width:100%;height:50px;font-size: 28px; font-weight: bold;margin-top:8px;">File List</div>
    	 <div style="text-align:center;width: 702px;margin: 0 auto;margin-bottom:20px;" class="rr">
    	 <table>
    	 <tr> <td><label >PO No.: </label></td><td> <input  name="po_no" type="text" id="pon" readOnly="true"  /></td><td><label >Start time :</label></td><td> <input  name="start_time"  id="start"  type="text" readOnly="true" />	</td></tr>
    	 <tr> <td><label >Customer:  </label></td><td><input  name="customer" type="text" id="cust" readOnly="true"/></td><td><label>Complete time: </label></td><td> <input  name="complete_time" id =comp  type="text" readOnly="true" /></td></tr>	 	  	 			
    	  <tr><td><label>Project No:</label></td><td> <input  name="proj_no" id="sproj_no" type="text" readOnly="true"  /></td><td><label>Make:</label></td><td> <input name="make"  id="smake" type="text" readOnly="true"/></td></tr>				
    	  <tr><td><label>Project description:</label></td><td><input  name="proj_desc" id="spdesc" type="text" readOnly="true"/></td><td><label>IA status:</label></td><td> <input name="ia_status"  id="sia" readOnly="true" type="text" /></td></tr>			
    	  <tr><td><label>Manufacturer:</label></td><td><input name="manufacturer"  id="smanu" type="text" readonly="readonly"/></td><td><label>Engineer:</label></td><td><input name="engineer" id="engineer" readonly="readonly" type="text"/></td></tr>					
    	</table>	 
    	 </div>	 
    	</div>   
    </div>

	<div id="dg" style="width: 100%;height:auto"></div>
	<div id="toolbar">
		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add"  plain="true" onclick="newBean()">New File</a>
	    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="copyFile()">Copy File</a>&nbsp;&nbsp;
	    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="closeFile()">Close File</a>&nbsp;&nbsp;			    
	    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="reopenFile()">Reopen File</a>&nbsp;&nbsp;
	    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="destroyBean()">Detele</a>&nbsp;&nbsp;
 		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="sendmail()">Save And Email</a>&nbsp;&nbsp;
 		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" plain="true" onclick="back()">Back</a>&nbsp;&nbsp;
<!--		<a href="javascript:void(0)" class="easyui-linkbutton"	iconCls="icon-add" plain="true" onclick="">Order From</a>&nbsp;&nbsp;
	    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="">项目进度</a>&nbsp;&nbsp;-->		    			
	</div>
	
	<div style="margin-top: -80px;">
<div id="smdlg" class="easyui-dialog" style="width: 580px; height: 450px; padding: 10px 20px" closed="true" buttons="#smdlg-buttons">
	  <div class="ftitle" id="smftitle"></div>
		<form id="smfm" method="post" enctype="multipart/form-data" novalidate>
				
			<table>
			<tr><td></td><td></td></tr>
			<tr><td><label>To:</label></td><td> <input name="to"  id="smto" type="text" readonly="readonly" class="easyui-textbox" style="width:350px" data-options="required:true" /></td></tr>				
			<tr><td><label>Subject:</label></td><td><input name="subject" type="text" class="easyui-textbox" style="width:350px" data-options="required:true"/></td></tr>			
			<tr><td align="top">Body:</td><td><textarea name="body" id="body" Columns="50" data-options="required:true" TextMode="MultiLine" style="width:350px; height:300px; word-wrap:break-word; word-break:break-all;" ></textarea></td></tr>						
			</table>			  		 													   
		</form>
	</div>
	<div id="smdlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" onclick="email()" style="width: 90px">Send</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel" onclick="javascript:$('#smdlg').dialog('close')"
			style="width: 90px">cancle</a>
	</div>	
</div>

	<div id="dlg" class="easyui-dialog"
		style="width: 580px; height: 450px; padding: 10px 20px" closed="true"
		buttons="#dlg-buttons">
		<div class="ftitle" id="ftitle"></div>
		<form id="fm" method="post" enctype="multipart/form-data" novalidate>
					<input id="comfile_no" name="file_no"  id="ofileno" value="" type="hidden">
			<input id="comproj_no" name="proj_no" value="" type="hidden">		
           <table>
           <tr>
            <td><label>Comment:</label></td>
            <td> <input  name="comment"  class="easyui-textbox"style="width:300px;height:100px;white-space: pre-wrap;"  data-options="multiline:true,required:true,validType:['length[3,200]']"  /></td>
            </tr>                      
           </table>				 
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" onclick="saveBean()" style="width: 90px">Save</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')"
			style="width: 90px">Cancle</a>
	</div>
</body>
</html>