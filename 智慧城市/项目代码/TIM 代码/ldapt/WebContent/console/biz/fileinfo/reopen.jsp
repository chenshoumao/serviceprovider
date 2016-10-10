<%@page import="com.solar.tech.bean.File_Item"%>
<%@page import="com.solar.tech.bean.UploadDoc"%>
<%@page import="com.solar.tech.bean.UploadTest"%>
<%@page import="com.solar.tech.bean.UploadCert"%>
<%@page import="com.solar.tech.bean.Action"%>
<%@page import="com.solar.tech.bean.comment"%>
<%@ page import="com.solar.tech.exception.ResultCode"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	
	String pono=request.getParameter("pono");	
	String psno=request.getParameter("psno");
    String fileno=request.getParameter("fileno");
%>
<html>
<head>
 <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>scripts/common/jquery-easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="<%=basePath%>scripts/common/jquery-easyui/themes/icon.css">
<script type="text/javascript"
	src="<%=basePath%>scripts/common/jquery-easyui/jquery.min.js"></script>
<script type="text/javascript"
	src="<%=basePath%>scripts/common/jquery-easyui/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="<%=basePath%>scripts/common/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
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

table td{ 
 height:30px;
 width:150px;
 text-align:right;
 }
</style>
<script type="text/javascript">

  
$(function(){
 
$("#datstab").tabs({    
      onSelect:function(title){    

         if (title=="Test"){
           getTest();
         };
         if (title=="Document"){
           getDoc();
         };
         if (title=="Test Report"){
           getTestReport();
         };
         if (title=="Certificate"){
         getCert();
         };         
         if (title=="Action"){
         getAction();
         };
         if (title=="Comment"){
         getComm();
         };
                   
      }   
  });  
});

//file info 
var fno ='<%=fileno %>';
var url11 = "<%=basePath %>framework/file/find.action?psno=<%=psno%>";

$.getJSON(url11, function(res) {
 
      
    document.getElementById("ipono").value=res[0][0].po_no ;
    document.getElementById("icust").value=res[0][0].customer;
    document.getElementById("istart").value=formatDatebox(res[0][0].start_time);
    document.getElementById("icomp").value=formatDatebox(res[0][0].complete_time);
	
    document.getElementById("ipsno").value=res[0][1].proj_no;
    document.getElementById("imake").value=res[0][1].make;
    document.getElementById("iproj").value=res[0][1].proj_desc;	
    document.getElementById("imanu").value=res[0][1].manufacturer;
    document.getElementById("iia").value=res[0][1].ia_status;
    document.getElementById("engineer").value=res[0][1].engineer;
	
   // document.getElementById("iia").value=res[0][1].ia_status;
    /// var fno=res[0][1].proj_no+"_f"+getRandom(20);
	// alert('fno:'+fno);
	
	document.getElementById("ifileno").value=fno;
	document.getElementById("tfileno").value=fno;
	document.getElementById("dfileno").value=fno;
	document.getElementById("cfileno").value=fno;
	document.getElementById("afileno").value=fno;
	document.getElementById("ofileno").value=fno;

 });

var fileurl = "<%=basePath %>framework/file/findfile.action?fileno=<%=fileno%>";
$.getJSON(fileurl, function(res) {
    $("#id_file_item").val(res[0].id_file_item);
    $("#from").textbox('setValue',res[0].from);
    document.getElementById("ifileno").options.length=0;
    $("#ifileno").append("<option value=''> </option><option value='"+res[0].file_no+"' selected='true'>"+res[0].file_no+"</option>");    
 	  
    document.getElementById("tfileno").value=res[0].file_no;
	document.getElementById("dfileno").value=res[0].file_no;
	document.getElementById("cfileno").value=res[0].file_no;
	document.getElementById("afileno").value=res[0].file_no;
	document.getElementById("ofileno").value=res[0].file_no;
	fno=res[0].file_no ; 
	fileno=res[0].file_no ;
   // $("#ofileno").combobox("setText",res[0].file_no); 
    $("#type").textbox('setValue',res[0].type);
    $("#standard").textbox('setValue',res[0].standard);
       
//    document.getElementById("nast_proj_no").value=formatDatebox(res[0][0].complete_time);
	
    document.getElementById("nast_proj_no").value=res[0].nast_proj_no;
    document.getElementById("nast_rep_no").value=res[0].nast_rep_no;
    document.getElementById("idi_rep_no").value=res[0].idi_rep_no;
    document.getElementById("hest_or_no").value=res[0].hest_or_no;	
    document.getElementById("hest_rep_no").value=res[0].hest_rep_no;
    document.getElementById("cert_no").value=res[0].cert_no;
    document.getElementById("file_type").value=res[0].file_type;
    document.getElementById("rev_ext").value=res[0].rev_ext;
    document.getElementById("status").value=res[0].status;
    document.getElementById("category").value=res[0].category;
    
  
  
   
    	
    		$("#manage").val(res[0].manage);
    	 
    		
   document.getElementById("Coordinator").value=res[0].coordinator;
     $("#deadline").textbox("setValue",formatDatebox(res[0].deadline)); 
    $("#create_time").textbox("setValue",formatDatebox(res[0].create_time)); 
      $("#endtime").textbox("setValue",formatDatebox(res[0].endtime));  
 });



function getRandom(n){
        return Math.floor(Math.random()*n+1)
        }


function infosaveBean(){
	
    $('#infofm').form('submit',{
        url:  '<%=basePath%>framework/file/update.action?po_close=false',
        onSubmit: function(){
            return $(this).form('validate');
        },
        success: function(result){
        	alert("保存成功！");
           // $('#dlg').dialog('close');        // close the dialog
           // $('#dg').datagrid('reload');    // reload the user data
        }
    });
}


//test
function getTest(){
	$('#testdg').datagrid({
		height: 'auto',
	    fit:false,
		url: '<%=basePath %>framework/info/showsTest.action',
	    queryParams: {fileno: fno},	    
	    method: 'POST',
	    striped: true,
	    nowrap: true,
	    pageSize: 10,
	    pageNumber:1, 
	    pageList: [10, 20, 50, 100, 150, 200],
	    showFooter: true,
		loadMsg : '数据加载中请稍后……',
		pagination : true,
	    toolbar:"#testtoolbar",
	    checkOnSelect:false,
	    selectOnCheck:false,  
	   
	    columns: [[  
	       { field: 'ck', checkbox: true  },
	        { field: 'name', title: 'Name', width: '16.5%',align:'center'},
	        { field: 'status', title: 'Status', width: '16.5%',align:'center'},
		    { field: 'version', title: 'Version', width: '16.5%',align:'center'},
	        { field: 'size', title: 'Size', width: '16.5%',align:'center'},
	        { field: 'createtime', title: 'Created',  width: '16.5%',align:'center'}, 
	        { field: 'createby',title: 'UploadBy', width:'16.5%',align:'center'} 	       	        
	    ]]

	});
	
	
}



var testurl;
function testnewBean(){
 	//if(fitemPassword!= undefined){
    //	$("#fitemPassword").append(fitemPassword);
    //}
 //	$("#fitemPassword").show();
    $('#testdlg').dialog('open').dialog('setTitle',' ');
    $('#testfm').form('clear');  
	document.getElementById("tpono").value='<%=pono %>';
    document.getElementById("tprojno").value='<%=psno %>';
    document.getElementById("tfileno").value=fno;	
    testurl = '<%=basePath%>framework/info/uploadtest.action';
    $('#testftitle').html("Upload A Document");
}
//var fitemPassword;
function testeditBean(row){
    if (row){
 
      //  row.password2=row.password="******";
        $('#testdlg').dialog('open').dialog('setTitle','');
        $('#testfm').form('load',row);
        
     
        testurl = '<%=basePath%>framework/file/update.action';    
        $('#testftitle').html("Modify A File");
    }
}


function testsaveBean(){
    $('#testfm').form('submit',{
        url: testurl,
        onSubmit: function(){
            return $(this).form('validate');
        },
        success: function(result){
            $('#testdlg').dialog('close');        // close the dialog
            $('#testdg').datagrid('reload');    // reload the user data
        }
    });
}
function testdestroyBean(){
	var rows = $('#testdg').datagrid('getChecked');
    if (rows.length>0){
        $.messager.confirm('温馨提示','你真的要删除么?',function(r){
            if (r){
            	for(var i=0; i<rows.length; i++){
            		var row=rows[i];
            	 
             $.post('<%=basePath%>framework/file/delete.action',{id_file:row.id_file_item},function(result){
                    if (result.success){
                        $('#testdg').datagrid('reload');    // reload the user data
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

//csm test Report
function getTestReport(){
	$('#testreportdg').datagrid({
		height: 'auto',
	    fit:false,
		 url: '<%=basePath %>framework/info/showsTestreport.action',
	    queryParams: {fileno: fno},	    
	    method: 'POST',
	    striped: true,
	    nowrap: true,
	    pageSize: 10,
	    pageNumber:1, 
	    pageList: [10, 20, 50, 100, 150, 200],
	    showFooter: true,
		loadMsg : '数据加载中请稍后……',
		pagination : true,
	    toolbar:"#testreporttoolbar",
	    checkOnSelect:false,
	    selectOnCheck:false,  
	   
	    columns: [[  
	       { field: 'ck', checkbox: true  },
	        { field: 'name', title: 'Name', width: '16.5%',align:'center'},
	        { field: 'status', title: 'Status', width: '16.5%',align:'center'},
		    { field: 'version', title: 'Version', width: '16.5%',align:'center'},
	        { field: 'size', title: 'Size', width: '16.5%',align:'center'},
	        { field: 'createtime', title: 'Created',  width: '16.5%',align:'center'}, 
	        { field: 'createby',title: 'UploadBy', width:'16.5%',align:'center'} 	       	        
	    ]]

	});
	
	
}



var testreporturl;
function testreportnewBean(){
 	//if(fitemPassword!= undefined){
    //	$("#fitemPassword").append(fitemPassword);
    //}
 //	$("#fitemPassword").show();
    $('#testreportdlg').dialog('open').dialog('setTitle',' ');
    $('#testreportfm').form('clear');  
	document.getElementById("trpono").value='<%=pono %>';
    document.getElementById("trprojno").value='<%=psno %>';
    document.getElementById("trfileno").value=fno;	
    testreporturl = '<%=basePath%>framework/info/uploadtestreport.action';
    $('#testftitle').html("Upload A Test Report");
}
//var fitemPassword;
function testreporteditBean(a){ 
	  console.log($(a).attr("value"));	
      var  testreporturl = '<%=basePath%>framework/info/downloadTestreport.action?path='+$(a).attr("value"); 
     // alert()
      window.location.href=testreporturl;
}


function testreportsaveBean(){
    $('#testreportfm').form('submit',{
        url: testreporturl,
        onSubmit: function(){
            return $(this).form('validate');
        },
        success: function(result){
            $('#testreportdlg').dialog('close');        // close the dialog
            $('#testreportdg').datagrid('reload');    // reload the user data
        }
    });
}


//document

function getDoc(){
	$('#docdg').datagrid({
		height: 'auto',
	    fit:false,
		url: '<%=basePath %>framework/info/showsDoc.action',
	    queryParams: {fileno: fno},	   	    
	    method: 'POST',
	    striped: true,
	    nowrap: true,
	    pageSize: 10,
	    pageNumber:1, 
	    pageList: [10, 20, 50, 100, 150, 200],
	    showFooter: true,
		loadMsg : '数据加载中请稍后……',
		pagination : true,
	    toolbar:"#doctoolbar",
	    checkOnSelect:false,
	    selectOnCheck:false,  
	   
	    columns: [[  
	      { field: 'ck', checkbox: true },
	        { field: 'name', title: 'Name', width: '16.5%',align:'center'},
	        { field: 'status', title: 'Status', width: '16.5%',align:'center'},
		    { field: 'version', title: 'Version', width: '16.5%',align:'center'},
	        { field: 'size', title: 'Size', width: '16.5%',align:'center'},
	        { field: 'createtime', title: 'Created',  width: '16.5%',align:'center'}, 
	        { field: 'createby',title: 'UploadBy', width:'16.5%',align:'center'}	    ]]

	});
}

var docurl;
function docnewBean(){
 	//if(fitemPassword!= undefined){
    //	$("#fitemPassword").append(fitemPassword);
    //}
 	//$("#fitemPassword").show();
    $('#docdlg').dialog('open').dialog('setTitle',' ');
    $('#docfm').form('clear');  
	document.getElementById("dpono").value='<%=pono %>';
    document.getElementById("dprojno").value='<%=psno %>';
    document.getElementById("dfileno").value=fno;	
    docurl = '<%=basePath%>framework/info/uploadDoc.action';
    $('#docftitle').html("Upload A Document");
}
//var fitemPassword;
function doceditBean(row){
    if (row){

       // row.password2=row.password="******";
        $('#docdlg').dialog('open').dialog('setTitle','');
        $('#docfm').form('load',row);
        
     
        docurl = '<%=basePath%>framework/file/update.action';    
        $('#docftitle').html("Modify A File");
    }
}


function docsaveBean(){
    $('#docfm').form('submit',{
        url: docurl,
        onSubmit: function(){
            return $(this).form('validate');
        },
        success: function(result){
            $('#docdlg').dialog('close');        // close the dialog
            $('#docdg').datagrid('reload');    // reload the user data
        }
    });
}
function docdestroyBean(){
	var rows = $('#docdg').datagrid('getChecked');
    if (rows.length>0){
        $.messager.confirm('温馨提示','你真的要删除么?',function(r){
            if (r){
            	for(var i=0; i<rows.length; i++){
            		var row=rows[i];
            	 
             $.post('<%=basePath%>framework/file/delete.action',{id_file:row.id_file_item},function(result){
                    if (result.success){
                        $('#docdg').datagrid('reload');    // reload the user data
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
//Certificate
function getCert(){
	
	$('#certdg').datagrid({
		height: 'auto',
	    fit:false,
		url: '<%=basePath %>framework/info/showsCert.action',
	    queryParams: {fileno: fno},	    
	    method: 'POST',
	    striped: true,
	    nowrap: true,
	    pageSize: 10,
	    pageNumber:1, 
	    pageList: [10, 20, 50, 100, 150, 200],
	    showFooter: true,
		loadMsg : '数据加载中请稍后……',
		pagination : true,
	    toolbar:"#certtoolbar",
	    checkOnSelect:false,
	    selectOnCheck:false,  
	   
	    columns: [[  
	         { field: 'ck', checkbox: true },
	        { field: 'name', title: 'Name', width: '16.5%',align:'center'},
	        { field: 'status', title: 'Status', width: '16.5%',align:'center'},
		    { field: 'version', title: 'Version', width: '16.5%',align:'center'},
	        { field: 'size', title: 'Size', width: '16.5%',align:'center'},
	        { field: 'createtime', title: 'Created',  width: '16.5%',align:'center'}, 
	        { field: 'createby',title: 'UploadBy', width:'16.5%',align:'center'},    	        
	    ]]

	});
	
}

var certurl;
function certnewBean(){
 	//if(fitemPassword!= undefined){
    //	$("#fitemPassword").append(fitemPassword);
    //}
 	//$("#fitemPassword").show();
   $('#certdlg').dialog('open').dialog('setTitle',' ');
    $('#certfm').form('clear');
	document.getElementById("cpono").value='<%=pono %>';
    document.getElementById("cprojno").value='<%=psno %>';
    document.getElementById("cfileno").value=fno;		
    certurl = '<%=basePath%>framework/info/uploadCert.action';
    $('#certftitle').html("Upload A Document");
}
var fitemPassword;
function certeditBean(row){
    if (row){
        
        $('#certdlg').dialog('open').dialog('setTitle','');
        $('#certfm').form('load',row);
        
     
        certurl = '<%=basePath%>framework/file/update.action';    
        $('#certftitle').html("Modify A File");
    }
}


function certsaveBean(){
    $('#certfm').form('submit',{
        url: certurl,
        onSubmit: function(){
            return $(this).form('validate');
        },
        success: function(result){
            $('#certdlg').dialog('close');        // close the dialog
            $('#certdg').datagrid('reload');    // reload the user data
        }
    });
}
function certdestroyBean(){
	var rows = $('#certdg').datagrid('getChecked');
    if (rows.length>0){
        $.messager.confirm('温馨提示','你真的要删除么?',function(r){
            if (r){
            	for(var i=0; i<rows.length; i++){
            		var row=rows[i];
            	 
             $.post('<%=basePath%>framework/file/delete.action',{id_file:row.id_file_item},function(result){
                    if (result.success){
                        $('#certdg').datagrid('reload');    // reload the user data
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
//Action
function getAction(){
	
	
	$('#actdg').datagrid({
		height: 'auto',
	    fit:false,
		url: '<%=basePath %>framework/info/showsAct.action',
	    queryParams: {fileno: fno},	    
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
	        { field: 'actionTime', title: 'Date', width: '16.5%',align:'center'},
	        { field: 'userName', title: 'User', width: '16.5%',align:'center'},
		    { field: 'actions', title: 'Actions', width: '16.5%',align:'center'},
	        { field: 'infonmation', title: 'Infonmation', width: '16.5%',align:'center'},
	        { field: 'Reason', title: 'Reason',  width: '16.5%',align:'center'} 	       	        
	    ]]

	});
}

var acturl;
function actnewBean(){
 	//if(fitemPassword!= undefined){
    //	$("#fitemPassword").append(fitemPassword);
    //}
 	//$("#fitemPassword").show();
    $('#actdlg').dialog('open').dialog('setTitle',' ');
    $('#actfm').form('clear');  
    acturl = '<%=basePath%>framework/file/add.action';
    $('#actftitle').html("Add A Action");
}
//var fitemPassword;
function acteditBean(row){
    if (row){

        $('#actdlg').dialog('open').dialog('setTitle','');
        $('#actfm').form('load',row);
        
     
        acturl = '<%=basePath%>framework/file/update.action';    
        $('#actftitle').html("Modify A Action");
    }
}


function actsaveBean(){
    $('#actfm').form('submit',{
        url: acturl,
        onSubmit: function(){
            return $(this).form('validate');
        },
        success: function(result){
            $('#actdlg').dialog('close');        // close the dialog
            $('#actdg').datagrid('reload');    // reload the user data
        }
    });
}
function actdestroyBean(){
	var rows = $('#actdg').datagrid('getChecked');
    if (rows.length>0){
        $.messager.confirm('温馨提示','你真的要删除么?',function(r){
            if (r){
            	for(var i=0; i<rows.length; i++){
            		var row=rows[i];
            	 
             $.post('<%=basePath%>framework/file/delete.action',{id_file:row.id_file_item},function(result){
                    if (result.success){
                        $('#actdg').datagrid('reload');    // reload the user data
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
//comment
function getComm(){
	
	$('#commdg').datagrid({
		height: 'auto',
	    fit:false,
		url: '<%=basePath %>framework/info/showsComm.action',
	    queryParams: {fileno: fno},	    
	    method: 'POST',
	    striped: true,
	    nowrap: true,
	    pageSize: 10,
	    pageNumber:1, 
	    pageList: [10, 20, 50, 100, 150, 200],
	    showFooter: true,
		loadMsg : '数据加载中请稍后……',
		pagination : true,
	    toolbar:"#commtoolbar",
	    checkOnSelect:false,
	    selectOnCheck:false,  
	   
	    columns: [[  
	        { field: 'ck', checkbox: true },
	        { field: 'comment', title: 'Comment', width: '33.2%',align:'center'},
	        { field: 'userName', title: 'User Name', width: '33.2%',align:'center'},
		    { field: 'commTime', title: 'Comment Time', width: '33.2%',align:'center'}	       	       	        
	    ]]

	});
	
	
}

var comurl;
function commnewBean(){

    $('#commdlg').dialog('open').dialog('setTitle',' ');
    $('#commfm').form('clear');  
    comurl = '<%=basePath%>framework/info/addComm.action';
    $('#commftitle').html("Add A File");
}
var fitemPassword;
function commeditBean(row){
    if (row){

        $('#commdlg').dialog('open').dialog('setTitle','');
        $('#commfm').form('load',row);
        
     
        comurl = '<%=basePath%>framework/file/update.action';    
        $('#commftitle').html("Modify A File");
    }
}


function commsaveBean(){
    $('#commfm').form('submit',{
        url: comurl,
        onSubmit: function(){
            return $(this).form('validate');
        },
        success: function(result){
            $('#commdlg').dialog('close');        // close the dialog
            $('#commdg').datagrid('reload');    // reload the user data
        }
    });
}
function commdestroyBean(){
	var rows = $('#commdg').datagrid('getChecked');
    if (rows.length>0){
        $.messager.confirm('温馨提示','你真的要删除么?',function(r){
            if (r){
            	for(var i=0; i<rows.length; i++){
            		var row=rows[i];
            	 
             $.post('<%=basePath%>framework/file/delete.action',{id_file:row.id_file_item},function(result){
                    if (result.success){
                        $('#commdg').datagrid('reload');    // reload the user data
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
                 url : "<%=basePath%>framework/file/isExist.action",
                 data : {id_file_item:'', file_no:value}, 
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
<title>Insert title here</title>
</head>
<body style="text-align:center;background:#F0F0F0;">
   
    <div id="datstab" class="easyui-tabs" style="width:100%;height：580px;">
    <div id="FileInfo" title="FileInfo" style="padding:20px;background:#F0F0F0;">
	   <div style="width:100%;float:left">
       <div  style="border: 1px solid #ccc;">
       <table>
       <tr> <td> <label >PO No.:</label></td> <td> <input name="po_no" type="text" id="ipono" readOnly="true"/></td> <td> <label >Customer</label></td> <td> <input name="customer"type="text" id="icust" /></td> <td><label >Start time</label> </td><td><input name="start_time" type="text" id="istart"/></td><td> <label >Complete time</label></td><td> <input name="complete_time" type="text" id="icomp" />  </td></tr>    
          <tr><td><label >Project No.;</label></td> <td> <input name="proj_no" type="text" id="ipsno" /></td> <td><label >Project description</label></td> <td> <input name="proj_desc" type="text" id="iproj" /></td> <td> <label >Manufacturer</label> </td> <td><input name="manufacturer" type="text" id="imanu"/></td> <td> <label >Make</label> </td> <td><input name="make"type="text" id="imake" /> </td> </tr>
          <tr><td> <label >IA status</label> </td> <td> <input name="ia_status" type="text" id="iia" /> </td><td> <label >Engineer</label> </td><td><input name="engineer" id="engineer" data-options="required:true,validType:['length[3,15]']"/></td><td>  </td><td>  </td><td>  </td><td>  </td></tr>
          </table>
       </div>      
       <div style="width:100%;height:25px"> </div>
      <div style="border: 1px solid #ccc;">
      <form id="infofm" method="post" enctype="multipart/form-data" novalidate>
      <input name="id_file_item" id="id_file_item" type="hidden">
      <input id="ipono" name="pono" value="<%= pono %>" type="hidden">
	  <input id="iprojno" name="projno" value="<%= psno %>" type="hidden">		
      <table>      
      <tr><td><label >From</label> </td> <td><input name="from" id="from"  class="easyui-textbox" data-options="required:true,validType:['length[3,15]']" /></td> <td><label >File No. </label></td> <td>
       <!-- input name="file_no" type="text" id="ifileno"  data-options="validType:['length[3,15]', 'isExist']"/--> 
       		<select name="file_no" id="ifileno"  style="width:160px"> </select>
       
       </td><td><label >Type</label></td> <td> <input name="type" id="type" class="easyui-textbox" data-options="required:true,validType:['length[3,50]']" /></td><td><label >Standard</label></td> <td> <input name="standard" id="standard" class="easyui-textbox" data-options="required:true,validType:['length[3,15]']"/> </td></tr>
      <tr><td><label >NAST project No.</label></td> <td> <input name="nast_proj_no"  id="nast_proj_no" data-options="validType:['length[3,15]']"/></td> <td><label >NAST report No.</label></td> <td> <input name="nast_rep_no" id="nast_rep_no" data-options="validType:['length[3,15]']" /> </td> <td><label >IDIADA report No.</label></td> <td> <input name="idi_rep_no" id="idi_rep_no" data-options="validType:['length[3,15]']" /></td> <td> <label >Hestocon order No.</label> </td> <td><input name="hest_or_no" id="hest_or_no" data-options="validType:['length[3,15]']" /> </td></tr>
      <tr><td><label >Hestocon report No.</label></td> <td> <input name="hest_rep_no" id="hest_rep_no" data-options="validType:['length[3,15]']"/></td> <td><label >Certificate No.</label></td> <td> <input name="cert_no" id="cert_no" data-options="validType:['length[3,15]']"/></td> <td><label >File type</label></td><td> <input name="file_type" id="file_type" data-options="validType:['length[3,15]']"/></td><td><label >Rev / Ext.</label></td><td> <input name="rev_ext" id="rev_ext" data-options="validType:['length[3,15]']"/> </td></tr>
      <tr><td><label >Status</label> </td> <td><input name="status" id="status" data-options="validType:['length[3,15]']"/></td> <td><label >Category</label></td><td> <input name="category" id="category" data-options="required:true,validType:['length[3,15]']" /></td><td> <label >Create time</label></td><td> <input name="create_time" id="create_time" data-options="required:true"  class="easyui-datebox" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})"/></td><td><label >End time</label></td><td> <input name="endtime"id="endtime" class="easyui-datebox" data-options="required:true" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd '})" /> </td></tr>
      <tr><td><label >Coordinator</label> </td><td><input name="Coordinator" id="Coordinator" data-options="validType:['length[3,15]']" /></td><td><label >Deadline</label></td><td> <input name="deadline" id ="deadline" data-options="required:true" class="easyui-datebox" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})"/></td>
      <td> <label >Manager</label> </td><td><input name="manage" id="manage"  data-options="required:true,validType:['length[3,15]']" /></td><td></td></tr>
       </table>       
       </form>
       </div>
        <div style="width:100%;height:25px"> </div>
       <div>
      	 <div><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="infosaveBean()">Save</a>&nbsp;&nbsp;
      	 <!-- <button type="button">Reopen</button> --></div>
      </div>
      
      <div style="border: 1px solid #ccc;" > 
      <div id="doc_flow" style="width: 100%;height:100px"></div>
      </div>
      </div>     		    				
          </div>
      <div title="Test"  style="padding:20px;background:#F0F0F0;">


	<div id="testdg" style="width: 100%;height:100%"></div>
	<div id="testtoolbar">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-add" plain="true" onclick="testnewBean()">UpLoad Test Report </a> 

	</div>

	<div id="testdlg" class="easyui-dialog"
		style="width: 580px; height: 450px; padding: 10px 20px" closed="true"
		buttons="#testdlg-buttons">
		<div class="ftitle" id="ftitle"></div>
		<form id="testfm" method="post" enctype="multipart/form-data" novalidate>
      <input id="tpono" name="pono" value="<%=pono %>" type="hidden">
	  <input id="tprojno" name="projno" value="<%=psno %>" type="hidden">
	 <input id="tfileno" name="fileno"id="tfileno" value="" type="hidden">				
			<table><tr><td><label>Test Document:</label></td><td><input type="file" name="uploadtest" id=""></td></tr></table>
			  		 				 
		</form>
	</div>
	<div id="testdlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" onclick="testsaveBean()" style="width: 90px">保存</a>
			 <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#testdlg').dialog('close')" style="width: 90px">取消</a>
	</div>
  

			
			</div>
    <div title="Document"  style="padding:20px;background:#F0F0F0;">
		
   <div id="docdg" style="width: 100%;height:100%"></div>
	<div id="doctoolbar">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-add" plain="true" onclick="docnewBean()">UpLoad Document</a> 

	</div>

	<div id="docdlg" class="easyui-dialog"
		style="width: 580px; height: 450px; padding: 10px 20px" closed="true"
		buttons="#docdlg-buttons">
		<div class="ftitle" id="ftitle"></div>
		<form id="docfm" method="post" enctype="multipart/form-data" novalidate>
      <input id="dpono" name="pono" value="<%=pono %>" type="hidden">
	  <input id="dprojno" name="projno" value="<%=psno %>" type="hidden">
	 <input id="dfileno" name="fileno"  value="" type="hidden">	
			
			<table><tr><td><label> Document:</label></td><td><input type="file" name="uploadtest" id=""></td></tr></table>
			  		 				 
		</form>
	</div>
	<div id="docdlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" onclick="docsaveBean()" style="width: 90px">保存</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel" onclick="javascript:$('#docdlg').dialog('close')"
			style="width: 90px">取消</a>
	</div>		
				
		
    </div>
    
    <div title="Test Report"  style="padding:20px;background:#F0F0F0">


	<div id="testreportdg" style="width: 100%;height:100%"></div>
	<div id="testreporttoolbar">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-add" plain="true" onclick="testreportnewBean()">UpLoad Test Report</a>
	</div>

	<div id="testreportdlg" class="easyui-dialog"
		style="width: 580px; height: 450px; padding: 10px 20px" closed="true"
		buttons="#testreportdlg-buttons">
		<div class="ftitle" id="ftitle"></div>
		<form id="testreportfm" method="post" enctype="multipart/form-data" novalidate>
      <input id="trpono" name="pono" value=""  >
	  <input id="trprojno" name="psno" value=""  >
	 <input id="trfileno" name="fileno" value=""  >				
			<table><tr><td><label>Test Report:</label></td><td><input type="file" name="uploadtest" id=""></td></tr></table>
			  		 				 
		</form>
	</div>
	<div id="testreportdlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" onclick="testreportsaveBean()" style="width: 90px">save</a>
			 <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#testreportdlg').dialog('close')" style="width: 90px">cancle</a>
	</div>
	</div>
    
    <div title="Certificate"  style="padding:20px;background:#F0F0F0;">
		
		
   <div id="certdg" style="width: 100%;height:100%"></div>
	<div id="certtoolbar">
		<a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-add" plain="true" onclick="certnewBean()">UpLoad Certificate</a> 

	</div>

	<div id="certdlg" class="easyui-dialog"
		style="width: 580px; height: 450px; padding: 10px 20px" closed="true"
		buttons="#certdlg-buttons">
		<div class="ftitle" id="ftitle"></div>
		<form id="certfm" method="post" enctype="multipart/form-data" novalidate>
      <input id="cpono" name="pono" value="<%=pono %>" type="hidden">
	  <input id="cprojno" name="projno" value="<%=psno %>" type="hidden">
	 <input id="cfileno" name="fileno" id ="cfileno" value="" type="hidden">	

			<table><tr><td><label>Certificate:</label></td><td> <input type="file" name="uploadtest" id=""></td></tr></table>
			
			  		 				 
		</form>
	</div>
	<div id="certdlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" onclick="certsaveBean()" style="width: 90px">保存</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel" onclick="javascript:$('#certdlg').dialog('close')"
			style="width: 90px">取消</a>
	</div>		

		
    </div>
    
    <div title="Action"  style="padding:20px;background:#F0F0F0;">
		
	<div id="actdg" style="width: 100%;height:100%"></div>
	<div id="acttoolbar">
		<!--  a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-add" plain="true" onclick="actnewBean()">Add Action</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-remove" plain="true" onclick="actdestroyBean()">Delete Action</a-->
	</div>

	<div id="actdlg" class="easyui-dialog"
		style="width: 580px; height: 450px; padding: 10px 20px" closed="true"
		buttons="#actdlg-buttons">
		<div class="ftitle" id="ftitle"></div>
		<form id="actfm" method="post" enctype="multipart/form-data" novalidate>
			<input id="actuuid" name="actuuid"  type="hidden">
			<input  name="file_no" id="afileno" value="" type="hidden">	
			<input id="actproj_no" name="proj_no"  value="<%=psno %>" type="hidden">
			<input id="actuserName" name="userName"  type="hidden">	
			
			
           <table>
           
           
           <tr>
            <td><label>Actions:</label></td>
            <td> <input name="Actions" class="easyui-textbox" data-options="required:true,validType:['length[3,15]']"  /></td>
            </tr>
           <tr>
            <td><label>Infonmation:</label></td>
            <td> <input name="infonmation" class="easyui-textbox" data-options="required:true,validType:['length[3,15]']"  /></td>
            </tr>            
           <tr>
            <td><label>Reason:</label></td>
            <td> <input name="Reason" class="easyui-textbox" data-options="required:true,validType:['length[3,15]']"  /></td>
            </tr>            
           <tr>
            <td><label>Type:</label></td>
            <td> <input name="Type" class="easyui-textbox" data-options="required:true,validType:['length[3,15]']"  /></td>
            </tr>                                  
           <tr>
            <td><label>Document Infomation:</label></td>
            <td> <input name="docinfo" class="easyui-textbox" data-options="required:true,validType:['length[3,15]']"  /></td>
            </tr>  
           </table>			
			
		</form>
	</div>
	<div id="actdlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" onclick="actsaveBean()" style="width: 90px">保存</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel" onclick="javascript:$('#actdlg').dialog('close')"
			style="width: 90px">取消</a>
	</div>		
		
		
		
			
    </div>
    
    <div title="Comment"  style="padding:20px;background:#F0F0F0;">
		
	<div id="commdg" style="width: 100%;height:100%"></div>
	<div id="commtoolbar">
		<!--  a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-add" plain="true" onclick="commnewBean()">Add Comment</a--> 
	</div>

	<div id="commdlg" class="easyui-dialog"
		style="width: 580px; height: 450px; padding: 10px 20px" closed="true"
		buttons="#commdlg-buttons">
		<div class="ftitle" id="ftitle"></div>
		<form id="commfm" method="post" enctype="multipart/form-data" novalidate>
			<input id="commentuuid" name="commentuuid"  type="hidden">
			<input  name="file_no"  id="ofileno" value="" type="hidden">
			<input id="comproj_no" name="proj_no" value="" type="hidden">
		

           <table>
           <tr>
            <td><label>Comment:</label></td>
            <td> <input name="comment" class="easyui-textbox" data-options="required:true,validType:['length[3,80]']"  /></td>
            </tr>                      
           </table>
   		 	
		</form>
	</div>
	<div id="commdlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" onclick="commsaveBean()" style="width: 90px">保存</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel" onclick="javascript:$('#commdlg').dialog('close')"
			style="width: 90px">取消</a>
	</div>

		
    </div>
    
    </div>
</body>
</html>