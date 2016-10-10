<%@page import="com.solar.tech.bean.Charge"%>
<%@ page import="com.solar.tech.exception.ResultCode"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Date"%>

<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
<title>Insert title here</title>
<style type="text/css">
#cc {
	margin: 0 auto;
}

.fitem {
	margin: 30px 0 0 40px;
}

#tt {
	border: 1px solid silver;
}

table {
	
}

button {
	margin-top: 30px;
	margin-left: 30px;
}
</style>

<script type="text/javascript">

var po_no = '${param.pono}';
 
var editRow = undefined;
var isComputed = true;
$(function(){ 
$("#po_no").val(po_no);  findIsLock();	});
	function findIsLock(){
	 $.ajax({
            			url : '<%=basePath %>framework/charge/findIsLock.action',  
            			type : "post",
            			data : {
            					"pono" : po_no
            				},
            			dataType : "json",           			 
            			success : function(data) {
            				if (data.success){
            					var json = data.isLock;
            					if(json == '1'){ 
            					alert(json);
            						//document.getElementById("contractPrice").readOnly=true;
            						  $('#contractPrice').textbox('readonly',true);
            						 //$('#originalContract').filebox('enable');           						 
            						 suoding(); 
            					}
            					else{
            						alert(json);
            					 	$('#contractPrice').textbox('readonly',false);
            					 //	$('#originalContract').filebox('enable');
            						loadData();            						
            					}
            				}
            					 
            				}
            			 
            		});
	}
	function loadData(){
		

$('#tt').datagrid({
							title : '结算费用',
							url: '<%=basePath %>framework/charge/shows.action?pono='+po_no,  
							onLoadSuccess: compute,  
						   height:220,
   							columns:[[    
        						 { field: 'order', title: '序号', width:45, align: 'center'}, 
       							 { field: 'originalPrice', title: '原始价格', width: 145, align: 'center', editor: { type: 'text', options: { required: true } } },
            					 { field: 'finalPrice', title: '最终价格', width: 145, align: 'center', editor: { type: 'text', options: { required: true } } },
            					 { field: 'construction', title: '解释', width: 145, align: 'center', editor: { type: 'text', options: { required: true } }},   
       							        							     
   							 ]],
							
							 toolbar: [{
            text: '添加', iconCls: 'icon-add', handler:  addrow
        }, '-', {
            text: '删除', iconCls: 'icon-remove', handler: function () { 
                 if (editRow == undefined){return}
           			 $('#tt').datagrid('cancelEdit', editRow)
                    	.datagrid('deleteRow', editRow);
           		 	editRow = undefined;
            }
        }, '-', {
            text: '回退', iconCls: 'icon-undo', handler: function () { 
            		isComputed = false;
                  $('#tt').datagrid('rejectChanges');
            		editRow = undefined;
            		
            		  
            }
        }], 	
							onBeforeEdit : function(index, row) {
								row.editing = true;
								$('#tt').datagrid('refreshRow', index);
								editcount++;
							},
							onAfterEdit : function(index, row) { 
            					editRow = undefined; 
            					 editcount--;
							},
							 
							onDblClickCell:function(rowIndex, field, value){
							 
								 if (editRow != undefined) {
                					$("#tt").datagrid('endEdit', editRow);
            						}
 
            						if (editRow == undefined) {
                						$("#tt").datagrid('beginEdit', rowIndex);
                						editRow = rowIndex;
            						}
							},
							onClickRow:function(rowIndex,rowData){
							 
            					if (editRow != undefined) {
                				$("#tt").datagrid('endEdit', editRow);
 
            					}
            
        					}
						}) ; 
						
	}
	
	function suoding(){
	 	 
		$('#tt').datagrid({
							title : '结算费用',
							url: '<%=basePath %>framework/charge/shows.action?pono='+po_no,  
							onLoadSuccess: compute,  
							height:220,
   							columns:[[    
        						 { field: 'order', title: '序号', width:45, align: 'center'}, 
       							 { field: 'originalPrice', title: '原始价格', width: 145, align: 'center', editor: { type: 'text', options: { required: true } } },
            					 { field: 'finalPrice', title: '最终价格', width: 145, align: 'center', editor: { type: 'text', options: { required: true } } },
            					 { field: 'construction', title: '解释', width: 145, align: 'center', editor: { type: 'text', options: { required: true } }},   
       							        							     
   							 ]],
							
							 toolbar: [{
            text: '添加', iconCls: 'icon-add'
        }, '-', {
            text: '删除', iconCls: 'icon-remove', handler: function () { 
                
            }
        }, '-', {
            text: '回退', iconCls: 'icon-undo', handler: function () {  
            }
        }], 
							onBeforeEdit : function(index, row) {
								row.editing = true;
								$('#tt').datagrid('refreshRow', index);
								editcount++;
							},
							onAfterEdit : function(index, row) { 
            					editRow = undefined; 
							},
							onDblClickCell:function(rowIndex, field, value){
							 
								 
							},
							onClickRow:function(rowIndex,rowData){
							 
            					 
            
        					}
						}) ; 
	}
	
	 function compute() {//计算函数
	  
	  if(isComputed){
	  		 
            var rows = $('#tt').datagrid('getRows');//获取当前的数据行
            
           // alert(rows[0]['contractPrice']);
            $("#contractPrice").textbox('setValue',rows[0]['contractPrice']);
            $("#isLock").val(rows[0]['isLock']);
           
            var ShouldPay = 0 ;
            var AreadyPay = 0;
             
            for (var i = 0; i < rows.length; i++) {
                if(!isNaN(parseFloat(rows[i]['originalPrice'])))
                ShouldPay += parseFloat(rows[i]['originalPrice']);
                if(!isNaN(parseFloat(rows[i]['finalPrice'])))
                AreadyPay += parseFloat(rows[i]['finalPrice']);
            }
          
		   $('#tt').datagrid('appendRow', { order: '<b>统计：</b>', originalPrice: ShouldPay, finalPrice: AreadyPay });
		  // $("#originalContract").filebox('setValue',rows[0]['filePath']);
		  alert(rows[0]['filePath']);
		  
		  if(num != ""){ 
		  	$("#isLock").val(num);
		  }
		  
		  } 
	}
	var editcount = 0;
	function editrow(index) {
		$('#tt').datagrid('beginEdit', index);
	}
	var currentIndex = 0;
	function deleterow(index) {
	     var allCheckedRows = $("#tt").datagrid('getChecked'); 
         var checkedRowLength = allCheckedRows.length;
        
         var checkedRow = allCheckedRows[0];
         var checkedRowIndex = $("#tt").datagrid('getRowIndex', checkedRow);
            
         
		$.messager.confirm('确认', '是否真的删除?', function(r) {
			if (r) {
			 
            $("#tt").datagrid('deleteRow', checkedRowIndex);
           
			}
		});
	}
	function saverow(index) {
		$('#tt').datagrid('endEdit', index);
		var row = $("#tt").datagrid('selectRow',index);
		 
		
		var _list = {};
		var rows = $('#tt').datagrid('getRows');
		for ( var i = 0; i < rows.length; i++) {
			var row = rows[i];
			_list["list[" + i + "].originalPrice"] = rows[i].originalPrice; //这里list要和后台的参数名List<Category> list一样
			_list["list[" + i + "].finalPrice"] = rows[i].finalPrice;
			_list["list[" + i + "].construction"] = rows[i].construction;
		}
		 
	}
	function cancelrow(index) {
		$('#tt').datagrid('cancelEdit', index);
	}
	function addrow() {
		if (editcount > 0) {
			$.messager.alert('警告', '当前还有' + editcount + '记录正在编辑，不能增加记录。');
			return;
		}
		var rows = $('#tt').datagrid('getRows');
		var index = rows.length;
		 
		$('#tt').datagrid('appendRow', {
			order:index,
			originalPrice : '',
			finalPrice : '',
			construction : ''

		});
		var todown =  $('#tt').datagrid('getData').rows[index-1];
            var toup =  $('#tt').datagrid('getData').rows[index];
             $('#tt').datagrid('getData').rows[index ] = todown;
             $('#tt').datagrid('getData').rows[index-1] = toup;
             $('#tt').datagrid('refreshRow', index-1);
             $('#tt').datagrid('refreshRow', index  );
             $('#tt').datagrid('selectRow', index  );
	}
	function saveall() {
		$('#tt').datagrid('acceptChanges');
	}
	 function reject(){
            $('#dg').datagrid('rejectChanges');
            editIndex = undefined;
        }

	function saveBean() {
		var data = $('#tt').datagrid('getData');
		$("input[name='mmm']").val(JSON.stringify(data));

		$('#fm').form('submit', {
			url : '<%=basePath%>framework/charge/upload.action',
			onSubmit : function() { 
				return $(this).form('validate');
			},
			success : function(result) {
				 alert("success");
				 findIsLock();
			}
		});  
	}
	var num = "";
	
	function tog(){
		num = ($("#isLock").val() == 1)? '0' : '1';  
		$("#isLock").val(num);
		saveBean();
		
	}
</script>
</head>
<body>
	<div id="cc" class="easyui-layout" style="width:600px;height:440px;"
		action="framework/charge/upload">

		<div data-options="region:'center',title:'费用变更'"
			style="padding:5px;background:#eee;">
			<form id="fm" method="post" enctype="multipart/form-data" novalidate>
				<input style="display:none" name="mmm">
				<input style="display:none;" id="po_no"  name="po_no">
				<input style="display:none;" id="isLock"  name="isLock">
				<div class="fitem">
					<label>合同报价:</label> <input name="contractPrice" id="contractPrice"
						class="easyui-textbox"
						data-options="validType:['length[3,15]', 'isExist']"  />

				</div>

				<div class="fitem">
					<label>合同原件:</label> <input name="originalContract" id="originalContract"
						class="easyui-filebox"
						data-options="validType:['length[3,105]', 'isExist']" />

				</div>


				<label>结算费用:</label>
				<div id="tt" style="width: 100%;height:100%"></div>



				<div class="fitem">
					<a href="#" class="easyui-linkbutton" onclick="saveBean()">submit</a>
					<a href="#" class="easyui-linkbutton"
						onclick="tog()">approvile</a> <a
						href="#" class="easyui-linkbutton"
						onclick="javascript:$('#mm').menu('hide')">people</a>
				</div>



			</form>

		</div>
	</div>
</body>
</html>