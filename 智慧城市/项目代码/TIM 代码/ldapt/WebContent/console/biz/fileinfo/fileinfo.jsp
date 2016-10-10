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
	
	String pono=request.getParameter("po_no");	
	String psno=request.getParameter("ps_no");
	String isDraft=request.getParameter("isDraft");
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

.FileInfo  td{ 
 height:30px;
 width:150px;
 text-align:right;
 }
</style>
<script type="text/javascript">
var s= false;
  
$(function(){
 
$("#datstab").tabs({    
      onSelect:function(title){    
      /** if(!s&&title!='FileInfo'){
         alert("you are do not save a file!");
 
         $("#datstab").tabs("select", 'FileInfo');
        }*/
         if (title=="Test Record"){
           getTest();
         };
         if (title=="Information Document"){
           getDoc();
         };
         if (title=="Certificates"){
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
       var fno;
 	    var fileno;    
 	    var psno;
 	    var pono;
var url11 = "<%=basePath %>framework/file/find.action?psno=<%=psno%>";
 
$.getJSON(url11, function(res) {

 
     //alert(res[0]);          
    document.getElementById("ipono").value=res[0][0].po_no ;
    document.getElementById("icust").value=res[0][0].customer;
    document.getElementById("istart").value=formatDatebox(res[0][0].start_time);
    document.getElementById("icomp").value=formatDatebox(res[0][0].complete_time);
	
    document.getElementById("ipsno").value=res[0][1].proj_no;
    document.getElementById("imake").value=res[0][1].make;
    document.getElementById("iproj").value=res[0][1].proj_desc;	
    document.getElementById("imanu").value=res[0][1].manufacturer;
    document.getElementById("iia").value=res[0][1].ia_status;
	psno=res[0][0].po_no;
    pono=res[0][1].proj_no;
   // document.getElementById("iia").value=res[0][1].ia_status;
    //  fno=res[0][1].proj_no+"_F"+getRandom(99);
      
	// alert('fno:'+fno);	
	//document.getElementById("ifileno").value=fno;
      var d = new Date();
      var vYear = d.getFullYear();
      var vMon = d.getMonth() + 1;
      var vDay = d.getDate();
     var s=vYear+(vMon<10 ? "0" + vMon : vMon)+(vDay<10 ? "0"+ vDay : vDay);
     var gr=getRandom(99);
     var fdvalue="D-"+s+gr;
     var fnvalue ="N-"+s+gr;
	$("#ifileno").append("<option value=''> </option><option value='"+fdvalue+"' selected='true'>"+fdvalue+"</option><option value='"+fnvalue+"'>"+fnvalue+"</option>");    
 	

    
   	document.getElementById("tfileno").value=fdvalue;
	document.getElementById("dfileno").value=fdvalue;
	document.getElementById("cfileno").value=fdvalue;
	document.getElementById("afileno").value=fdvalue;
	document.getElementById("ofileno").value=fdvalue;
	fno=fdvalue ; 
	fileno=fdvalue ; 

 });
 

$("#ifileno").change(function(){
 
   var cfileno=$("#ifileno").find("option:selected").val();
   	document.getElementById("tfileno").value=cfileno;
	document.getElementById("dfileno").value=cfileno;
	document.getElementById("cfileno").value=cfileno;
	document.getElementById("afileno").value=cfileno;
	document.getElementById("ofileno").value=cfileno;
	fno=cfileno ;
	fileno=cfileno ; 
   
});

var meurl = "<%=basePath %>framework/ldap/shows.action";
$.getJSON(meurl, function(m) {
$('#manage').combobox({
data : m,
valueField:'userName',
textField:'fullName'
});
$('#engineer').combobox({
data : m,
valueField:'userName',
textField:'fullName'
});

$('#smto').combobox({
data : m,
valueField:'email',
textField:'userName'
});
if('<%=isDraft%>' == 1){ 
findDraft();
}

});


function getRandom(n){
        return Math.floor(Math.random()*n+1)
        }


function infosaveBean(){
	if(s){ 
		return s;
	}
	var isDraft = $("input[name=draft]").val();
    $('#infofm').form('submit',{
        url:  '<%=basePath%>framework/file/add.action',
        onSubmit: function(){
            return $(this).form('validate');
        },
        success: function(result){
           // $('#dlg').dialog('close');        // close the dialog
           // $('#dg').datagrid('reload');
           s=true; 
          // $("#datstab").tabs("select", 'Test Record');
           // alert("Your fileinfo are saved !")
        }
    });
}

function findDraft(){
	var draftUrl = "<%=basePath %>framework/file/findDraft.action?fileno=<%=fileno%>";
	 
$.getJSON(draftUrl, function(res) { 
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
    var engineer = res[0].engineer;
    var cdata = $("#engineer").combobox('getData'); 
    for(var i = 0;i < cdata.length;i++){ 
    	if(cdata[i].userName == engineer){
    		$("#engineer").combobox('setValue',cdata[i].userName);
    		$("#engineer").combobox('setText',cdata[i].fullName);
    	}
    } 
    cdata = $("#manage").combobox('getData'); 
    var manage = res[0].manage;
    for(var i = 0;i < cdata.length;i++){ 
    	if(cdata[i].userName == manage){
    		$("#manage").combobox('setValue',cdata[i].userName);
    		$("#manage").combobox('setText',cdata[i].fullName);
    	}
    } 
   // $("#engineer").combobox("setText",res[0].engineer);
   // $("#manage").combobox("setText",res[0].manage);
    
   document.getElementById("Coordinator").value=res[0].coordinator;
     $("#deadline").textbox("setValue",formatDatebox(res[0].deadline)); 
    $("#create_time").textbox("setValue",formatDatebox(res[0].create_time)); 
      $("#endtime").textbox("setValue",formatDatebox(res[0].endtime));  

 });
}







//test
function getTest(){
	
	
	$('#testdg').datagrid({
	    height: '100%',
	    fit:true,
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
	       // { field: 'ck', checkbox: true  },
	        { field: 'name', title: 'Name', width: '16.5%',align:'center'},
	        { field: 'status', title: 'Status', width: '16.5%',align:'center'},
		    { field: 'version', title: 'Version', width: '16.5%',align:'center'},
	        { field: 'size', title: 'Size', width: '16.5%',align:'center'},
	        { field: 'createtime', title: 'Created',  width: '16.5%',align:'center'}, 
	        { field: 'createby',title: 'UploadBy', width:'16.5%',align:'center'}//,
	     /**   { field:'test',title:'action',width:'10%',align:'center',  
            formatter:function(value,rec){  
            	var btn = "";
                btn = '<a class="linkbutton" onclick="testeditBean(this)">Download</a>';
              
                return btn;  
            }}	*/
	       
	    ]],
	//onLoadSuccess:function(data){  
    //    $('.linkbutton').linkbutton({text:'Download',plain:true,iconCls:'icon-add'});  
      
   // }  
	   // ,

	   // onDblClickRow :function(rowIndex,rowData){
	   // 	testeditBean(rowData);
	  //	}
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
     //   $('#testdlg').dialog('open').dialog('setTitle','');
      //  $('#testfm').form('load',row);
        
     
      var  testurl = '<%=basePath%>framework/info/downloadTest.action';  
       $.get(testurl, function(result){    });  
      //  $('#testftitle').html("Modify A File");
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


//document

function getDoc(){
	
	
	$('#docdg').datagrid({
	    height: '100%',
	    fit:true,
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
	        { field: 'createby',title: 'UploadBy', width:'16.5%',align:'center'},
	        { field:'doc',title:'action',width:'10%',align:'center',  
            formatter:function(value,rec){  
            	var btn = "";
                btn = '<a class="linkbutton" onclick="doceditBean(this)">Download</a>';
              
                return btn;  
            }}	
	       
	    ]],
	onLoadSuccess:function(data){  
        $('.linkbutton').linkbutton({text:'Download',plain:true,iconCls:'icon-add'});  
      
    } 
	    //,

	   // onDblClickRow :function(rowIndex,rowData){
	   // 	doceditBean(rowData);
	  // 	}
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
       // $('#docdlg').dialog('open').dialog('setTitle','');
       // $('#docfm').form('load',row);
        
     
        docurl = '<%=basePath%>framework/info/downloadDoc.action';    
       // $('#docftitle').html("Modify A File");
        $.get(docurl, function(result){    });
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
	    height: '100%',
	    fit:true,
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
	        { field:'test',title:'action',width:'10%',align:'center',  
            formatter:function(value,rec){  
            	var btn = "";
                btn = '<a class="linkbutton" onclick="certeditBean(this)">Download</a>';
              
                return btn;  
            }}	
	       
	    ]],
	onLoadSuccess:function(data){  
        $('.linkbutton').linkbutton({text:'Download',plain:true,iconCls:'icon-add'});  
      
    } 

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
        
      //  $('#certdlg').dialog('open').dialog('setTitle','');
      //  $('#certfm').form('load',row);
        
     
        certurl = '<%=basePath%>framework/info/downloadCert.action';  
        $.get(certurl, function(result){    });
          
      //  $('#certftitle').html("Modify A File");
    }
}


function copyFile(){    
        var url='<%=basePath %>console/biz/fileinfo/copyfile.jsp?fileno='+fileno+'&pono='+pono+'&psno='+psno;
        window.location.href = url;		
}
function closeFile(){
	    $('#infofm').form('submit',{
        url:  '<%=basePath%>framework/file/addclose.action',
        onSubmit: function(){
            return $(this).form('validate');
        },
        success: function(result){
           // $('#dlg').dialog('close');        // close the dialog
           // $('#dg').datagrid('reload');    // reload the user data
        }
    });

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
	    height: '100%',
	    fit:true,
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
	    toolbar:"#acttoolbar",
	    checkOnSelect:false,
	    selectOnCheck:false,  
	    columns: [[  
	       { field: 'ck', checkbox: true },
	        { field: 'actionTime', title: 'Date', width: '16.5%',align:'center'},
	        { field: 'userName', title: 'User', width: '16.5%',align:'center'},
		    { field: 'actions', title: 'Actions', width: '16.5%',align:'center'},
	        { field: 'infonmation', title: 'Infonmation', width: '16.5%',align:'center'},
	        { field: 'reason', title: 'Reason',  width: '16.5%',align:'center'} 	       	        
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
	    height: '100%',
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

function save1(){ 
	    
        $('#infofm').form('submit',{
        url:  '<%=basePath%>framework/file/add.action',
        onSubmit: function(){
            return $(this).form('validate');
        },
        success: function(result){
         s=true;
           // $('#dlg').dialog('close');        // close the dialog
           // $('#dg').datagrid('reload');    // reload the user data
           var isDraft = $("input[name=draft]").val();
           if(isDraft == 1){
           		alert("草稿保存成功！");
           		todoAdd();
           } 
        }
    });
}

var url;
function sendmail(){
  if(s){
		 
		return s;
	}
  $("input[name=draft]").val(0);
	
    $('#smdlg').dialog('open').dialog('setTitle',' ');  
    
    url = '<%=basePath%>framework/mail/send.action';
    $('#smftitle').html("Send An Email");
}

function saveBean(){	 
    $("#smfm").form('submit',{
        url: url,
        onSubmit: function(){
            return $(this).form('validate'); 
        },
        success: function(result){ 
 			save1();	
 			todoAdd();
            $('#smdlg').dialog('close'); 
          //  $("#datstab").tabs("select", 'Test Record');       // close the dialog 
        }
    });
}
function todoAdd(){
		
		//预制一些数据
		var itemname = "File";
		var itemid = fileno;
		var itemurl = "<%=basePath %>console/biz/fileinfo/approve_file.jsp?fileno="+fileno;
		//var reviewer = "<%=com.solar.tech.util.Current.user().getUserName()%>";
		var reviewer = 	$("#smto").combobox("getText");		
		var draft = $("input[name='draft']").val();
        $.post('<%=basePath%>framework/todo/add.action',{itemname:itemname,itemid:itemid, itemurl:itemurl, reviewer:reviewer,draft:draft},function(result){
            if (result.success){
             // alert("seccuss ")             	
            } else {

            }
        },'json'); 	
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
<body  style="text-align:center;background:#F0F0F0;">
   
    <div id="datstab" class="easyui-tabs" style="width:100%;height:580px;">
    <div id="FileInfo" title="FileInfo" style="padding:20px;;background:#F0F0F0;">
	   <div style="width:100%;">
       <div  style="border: 1px solid #ccc;">
       <table>
       <tr> <td> <label >PO No.:</label></td> <td> <input name="po_no" type="text" id="ipono" readOnly="true"/></td> <td> <label >Customer</label></td> <td> <input name="customer"type="text" id="icust" /></td> <td><label >Start time</label> </td><td><input name="start_time" type="text" id="istart"/></td><td> <label >Complete time</label></td><td> <input name="complete_time" type="text" id="icomp" />  </td></tr>    
          <tr><td><label >Project No.;</label></td> <td> <input name="proj_no" type="text" id="ipsno" /></td> <td><label >Project description</label></td> <td> <input name="proj_desc" type="text" id="iproj" /></td> <td> <label >Manufacturer</label> </td> <td><input name="manufacturer" type="text" id="imanu"/></td> <td> <label >Make</label> </td> <td><input name="make"type="text" id="imake" /> </td> </tr>
          <tr><td> <label >IA status</label> </td> <td> <input name="ia_status" type="text" id="iia" /> </td><td>  </td><td>  </td><td>  </td><td>  </td><td>  </td><td>  </td></tr>
          </table>
       </div>
       
       <div style="width:100%;height:25px"> </div>
      <div style="border: 1px solid #ccc;">
      <form id="infofm" method="post" enctype="multipart/form-data" novalidate>
      <input id="ipono" name="pono" value="<%=pono %>" type="hidden">
      <input id="draft" name="draft" value="1" type="hidden">
	  <input id="iprojno" name="projno" value="<%=psno %>" type="hidden">		
      <table>      
      <tr><td><label >From</label> </td> <td><input name="from" id="from" class="easyui-textbox" data-options="required:true,validType:['length[3,15]']" /></td> <td><label >File No. </label></td> <td>
       <!-- input name="file_no" type="text" id="ifileno"  data-options="validType:['length[3,15]', 'isExist']"/--> 
       		<select name="file_no" id="ifileno"  style="width:160px"> </select>
       
       </td><td><label >Type</label></td> <td> <input name="type" id="type" class="easyui-textbox" data-options="required:true,validType:['length[3,50]']" /></td><td><label >Standard</label></td> <td> <input name="standard" id="standard" class="easyui-textbox" data-options="required:true,validType:['length[3,15]']"/> </td></tr>
      <tr><td><label >NAST project No.</label></td> <td> <input name="nast_proj_no"  id="nast_proj_no" data-options="validType:['length[3,15]']"/></td> <td><label >NAST report No.</label></td> <td> <input name="nast_rep_no" id="nast_rep_no" data-options="validType:['length[3,15]']" /> </td> <td><label >IDIADA report No.</label></td> <td> <input name="idi_rep_no" id="idi_rep_no" data-options="validType:['length[3,15]']" /></td> <td> <label >Hestocon order No.</label> </td> <td><input name="hest_or_no" id="hest_or_no" data-options="validType:['length[3,15]']" /> </td></tr>
      <tr><td><label >Hestocon report No.</label></td> <td> <input name="hest_rep_no" id="hest_rep_no" data-options="validType:['length[3,15]']"/></td> <td><label >Certificate No.</label></td> <td> <input name="cert_no" id="cert_no" data-options="validType:['length[3,15]']"/></td> <td><label >File type</label></td><td> <input name="file_type" id="file_type" data-options="validType:['length[3,15]']"/></td><td><label >Rev / Ext.</label></td><td> <input name="rev_ext" id="rev_ext" data-options="validType:['length[3,15]']"/> </td></tr>
      <tr><td><label >Status</label> </td> <td><input name="status" id="status" data-options="validType:['length[3,15]']"/></td> <td><label >Category</label></td><td> <input name="category" id="category" data-options="required:true,validType:['length[3,15]']" /></td> <td> <label >Engineer</label> </td><td><input name="engineer" id="engineer" data-options="required:true,validType:['length[3,15]']"/></td><td> <label >Manager</label> </td><td><input name="manage" id="manage" data-options="required:true,validType:['length[3,15]']"/></td></tr>
      <tr><td><label >Coordinator</label> </td><td><input name="Coordinator" id="Coordinator" data-options="validType:['length[3,15]']" /></td><td><label >Deadline</label></td><td> <input name="deadline" id ="deadline" data-options="required:true" class="easyui-datebox" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})"/></td><td> <label >Create time</label></td><td> <input name="create_time" id="create_time" data-options="required:true"  class="easyui-datebox" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})"/></td><td><label >End time</label></td><td> <input name="endtime"id="endtime" class="easyui-datebox" data-options="required:true" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd '})" /> </td></tr>
       </table>       
       </form>
       </div>
        <div style="width:100%;height:25px"> </div>
        <div>     
           
      	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="infosaveBean()">Save</a>&nbsp;&nbsp;       	     	 
      	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="sendmail()">Save And SendMail </a>&nbsp;&nbsp;
	    <!--a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="closeFile()">Close</a>&nbsp;&nbsp; 
	    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="approve()">Approve</a>&nbsp;&nbsp;	         	
	    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="copyFile()">Copy</a>&nbsp;&nbsp;		
	    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="reopenFile()">Reopen</a>&nbsp;&nbsp;  -->    	       	 
      </div>

      
      <div style="border: 1px solid #ccc;" > 
      <div id="doc_flow" style="width: 100%;height:100px"></div>
      </div>
      </div>
      		
      				
          </div>
      <div title="Test Record"  style="padding:20px;background:#F0F0F0">


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
      <input id="tpono" name="pono" value="" type="hidden">
	  <input id="tprojno" name="psno" value="" type="hidden">
	 <input id="tfileno" name="fileno" value="" type="hidden">				
			<table><tr><td><label>Test Document:</label></td><td><input type="file" name="uploadtest" id=""></td></tr></table>
			  		 				 
		</form>
	</div>
	<div id="testdlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" onclick="testsaveBean()" style="width: 90px">save</a>
			 <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#testdlg').dialog('close')" style="width: 90px">cancle</a>
	</div>
  

			
			</div>
    <div title="Information Document"  style="padding:20px;background:#F0F0F0">
		
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
	  <input id="dprojno" name="psno" value="<%=psno %>" type="hidden">
	 <input id="dfileno" name="fileno"  value="" type="hidden">	
			
			<table><tr><td><label> Document:</label></td><td><input type="file" name="uploadtest" id=""></td></tr></table>
			  		 				 
		</form>
	</div>
	<div id="docdlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" onclick="docsaveBean()" style="width: 90px">save</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel" onclick="javascript:$('#docdlg').dialog('close')"
			style="width: 90px">cancle</a>
	</div>		
				
		
    </div>
    
    <div title="Certificates"  style="padding:20px;background:#F0F0F0">
		
		
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
	  <input id="cprojno" name="psno" value="<%=psno %>" type="hidden">
	 <input id="cfileno" name="fileno" id ="cfileno" value="" type="hidden">	

			<table><tr><td><label>Certificate:</label></td><td> <input type="file" name="uploadtest" id=""></td></tr></table>
			
			  		 				 
		</form>
	</div>
	<div id="certdlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" onclick="certsaveBean()" style="width: 90px">save</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel" onclick="javascript:$('#certdlg').dialog('close')"
			style="width: 90px">cancle</a>
	</div>		

		
    </div>
    
    <div title="Action"  style="padding:20px;background:#F0F0F0">
		
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
			<input id="afileno" name="file_no"  value="" type="hidden">	
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
			iconCls="icon-ok" onclick="actsaveBean()" style="width: 90px">save</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel" onclick="javascript:$('#actdlg').dialog('close')"
			style="width: 90px">cancle</a>
	</div>		
		
		
		
			
    </div>
    
    <div title="Comment"  style="padding:20px;background:#F0F0F0">
		
	<div id="commdg" style="width: 100%;height:100%"></div>
	<div id="commtoolbar">
		<!-- a href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-add" plain="true" onclick="commnewBean()">Add Comment</a--> 
	</div>

	<div id="commdlg" class="easyui-dialog"
		style="width: 580px; height: 450px; padding: 10px 20px" closed="true"
		buttons="#commdlg-buttons">
		<div class="ftitle" id="ftitle"></div>
		<form id="commfm" method="post" enctype="multipart/form-data" novalidate>
			<input id="commentuuid" name="commentuuid"  type="hidden">
			<input id="ofileno" name="file_no"   value="" type="hidden">
			<input id="comproj_no" name="proj_no" value="<%=psno %>" type="hidden">
			<input id="comuserName" name="userName"  type="hidden">			

           <table>
           <tr>
            <td><label>Comment:</label></td>
            <td> <input name="comment" class="easyui-textbox" data-options="required:true,validType:['length[3,15]']"  /></td>
            </tr>                      
           </table>
   		 	
		</form>
	</div>
	<div id="commdlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" onclick="commsaveBean()" style="width: 90px">save</a>
			 <a	href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel" onclick="javascript:$('#commdlg').dialog('close')"
			style="width: 90px">cancle</a>
	</div>


	 <div id="smdlg" class="easyui-dialog" style="width: 580px; height: 450px; padding: 10px 20px" closed="true" buttons="#smdlg-buttons">
	  <div class="ftitle" id="smftitle"></div>
		<form id="smfm" method="post" enctype="multipart/form-data" novalidate>
				
			<table>
			<tr><td></td><td></td></tr>
			<tr><td><label>To:</label></td><td> <input name="to"  id="smto" type="text" class="easyui-textbox" style="width:350px" data-options="required:true" /></td></tr>				
			<tr><td><label>Subject:</label></td><td><input name="subject" type="text" class="easyui-textbox" style="width:350px" data-options="required:true"/></td></tr>			
			<tr><td align="top">Body:</td><td><textarea name="body" Columns="50" data-options="required:true" TextMode="MultiLine" style="width:350px; height:300px; word-wrap:break-word; word-break:break-all;" ></textarea></td></tr>						
			</table>			  		 													   
		</form>
	</div>
	<div id="smdlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" onclick="saveBean()" style="width: 90px">Send</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel" onclick="javascript:$('#smdlg').dialog('close')"
			style="width: 90px">cancle</a>
	</div>	



		
    </div>
    
    </div>
</body>
</html>