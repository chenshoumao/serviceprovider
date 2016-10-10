<%@page import="com.solar.tech.bean.Po_Create"%>
<%@ page import="com.solar.tech.exception.ResultCode" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
    String po_no=request.getParameter("po_no");
    String resultApprove = request.getParameter("resultApprove");
    String opinion = request.getParameter("opinion");
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

<title></title>
<style type="text/css">
* { 
	padding: 0px;
	margin: 0px;
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

	
	margin-bottom: 5px;
	width:200px;
}

.fitem input {
	width: 180px;
}

.fitem input[type=radio] {
	width: 39px;
}
.textbox .textbox-text{white-space: pre-line;}

table td{ 

 text-width:300px;
 font-size: 20px;
 font-weight: bold;
 text-align:right;
 }
#fm{width:900px;margin:0 auto;}
table tr td:nth-child(2){padding-right:30px;}
</style>
<script type="text/javascript">

	$(function(){
		var url11 = "<%=basePath %>framework/po/find.action?pono=<%=po_no%>"; 
			$.getJSON(url11, function(res) { 
    			document.getElementById("po").value=res[0].po_no ;  
   				document.getElementById("cust").value=res[0].customer;
    			document.getElementById("manu").value=res[0].maufacturer; 
    			document.getElementById("desc").value=res[0].po_desc;
    			document.getElementById("pro").value=res[0].prod_type_desc; 
    			document.getElementById("start").value=formatDatebox(res[0].start_time);
    			document.getElementById("comp").value=formatDatebox(res[0].complete_time);   
    			$("#resultApprove").val('<%=resultApprove%>');
    			$("#opinion").html('<%=opinion%>');
 });
		
		//$('#dlg').dialog('open').dialog('setTitle','Result Of Approving'); 
	}); 
	
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
<body style="text-align:center;;background:#F0F0F0;">
	 <div style="width:100%;text-align:center;;background:#F0F0F0;">
	 <div style="width:100%;height:90px;"></div>
	 <div style="width:100%;height:90px;font-size: 28px; font-weight: bold;">Create A Project Order</div>
	 <div style="border: 0px solid #ccc;">
	 <form id="fm" method="post" enctype="multipart/form-data" novalidate >
     <input name="approveResult" type="hidden">
	 <table style="margin:0 auto;">
	 <tr> <td><label >Customer:</label></td><td><input name="customer" readonly="readonly" id="cust" data-options="required:true"/></td> <td><label >Manufacturer:</label></td><td><input name="maufacturer" readonly="readonly" id="manu" data-options="required:true" /></td></tr>	 
	 <tr><td><label >PO No.: </label></td><td> <input name="po_no" readonly="readonly" id="po" type="text"	data-options="required:true,validType:['length[3,15]', 'isExist']"  /></td><td><label >PO description:</label></td><td><input name="po_desc" readonly="readonly" id="desc" data-options="required:true"  /></td> </tr>	 
	 <tr> <td><label >Product type description:</label></td><td><input readonly="readonly" name="prod_type_desc" id="pro"	data-options="required:true"/></td><td></td><td></td></tr>	 
	 <tr> <td><label >Start time :</label></td ><td> <input readonly="readonly" name="start_time" id="start" type="text"data-options="required:true" />	</td><td><label>Complete time: </label></td><td> <input readonly="readonly" name="complete_time" id="comp" type="text" data-options="required:true"/></td></tr>	 
	 <tr> <td><label >ResultOfApprove :</label></td><td ><input type="text" readonly="readonly" id="resultApprove"/></td><td></td><td ><!--button type="button" >Approve</button--></tr>
	 <tr><td><label >Opinion :</label></td>
	 	<td colspan="3"><textarea name="opinion" id="opinion" readonly="readonly"  style="width:480px;
				 height:80px; word-wrap:break-word; word-break:break-all;"  ></textarea>
				 </td>
	 </tr>	
	 </table>  
	 </form>
	 </div>
	</div>
</body>
</html>