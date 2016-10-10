<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
    String path = request.getContextPath();  
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head> 

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<jsp:include page="/resources.jsp"></jsp:include>
<script type="text/javascript">
$(function(){ 
	 
	$('#dg').datagrid({
	    height: 'auto',
	    fit:false,
	    url: '<%=basePath %>framework/todo/shows.action',
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
	        { field: 'itemname', title: 'Name', width: '11%',align:'center'},
	        { field: 'itemid', title: 'ID', width: '11%',align:'center'},
	        { field: 'submitter', title: 'Submitter', width: '14%',align:'center'},
	        { field: 'itemstatus', title: 'Status',  width: '11%',align:'center'},
	        { field: 'approveResult', title: 'ApproveResult',  width: '11%',align:'center'},
	        { field: 'reviewer', title: 'Approver',  width: '11%',align:'center'},	 
	        { field: 'updateTime', title: 'Approvetime',  width: '11%',align:'center',formatter: function(value,row,index){
	        	if(value != '' && value != null) { 
	        		return formatDatebox(value);
	        	} 
			}},
	        { field: 'isDraft', title: 'isDraft',  width: '11%',align:'center',formatter: function(value,row,index){ 
				return (value == 1? 'Yes':'No');
			}}
	           
	    ]],  
	    onDblClickRow :function(rowIndex,rowData){ 
	    	editBean(rowData);
	   	}
	});
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

 
function editBean(row){ 
    if (row){
     	      var po_no =row.itemid;
     	      var url2=row.itemurl;
     	      var submitter= row.submitter; 
 	        //  var url=url2+'?pono='+po_no;
 	          var url=url2+"&submitter="+submitter; 
 	          var reviewer = row.reviewer;
 	          var status = row.itemstatus;
 	          var draft = row.isDraft;
 		      var itemname = row.itemname;
 	          var resultApprove = row.approveResult;
 	          var opinion = row.opinion; 
 	          var user = '<%=com.solar.tech.util.Current.user().getUserName()%>';
 	          if(row.itemname == 'Porject Order' && user == submitter && row.itemstatus != '已审批' && row.isDraft == '0'){ 
 	          		 window.open("<%=basePath%>console/biz/po/editPoAfterSend.jsp?isDraft=0&po_no="+po_no);
 	          }
 	          else if(row.itemname == 'Porject Order' || row.itemname == 'Charge' || row.itemname == 'Travel'){ 
				  if(draft!=0|| (status!='未审批' && submitter==user) || user == 'Samuelzhou'){ 
					  window.open(url2);
				  } 
				  if(draft!=0||(status=='未审批'  &&  submitter!=user) || user == 'Samuelzhou'){ 
					  window.open(url2);
				  } 
 	          }
 	          else if(row.itemname == 'File'){ 
 	        	  if(reviewer==user||(submitter==user && row.itemstatus == '已审批') || user == 'Samuelzhou'){ 
 	        		 window.open(url2);
 	        	  }
 	          }
 	          else if(row.itemname == 'File List'){  
 	        		 window.open(url2); 
 	          }
 	          else if(row.itemname == 'Delete PO' && user == row.reviewer)
 	        	 window.open(url2); 
 	          
    }
}


	 
</script>
</head>
<body class="easyui-layout">
	<div data-options="region:'north',border:false" class="north">
		<jsp:include page="./top.jsp" />
	</div>
	<div data-options="region:'west',split:true,title:'  '  " class="west">
	<jsp:include page="./leftmenu.jsp" />
	</div>
	<div data-options="region:'center'" class="center">
		<div id="tabs" class="easyui-tabs" fit="true" border="false">
			<div title="My TodoList">
				<!--  div class="cs-home-remark">
					<h1></h1>
					<br>
				</div-->
	<div id="dg" style="width: 100%;height:100%"></div>
	<div id="toolbar">&nbsp;&nbsp;	</div>				
			</div>
		</div>
	</div>

	<div id="mm" class="easyui-menu cs-tab-menu">
		<div id="mm-tabupdate">刷新</div>
		<div class="menu-sep"></div>
		<div id="mm-tabclose">关闭</div>
		<div id="mm-tabcloseother">关闭其他</div>
		<div id="mm-tabcloseall">关闭全部</div>
	</div>
</body>

</html>