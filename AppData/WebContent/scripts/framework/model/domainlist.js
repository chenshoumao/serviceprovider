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
$("document").ready(function(){

	//初始化grid
	$("#datagrid").datagrid({
		url:rootPath+'/framework/model/getDomainPage.action',
		method:'post',
		pageSize:10,
		pageList:[10,20],
		columns:[[
				  {field:'check',width:10,checkbox:true},
		          {field:'domainId',title:'数据域ID',width:80},
		          {field:'domainCName',title:'数据域中文名',width:80},
		          {field:'domainEName',title:'数据域英文名',width:80,align:'right'},
		          {field:'domainDesc',title:'描述',width:80,align:'right'},
		      ]],
		pagination:true,
		onSelect:function(rowIndex,rowData){
			$("#toolbar_edit").linkbutton('enable');
			$("#toolbar_delete").linkbutton('enable');
			
		},
		rowStyler:function(index,row){     
		if (index%2==0){     
				return 'background-color:rgb(233,240,255);font-weight:bold;';     
			}     
		},
		onDblClickRow:function(index,field,value){
			$('#form').form('load',field);
			$('#domainDesc').val(field.domainDesc);
			//展现隐藏的id
			$('#form table tr').eq(0).css({'visibility':'visible'});
			$('#dialog').css('display','block');
			$('#dialog').dialog('setTitle','修改数据域');
			$('#dialog').dialog('open');
			
		}			
  
	});
	$('#toolbar_edit').linkbutton("disable");
	$('#toolbar_delete').linkbutton("disable");
	
	
	//新建和修改窗体初始化
	$('#dialog').dialog({
	    title: '新建数据域',
		resizable:true,
	    closed: true,
	    cache: false,
	    modal: true,
		buttons:[{
				text:'保存',
				iconCls:"icon-ok",
				handler:function(){
					if($("#form").form('validate'))
					{
						var url=rootPath+'/framework/model/addDomain.action';
						if($('#domainId').val()!="")
							url="../../../framework/model/updateDomain.action";
						$('#form').form('submit', {
							url:url,
							success:function(data){
								console.log(data);
								var result=$.parseJSON(data);
								if(result.success==true){
									if($('#domainId').val()!=""){
										$.messager.alert('提示','数据域修改成功！！！');
									}
									else
										$.messager.alert('提示','数据域添加成功！！！');
									$('#datagrid').datagrid('reload');
								}
								else if(result.msg!=""){
									$.messager.alert('提示','创建失败！！！</br>异常编码：'+result.code+'</br>异常名字：'+result.name+'</br>异常原因：'+result.msg+'</br>请求连接：'+result.url);
								}
								$('#form').form('clear');
								$('#dialog').dialog('close');
							}
						});
					
					}
				}
			},{
				text:'取消',
				iconCls:"icon-cancel",
				handler:function(){
					$('#form').form('clear');
					$('#dialog').dialog('close');
				}
			}]
	});
	
	//添加数据域
	 $("#toolbar_add").bind('click',function(){
		$('#form table tr').eq(0).css({'visibility':'hidden'});
		$('#form').form('clear');
		$('#dialog').css('display','block');
		$('#dialog').dialog('open');
	})
	
	//删除数据域
	 $("#toolbar_delete").bind('click',function(){
		var checkedRows=$('#datagrid').datagrid('getChecked');
		if(checkedRows.length<1)
			$.messager.alert('提示','请选择要删除的记录！！！');
		else{
			$.messager.confirm('确认', '是否真的要删除所选记录？', function(r){
				if (r){
					var ids=new Array();
					for(var i=0;i<checkedRows.length;i++)
						ids.push(checkedRows[i].domainId);
					$.ajax({  
					 type: "post",  
					   dataType:'json',
					   cache:false,  
					   data:{"ids":ids},  
					   url: "../../../framework/model/deleteDomain.action",  
					   beforeSend: function(XMLHttpRequest){  
					   },  
					   success: function(data){  
						   console.log(data);
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
	})
});



