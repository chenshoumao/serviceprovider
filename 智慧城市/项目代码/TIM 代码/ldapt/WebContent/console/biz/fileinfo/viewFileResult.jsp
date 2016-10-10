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
  
//file info 
       var fno;
 	    var fileno;    
 	    var psno;
 	    var pono;
 	  
var findPonoUrl = "<%=basePath %>framework/file/findProjno.action?fileno=<%=fileno%>";
 
$.getJSON(findPonoUrl, function(data) {
	var psno = data[0][0].proj_no;
	
var url13 = "<%=basePath %>framework/todo/find.action?pono=<%=fileno %>";
$.getJSON(url13, function(res) {   
    $("#opinion").val(res.opinion); 
    
 });
 
 var url11 = "<%=basePath %>framework/file/find.action?psno="+ psno;
 $.getJSON(url11, function(res) {

 
     //alert(res[0]);          
    document.getElementById("ipono").value=res[0][0].po_no;
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
 	

    
   	 
	fno=fdvalue ; 
	fileno=fdvalue ; 
	
	var draftUrl = "<%=basePath %>framework/file/findfile.action?fileno=<%=fileno%>";
	 
$.getJSON(draftUrl, function(res) { 
    $("#from").textbox('setValue',res[0].from);
    $("#id_file_item").val(res[0].id_file_item); 
    document.getElementById("ifileno").options.length=0;
    $("#ifileno").append("<option value=''> </option><option value='"+res[0].file_no+"' selected='true'>"+res[0].file_no+"</option>");    
 	  
     
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
  
   // $("#engineer").combobox("setText",res[0].engineer);
   
    $("#manage").val(res[0].manage);
    
   $("#Coordinator").textbox('setValue',res[0].coordinator);
     $("#deadline").textbox("setValue",formatDatebox(res[0].deadline)); 
    $("#create_time").textbox("setValue",formatDatebox(res[0].create_time)); 
      $("#endtime").textbox("setValue",formatDatebox(res[0].endtime));  
 
 });

 });
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

function DownloadAccessory(obj){
	var str = $(obj).find('.l-btn-text').text();
	var fileno = $('#ifileno').val();
	if(str=='Download Test Record'){
		$.get('<%=basePath%>framework/dl/findTest.action',{fileno:fileno},function(result){
			var path = result.path;
			var filename = result.name;
			window.location.href = '<%=basePath %>framework/dl/down.action?fileUrl='+path+'&filename='+filename;
		},'json');
	}
	if(str=='Download Infomation Document'){
		$.get('<%=basePath%>framework/dl/findDoc.action',{fileno:fileno},function(result){
			var path = result.path;
			var filename = result.name;
			window.location.href = '<%=basePath%>framework/info/downloadDoc.action?path='+path;
		},'json');
	}
	if(str=='Download Certificates'){
		$.get('<%=basePath%>framework/dl/findCert.action',{fileno:fileno},function(result){
			var path = result.path;
			var filename = result.name;
			window.location.href = '<%=basePath%>framework/info/downloadCert.action?path='+path;
		},'json');
	}
	if(str=='Download Test Report'){
		$.get('<%=basePath%>framework/dl/findReport.action',{fileno:fileno},function(result){
			var path = result.path;
			var filename = result.name;
			window.location.href = '<%=basePath%>framework/info/downloadTestreport.action?path='+path;
		},'json');
	}
}
</script>

<title>Insert title here</title>
</head>
<body  style="text-align:center;background:#F0F0F0;">
   
    <div id="datstab" class="easyui-tabs" style="width:100%;height:580px;">
    <div id="FileInfo" title="FileInfo" style="padding:20px;;background:#F0F0F0;">
	   <div style="width:100%;">
       <div  style="border: 1px solid #ccc;">
       <table>
       <tr> <td> <label >PO No.:</label></td> <td> <input name="po_no" type="text" id="ipono" readOnly="true"/></td> <td> <label >Customer</label></td> <td> <input readOnly="true" name="customer"type="text" id="icust" /></td> <td><label >Start time</label> </td><td><input readOnly="true" name="start_time" type="text" id="istart"/></td><td> <label >Complete time</label></td><td> <input readOnly="true" name="complete_time" type="text" id="icomp" />  </td></tr>    
          <tr><td><label >Project No.;</label></td> <td> <input readOnly="true" name="proj_no" type="text" id="ipsno" /></td> <td><label >Project description</label></td> <td> <input readOnly="true" name="proj_desc" type="text" id="iproj" /></td> <td> <label >Manufacturer</label> </td> <td><input readOnly="true" name="manufacturer" type="text" id="imanu"/></td> <td> <label >Make</label> </td> <td><input readOnly="true" name="make"type="text" id="imake" /> </td> </tr>
          <tr><td> <label >IA status</label> </td> <td> <input readOnly="true" readOnly="true" name="ia_status" type="text" id="iia" /> </td><td><label>Engineer:</label></label></td><td><input name="engineer" id="engineer" readonly="readonly"> </td><td>  </td><td>  </td><td>  </td><td>  </td></tr>
          </table>
       </div>
       
       <div style="width:100%;height:25px"> </div>
      <div style="border: 1px solid #ccc;">
      <form id="infofm" method="post" enctype="multipart/form-data" novalidate>
      <input id="filePono" name="pono" value="<%=pono %>" type="hidden" >
      <input id="draft" name="draft" value="1" type="hidden">
	  <input id="fileProjno" name="projno" value="<%=psno %>" type="hidden">
	  <input id="id_file_item" name="id_file_item" type="hidden">		
      <table>      
      <tr><td><label >From</label> </td> <td><input name="from" id="from" class="easyui-textbox" data-options="required:true,validType:['length[3,15]']" readOnly="true" /></td> <td><label >File No. </label></td> <td>
       <!-- input name="file_no" type="text" id="ifileno"  data-options="validType:['length[3,15]', 'isExist']"/--> 
       		<select name="file_no" id="ifileno"  style="width:160px"> </select>
       
      </td><td><label >Type</label></td> <td> <input name="type" id="type" class="easyui-textbox" data-options="required:true,validType:['length[3,50]']" readOnly="true"/></td><td><label >Standard</label></td> <td> <input name="standard" id="standard" class="easyui-textbox" data-options="required:true,validType:['length[3,15]']" readOnly="true"/> </td></tr>
      <tr><td><label >NAST project No.</label></td> <td> <input name="nast_proj_no"  id="nast_proj_no" data-options="validType:['length[3,15]']"readOnly="true"/></td> <td><label >NAST report No.</label></td> <td> <input name="nast_rep_no" id="nast_rep_no" data-options="validType:['length[3,15]']"readOnly="true" /> </td> <td><label >IDIADA report No.</label></td> <td> <input name="idi_rep_no" id="idi_rep_no" data-options="validType:['length[3,15]']"readOnly="true" /></td> <td> <label >Hestocon order No.</label> </td> <td><input name="hest_or_no" id="hest_or_no" data-options="validType:['length[3,15]']"readOnly="true" /> </td></tr>
      <tr><td><label >Hestocon report No.</label></td> <td> <input name="hest_rep_no" id="hest_rep_no" data-options="validType:['length[3,15]']"readOnly="true"/></td> <td><label >Certificate No.</label></td> <td> <input name="cert_no" id="cert_no" data-options="validType:['length[3,15]']"readOnly="true"/></td> <td><label >File type</label></td><td> <input name="file_type" id="file_type" data-options="validType:['length[3,15]']"readOnly="true"/></td><td><label >Rev / Ext.</label></td><td> <input name="rev_ext" id="rev_ext" data-options="validType:['length[3,15]']"readOnly="true"/> </td></tr>
      <tr><td><label >Status</label> </td> <td><input name="status" id="status" data-options="validType:['length[3,15]']" readOnly="true"/></td> <td><label >Category</label></td><td> <input name="category" id="category" data-options="required:true,validType:['length[3,15]']" readOnly="true"/></td><td> <label >Create time</label></td><td> <input name="create_time" id="create_time" data-options="required:true"  class="easyui-datebox" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})"readOnly="true"/></td><td><label >End time</label></td><td> <input name="endtime"id="endtime" class="easyui-datebox" data-options="required:true" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd '})"readOnly="true" /> </td></tr>
      <tr><td><label >Coordinator</label> </td><td><input name="Coordinator" id="Coordinator" class="easyui-textbox" data-options="validType:['length[3,15]']" readOnly="true"/></td><td><label >Deadline</label></td><td> <input name="deadline" id ="deadline" data-options="required:true" class="easyui-datebox" onfocus="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})"readOnly="true"/></td><td> <label >Manager</label> </td><td><input name="manage" id="manage" readOnly="true" data-options="required:true,validType:['length[3,15]']"/></td><td></td></tr>
      <tr>
	 	<td>Opinion</td>
		<td colspan="7" style="padding-left:-20px;">
			<textarea readonly="readonly" id="opinion" style="width: 965px;"></textarea>
		</td>
	 
	 </tr>
       </table>       
       </form>
       </div>
       	<a class="easyui-linkbutton" iconCls="icon-add" onclick="DownloadAccessory(this);">Download Test Record</a>
       	<a class="easyui-linkbutton" iconCls="icon-add" onclick="DownloadAccessory(this);">Download Infomation Document</a>
       	<a class="easyui-linkbutton" iconCls="icon-add" onclick="DownloadAccessory(this);">Download Test Report</a>
       	<a class="easyui-linkbutton" iconCls="icon-add" onclick="DownloadAccessory(this);">Download Certificates</a>
      </div>
      </div>
          </div>
    </div>
</body>
</html>