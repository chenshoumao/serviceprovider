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
         if (title=="Test Report"){
           getTestReport();
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
 	  
var findPonoUrl = "<%=basePath %>framework/file/findProjno.action?fileno=<%=fileno%>";
 
$.getJSON(findPonoUrl, function(data) {
	var psno = data[0][0].proj_no;
 
 
	 
var managerUrl = '<%=basePath %>framework/group/showMembers.action?groupId=6';
$.getJSON(managerUrl, function(m) { 
	var json = m.rows;
	$('#manage').combobox({
	data : json, 
	valueField:'email',
	textField:'userName'
	});
	});



 
 var url11 = "<%=basePath %>framework/file/find.action?psno="+ psno;
 
$.getJSON(url11, function(res) {

 
     //alert(res[0]);          
    document.getElementById("ipono").value=res[0][0].po_no ;
    document.getElementById("icust").value=res[0][0].customer;
    document.getElementById("istart").value=formatDatebox(res[0][0].start_time);
    document.getElementById("icomp").value=formatDatebox(res[0][0].complete_time);
	
    document.getElementById("ipsno").value=res[0][1].proj_no;
    $("#filePono").val(res[0][0].po_no);
    $("#fileProjno").val(res[0][1].proj_no);
    document.getElementById("imake").value=res[0][1].make;
    document.getElementById("iproj").value=res[0][1].proj_desc;	
    document.getElementById("imanu").value=res[0][1].manufacturer;
    document.getElementById("iia").value=res[0][1].ia_status;
    document.getElementById("engineer").value=res[0][1].engineer;
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
	
	var draftUrl = "<%=basePath %>framework/file/findfile.action?fileno=<%=fileno%>";
	 
$.getJSON(draftUrl, function(res) { 
    $("#from").textbox('setValue',res[0].from);
    $("#id_file_item").val(res[0].id_file_item); 
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
    
    //var engineer = res[0].engineer;
    
   
    
  // $("#engineer").textbox("setValue",res[0].engineer);
   // $("#manage").combobox("setText",res[0].manage);
    
   $("#Coordinator").textbox('setValue',res[0].coordinator);
     $("#deadline").textbox("setValue",formatDatebox(res[0].deadline)); 
    $("#create_time").textbox("setValue",formatDatebox(res[0].create_time)); 
      $("#endtime").textbox("setValue",formatDatebox(res[0].endtime));  
      
   var str  = res[0].proj_no;
  
   var substr = str.substr(str.lastIndexOf('-')+1,str.length);
 
  if(substr == "IDI" || substr == "ORDER"){
   		$("#nast_proj_no").attr('readonly','readonly');
   		$("#nast_proj_no").css('background-color','#ccc');
  		$("#nast_rep_no").attr('readonly','readonly');
  		$("#nast_rep_no").css('background-color','#ccc');
 		$("#hest_or_no").attr('readonly','readonly');
 		$("#hest_or_no").css('background-color','#ccc');
   		$("#hest_rep_no").attr('readonly','readonly');
   		$("#hest_rep_no").css('background-color','#ccc');
   		
  }
 
 });

 });
 })
 

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

function getRandom(n){
        return Math.floor(Math.random()*n+1)
        } 
function infosaveBean(){
	if(s){ 
		return s;
	}
	var isDraft = $("input[name=draft]").val();
    $('#infofm').form('submit',{
        url:  '<%=basePath%>framework/file/update.action',
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
	        { field: 'ck', checkbox: true  },
	        { field: 'name', title: 'Name', width: '16.5%',align:'center',
	          formatter:function(value,rec){  
	         	 
            	var a = "";
                a = '<a style="cursor:pointer;" onclick="downloadByName(this)">'+value+'</a>';
                
                return a;  
            }},
	        { field: 'status', title: 'Status', width: '16.5%',align:'center'},
		    { field: 'version', title: 'Version', width: '16.5%',align:'center'},
	        { field: 'size', title: 'Size', width: '16.5%',align:'center'},
	        { field: 'createtime', title: 'Created',  width: '16.5%',align:'center'}, 
	        { field: 'createby',title: 'UploadBy', width:'16.5%',align:'center'},
	      	{ field:'path',title:'action',width:'10%',align:'center',  
            formatter:function(value,rec){  
            	var btn = "";
                btn = '<a value="'+value+'" class="linkbutton" onclick="testeditBean(this)">Download</a>';
                
                return btn;  
            }}	
	       
	    ]], 
	    onLoadSuccess:function(data){  
        $('.linkbutton').linkbutton({text:'Download',plain:true,iconCls:'icon-add'});  
    } 
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
    $('#testftitle').html("Upload A Test");
}
//var fitemPassword;
function testeditBean(a){ 
	  console.log($(a).attr("value"));	
      var  testurl = '<%=basePath%>framework/info/downloadTest.action?path='+$(a).attr("value"); 
      window.location.href=testurl;
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
	    height: '100%',
	    fit:true,
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
	        { field: 'name', title: 'Name', width: '16.5%',align:'center',
	         formatter:function(value,rec){  
	         	 
            	var a = "";
                a = '<a style="cursor:pointer;" onclick="downloadByName(this)">'+value+'</a>';
                
                return a;  
            }},
	        { field: 'status', title: 'Status', width: '16.5%',align:'center'},
		    { field: 'version', title: 'Version', width: '16.5%',align:'center'},
	        { field: 'size', title: 'Size', width: '16.5%',align:'center'},
	        { field: 'createtime', title: 'Created',  width: '16.5%',align:'center'}, 
	        { field: 'createby',title: 'UploadBy', width:'16.5%',align:'center'},
	      	{ field:'path',title:'action',width:'10%',align:'center',  
            formatter:function(value,rec){  
            	 
            	var btn = "";
                btn = '<a value="'+value+'" class="linkbutton" onclick="testreporteditBean(this)">Download</a>';
                
                return btn;  
            }}	
	       
	    ]], 
	    onLoadSuccess:function(data){  
        $('.linkbutton').linkbutton({text:'Download',plain:true,iconCls:'icon-add'});  
    } 
	});
}



var testreporturl;
function downloadByName(a){
	var td = $(a).parent().parent().parent().find("td");
	var length = td.length;
	var a = td.eq(length -1).find("a");
	a.click();
	
}
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
            var json = eval('(' + result + ')');  
        	if(!json.success)
        		alert("请上传格式为xlx、xlsx、doc、docx、pdf的文件！");
            $('#testreportdlg').dialog('close');        // close the dialog
            $('#testreportdg').datagrid('reload');    // reload the user data
        }
    });
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
	        { field: 'name', title: 'Name', width: '16.5%',align:'center',
	          formatter:function(value,rec){  
	         	 
            	var a = "";
                a = '<a style="cursor:pointer;" onclick="downloadByName(this)">'+value+'</a>';
                
                return a;  
            }},
	        { field: 'status', title: 'Status', width: '16.5%',align:'center'},
		    { field: 'version', title: 'Version', width: '16.5%',align:'center'},
	        { field: 'size', title: 'Size', width: '16.5%',align:'center'},
	        { field: 'createtime', title: 'Created',  width: '16.5%',align:'center'}, 
	        { field: 'createby',title: 'UploadBy', width:'16.5%',align:'center'},
	        { field:'path',title:'action',width:'10%',align:'center',  
            formatter:function(value,rec){  
            	var btn = "";
                btn = '<a value="'+value+'" class="linkbutton" onclick="doceditBean(this)">Download</a>';
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
function doceditBean(a){
	 
     docurl = '<%=basePath%>framework/info/downloadDoc.action?path='+$(a).attr("value");     
     window.location.href=docurl;
}


function docsaveBean(){
    $('#docfm').form('submit',{
        url: docurl,
        onSubmit: function(){
            return $(this).form('validate');
        },
        success: function(result){
        	var json = eval('(' + result + ')');  
        	if(!json.success)
        		alert("请上传格式为xlx、xlsx、doc、docx、pdf的文件！");
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
	        { field: 'name', title: 'Name', width: '16.5%',align:'center',
	          formatter:function(value,rec){  
	         	 
            	var a = "";
                a = '<a style="cursor:pointer;" onclick="downloadByName(this)">'+value+'</a>';
                
                return a;  
            }},
	        { field: 'status', title: 'Status', width: '16.5%',align:'center'},
		    { field: 'version', title: 'Version', width: '16.5%',align:'center'},
	        { field: 'size', title: 'Size', width: '16.5%',align:'center'},
	        { field: 'createtime', title: 'Created',  width: '16.5%',align:'center'}, 
	        { field: 'createby',title: 'UploadBy', width:'16.5%',align:'center'}, 
	        { field:'path',title:'action',width:'10%',align:'center',  
	         formatter:function(value,rec){  
            	var btn = "";
                btn = '<a value="'+value+'" class="linkbutton" onclick="certeditBean(this)">Download</a>';
                
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
     
      certurl = '<%=basePath%>framework/info/downloadCert.action?path='+$(row).attr("value");  
      window.location.href=certurl;
        
     
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
  var checkUnloadNumUrl = '<%=basePath %>framework/info/checkUnloadNum.action?fileno='+fileno;
   $.getJSON(checkUnloadNumUrl, function(data) {
 	 var length = data.length;
  	 var managerText = $("#manage").combobox("getText");   
  	 if(length == 3 && managerText != ""){
  	 
  	 	 $("input[name=draft]").val(0);
  	 	 $("#smto").textbox("setText",managerText);  
    	 $('#smdlg').dialog('open').dialog('setTitle',' ');   
    	 url = '<%=basePath%>framework/mail/send.action';
		 $('#smftitle').html("Send An Email"); 
	 }
     else if(managerText == ""){
		alert("请选择manager");
	 }
	 else{
	 	alert("请上传相关附件");
	 }
   });

}

	function saveBean() {
	  $('#smdlg').dialog('close');
	  var user = '<%=com.solar.tech.util.Current.user().getUserName()%>';
	  var basePath = '<%=basePath%>';
      var appendBody = "你有一条来自"+user+"的新记录需要审批，<br>"+user+"的留言是:"+$("#body").val()+"<br>"
		+"<a href="+basePath+"framework/index.action"+"'>点此链接去看看！</a>";
	  $("#body").val(appendBody);
	  $("#smto").textbox("setValue",$("#manage").combobox('getValue'));
      todoAdd();
	}
	function todoAdd() {
		//预制一些数据
		var isDraft = $('input[name=draft]').val();
		var itemurl = "<%=basePath %>console/biz/fileinfo/fileinfo_ma.jsp?fileno="+fileno+"&po_no=<%=pono%>&ps_no=+<%=psno%>&isDraft="+isDraft;
		var reviewer = 	$("#manage").combobox("getText");	
	    var pono = 	fileno;
		var draft = 0;
		var itemid = fileno;
		var status = 'To Manager';  
		var user = '<%=com.solar.tech.util.Current.user().getUserName()%>';
        $.post('<%=basePath%>framework/todo/add.action',
        		{itemname:'File',pono:pono,reviewer:reviewer,itemid:itemid,submitter:user,status:status,itemurl:itemurl,draft:0},
        function(result){
            if (result.success){
            //更新file_Item
           var updateFile = '<%=basePath%>framework/file/update.action';
            $("#manage").combobox('setValue',$("#manage").combobox('getText'));
           // $("#engineer").combobox('setValue',$("#engineer").combobox('getText'));
		 		$("#infofm").form('submit',{
        		url: updateFile,
        		onSubmit: function(){
           		   return $(this).form('validate'); 
        		}
        	});
               //更新成功,发邮件
               $("#smfm").form('submit', {
					url : url,
					onSubmit : function() {
					return $(this).form('validate');
				},
					success : function(result) {  
						$('#smdlg').dialog('close');
						alert("已将结果邮件通知"+$("#manage").textbox("getValue"));
						closeWin();
					//  $("#datstab").tabs("select", 'Test Record');       // close the dialog 
					}
				});           	
            } else {
				 closeWin();
            }
        },'json'); 	
}

function closeWin(){
	window.opener.location.reload();
  	window.opener=null;
  	window.open('','_self');
  	window.close();
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
       <tr> <td> <label >PO No.:</label></td> <td> <input name="po_no" type="text" id="ipono" readOnly="true"/></td> <td> <label >Customer</label></td> <td> <input name="customer"type="text" id="icust" readOnly="true"/></td> <td><label >Start time</label> </td><td><input name="start_time" type="text" id="istart" readOnly="true"/></td><td> <label >Complete time</label></td><td> <input name="complete_time" type="text" id="icomp" readOnly="true"/>  </td></tr>    
          <tr><td><label >Project No.;</label></td> <td> <input readOnly="true" name="proj_no" type="text" id="ipsno" /></td> <td><label >Project description</label></td> <td> <input name="proj_desc" type="text" id="iproj" readOnly="true"/></td> <td> <label >Manufacturer</label> </td> <td><input name="manufacturer" type="text" id="imanu" readOnly="true"/></td> <td> <label >Make</label> </td> <td><input name="make"type="text" id="imake" readOnly="true"/> </td> </tr>
          <tr><td> <label >IA status</label> </td> <td> <input readOnly="true" name="ia_status" type="text" id="iia" /> </td><td> <label >Engineer</label> </td><td><input readOnly="true" name="engineer" id="engineer" data-options="required:true,validType:['length[3,15]']"/></td><td>  </td><td>  </td><td>  </td><td>  </td></tr>
          </table>
       </div>
       
       <div style="width:100%;height:25px"> </div>
      <div style="border: 1px solid #ccc;">
      <form id="infofm" method="post" enctype="multipart/form-data" novalidate>
      <input id="filePono" name="pono" value="<%=pono %>" type="hidden" >
      <input id="draft" name="draft" value="1" type="hidden">
	  <input id="fileProjno" name="projno" value="<%=psno %>" type="hidden">
	  <input id="id_file_item" name="id_file_item" type="hidden">		
	  <input id="itemurl" name="itemurl" type="hidden">
	  <input id="fileApprove" name="fileApprove" value="1"  type="hidden">
			
      <table>      
      <tr><td><label>From</label> </td> <td><input name="from" id="from" class="easyui-textbox" data-options="required:true,validType:['length[3,15]']"/></td> <td><label >File No. </label></td> <td>
       <!-- input name="file_no" type="text" id="ifileno"  data-options="validType:['length[3,15]', 'isExist']"/--> 
       		<select name="file_no" id="ifileno"  style="width:160px"> </select>
       
       </td><td><label >Type</label></td> <td> <input name="type" id="type" class="easyui-textbox" data-options="required:true,validType:['length[3,50]']"/></td><td><label >Standard</label></td> <td> <input name="standard" id="standard" class="easyui-textbox" data-options="required:true,validType:['length[3,15]']"/> </td></tr>
      <tr><td><label >NAST project No.</label></td> <td> <input name="nast_proj_no"  id="nast_proj_no" data-options="validType:['length[3,15]']"/></td> <td><label >NAST report No.</label></td> <td> <input name="nast_rep_no" id="nast_rep_no" data-options="validType:['length[3,15]']"/> </td> <td><label >IDIADA report No.</label></td> <td> <input name="idi_rep_no" id="idi_rep_no" data-options="validType:['length[3,15]']"/></td> <td> <label >Hestocon order No.</label> </td> <td><input name="hest_or_no" id="hest_or_no" data-options="validType:['length[3,15]']"/> </td></tr>
      <tr><td><label >Hestocon report No.</label></td> <td> <input name="hest_rep_no" id="hest_rep_no" data-options="validType:['length[3,15]']"/></td> <td><label >Certificate No.</label></td> <td> <input name="cert_no" id="cert_no" data-options="validType:['length[3,15]']"/></td> <td><label >File type</label></td><td> <input name="file_type" id="file_type" data-options="validType:['length[3,15]']"/></td><td><label >Rev / Ext.</label></td><td> <input name="rev_ext" id="rev_ext" data-options="validType:['length[3,15]']"/> </td></tr>
      <tr><td><label >Status</label> </td> <td><input name="status" id="status"/></td> <td><label >Category</label></td><td> <input name="category" id="category" data-options="required:true,validType:['length[3,15]']"/></td><td> <label >Create time</label></td><td> <input name="create_time" id="create_time" data-options="required:true"  class="easyui-datebox" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})"/></td><td><label >End time</label></td><td> <input name="endtime"id="endtime" class="easyui-datebox" data-options="required:true" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd '})"/> </td></tr>
      <tr><td><label >Coordinator</label> </td><td><input name="Coordinator" id="Coordinator" class="easyui-textbox" data-options="validType:['length[3,15]']"/></td><td><label >Deadline</label></td><td> <input name="deadline" id ="deadline" data-options="required:true" class="easyui-datebox" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})"/></td>
      <td> <label >Expert</label> </td><td><input name="manage" id="manage" data-options="required:true,validType:['length[3,15]']"/></td><td></td></tr>
       </table>       
       </form>
       </div>
        <div style="width:100%;height:25px"> </div>
        <div>         	 
      	<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="sendmail()">Save And SendMail </a>&nbsp;&nbsp;
	  <!--   <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="closeFile()">Close</a>&nbsp;&nbsp; 
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
			iconCls="icon-add" plain="true" onclick="testnewBean()">UpLoad Test Record</a>
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
			iconCls="icon-add" plain="true" onclick="docnewBean()">UpLoad Infomation Document</a> 

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
      <input id="trpono" name="pono" value="" type="hidden">
	  <input id="trprojno" name="psno" value=""  type="hidden">
	 <input id="trfileno" name="fileno" value=""  type="hidden">				
			<table><tr><td><label>Test Report:</label></td><td><input type="file" name="uploadtest" id=""></td></tr></table>
			  		 				 
		</form>
	</div>
	<div id="testreportdlg-buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton c6"
			iconCls="icon-ok" onclick="testreportsaveBean()" style="width: 90px">save</a>
			 <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#testreportdlg').dialog('close')" style="width: 90px">cancle</a>
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
			<tr><td><label>To:</label></td><td> <input name="to"  id="smto" readonly="readonly" type="text" class="easyui-textbox" style="width:350px" data-options="required:true" /></td></tr>				
			<tr><td><label>Subject:</label></td><td><input name="subject" type="text" class="easyui-textbox" style="width:350px" data-options="required:true"/></td></tr>			
			<tr><td align="top">Body:</td><td><textarea name="body" id="body" Columns="50" data-options="required:true" TextMode="MultiLine" style="width:350px; height:300px; word-wrap:break-word; word-break:break-all;" ></textarea></td></tr>						
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