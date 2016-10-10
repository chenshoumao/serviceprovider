<%@page import="com.solar.tech.bean.Project"%>
<%@ page import="com.solar.tech.exception.ResultCode" %>

<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
    String path = request.getContextPath(); 
    String basePath  = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    String po_no=request.getParameter("pono");
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
	width: 80px;
}

.fitem input {
	width: 160px;
}

.fitem input[type=radio] {
	width: 39px;
}
.textbox .textbox-text{white-space: pre-line;}
.Create_or_mor tr td{text-align:right;line-height:30px;margin:0px auto;}
.Create_or_mor tr td input{text-indent:5px;}
.Create_or_mor tr td:nth-child(2){padding-right:30px;}
</style>
<script type="text/javascript">
// alert("ddsa");
var url11 = "<%=basePath %>framework/po/find.action?pono=<%=po_no %>";
$.getJSON(url11, function(res) {
 
    // alert(res[0].po_no);
            
    document.getElementById("pon").value=res[0].po_no ;
    document.getElementById("cust").value=res[0].customer;
    document.getElementById("manu").value=res[0].maufacturer;
    document.getElementById("desc").value=res[0].po_desc;
    document.getElementById("start").value=formatDatebox(res[0].start_time);
    document.getElementById("comp").value=formatDatebox(res[0].complete_time);
 //   document.getElementById("pro").value=res[0].prod_type_desc;
  
    $("#manu1").val(res[0].maufacturer);
    // $('#po').textbox("setValue",'dsfd');
    // $('#cust').textbox("setValue",'dsfd');
    // $('#manu').textbox("setValue",'dsfd');
    // $('#desc').textbox("setValue",'dsfd');
    // $('#start').textbox("setValue",'dsfd');
   //  $('#comp').textbox("setValue",'dsfd');
    // $('#pro').textbox("setValue",'dsfd');
 });

var engineerUrl = '<%=basePath %>framework/group/showMembers.action?groupId=8';
$.getJSON(engineerUrl, function(m) { 
	var json = m.rows;
	$('#engineer').combobox({
	data : json, 
	valueField:'userName',
	textField:'userName'
	});	
	 
});


$(function(){
	
	
	$('#dg').datagrid({
	    height: 'auto',
	    fit:false,
	    url: '<%=basePath %>framework/ps/showsbypo.action',
	    queryParams: {pono: '<%=po_no %>'},
	    method: 'POST',
	    striped: true,
	    remoteSort: false,	    
	    nowrap: false,
	    pageSize: 10,
	    pageNumber:1, 
	    pageList: [10, 20, 50, 100, 150, 200],
	    showFooter: true,
		loadMsg : 'load……',
		pagination : true,
	    toolbar:"#toolbar",
	    checkOnSelect:false,
	    selectOnCheck:false,  
	    columns: [[  
	        { field: 'ck', checkbox: true },
	        { field: '<%=Project.Proj_no%>', title: 'Project No.', width: '14.2%',align:'center',sortable:true, sorter:sortt},
	        { field: '<%=Project.Po_no%>', title: 'PO No.', width: '14.2%',align:'center',sortable:true, sorter:sortt},
	        { field: '<%=Project.Proj_desc%>', title: 'Project description', width: '14.2%',align:'center',sortable:true, sorter:sortt},
	        { field: '<%=Project.Manufacturer%>', title: 'Manufacturer',  width: '14.2%',align:'center',sortable:true, sorter:sortt}, 
	        { field: '<%=Project.Make%>',title: 'Make', width:'14.2%',align:'center',sortable:true, sorter:sortt},
	        { field: 'engineer',title: 'Engineer', width:'14.2%',align:'center',sortable:true, sorter:sortt},
	        { field: '<%=Project.Ia_status%>', title: 'IA status', width: '14.2%',align:'center',sortable:true, sorter:sortt} ,
	        { field: 'proj_close', title: 'isClose', width: '14.2%',align:'center',sortable:true, sorter:sortt}
	        	        
	
	    ]],
	    onDblClickRow :function(rowIndex,rowData){
	    	editBean(rowData);
	   	}
	});
});

function sortt(a,b){ 
 a = a.split('/'); 
 b = b.split('/');
 if (a[2] == b[2]){
 if (a[0] == b[0]){  return (a[1]>b[1]?1:-1);
 } else { return (a[0]>b[0]?1:-1);}                  
 } else { return (a[2]>b[2]?1:-1);} 
 } 


function newFileBean(){

	var rows = $('#dg').datagrid('getChecked');    
    	if (rows.length>0){
 	    if(rows.length==1){
 	    var row=rows[0];
       var ps_no=row.proj_no;
       var po_no=row.po_no;  
       var  url2 = "<%=basePath %>console/biz/filelist/shows.jsp?ps_no="+ ps_no +"&po_no="+po_no;
       window.location.href = url2; 	         
 	   }else{
 	     alert("你的选择了多个选项,请只选择一个");
 	   }
 	
 	  
 	} else{
 	   alert("你没有选择任何一个选项");
 	}    
    
    

    
   // $('#fileFtitle').html("File List");
}


var url;
function newBean(){
	var findCountByPono = '<%=basePath%>framework/ps/getCountByPo.action?po_no=<%=po_no%>';
	$.getJSON(findCountByPono,function(res){
		var index = res.sum; 
		
		$("#proj_noSelect").children().remove();
		var text = "<option value='<%=po_no %>-"+index+"-IDI'><%=po_no %>-"+index+"-IDI</option>"
		+ "<option    value='<%=po_no %>-"+index+"-HT'><%=po_no %>-"+index+"-HT</option>"
		+ "<option    value='<%=po_no %>-"+index+"-NAST'><%=po_no %>-"+index+"-NAST</option>"
		+ "<option    value='<%=po_no %>-"+index+"-ORDER'><%=po_no %>-"+index+"-ORDER</option>";
		$("#proj_noSelect").append(text); 
	});

    $('#dlg').dialog('open').dialog('setTitle',' ');
    $('#fm').form('clear');
    $("#fmmanu").textbox('setValue',$("#manu1").val());
    document.getElementById("11ppo").value='<%=po_no %>';

    url = '<%=basePath%>framework/ps/add.action';
    $('#ftitle').html("Add A Project");
}

function getRandom(n){
        return Math.floor(Math.random()*n+1)
        }
var fitemPassword;
function editBean(row){
    if (row){

       var ps_no=row.proj_no;
       var po_no=row.po_no;       
       var  url2 = "<%=basePath %>console/biz/ps/edit_ps.jsp?ps_no="+ ps_no ;
       window.location.href = url2;
        
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

function copyPs(){
	var findCountByPono = '<%=basePath%>framework/ps/getCountByPo.action?po_no=<%=po_no%>';
	$.getJSON(findCountByPono,function(res){
		var index = res.sum; 
		
		$("#proj_noSelect").children().remove();
		var text = "<option value='<%=po_no %>-"+index+"-IDI'><%=po_no %>-"+index+"-IDI</option>"
		+ "<option    value='<%=po_no %>-"+index+"-HT'><%=po_no %>-"+index+"-HT</option>"
		+ "<option    value='<%=po_no %>-"+index+"-NAST'><%=po_no %>-"+index+"-NAST</option>";
		$("#proj_noSelect").append(text); 
	});
  	var rows = $('#dg').datagrid('getChecked');
     	if (rows.length>0){
 	    if(rows.length==1){
 	        var row=rows[0];
 	       // var po_no =row.po_no ;
 	       // var ps_no =row.ps_no;
 	          $('#dlg').dialog('open').dialog('setTitle',' ');
           // $('#fm').form('clear');
              $('#fm').form('load',row); 
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
     	if (rows.length>0){
 	    if(rows.length==1){
 	        var row=rows[0];
 	         var id_project =row.id_project ;
 	         var ps_no =row.proj_no;
              $.post('<%=basePath%>framework/ps/close.action',{id_project:id_project,proj_no:ps_no},function(result){
               if (result.success){
               	  alert("This Project is closeed !");
                  $('#dg').datagrid('reload');                 	  
                } else {
                  alert("This Project is not closeed !");
               }
        },'json'); 	         
 	         
 	         
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

$.extend($.fn.validatebox.defaults.rules, {  
    isExist: {
        validator:function(value,param){
        	var r=false;
        	$.ajax({  
                type : "post",  
                 url : "<%=basePath%>framework/ps/isExist.action",
                 data : {<%=Project.ID_PROJECT %>:$("#Project.ID_PROJECT").val(), proj_no:value}, 
                 dataType: 'json',
                 async : false,  
                 success : function(data){
                	 if(data==false) r=true;
                 }  
            }); 
            return r;
        },
        message:' PO NO is Exist'
    }

}); 
 
    </script>
</head>
<body style="text-align:center;background:#F0F0F0;">

    <input id="manu1" type="hidden">
    <div id="po" style="width: 100%;height:auto;text-align:center;margin:0 auto;background:#F0F0F0;">       
    <div style="width:100%;float:left">
	 <div style="width:100%;height:auto;float:left;font-size: 28px; font-weight: bold;margin-top:8px;">Create A Project Or More</div>
	 <table class="Create_or_mor" style="margin:70px 0px 20px 200px;">
	 <tr> <td><label >PO No.: </label></td><td> <input name="po_no" type="text" id="pon" readOnly="true"  /></td><td><label >Start time :</label></td><td> <input name="start_time"  id="start" readOnly="true"  type="text" />	</td>
   <tr>
        <td><label>Complete time: </label></td>
        <td> <input name="complete_time" id =comp readOnly="true" type="text" /></td>
	      <td><label >Customer:  </label></td><td><input name="customer" type="text" id="cust" readOnly="true"/></td>
    </tr>
  <!--   <tr>
      <td><label >Manufacturer:</label></td><td><input name="maufacturer" type="text" readOnly="true" id ="manu"  /></td><td><label >Product type description:</label></td><td><input name="prod_type_desc" readOnly="true" type="text" id ="pro" /></td></tr>	 
	 <tr> <td><label >PO description:</label></td><td><input name="po_desc" readOnly="true"type="text" id="desc"  /></td><td colspan="2"></td></tr> -->	 	  	 
	<tr>
	 <td><label >Manufacturer:</label></td><td><input name="maufacturer" type="text" readOnly="true" id ="manu"  /></td>
	 <td><label >PO description:</label></td><td><input name="po_desc" readOnly="true"type="text" id="desc"  /></td>
	 </tr>
	 </table>	 
	</div>      
    </div>
  
    
	<div id="dg" style="width: 100%;height:auto"></div>
	<div id="toolbar">
		<a href="javascript:void(0)" class="easyui-linkbutton"	iconCls="icon-add" plain="true" onclick="newBean()">Add Project</a>&nbsp;&nbsp;
	    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="newFileBean()">File List</a>&nbsp;&nbsp;
		<a href="javascript:void(0)" class="easyui-linkbutton"	iconCls="icon-add" plain="true" onclick="copyPs()">Copy Project</a>&nbsp;&nbsp;
	    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="closePs()">Close Project</a>&nbsp;&nbsp;
	    <a href="javascript:history.go(-1)" class="easyui-linkbutton" iconCls="icon-back" plain="true">Back</a>&nbsp;&nbsp;
<!--		<a href="javascript:void(0)" class="easyui-linkbutton"	iconCls="icon-add" plain="true" onclick="">Order From</a>&nbsp;&nbsp;
	    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="">项目进度</a>&nbsp;&nbsp;-->	    
	</div>

	<div id="dlg" class="easyui-dialog"
		style="width: 580px; height: 450px; padding: 10px 20px" closed="true"
		buttons="#dlg-buttons">
		<div class="ftitle" id="ftitle"></div>
		<form id="fm" method="post" enctype="multipart/form-data" novalidate>
			<input id="<%=Project.ID_PROJECT %>" name="<%=Project.ID_PROJECT %>"  type="hidden">
			<input id="11ppo" name="po_no"   type="hidden">				
			<table>
			<tr><td></td><td></td></tr>
			<tr><td><label>Project No:</label></td>
			<td>
			 <!-- input name="proj_no" id="111proj_no" type="text" data-options="validType:['length[3,15]', 'isExist']"  /-->
			 	<select name="proj_no" style="width:180px" id="proj_noSelect">
			    
			   </select>
			 </td>						
			</tr>				
			<tr><td><label>Project description:</label></td><td><input name="proj_desc" class="easyui-textbox"	data-options="validType:['length[3,15]']"/></td></tr>			
			<tr><td><label>Manufacturer:</label></td><td><input name="manufacturer" id="fmmanu" readonly="readonly" class="easyui-textbox" data-options="validType:['length[3,15]']" /></td></tr>			
			<tr><td><label>Make:</label></td><td> <input name="make" class="easyui-textbox"	data-options="validType:['length[3,15]']"/></td></tr>			
			<tr><td><label>IA status:</label></td><td>
			 <!--  input name="ia_status" class="easyui-textbox" data-options="validType:['length[3,15]']" /-->
			 <select name="ia_status" style="width:180px">
			      <option    value="Yes" selected="true">Yes</option>
			      <option    value="No">NO</option>

			   </select>
			 
			 </td></tr>	
			 
			 <tr><td><label>Engineer:</label></td><td><input name="engineer" id="engineer" class="easyui-textbox" data-options="required:true,validType:['length[3,35]']" style="width: 175px;"/></td></tr>		
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