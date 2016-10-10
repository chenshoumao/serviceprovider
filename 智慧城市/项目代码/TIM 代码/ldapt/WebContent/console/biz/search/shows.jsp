<%@page import="com.solar.tech.bean.Project"%>
<%@page import="com.solar.tech.bean.Po_Create"%>
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

(function($){
                var renderEmptyRow = $.fn.datagrid.defaults.view.renderEmptyRow;
                $.extend($.fn.datagrid.defaults.view, {
                    renderEmptyRow:function(target){
                        var fields = $(target).datagrid('getColumnFields');
                        for(var i=0; i<fields.length; i++){
                            var col = $(target).datagrid('getColumnOption', fields[i]);
                            col.formatter1 = col.formatter;
                            col.styler1 = col.styler;
                            col.formatter = col.styler = undefined;
                        }
                        renderEmptyRow.call(this, target);
                        for(var i=0; i<fields.length; i++){
                            var col = $(target).datagrid('getColumnOption', fields[i]);
                            col.formatter = col.formatter1;
                            col.styler = col.styler1;
                            col.formatter1 = col.styler1 = undefined;
                        }
                    }
                })
            })(jQuery);
$(function(){
	$('#dg').datagrid({
	    height: 'auto',
	    fit:false,
	    url: '<%=basePath %>framework/search/shows.action' ,
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
	    //   { field: 'ck', checkbox: true },
	      //  { field: 'from',title : 'From',width : 150,align:'center', formatter: function (value, rec) { return rec[2].from; } },
    		{ field: 'file_no',title : 'File No',width : 150,align:'center',formatter: function (value, rec) {return rec[2].file_no;}},
            { field: 'type',title : 'Type',width : 150,align:'center', formatter: function (value, rec) { return rec[2].type; } },
    		{ field: 'standard',title : 'standard',width : 150,align:'center', formatter: function (value, rec) { return rec[2].standard; } },
    	//	{ field: 'nast_proj_no',title : 'nast_proj_no',width :150,align:'center',formatter:function (value, rec){ return rec[2].nast_proj_no; } },
    	//	{ field: 'nast_rep_no',title : 'nast_rep_no',width : 150,align:'center',formatter: function (value, rec) {return rec[2].nast_rep_no;}},
        //    { field: 'idi_rep_no',title : 'idi_rep_no',width : 150,align:'center', formatter: function (value, rec) { return rec[2].idi_rep_no; } },
    	//	{ field: 'hest_or_no',title : 'hest_or_no',width : 150,align:'center', formatter: function (value, rec) { return rec[2].hest_or_no; } },
    	//	{ field: 'hest_rep_no',title : 'hest_rep_no',width : 150,align:'center',formatter: function (value, rec) { return rec[2].hest_rep_no; } },
    	//	{ field: 'cert_no',title : 'cert_no',width : 150,align:'center',formatter: function (value, rec) {return rec[2].cert_no;}},
         //   { field: 'file_type',title : 'file_type',width : 150,align:'center', formatter: function (value, rec) { return rec[2].file_type; } },
    	//	{ field: 'rev_ext',title : 'rev_ext',width : 150,align:'center', formatter: function (value, rec) { return rec[2].rev_ext; } },
    		{ field: 'status',title : 'Status',width : 150,align:'center',formatter: function (value, rec) {return rec[2].status;}},
            { field: 'category',title : 'Category',width : 150,align:'center', formatter: function (value, rec) { return rec[2].category; } },
    		{ field: 'engineer',title : 'Engineer',width : 150,align:'center', formatter: function (value, rec) { return rec[2].engineer; } },
    		{ field: 'Create_time',title :'Create Time',width : 150,align:'center',formatter: function (value, rec) { return rec[2].Create_time; } },
    		{ field: 'Endtime',title : 'End Time',width : 150,align:'center',formatter: function (value, rec) {return rec[2].Endtime;}},
           // { field: 'deadline',title : 'deadline',width : 150,align:'center', formatter: function (value, rec) { return rec[2].deadline; } },
    		{ field: 'proj_no',title : 'Project No.',width : 150,align:'center', formatter: function (value, rec) { return rec[2].proj_no; } },
    		
    		{ field: 'po_no',title : 'PO No.',width : 150,align:'center', formatter: function (value, rec) { return rec[1].po_no; } },
    		{ field: 'proj_desc',title :'Project Description',width : 150,align:'center',formatter: function (value, rec) {return rec[1].proj_desc;}},
            { field: 'manufacturer',title:'Manufacturer',width :150,align:'center',formatter: function (value, rec) { return rec[1].manufacturer; } },
    		{ field: 'make;',title : 'Make;',width : 150,align:'center', formatter: function (value, rec) { return rec[1].make; } },
    		{ field: 'ia_status',title : 'IA Status',width : 150,align:'center', formatter: function (value, rec) { return rec[1].ia_status; } },
    		
    		{ field: 'po_desc',title : 'PO Description',width : 150,align:'center',formatter: function (value, rec) {return rec[0].po_desc;}},
            { field: 'prod_type_desc',title : 'Product Type Description',width : 150,align:'center', formatter: function (value, rec) { return rec[0].prod_type_desc; } },
    		{ field: 'start_time',title : 'Start Time',width : 150,align:'center', formatter: function (value, rec) { return rec[0].start_time; } },
    		{ field: 'complete_time',title : 'Complete Time',width : 150,align:'center', formatter: function (value, rec) { return rec[0].complete_time; } },
    		{ field: 'contract_price',title : 'Contract Price',width : 150,align:'center',formatter: function (value, rec) {return rec[0].contract_price;}},
    		{ field: 'customer',title : 'Customer',width : 150,align:'center', formatter: function (value, rec) { return rec[0].customer; } },
    		//{ field: 'maufacturer',title : 'maufacturer',width : 150,align:'center',formatter: function (value, rec) {return rec[0].maufacturer;}}
    		      
            
			]]
	});
});
function searchText(){
	var value = $("input[name=search]").val();
	var svalue = $("input[name=stime]").val();
	var evalue = $("input[name=etime]").val();	
	$('#dg').datagrid({
	    height: '100%',
	    fit:true,
	    url: '<%=basePath %>framework/search/search.action?pono=' + value + '&stime=' + svalue + ' &etime=' + evalue ,
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
	    //   { field: 'ck', checkbox: true },
	      //  { field: 'from',title : 'From',width : 150,align:'center', formatter: function (value, rec) { return rec[2].from; } },
    		{ field: 'file_no',title : 'File No',width : 150,align:'center',formatter: function (value, rec) {return rec[2].file_no;}},
            { field: 'type',title : 'Type',width : 150,align:'center', formatter: function (value, rec) { return rec[2].type; } },
    		{ field: 'standard',title : 'standard',width : 150,align:'center', formatter: function (value, rec) { return rec[2].standard; } },
    	//	{ field: 'nast_proj_no',title : 'nast_proj_no',width :150,align:'center',formatter:function (value, rec){ return rec[2].nast_proj_no; } },
    	//	{ field: 'nast_rep_no',title : 'nast_rep_no',width : 150,align:'center',formatter: function (value, rec) {return rec[2].nast_rep_no;}},
        //    { field: 'idi_rep_no',title : 'idi_rep_no',width : 150,align:'center', formatter: function (value, rec) { return rec[2].idi_rep_no; } },
    	//	{ field: 'hest_or_no',title : 'hest_or_no',width : 150,align:'center', formatter: function (value, rec) { return rec[2].hest_or_no; } },
    	//	{ field: 'hest_rep_no',title : 'hest_rep_no',width : 150,align:'center',formatter: function (value, rec) { return rec[2].hest_rep_no; } },
    	//	{ field: 'cert_no',title : 'cert_no',width : 150,align:'center',formatter: function (value, rec) {return rec[2].cert_no;}},
         //   { field: 'file_type',title : 'file_type',width : 150,align:'center', formatter: function (value, rec) { return rec[2].file_type; } },
    	//	{ field: 'rev_ext',title : 'rev_ext',width : 150,align:'center', formatter: function (value, rec) { return rec[2].rev_ext; } },
    		{ field: 'status',title : 'Status',width : 150,align:'center',formatter: function (value, rec) {return rec[2].status;}},
            { field: 'category',title : 'Category',width : 150,align:'center', formatter: function (value, rec) { return rec[2].category; } },
    		{ field: 'engineer',title : 'Engineer',width : 150,align:'center', formatter: function (value, rec) { return rec[2].engineer; } },
    		{ field: 'Create_time',title :'Create Time',width : 150,align:'center',formatter: function (value, rec) { return rec[2].Create_time; } },
    		{ field: 'Endtime',title : 'End Time',width : 150,align:'center',formatter: function (value, rec) {return rec[2].Endtime;}},
           // { field: 'deadline',title : 'deadline',width : 150,align:'center', formatter: function (value, rec) { return rec[2].deadline; } },
    		{ field: 'proj_no',title : 'Project No.',width : 150,align:'center', formatter: function (value, rec) { return rec[2].proj_no; } },
    		
    		{ field: 'po_no',title : 'PO No.',width : 150,align:'center', formatter: function (value, rec) { return rec[1].po_no; } },
    		{ field: 'proj_desc',title :'Project Description',width : 150,align:'center',formatter: function (value, rec) {return rec[1].proj_desc;}},
            { field: 'manufacturer',title:'Manufacturer',width :150,align:'center',formatter: function (value, rec) { return rec[1].manufacturer; } },
    		{ field: 'make;',title : 'Make;',width : 150,align:'center', formatter: function (value, rec) { return rec[1].make; } },
    		{ field: 'ia_status',title : 'IA Status',width : 150,align:'center', formatter: function (value, rec) { return rec[1].ia_status; } },
    		
    		{ field: 'po_desc',title : 'PO Description',width : 150,align:'center',formatter: function (value, rec) {return rec[0].po_desc;}},
            { field: 'prod_type_desc',title : 'Product Type Description',width : 150,align:'center', formatter: function (value, rec) { return rec[0].prod_type_desc; } },
    		{ field: 'start_time',title : 'Start Time',width : 150,align:'center', formatter: function (value, rec) { return rec[0].start_time; } },
    		{ field: 'complete_time',title : 'Complete Time',width : 150,align:'center', formatter: function (value, rec) { return rec[0].complete_time; } },
    		{ field: 'contract_price',title : 'Contract Price',width : 150,align:'center',formatter: function (value, rec) {return rec[0].contract_price;}},
    		{ field: 'customer',title : 'Customer',width : 150,align:'center', formatter: function (value, rec) { return rec[0].customer; } },
    		//{ field: 'maufacturer',title : 'maufacturer',width : 150,align:'center',formatter: function (value, rec) {return rec[0].maufacturer;}}
    		      
             
			]]
	});

	} 
</script>
</head>
<body> 
	<div id="dg" style="width: 100%;height:100%"></div>
	<div id="toolbar">
		 			&nbsp;&nbsp;
		 <input id="sd" name="stime" class="easyui-datebox" data-options="editable:false"></input> &nbsp;&nbsp; 
		 <input id="ed" name="etime"  class="easyui-datebox" data-options="editable:false"></input>  &nbsp;&nbsp; 
			<input name="search" class="easyui-textbox"> 
		<a href="javascript:void(0)"  id="btn" iconCls="icon-search" class="easyui-linkbutton"
		onclick="searchText()">搜索</a>
	</div> 
	 
</body>
</html>