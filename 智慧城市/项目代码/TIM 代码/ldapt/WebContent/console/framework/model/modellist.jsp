
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
<title>Insert title here</title>
<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"href="<%=basePath %>scripts/common/jquery-easyui/themes/icon.css">
<link rel="stylesheet" type="text/css"href="<%=basePath %>styles/framework/frameset.css">


<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-1.8.3.min.js"></script>
<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-easyui/jquery.easyui.min.js"></script>
<script type="text/javascript"src="<%=basePath %>scripts/common/jquery-easyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript"src="<%=basePath %>scripts/framework/frameset.js"></script>
<script type="text/javascript"src="<%=basePath %>scripts/framework/model/modellist.js"></script>
<style type="text/css">
	html,body{
	height:100%;width:100%;margin:0px;
	}

	.fm {margin: 0;padding: 10px 50px;
	}

	.ftitle {font-size: 14px;font-weight: bold;padding: 5px 0;margin-bottom: 10px;border-bottom: 1px solid #ccc;
	}

	.fitem {
	margin-bottom: 5px;padding-left: 40px;
	}

	.fitem label {
		display: inline-block;
		width: 80px;
		padding-right: 130px;
		text-align: right;
	}

	.fitem input {width: 160px;
	}
</style>
</head>

<body>
	<div style="text-align:center;width:100%;height:100%">
		
	<table id="datagrid" style="width:100%;height:100%"
       data-options="fitColumns:true,title:'模型管理',toolbar:'#toolbox'">
	</table>
	</div>
	<div id="toolbox" style="padding:5px;height:25px">
		<div style="margin-bottom:5px;float:left">
			<a href="#" class="easyui-linkbutton" id="toolbar_add"  iconCls="icon-add" plain="true">新建模型</a>
			<a href="#" class="easyui-linkbutton" id="toolbar_delete" iconCls="icon-remove" plain="true">删除模型</a>
		</div>
		<div style="margin-bottom:5px;margin-right:20px;float:right">
			<label>选择数据域：</label><input id="selectDomain" >
		</div>
	</div>
	
	
		
	<div id="dialog" style="display: none;text-align:center;top:0px;left:0px;width:1000px;height:600px;">
		<div id="tabs" class="easyui-tabs" style="height:100%;width:100%;" data-options="fit:true">
			
			<div id="modelTab"  title="模型属性" data-options="fit:true" >
				<form id="modelForm" method="post" class="fm"  >
					<div class="fitem" style="display:none;">
					<label>模型Id:</label>
					 <input id="modelId" name="modelId"  class="easyui-textbox"
						 style="width: 280px;" validtype="length[1,50]" invalidMessage="有效长度1-50" >

					</div>
					<div class="fitem">
					<label>模型中文名:</label>
					 <input id="modelCName" name="modelCName" class="easyui-textbox"
						required="true" style="width: 280px;" validtype="length[1,50]" invalidMessage="有效长度1-50" >

					</div>
					<div class="fitem">
					<label>模型英文名:</label>
					 <input id="modelEName" name="modelEName" class="easyui-textbox"
						required="true" style="width: 280px;" validtype="length[1,50]" invalidMessage="有效长度1-50" >
					</div>
					<div class="fitem">
						<label>所属数据域:</label>
						 <input id="refDomainId" name="refDomainId" data-options="required:true" style="width: 280px;">
					</div>
					<div class="fitem">
					<label>是否主实体:</label>
					<input id="isMainEntity" name="isMainEntity" type="checkbox" style="width:14px;" >
					</div>
					<div class="fitem">
					<label>模型描述:</label>
					<textarea  id="modelDesc" name="modelDesc"   style="width: 280px; height: 80px;border: 1px solid #95B8E7;border-radius: 5px 5px 5px 5px;"></textarea>
					</div>
				</form>
			</div>
			
			<div id="attriTab"  title="属性列表" data-options="fit:true">
				
				<table id="attriGrid" style="height:100%;width:100%;" data-options="fitColumns:true,toolbar:'#attri_toolbox'">
				</table>
				<div id="attri_toolbox" style="padding:5px;height:25px">
					<div style="margin-bottom:5px;float:left">
						<a href="#" class="easyui-linkbutton" id="attri_toolbar_add"  iconCls="icon-add" plain="true">添加属性</a>
						<a href="#" class="easyui-linkbutton" id="attri_toolbar_delete" iconCls="icon-remove" plain="true">删除属性</a>
					</div>
				</div>
			</div>
			
			
			
			<div id="foreignTab"   title="外键列表" data-options="fit:true">
				<table id="foreignGrid" style="height:100%;width:100%;" data-options="fitColumns:true,toolbar:'#foreign_toolbox'">
				</table>
				
				<div id="foreign_toolbox" style="padding:5px;height:25px">
					<div style="margin-bottom:5px;float:left">
						<a href="#" class="easyui-linkbutton" id="foreign_toolbar_add"  iconCls="icon-add" plain="true">添加外键</a>
						<a href="#" class="easyui-linkbutton" id="foreign_toolbar_delete" iconCls="icon-remove" plain="true">删除外键</a>
					</div>
				</div>
			</div>
		</div>
	
		<div id="attriDialog" class="easyui-dialog" style="width:70%;" data-options="closed:true,modal:true,buttons:'#attriFooter'" title="添加属性">
			<form id="attriForm" method="post" class="fm" >
				<div class="fitem" style="display:none;">
					<label>属性ID:</label>
					 <input id="attributeId" name="attributeId" class="easyui-textbox"
						 style="width: 280px;"  >

				</div>
				<div class="fitem">
					<label>属性中文名:</label>
					 <input id="attributeCName" name="attributeCName" class="easyui-textbox"
						required="true" style="width: 280px;" validtype="length[1,50]" invalidMessage="有效长度1-50" >

				</div>
				<div class="fitem">
					<label>属性英文名:</label>
					 <input id="attributeEName" name="attributeEName" class="easyui-textbox"
						required="true" style="width: 280px;" validtype="length[1,50]" invalidMessage="有效长度1-50" >

				</div>
				<div class="fitem">
					<label>是否主键:</label>
					 <input id="isPrimariKey" name="isPrimariKey" style="width: 14px;" type="checkbox">
				</div>
				<div class="fitem">
					<label>是否允许为空:</label>
					 <input id="isAllowNull" name="isAllowNull" style="width: 14px;" type="checkbox">
				</div>
				<div class="fitem">
					<label>是否索引:</label>
					 <input id="isIndex" name="isIndex" style="width: 14px;" type="checkbox">
				</div>
				<div class="fitem">
					<label>是否唯一:</label>
					 <input id="isUnique" name="isUnique" style="width: 14px;" type="checkbox">
				</div>
				<div class="fitem">
					<label>长度:</label>
					 <input id="length" name="length" class="easyui-textbox"
						required="true" style="width: 280px;" validtype="length[1,50]" invalidMessage="有效长度1-50" >
				</div>
				<div class="fitem">
					<label>类型:</label>
					 <input id="type" name="type" class="easyui-combobox"
						required="true" style="width: 280px;" data-options="valueField:'value',textField:'label',data: [{
														label: 'String',
														value: 'String'
													},{
														label: 'int',
														value: 'int'
													},{
														label: 'double',
														value: 'double'
													},{
														label: 'bool',
														value: 'bool'
													},{
														label: 'Date',
														value: 'Date'
													},{
														label: 'TimeStamp',
														value: 'TimeStamp'
													}]" >
				</div>
				<div class="fitem">
					<label>属性正则约束:</label>
					 <input id="validataRuler" name="validataRuler" class="easyui-textbox"
						style="width: 280px;"  >
				</div>
			
			</form>
		</div>
		<div id="attriFooter" style="padding:0px;">
			<div style="float:right;">
				<a href="#" class="easyui-linkbutton" id="attri_save"  iconCls="icon-ok" plain="true">保存</a>
				<a href="#" class="easyui-linkbutton" id="attri_close"  iconCls="icon-cancel" plain="true">取消</a>
			</div>
		</div>
		
		

		<div id="foreignDialog" class="easyui-dialog" data-options="closed:true,modal:true,buttons:'#foreignFooter'" style="width:70%;height200px;" title="添加外键" >
			<form id="foreignForm" method="post" class="fm" >
				<div class="fitem" style="display:none;">
					<label>外键ID:</label>
					 <input id="fKId" name="fKId" class="easyui-textbox"
						 style="width: 280px;"  >

				</div>
				<div class="fitem">
					<label>外键中文名:</label>
					 <input id="fKCName" name="fKCName" class="easyui-textbox"
						required="true" style="width: 280px;" validtype="length[1,50]" invalidMessage="有效长度1-50" >

				</div>
				<div class="fitem">
					<label>外键英文名:</label>
					 <input id="fKEName" name="fKEName" class="easyui-textbox"
						required="true" style="width: 280px;" validtype="length[1,50]" invalidMessage="有效长度1-50" >

				</div>
				<div class="fitem">
					<label>外键主属性:</label>
					 <input id="fKMainAttribute" name="fKMainAttribute" data-options="required:true" style="width: 280px;">

				</div>
				<div class="fitem">
					<label>外键参照模型:</label>
					 <input id="refModelId" name="refModelId" data-options="required:true" style="width: 280px;">

				</div>
				<div class="fitem">
					<label>外键参照属性:</label>
					 <input id="refAttriId" name="refAttriId" data-options="required:true" style="width: 280px;">

				</div>
			</form>
		</div>
		
		<div id="foreignFooter" style="padding:0px;">
			<div style="float:right;">
				<a href="#" class="easyui-linkbutton" id="foreign_save"  iconCls="icon-ok" plain="true">保存</a>
				<a href="#" class="easyui-linkbutton" id="foreign_close"  iconCls="icon-cancel" plain="true">取消</a>
			</div>
		</div>
		
		
		<div id="edit_attriDialog" class="easyui-dialog" style="width:70%;" data-options="model:true,closed:true,title:'修改属性',buttons:'#edit_attriDialog_bt'">
		<form id="edit_AttriForm" method="post"  >
				<div class="fitem" style="display:none;">
					<label>属性ID:</label>
					 <input id="edit_AttributeId" name="attributeId" class="easyui-textbox"
						 style="width: 280px;"  >

				</div>
				<div class="fitem">
					<label>属性中文名:</label>
					 <input id="edit_AttributeCName" name="attributeCName" class="easyui-textbox"
						required="true" style="width: 280px;" validtype="length[1,50]" invalidMessage="有效长度1-50" >

				</div>
				<div class="fitem">
					<label>属性英文名:</label>
					 <input id="edit_AttributeEName" name="attributeEName" class="easyui-textbox"
						required="true" style="width: 280px;" validtype="length[1,50]" invalidMessage="有效长度1-50" >

				</div>
				<div class="fitem">
					<label>是否主键:</label>
					 <input id="edit_AisPrimariKey" name="isPrimariKey" style="width: 14px;" type="checkbox">
				</div>
				<div class="fitem">
					<label>是否允许为空:</label>
					 <input id="edit_AisAllowNull" name="isAllowNull" style="width: 14px;" type="checkbox">
				</div>
				<div class="fitem">
					<label>是否索引:</label>
					 <input id="edit_AisIndex" name="isIndex" style="width: 14px;" type="checkbox">
				</div>
				<div class="fitem">
					<label>是否索引:</label>
					 <input id="edit_AisUnique" name="isUnique" style="width: 14px;" type="checkbox">
				</div>
				<div class="fitem">
					<label>长度:</label>
					 <input id="edit_Alength" name="length" class="easyui-textbox"
						required="true" style="width: 280px;" validtype="length[1,50]" invalidMessage="有效长度1-50" >
				</div>
				<div class="fitem">
					<label>类型:</label>
					<input id="edit_Atype" name="type" class="easyui-combobox"
						required="true" style="width: 280px;" data-options="valueField:'value',textField:'label',data: [{
														label: 'String',
														value: 'String'
													},{
														label: 'int',
														value: 'int'
													},{
														label: 'double',
														value: 'double'
													},{
														label: 'bool',
														value: 'bool'
													},{
														label: 'Date',
														value: 'Date'
													},{
														label: 'TimeStamp',
														value: 'TimeStamp'
													}]" >
				</div>
				<div class="fitem">
					<label>属性正则约束:</label>
					 <input id="edit_AvalidataRuler" name="validataRuler" class="easyui-textbox"
						 style="width: 280px;" >
				</div>
		</form>
	</div>
	
	<div id="edit_attriDialog_bt">
		<a href="#" id="edit_attriDialog_bt_save" iconCls="icon-ok" class="easyui-linkbutton">保存</a>
		<a href="#" id="edit_attriDialog_bt_close" iconCls="icon-cancel"class="easyui-linkbutton">取消</a>
	</div>
	
	<div id="edit_foreignDialog" class="easyui-dialog" style="width:70%;" data-options="model:true,closed:true,title:'修改外键',buttons:'#edit_foreignDialog_bt'">
		<form id="edit_foreignForm" method="post" class="fm" >
				<div class="fitem" style="display:none;">
					<label>外键ID:</label>
					 <input id="edit_fKId" name="fKId" class="easyui-textbox"
						 style="width: 280px;"  >

				</div>
				<div class="fitem">
					<label>外键中文名:</label>
					 <input id="edit_fKCName" name="fKCName" class="easyui-textbox"
						required="true" style="width: 280px;" validtype="length[1,50]" invalidMessage="有效长度1-50" >

				</div>
				<div class="fitem">
					<label>外键英文名:</label>
					 <input id="edit_fKEName" name="fKEName" class="easyui-textbox"
						required="true" style="width: 280px;" validtype="length[1,50]" invalidMessage="有效长度1-50" >

				</div>
				<div class="fitem">
					<label>外键主属性:</label>
					 <input id="edit_fKMainAttribute" name="fKMainAttribute" data-options="required:true" style="width: 280px;">

				</div>
				<div class="fitem">
					<label>外键参照模型:</label>
					 <input id="edit_refModelId" name="refModelId" data-options="required:true" style="width: 280px;">

				</div>
				<div class="fitem">
					<label>外键参照属性:</label>
					 <input id="edit_refAttriId" name="refAttriId" data-options="required:true" style="width: 280px;">

				</div>
		</form>
	</div>
	<div id="edit_foreignDialog_bt">
		<a href="#" id="edit_foreignDialog_bt_save" iconCls="icon-ok" class="easyui-linkbutton">保存</a>
		<a href="#" id="edit_foreignDialog_bt_close" iconCls="icon-cancel" class="easyui-linkbutton">取消</a>
	</div>
		
	</div>
</body>
</html>