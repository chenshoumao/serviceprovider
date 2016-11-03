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
var rootPath=getRootPath();
$("document").ready(function(){
	//选中checbox
	$("#isMainEntity")[0].checked=Boolean(parseInt($("#isMainEntity").val()));
	
	$('#refDomainId').combobox({
		url:rootPath+'/framework/model/getDomains.action',
		valueField:'domainId',
		textField:'domainCName'
	});
	
	//alert($("#refDomainId").val()+JSON.stringify($("#refDomainId")[0].attributes[5]));
	//设置模型所属主数据域
	$("#refDomainId").combobox('setValue',$("#refDomainId").val());
	$("#refDomainId").combobox('setText',$("#refDomainId")[0].attributes[5].nodeValue);
	
	
	//定义全局变量用来标识属性修改的 行标
	var changeAttriIndex=-1;
	//定义全局变量用来标识外键 修改的 行标
	var changeForeignIndex=-1;

	//初始化模型列表
	$("#datagrid").datagrid({
		url:'domainData.js',
		method:'post',
		autoRowHeight:true,
		singleSelect: false,
	    checkOnSelect: false, 
	    selectOnCheck: false,
	    striped : true,
		nowrap : true,
		columns:[[
				  {field:'check',width:10,checkbox:true},
		          {field:'modelId',title:'模型ID',width:80},
		          {field:'modelCName',title:'模型中文名',width:80},
		          {field:'modelEName',title:'模型英文名',width:80,align:'right'},
		          {field:'modelDesc',title:'描述',width:80,align:'right'},
		      ]],
		pagination:false,
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
		url:rootPath+'/framework/model/getAttributesByModelId.action?modelId='+$("#modelId").val(),
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
		          {field:'isPrimariKey',title:'是否主键',width:80,align:'right',
					 formatter: function(value,row,index){
							if(value==1)
								return true;
							else
								return false;
						}
				  },
				  {field:'isAllowNull',title:'是否允许为空',width:80,align:'right',
					formatter: function(value,row,index){
							if(value==1)
								return true;
							else
								return false;
						}
				},
				  {field:'isIndex',title:'是否索引',width:80,align:'right',
					formatter: function(value,row,index){
							if(value==1)
								return true;
							else
								return false;
						}
				  },
				  {field:'isUnique',title:'是否唯一',width:80,align:'right',
					formatter: function(value,row,index){
							if(value==1)
								return true;
							else
								return false;
						}
				  },
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
			//alert(index);
			//alert(JSON.stringify(field));
			var srecord=field;
			//alert(JSON.stringify(srecord));
			changeAttriIndex=index;
			//alert(changeAttriIndex);
			$("#edit_AttriForm").form('clear');
			$("#edit_AttriForm").form('load',srecord);
			//console.log(JSON.stringify(srecord.isPrimariKey));
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
	$("#attri_toolbar_add").bind('click',function(){
		$("#attriForm input[type='checkbox']").each(function(){this.checked=false;this.disabled=false;});
		$("#attriDialog").dialog('open');
	});
	
	
	
	//修改模型属性
	$("#attri_toolbar_edit").bind('click',function(){
		var srecord=$("#attriGrid").datagrid("getSelected");
		//alert(JSON.stringify(srecord));
		changeAttriIndex=$("#attriGrid").datagrid("getRowIndex",srecord);
		//alert(changeAttriIndex);
		$("#edit_AttriForm").form('clear');
		$("#edit_AttriForm").form('load',srecord);
		//console.log(JSON.stringify(srecord.isPrimariKey));
		$("#edit_AisPrimariKey")[0].checked=Boolean(srecord.isPrimariKey);
		$("#edit_AisAllowNull")[0].checked=Boolean(srecord.isAllowNull);
		$("#edit_AisIndex")[0].checked=Boolean(srecord.isIndex);
		$("#edit_AisUnique")[0].checked=Boolean(srecord.isUnique);
		$("#edit_attriDialog").css('display','block');
		$("#edit_attriDialog").dialog('open');
	});
	
	
	
	
	$("#edit_attriDialog_bt_close").bind("click",function(){
		
		$("#edit_attriDialog").dialog('close');
	});
	
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
					var ids=new Array();
					for(var i=0;i<checkedRows.length;i++){
						var index=$('#attriGrid').datagrid('getRowIndex',checkedRows[i]);
						var attriId=checkedRows[i].attributeId;
						if(attriId!=undefined){
							ids.push(attriId);
						}
					}
					$.ajax({  
					 type: "post",  
					   dataType:'json',
					   cache:false,  
					   data:{"ids":ids},  
					   url: rootPath+"/framework/model/deleteAttributes.action",  
					   beforeSend: function(XMLHttpRequest){  
					   },  
					   success: function(data){  
							if(data.success==true){
								$.messager.alert('提示','删除成功！！！');
								$('#attriGrid').datagrid('reload');
							}	
							else{
									$.messager.alert('提示','删除失败！！！</br>异常编码：'+data.code+'</br>异常名字：'+data.name+'</br>异常原因：'+data.msg+'</br>请求连接：'+data.url);
									
								}
						},  
					   error: function(){  
						   alert("Error!");  
					   }  
					});  
				}
			});	
		}
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
	
	
	
	//初始化外键列表
	$("#foreignGrid").datagrid({
		url:rootPath+'/framework/model/getForeignKeysByModelId.action?modelId='+$("#modelId").val(),
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
				  {field:'refModelId',title:'外键参照模型ID',width:80,align:'right',
					  formatter: function(value,row,index){
							if(row.attri)
								return row.attri.model.modelId;
							else
								return value;
						}
					},
				  {field:'refModelCName',title:'外键参照模型',width:80,align:'right',
					  formatter: function(value,row,index){
							if(row.attri)
								return row.attri.model.modelCName;
							else
								return value;
						}
					},
				  {field:'refAttriId',title:'外键参照属性ID',width:80,align:'right',
				  
					  formatter: function(value,row,index){
							if(row.attri)
								return row.attri.attributeId;
							else
								return value;
						}
					},
				  {field:'refAttriCName',title:'外键参照属性',width:80,align:'right',
					 formatter: function(value,row,index){
							if(row.attri)
								return row.attri.attributeCName;
							else
								return value;
						}
				  },
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
			//var srecord=$("#foreignGrid").datagrid("getSelected");
			var srecord=field;
			//changeForeignIndex=$("#foreignGrid").datagrid("getRowIndex",srecord);
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
				//$('#edit_fKMainAttribute').combobox('setText',srecord.attri.attributeCName);
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
		width:100,
		valueField:'attributeEName',
		textField:'attributeCName'
	});
	
	$('#refModelId').combobox({
		url:rootPath+'/framework/model/getModels.action',
		width:170,
		valueField:'modelId',
		textField:'modelCName',
		onSelect:function(record){
			//alert(record.modelId);
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
		$("#foreignDialog").dialog('open');
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
	
	$("#edit_foreignDialog_bt_close").bind("click",function(){
		$("#edit_foreignDialog").dialog('close');
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
					var ids=new Array();
					for(var i=0;i<checkedRows.length;i++){
						var index=$('#foreignGrid').datagrid('getRowIndex',checkedRows[i]);
						var foreignId=checkedRows[i].fKId;
						if(foreignId!=undefined){
							ids.push(foreignId);
						}
					}
					$.ajax({  
					 type: "post",  
					   dataType:'json',
					   cache:false,  
					   data:{"ids":ids},  
					   url: "../../../framework/model/deleteForeigns.action",  
					   beforeSend: function(XMLHttpRequest){  
					   },  
					   success: function(data){  
							if(data.success==true){
								$.messager.alert('提示','删除成功！！！');
								$('#foreignGrid').datagrid('reload');
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
	
	
	$("#model_close").click(function(){
		
		window.location.href=document.referrer;	
	});
	//修改模型
	$("#model_save").click(function(){
		if($("#modelForm").form('validate'))
			{
				var url=rootPath+'/framework/model/updateModel.action';
				var modelObject={
					modelId:$("#modelId").val(),
					refDomainId:$("#refDomainId").combobox('getValue'),
					modelCName:$("#modelCName").val(),
					modelEName:$("#modelEName").val(),
					modelDesc:$("#modelDesc").val(),
					isMainEntity:$("#isMainEntity")[0].checked
				};
				var attris=$("#attriGrid").datagrid("getData").rows;
				//alert(JSON.stringify(attris));
				var attrisObject=new Array();
				for(var i=0;i<attris.length;i++){
					attrisObject.push({
						"attributeId":attris[i].attributeId,
						"attributeCName":attris[i].attributeCName,
						"attributeEName":attris[i].attributeEName,
						"isPrimariKey":attris[i].isPrimariKey,
						"isAllowNull":attris[i].isAllowNull,
						"isIndex":attris[i].isIndex,
						"isUnique":attris[i].isUnique,
						"length":attris[i].length,
						"type":attris[i].type,
						"validataRuler":attris[i].validataRuler
						});
				}
				
				var foreigns=$("#foreignGrid").datagrid("getData").rows;
				var foreignsObject=new Array();
				for(var i=0;i<foreigns.length;i++){
					var foreignRow=new Object();
					if(foreigns[i].model!=undefined){
						foreignRow={
							"fKId":foreigns[i].fKId,
							"fKCName":foreigns[i].fKCName,
							"fKEName":foreigns[i].fKEName,
							"fKMainAttribute":foreigns[i].fKMainAttribute,
							"refModelId":foreigns[i].attri.model.modelId,
							"refModelCName":foreigns[i].attri.model.modelCName,
							"refAttriId":foreigns[i].attri.attributeId,
							"refAttriCName":foreigns[i].attri.attributeCName
						};
					}else{
						foreignRow={
							"fKId":foreigns[i].fKId,
							"fKCName":foreigns[i].fKCName,
							"fKEName":foreigns[i].fKEName,
							"fKMainAttribute":foreigns[i].fKMainAttribute,
							"refModelId":foreigns[i].refModelId,
							"refModelCName":foreigns[i].refModelCName,
							"refAttriId":foreigns[i].refAttriId,
							"refAttriCName":foreigns[i].refAttriCName
						};
					}
					foreignsObject.push(foreignRow);
				}
				
				$.ajax({  
				   type: "post",  
				   dataType:'json',
				   cache:false,  
				   data:{"model":JSON.stringify(modelObject),"attris":JSON.stringify(attrisObject),"foreigns":JSON.stringify(foreignsObject)}, 
				   url: url,  
				   beforeSend: function(XMLHttpRequest){  
				   },  
				   success: function(data){  
						if(data.success==true){
									$.messager.alert('提示','模型修改成功！！！');
									$("#attriGrid").datagrid('reload');
									$("#foreignGrid").datagrid('reload');
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
	});
	
});



