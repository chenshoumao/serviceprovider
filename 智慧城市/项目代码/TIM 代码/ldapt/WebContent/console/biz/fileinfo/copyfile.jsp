<%@page import="com.solar.tech.bean.File_Item"%>
<%@page import="com.solar.tech.bean.UploadDoc"%>
<%@page import="com.solar.tech.bean.UploadTest"%>
<%@page import="com.solar.tech.bean.UploadCert"%>
<%@page import="com.solar.tech.bean.Action"%>
<%@page import="com.solar.tech.bean.comment"%>
<%@page import="com.solar.tech.bean.User"%>
<%@ page import="com.solar.tech.exception.ResultCode"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<% 
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
	
	String pono=request.getParameter("po_no");	
	String psno=request.getParameter("psno");
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
	
   // document.getElementById("iia").value=res[0][1].ia_status;
    /// var fno=res[0][1].proj_no+"_f"+getRandom(20);
	// alert('fno:'+fno);


 });

var fileurl = "<%=basePath %>framework/file/findfile.action?fileno=<%=fileno%>";
$.getJSON(fileurl, function(res) {
 
   $("#from").textbox('setValue',res[0].from);
   $("#type").textbox('setValue',res[0].type);
   $("#standard").textbox('setValue',res[0].standard);
   $("#nast_proj_no").val(res[0].nast_proj_no);
   $("#nast_rep_no").val(res[0].nast_rep_no);
   $("#idi_rep_no").val(res[0].idi_rep_no);
   $("#hest_or_no").val(res[0].hest_or_no);
   $("#hest_rep_no").val(res[0].hest_rep_no);
   $("#cert_no").val(res[0].cert_no);
   $("#file_type").textbox('setValue',res[0].file_type);
   $("#rev_ext").textbox('setValue',res[0].rev_ext);
   
   $("#status").val(res[0].status);
   $("#category").val(res[0].category);
   $("#deadline").datebox('setValue',res[0].deadline);
   
   var create_time = new Date(res[0].create_time); 
   $("#create_time").datebox('setValue', create_time.getFullYear()+"-"+(create_time.getMonth()+1)+"-"+create_time.getDate());

   var endtime = new Date(res[0].endtime); 
   $("#endtime").datebox('setValue', endtime.getFullYear()+"-"+(endtime.getMonth()+1)+"-"+endtime.getDate());
 });


$(function(){


$("#file_type").combobox({

onChange: function (n,o) {
  if(n == "NEW"){
  	$("#rev_ext").textbox('setValue','00');
  	//$("#rev_ext").attr({editable:false});
  }
  else{
  	//$("#rev_ext").attr({editable:true});
    var json = '[';
  	for(var i = 1;i < 99;i++){
  		json += '{"number":' + i + '},' ;
  	}
  	json += '{"number":' + i + '}]';
  	json = eval('(' + json + ')');  
  	$('#rev_ext').combobox({
	data : json, 
	valueField:'number',
	textField:'number'
	});	
  } 
}

});

$("#datstab").tabs({    
      onSelect:function(title){    
      /** if(!s&&title!='FileInfo'){
         alert("you are do not save a file!");
 
         $("#datstab").tabs("select", 'FileInfo');
        }*/
     /**    if (title=="Test Record"){
           getTest();
         };
         if (title=="Information Document"){
           getDoc();
         };
         if (title=="Certificates"){
         getCert();
         }; */        
         if (title=="Action"){
         getAction();
         };
       //  if (title=="Comment"){
       //  getComm();
       //  };
                   
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
     //根据engineer名字获取邮箱
   var emailUrl = '<%=basePath%>framework/ldap/userdetails.action?userName='+ res[0][1].engineer;
   $.getJSON(emailUrl,function(user){
   		$("#engineerEmail").val(user.email);
   		//alert(user.email);
   });
	psno=res[0][0].po_no;
    pono=res[0][1].proj_no;
  
      var d = new Date();
      var vYear = d.getFullYear().toString().substring(2);
      var vMon = d.getMonth() + 1;
      var vDay = d.getDate();
     var s=vYear+(vMon<10 ? "0" + vMon : vMon)+(vDay<10 ? "0"+ vDay : vDay);
     //alert(12121);
     //alert(s);
     var gr=getRandom(99);
     var fdvalue="D-"+s+"-"+gr;
     var fnvalue ="N-"+s+"-"+gr;
     var fvalue =s+"-"+gr;
	$("#ifileno").append("<option value='"+fvalue+"' selected='true'>"+fvalue+"</option>");    
 	
 
	fno=fdvalue ; 
	fileno=fdvalue ; 
 
	 var str  = res[0][1].proj_no;
   var substr = str.substr(str.lastIndexOf('-')+1,str.length);
   if(substr == "IDI" || substr == "ORDER"){
   		$("#nast_proj_no").attr('readonly','readonly');
   		$("#nast_rep_no").attr('readonly','readonly');
   		$("#hest_or_no").attr('readonly','readonly');
   		$("#hest_rep_no").attr('readonly','readonly');
   		
   }
   
 });
 

$("#ifileno").change(function(){
 
   var cfileno=$("#ifileno").find("option:selected").val();
   	
	fno=cfileno ;
	fileno=cfileno ; 
   
});


var CoordinatorUrl = '<%=basePath %>framework/group/showMembers.action?groupId=3';
$.getJSON(CoordinatorUrl, function(m) { 
	var json = m.rows;
	$('#Coordinator').combobox({
	data : json, 
	valueField:'userName',
	textField:'userName'
	});
	var user = '<%=com.solar.tech.util.Current.user().getUserName()%>';
	var cdata = $("#Coordinator").combobox('getData'); 
    for(var i = 0;i < cdata.length;i++){  
    	if(cdata[i].userName == user){
    		$("#Coordinator").combobox('setValue',user);
    		$("#Coordinator").combobox('setText',user);
    		break;
    	}
    } 
	if('<%=isDraft%>' == 1){ 
findDraft();
}
});



function getRandom(n){
        return Math.floor(Math.random()*n+1)
        }


function infosaveBean(){
	//alert(1113333);
	//var ttt=$("#engineer").combobox('getText');
	//alert(ttt);
	$("#engineer").combobox('setValue',$("#engineer").combobox('getText'));
	alert(s);
	/* if(s){ 
		return s;
	} */
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
           if(isDraft == '1'){
           		alert("Your fileinfo are saved !");
           }
          // $("#datstab").tabs("select", 'Test Record');
             
        }
    });
}

function findDraft(){

	var draftUrl = "<%=basePath %>framework/file/findDraft.action?fileno=<%=fileno%>";
	 
$.getJSON(draftUrl, function(res) {  
alert(res[0].from);
    $("#from").combobox('setValue',res[0].from);
     $("#from").combobox('setText',res[0].from);
    document.getElementById("ifileno").options.length=0;
    $("#ifileno").append("<option value=''> </option><option value='"+res[0].file_no+"' selected='true'>"+res[0].file_no+"</option>");    
 	 
	fno=res[0].file_no ; 
	fileno=res[0].file_no ;
	$("#deadline").textbox("setValue",formatDatebox(res[0].deadline)); 
    $("#create_time").textbox("setValue",formatDatebox(res[0].create_time)); 
      $("#endtime").textbox("setValue",formatDatebox(res[0].endtime)); 
   
    $("#type").textbox('setValue',res[0].type);
    $("#standard").textbox('setValue',res[0].standard);
        
    document.getElementById("nast_proj_no").value=res[0].nast_proj_no;
    document.getElementById("nast_rep_no").value=res[0].nast_rep_no;
    document.getElementById("idi_rep_no").value=res[0].idi_rep_no;
    document.getElementById("hest_or_no").value=res[0].hest_or_no;	
    document.getElementById("hest_rep_no").value=res[0].hest_rep_no;
    document.getElementById("cert_no").value=res[0].cert_no;
   // $("#file_type").textbox('setValue',res[0].file_type); 
   // $("#rev_ext").textbox('setValue',res[0].rev_ext); 
    alert(res[0].rev_ext);
    document.getElementById("status").value=res[0].status;
    document.getElementById("category").value=res[0].category;
   
  	var coordinator =res[0].coordinator;
   	cdata = $("#Coordinator").combobox('getData'); 
    for(var i = 0;i < cdata.length;i++){  
    	if(cdata[i].userName == coordinator){
    		$("#Coordinator").combobox('setValue',coordinator);
    		$("#Coordinator").combobox('setText',coordinator);
    		break;
    	}
    } 

 });
}







//test







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
	$("#engineer").combobox('setValue',$("#engineer").combobox('getText'));
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
           		//todoAdd();
           } 
        }
    });
}

function back(){
	history.go(-1);
	/*
	var urlback="<%=basePath%>console/biz/filelist/shows.jsp";
	window.location.href=urlback;
	*/
}
var url;
function sendmail(){
  if(s){ 
		return s;
	}
  $("input[name=draft]").val(0);
   $("#smto").textbox('setText',$('#engineer').val()); 
    $('#smdlg').dialog('open').dialog('setTitle',' '); 
   
	$('#dlg').dialog('close');
	
    url = '<%=basePath%>framework/mail/send.action';
    $('#smftitle').html("Send An Email");
}

function saveBean(){	
	$("#smto").textbox('setValue',$('#engineerEmail').val());
	$('#smdlg').dialog('close');
	 var user = '<%=com.solar.tech.util.Current.user().getUserName()%>';
	 var basePath = '<%=basePath%>';
    var appendBody = "你有一条来自"+user+"的新记录需要审批，<br>"+user+"的留言是:"+$("#body").val()+"<br>"
		+"<a href="+basePath+"framework/index.action"+"'>点此链接去看看！</a>";
	$("#body").val(appendBody);
   $("#smfm").form('submit',{
        url: url,
        onSubmit: function(){
            return $(this).form('validate'); 
        },
        success: function(result){
        	alert("已将结果邮件通知"+$("#engineer").val()); 
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
		var itemurl = "<%=basePath %>console/biz/fileinfo/approve_en.jsp?fileno="+fileno;
		//var reviewer = "<%=com.solar.tech.util.Current.user().getUserName()%>";
		var reviewer = 	$("#engineer").combobox("getText");		
		var draft = $("input[name='draft']").val();
		var status = '未转接';
        $.post('<%=basePath%>framework/todo/add.action',{itemname:itemname,itemid:itemid, itemurl:itemurl, reviewer:reviewer,draft:draft,status:status},function(result){
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
       <tr> <td> <label >PO No.:</label></td> <td> <input name="po_no" type="text" id="ipono" readOnly="true"/></td> <td> <label >Customer</label></td> <td> <input name="customer"type="text" id="icust" readonly="readonly"/></td> <td><label >Start time</label> </td><td><input name="start_time" type="text" id="istart" readonly="readonly"/></td><td> <label >Complete time</label></td><td> <input name="complete_time" type="text" id="icomp" readonly="readonly"/>  </td></tr>    
          <tr><td><label >Project No.;</label></td> <td> <input name="proj_no" type="text" id="ipsno" readonly="readonly"/></td> <td><label >Project description</label></td> <td> <input name="proj_desc" type="text" id="iproj" readonly="readonly"/></td> <td> <label >Manufacturer</label> </td> <td><input name="manufacturer" type="text" id="imanu" readonly="readonly"/></td> <td> <label >Make</label> </td> <td><input name="make"type="text" id="imake" readonly="readonly"/> </td> </tr>
          <tr><td> <label >IA status</label> </td> <td> <input name="ia_status" type="text" id="iia" readonly="readonly"/> </td><td> <label >Engineer</label> </td><td><input name="engineer" id="engineer" readonly="readonly" data-options="required:true,validType:['length[3,15]']"/></td><td>  </td></tr>
          </table>
       </div>
       
       <div style="width:100%;height:25px"> </div>
      <div style="border: 1px solid #ccc;">
      <form id="infofm" method="post" enctype="multipart/form-data" novalidate>
      <input id="ipono" name="pono" value="<%=pono %>" type="hidden">
      <input id="draft" name="draft" value="1" type="hidden">
	  <input id="iprojno" name="projno" value="<%=psno %>" type="hidden">	
      <input name="engineerEmail" id="engineerEmail" type="hidden">

      	  	
      <table>      
      <tr><td><label >From</label> </td> 
      <td>
      	<!--<input name="from" id="from" class="easyui-textbox" data-options="required:true,validType:['length[3,15]']" />-->
      	 
      	  	<select id="from" class="easyui-combobox" name="from" style="width:173px;">
			<option value="DATS">DATS</option>
			<option value="NATS">NATS</option> 
			</select>
      	 
      </td> 
      <td><label >File No. </label></td> <td>
       <!-- input name="file_no" type="text" id="ifileno"  data-options="validType:['length[3,15]', 'isExist']"/--> 
       		<select name="file_no" id="ifileno"  style="width:160px"> </select>
       
       </td><td><label >Type</label></td> <td> <input name="type" id="type" class="easyui-textbox" data-options="required:true,validType:['length[3,50]']" /></td><td><label >Standard</label></td> <td> <input name="standard" id="standard" class="easyui-textbox" data-options="required:true,validType:['length[3,15]']"/> </td></tr>
      <tr><td><label >NAST project No.</label></td> <td> <input name="nast_proj_no"  id="nast_proj_no" data-options="validType:['length[3,15]']"/></td> <td><label >NAST report No.</label></td> <td> <input name="nast_rep_no" id="nast_rep_no" data-options="validType:['length[3,15]']" /> </td> <td><label >IDIADA report No.</label></td> <td> <input name="idi_rep_no" id="idi_rep_no" data-options="validType:['length[3,15]']" /></td> <td> <label >Hestocon order No.</label> </td> <td><input name="hest_or_no" id="hest_or_no" data-options="validType:['length[3,15]']" /> </td></tr>
      <tr><td><label >Hestocon report No.</label></td> <td> <input name="hest_rep_no" id="hest_rep_no" data-options="validType:['length[3,15]']"/></td> <td><label >Certificate No.</label></td> <td> <input name="cert_no" id="cert_no" data-options="validType:['length[3,15]']"/></td>
      <td><label >File type</label></td>
      <td><!--<input name="file_type" id="file_type" data-options="validType:['length[3,15]']"/>-->
       <select id="file_type" class="easyui-combobox" name="file_type" style="width:173px;">
      	 	<option value=""></option>
			<option value="NEW">NEW</option>
			<option value="EXT">EXT</option> 
			<option value="CORR">CORR</option> 
		</select>
      
      </td><td><label >Rev / Ext.</label></td><td> <input name="rev_ext" id="rev_ext" class="easyui-textbox"/> </td></tr>
      <tr><td><label >Status</label> </td> <td><input name="status" id="status" data-options="validType:['length[3,15]']"/></td> <td><label >Category</label></td><td> <input name="category" id="category" data-options="required:true,validType:['length[3,15]']" /></td><td> <label >Create time</label></td><td> <input name="create_time" id="create_time" data-options="required:true"  class="easyui-datebox" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})"/></td><td><label >End time</label></td><td> <input name="endtime"id="endtime" class="easyui-datebox" data-options="required:true" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd '})" /> </td></tr>
      <tr><td><label >Coordinator</label> </td><td><input name="Coordinator" id="Coordinator" data-options="validType:['length[3,15]']" /></td><td><label >Deadline</label></td><td> <input name="deadline" id ="deadline" data-options="required:true" class="easyui-datebox" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})"/></td> <td></td><td></td><td>  </td><td></td></tr>
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
	    <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" plain="true" onclick="back()">Back</a>&nbsp;&nbsp;
      </div>

      
      <div style="border: 1px solid #ccc;" > 
      <div id="doc_flow" style="width: 100%;height:100px"></div>
      </div>
      </div>
     </div>
          
  
    
    
    <div title="Action"  style="padding:20px;background:#F0F0F0">
		
	<div id="actdg" style="width: 100%;height:100%"></div>
	<div id="acttoolbar">

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
		
		
		
		
			
    </div>
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
			iconCls="icon-ok" onclick="saveBean()" style="width: 90px">Send</a> <a
			href="javascript:void(0)" class="easyui-linkbutton"
			iconCls="icon-cancel" onclick="javascript:$('#smdlg').dialog('close')"
			style="width: 90px">cancle</a>
	</div>	
</div>
		
    
    
    
</body>
</html>