

//js获取项目根路径，如： http://localhost:8083/uimcardprj
function getRootPath(){
    //获取当前网址，如： http://localhost:8083/uimcardprj/share/meun.jsp
    var curWwwPath=window.document.location.href;
    //获取主机地址之后的目录，如： uimcardprj/share/meun.jsp
    var pathName=window.document.location.pathname;
    var pos=curWwwPath.indexOf(pathName);
    //获取主机地址，如： http://localhost:8083
    var localhostPaht=curWwwPath.substring(0,pos);
    //获取带"/"的项目名，如：/uimcardprj
    var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);
    return(localhostPaht+projectName);
}
var rootPath=getRootPath();//123

function clearGrid(gridId){
	$('#'+gridId+'').datagrid('checkAll');
	var checkedRows=$('#'+gridId+'').datagrid('getChecked');
	
	for(var i=0;i<checkedRows.length;i++){
		var index=$('#'+gridId+'').datagrid('getRowIndex',checkedRows[i]);
		$('#'+gridId+'').datagrid('deleteRow',index);
	}

	
}


$("document").ready(function(){
	//定义全局变量用来标识属性修改的 行标
	var changeAttriIndex=-1;
	//定义全局变量用来标识外键 修改的 行标
	var changeForeignIndex=-1;
	
	$('#refDomainId').combobox({
		url:rootPath+'/framework/model/getDomains.action',
		valueField:'domainId',
		textField:'domainCName'
	});
	//初始化数据域查询
	$('#selectDomain').combobox({
		url:rootPath+'/framework/model/getSelectDomains.action',
		valueField:'domainId',
		textField:'domainCName',
		onSelect:function(record){
			//$("#datagrid").datagrid({ url:"getModelsByDomianPage.action?domainId="+record.domainId,method:"post"});
			$("#datagrid").datagrid('load',{domainId:record.domainId});
		}
	});
	//数据域查询默认选中
	$('#selectDomain').combobox('setValue',0);
	
	
	//初始化模型列表
	$("#datagrid").datagrid({
		url:"../../../framework/model/getModelsByDomianPage.action",
		queryParams:{domainId:$('#selectDomain').combobox('getValue')},
		method:'post',
		autoRowHeight:true,
		singleSelect: false,
	    checkOnSelect: false, 
	    selectOnCheck: false,
	    striped : true,
		nowrap : true,
		pageSize:10,
		pageList:[10,20],
		columns:[[
				  {field:'check',width:10,checkbox:true},
		          {field:'modelId',title:'模型ID',width:80},
		          {field:'modelCName',title:'模型中文名',width:80},
		          {field:'modelEName',title:'模型英文名',width:80,align:'right'},
		          {field:'modelDesc',title:'描述',width:80,align:'right'},
				  {field:'modelDetail',title:'模型详情',width:80,align:'right',
					  formatter: function(value,row,index){
						return '<a href="../../../framework/model/modelDetailPage.action?modelId='+row.modelId+'">查看详情</a>';
					}
				},
		      ]],
		pagination:true,
		onSelect:function(rowIndex,rowData){
			$("#toolbar_edit").linkbutton('enable');
			$("#toolbar_delete").linkbutton('enable');
			
		}/*,
		rowStyler:function(index,row){     
		if (index%2==0){     
				return 'background-color:rgb(233,240,255);font-weight:bold;';     
			}     
		}     */
  
	});
	
	//初始化属性列表
	$("#attriGrid").datagrid({
		method:'post',
		autoRowHeight:true,
		singleSelect: false,
	    checkOnSelect: false, 
	    selectOnCheck: false,
	    striped : true,
		nowrap : true,
		columns:[[
				  {field:'check',width:10,checkbox:true},
		          {field:'attributeId',title:'属性ID',width:80,hidden:true},
		          {field:'attributeCName',title:'属性中文名',width:80},
		          {field:'attributeEName',title:'属性英文名',width:80,align:'right'},
		          {field:'isPrimariKey',title:'是否主键',width:80,align:'right'},
				  {field:'isAllowNull',title:'是否允许为空',width:80,align:'right'},
				  {field:'isIndex',title:'是否索引',width:80,align:'right'},
				  {field:'isUnique',title:'是否唯一',width:80,align:'right'},
				  {field:'length',title:'长度',width:80,align:'right'},
				  {field:'type',title:'类型',width:80,align:'right'},
				  {field:'validataRuler',title:'属性正则约束',width:80,align:'right'}
		      ]],
		pagination:false,
		onSelect:function(rowIndex,rowData){
			$("#toolbar_edit").linkbutton('enable');
			$("#toolbar_delete").linkbutton('enable');
			
		},
		/*rowStyler:function(index,row){     
		if (index%2==0){     
				return 'background-color:rgb(233,240,255);font-weight:bold;';     
			}     
		},*/
		onDblClickRow:function(index,field,value){
			var srecord=field;
			changeAttriIndex=index;
			$("#edit_AttriForm").form('clear');
			$("#edit_AttriForm").form('load',srecord);
			$("#edit_AisPrimariKey")[0].checked=Boolean(srecord.isPrimariKey);
			$("#edit_AisAllowNull")[0].checked=Boolean(srecord.isAllowNull);
			$("#edit_AisIndex")[0].checked=Boolean(srecord.isIndex);
			$("#edit_AisUnique")[0].checked=Boolean(srecord.isUnique);
			$("#edit_attriDialog").css('display','block');
			$("#edit_attriDialog").dialog('open');
			
		}	
  
	});
	
	//如果是主键，必须是索引非空
	$("#isPrimariKey").change(function(){
		if(this.checked==true){
			$("#isAllowNull")[0].checked=false;
			$("#isIndex")[0].checked=true;
			$("#isUnique")[0].checked=true;
			$("#isAllowNull")[0].disabled=true;
			$("#isIndex")[0].disabled=true;
			$("#isUnique")[0].disabled=true;
			
		}else{
			$("#isAllowNull")[0].checked=false;
			$("#isIndex")[0].checked=false;
			$("#isUnique")[0].checked=false;
			$("#isAllowNull")[0].disabled=false;
			$("#isIndex")[0].disabled=false;
			$("#isUnique")[0].disabled=false;
		}
	});
	
	//添加属性按钮方法
	$("#attri_toolbar_add").bind('click',function(){
		$("#attriForm input[type='checkbox']").each(function(){this.checked=false;this.disabled=false;});
		$("#attriDialog").dialog('open');
	});
	
	$("#attri_save").bind('click',function(){
		if($("#attriForm").form('validate')){
			$('#attriGrid').datagrid('insertRow',{
				row: {
					attributeCName:$("#attributeCName").val(),
					attributeEName: $("#attributeEName").val(),
					isPrimariKey: $("#isPrimariKey")[0].checked,
					isAllowNull:$("#isAllowNull")[0].checked,
					isIndex:$("#isIndex")[0].checked,
					isUnique:$("#isUnique")[0].checked,
					length:$("#length").val(),
					type:$("#type").combobox('getValue'),
					validataRuler:$("#validataRuler").val()
				}
			});
			$("#attriForm").form('clear');
			$("#attriDialog").panel('close');
		}
	});
	$("#attri_close").bind('click',function(){
		$("#attriDialog").panel('close');
	});
	
	
	//修改模型属性
	$("#edit_attriDialog_bt_save").bind("click",function(){
		if($("#edit_AttriForm").form('validate')){
			$('#attriGrid').datagrid('updateRow',{
				index:changeAttriIndex,
				row: {
					attributeId:$("#edit_AttributeId").val()==""?undefined:$("#edit_AttributeId").val(),
					attributeCName:$("#edit_AttributeCName").val(),
					attributeEName: $("#edit_AttributeEName").val(),
					isPrimariKey: $("#edit_AisPrimariKey")[0].checked,
					isAllowNull:$("#edit_AisAllowNull")[0].checked,
					isIndex:$("#edit_AisIndex")[0].checked,
					isUnique:$("#edit_AisUnique")[0].checked,
					length:$("#edit_Alength").val(),
					type:$("#edit_Atype").combobox('getValue'),
					validataRuler:$("#edit_AvalidataRuler").val()
				}
			});
			$("#attriForm").form('clear');
			$("#edit_attriDialog").dialog('close');
		}
	});
	
	//如果是主键，必须是索引非空
	$("#edit_AisPrimariKey").change(function(){
		if(this.checked==true){
			$("#edit_AisAllowNull")[0].checked=false;
			$("#edit_AisIndex")[0].checked=true;
			$("#edit_AisUnique")[0].checked=true;
			$("#edit_AisAllowNull")[0].disabled=true;
			$("#edit_AisIndex")[0].disabled=true;
			$("#edit_AisUnique")[0].disabled=true;
			
		}else{
			$("#edit_AisAllowNull")[0].checked=false;
			$("#edit_AisIndex")[0].checked=false;
			$("#edit_AisUnique")[0].checked=false;
			$("#edit_AisAllowNull")[0].disabled=false;
			$("#edit_AisIndex")[0].disabled=false;
			$("#edit_AisUnique")[0].disabled=false;
		}
	});
	
	
	//修改模型属性结束
	
	
	//删除属性
	$("#attri_toolbar_delete").bind('click',function(){
		var checkedRows=$('#attriGrid').datagrid('getChecked');
		if(checkedRows.length<1)
			$.messager.alert('提示','请选择要删除的记录！！！');
		else{
			$.messager.confirm('确认', '是否真的要删除所选记录？', function(r){
				if (r){
					for(var i=0;i<checkedRows.length;i++){
						var index=$('#attriGrid').datagrid('getRowIndex',checkedRows[i]);
						$('#attriGrid').datagrid('deleteRow',index);
					}
				}
			});	
		}
	});
	
	
	
	//初始化外键列表
	$("#foreignGrid").datagrid({
		method:'post',
		autoRowHeight:true,
		singleSelect: false,
	    checkOnSelect: false, 
	    selectOnCheck: false,
	    striped : true,
		nowrap : true,
		columns:[[
				  {field:'check',width:10,checkbox:true},
		          {field:'fKId',title:'外键ID',width:80,hidden:true},
		          {field:'fKCName',title:'外键中文名',width:80},
		          {field:'fKEName',title:'外键英文名',width:80,align:'right'},
		          {field:'fKMainAttribute',title:'外键主属性',width:80,align:'right'},
				  {field:'refModelId',title:'外键参照模型ID',width:80,align:'right'},
				  {field:'refModelCName',title:'外键参照模型',width:80,align:'right'},
				  {field:'refAttriId',title:'外键参照属性ID',width:80,align:'right'},
				  {field:'refAttriCName',title:'外键参照属属性',width:80,align:'right'},
		      ]],
		pagination:false,
		onSelect:function(rowIndex,rowData){
			$("#toolbar_edit").linkbutton('enable');
			$("#toolbar_delete").linkbutton('enable');
			
		},
		/*rowStyler:function(index,row){     
		if (index%2==0){     
				return 'background-color:rgb(233,240,255);font-weight:bold;';     
			}     
		},*/
		onDblClickRow:function(index,field,value){
			$('#edit_fKMainAttribute').combobox('loadData',$("#attriGrid").datagrid('getData').rows);
			var srecord=field;
			changeForeignIndex=index;
			$('#edit_fKId').textbox('setValue',srecord.fKId);
			$('#edit_fKCName').textbox('setValue',srecord.fKCName);
			$('#edit_fKEName').textbox('setValue',srecord.fKEName);
			if(srecord.attri!=undefined){
				$('#edit_fKMainAttribute').combobox('setValue',srecord.attri.attributeEName);
				$('#edit_fKMainAttribute').combobox('setText',srecord.attri.attributeCName);
				
				$('#edit_refModelId').combobox('setValue',srecord.attri.model.modelId);
				$('#edit_refModelId').combobox('setText',srecord.attri.model.modelCName);
				$('#edit_refAttriId').combobox('setValue',srecord.attri.attributeId);
				$('#edit_refAttriId').combobox('setText',srecord.attri.attributeCName);
			}
			else{
				$('#edit_fKMainAttribute').combobox('setValue',srecord.fKMainAttribute);
				$('#edit_refModelId').combobox('setValue',srecord.refModelId);
				$('#edit_refModelId').combobox('setText',srecord.refModelCName);
				$('#edit_refAttriId').combobox('setValue',srecord.refAttriId);
				$('#edit_refAttriId').combobox('setText',srecord.refAttriCName);
			}
			$("#edit_foreignDialog").css('display','block');
			$("#edit_foreignDialog").dialog('open');
			}
  
	});
	
	$('#fKMainAttribute').combobox({
		width:170,
		valueField:'attributeEName',
		textField:'attributeCName'
	});
	$('#refModelId').combobox({
		url:rootPath+'/framework/model/getModels.action',
		width:170,
		valueField:'modelId',
		textField:'modelCName',
		onSelect:function(record){
			$('#refAttriId').combobox('reload',rootPath+'/framework/model/getAttributesByModelId.action?modelId='+record.modelId);
		}
	});
	$('#refAttriId').combobox({
		width:170,
		valueField:'attributeId',
		textField:'attributeCName'
	});
	
	
	$("#foreign_toolbar_add").bind('click',function(){
		//加载下拉框的数据
		//console.log(JSON.stringify($("#attriGrid").datagrid('getData').rows))
		$('#fKMainAttribute').combobox('loadData',$("#attriGrid").datagrid('getData').rows);
		$("#foreignDialog").panel('open');
	});
	
	
	//修改模型外键
	//修改界面的下拉框设置
	$('#edit_fKMainAttribute').combobox({
		width:100,
		valueField:'attributeEName',
		textField:'attributeCName'
	});
	
	$('#edit_refModelId').combobox({
		url:rootPath+'/framework/model/getModels.action',
		width:170,
		valueField:'modelId',
		textField:'modelCName',
		onSelect:function(record){
			$('#edit_refAttriId').combobox('reload',rootPath+'/framework/model/getAttributesByModelId.action?modelId='+record.modelId);
		}
	});
	$('#edit_refAttriId').combobox({
		width:170,
		valueField:'attributeId',
		textField:'attributeCName'
	});
	
	$("#foreign_toolbar_edit").bind('click',function(){
		$('#edit_fKMainAttribute').combobox('loadData',$("#attriGrid").datagrid('getData').rows);
		
		var srecord=$("#foreignGrid").datagrid("getSelected");
		changeForeignIndex=$("#foreignGrid").datagrid("getRowIndex",srecord);
		alert(changeForeignIndex);
		
		alert(JSON.stringify(srecord));
		$('#edit_fKId').val(srecord.fKId);
		$('#edit_fKCName').val(srecord.fKCName);
		$('#edit_fKEName').val(srecord.fKEName);
		if(srecord.attri!=undefined){
			$('#edit_fKMainAttribute').combobox('setValue',srecord.attri.attributeEName);
			$('#edit_fKMainAttribute').combobox('setText',srecord.attri.attributeCName);
			
			$('#edit_refModelId').combobox('setValue',srecord.attri.model.modelId);
			$('#edit_refModelId').combobox('setText',srecord.attri.model.modelCName);
			$('#edit_refAttriId').combobox('setValue',srecord.attri.attributeId);
			$('#edit_refAttriId').combobox('setText',srecord.attri.attributeCName);
		}
		else{
			$('#edit_fKMainAttribute').combobox('setValue',srecord.fKMainAttribute);
			//$('#edit_fKMainAttribute').combobox('setText',srecord.attri.attributeCName);
			$('#edit_refModelId').combobox('setValue',srecord.refModelId);
			$('#edit_refModelId').combobox('setText',srecord.refModelCName);
			$('#edit_refAttriId').combobox('setValue',srecord.refAttriId);
			$('#edit_refAttriId').combobox('setText',srecord.refAttriCName);
		}
		$("#edit_foreignDialog").css('display','block');
		$("#edit_foreignDialog").dialog('open');
	});
	
	$("#edit_foreignDialog_bt_save").bind("click",function(){
		if($("#edit_foreignForm").form('validate')){
			$('#foreignGrid').datagrid('insertRow',{
				index:changeForeignIndex,
				row: {
					fKId:$("#edit_fKId").val()==""?undefined:$("#edit_fKId").val(),
					fKCName:$("#edit_fKCName").val(),
					fKEName: $("#edit_fKEName").val(),
					fKMainAttribute:$("#edit_fKMainAttribute").combobox('getValue'),
					refModelId:$("#edit_refModelId").combobox('getValue'),
					refModelCName:$("#edit_refModelId").combobox('getText'),
					refAttriId:$("#edit_refAttriId").combobox('getValue'),
					refAttriCName:$("#edit_refAttriId").combobox('getText')
				}
			});
			$('#foreignGrid').datagrid('deleteRow',changeForeignIndex+1);
			$("#edit_foreignForm").form('clear');
			$("#edit_foreignDialog").dialog('close');
		}
		
	
	});
	//修改模型外键结束
	
	
	
	
	//删除外键
	$("#foreign_toolbar_delete").bind('click',function(){
		var checkedRows=$('#foreignGrid').datagrid('getChecked');
		if(checkedRows.length<1)
			$.messager.alert('提示','请选择要删除的记录！！！');
		else{
			$.messager.confirm('确认', '是否真的要删除所选记录？', function(r){
				if (r){
					for(var i=0;i<checkedRows.length;i++){
						var index=$('#foreignGrid').datagrid('getRowIndex',checkedRows[i]);
						$('#foreignGrid').datagrid('deleteRow',index);
					}
				}
			});	
		}
	});
	
	$("#foreign_save").bind('click',function(){
		if($("#foreignForm").form('validate')){
			$('#foreignGrid').datagrid('insertRow',{
				row: {
					fKCName:$("#fKCName").val(),
					fKEName: $("#fKEName").val(),
					fKMainAttribute:$("#fKMainAttribute").combobox('getValue'),
					refModelId:$("#refModelId").combobox('getValue'),
					refModelCName:$("#refModelId").combobox('getText'),
					refAttriId:$("#refAttriId").combobox('getValue'),
					refAttriCName:$("#refAttriId").combobox('getText')
				}
			});
			$("#foreignForm").form('clear');
			$("#foreignDialog").panel('close');
		}
	});
	
	$("#foreign_close").bind('click',function(){
		$("#foreignDialog").panel('close');
	});
	
	//新建和修改窗体初始化
	$('#dialog').dialog({
	    title: '新建模型',
		left:0,
		top:0,
	    width: 1000,
	    height: 500,
		resizable:true,
	    closed: true,
	    cache: false,
	    modal: true,
		buttons:[{
				text:'保存',
				iconCls:'icon-ok',
				handler:function(){
					if($("#modelForm").form('validate'))
					{
						var url=rootPath+'/framework/model/addModel.action';
						var modelObject={
							refDomainId:$("#refDomainId").combobox('getValue'),
							modelCName:$("#modelCName").val(),
							modelEName:$("#modelEName").val(),
							modelDesc:$("#modelDesc").val(),
							isMainEntity:$("#isMainEntity")[0].checked
						};
						
						$.ajax({  
						   type: "post",  
						   dataType:'json',
						   cache:false,  
						   data:{"model":JSON.stringify(modelObject),"attris":JSON.stringify($("#attriGrid").datagrid("getData").rows),"foreigns":JSON.stringify($("#foreignGrid").datagrid("getData").rows)}, 
						   url: url,  
						   beforeSend: function(XMLHttpRequest){  
						   },  
						   success: function(data){  
								if(data.success==true){
									$.messager.alert('提示','模型创建成功！！！');
									$('#datagrid').datagrid('reload');
									$('#form').form('clear');
									$('#dialog').dialog('close');
								}
								else{
									$.messager.alert('提示','创建失败！！！</br>异常编码：'+data.code+'</br>异常名字：'+data.name+'</br>异常原因：'+data.msg+'</br>请求连接：'+data.url);
									
									}
							},  
						   error: function(){  
							   alert("Error!");  
						   }  
						});  
					}
					else{
						$.messager.alert('提示','信息没有完善！！');
					}
				}
			},{
				text:'关闭',
				iconCls:'icon-cancel',
				handler:function(){
					$('#form').form('clear');
					$('#dialog').dialog('close');
				}
			}]
	});
	
	
	//添加模型
	 $("#toolbar_add").bind('click',function(){
		$('#dialog').css('display','block');
		$('#modelForm').form('reset');
		clearGrid('attriGrid');
		clearGrid('foreignGrid');
		$('#dialog').dialog('open');
	})
	
	//删除模型
	 $("#toolbar_delete").bind('click',function(){
		var checkedRows=$('#datagrid').datagrid('getChecked');
		if(checkedRows.length<1)
			$.messager.alert('提示','请选择要删除的记录！！！');
		else{
			$.messager.confirm('确认', '是否真的要删除所选记录？', function(r){
				if (r){
					var ids=new Array();
					for(var i=0;i<checkedRows.length;i++)
						ids.push(checkedRows[i].modelId);
					$.ajax({  
					 type: "post",  
					   dataType:'json',
					   cache:false,  
					   data:{"ids":ids},  
					   url: "../../../framework/model/deleteModel.action",  
					   beforeSend: function(XMLHttpRequest){  
					   },  
					   success: function(data){  
							if(data.success==true){
								$.messager.alert('提示','删除成功！！！');
								$('#datagrid').datagrid('reload');
							}
								
							else
								$.messager.alert('提示','删除失败！！！');
						},  
					   error: function(){  
						   alert("Error!");  
					   }  
					});  
				}
			});	
		}
	});
});



