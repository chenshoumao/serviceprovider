<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()+path;
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="easyui-accordion" data-options="fit:true,border:false">
	<c:forEach var="menu" items="${sysMenus}" varStatus="s">
		<div title="${menu.menuName}" name="${menu.menuName}">
			<div id="leftmenuTree${menu.menuId}"></div>
			<script type="text/javascript">
		   $('#leftmenuTree${menu.menuId}').tree({   
            url: '<%=basePath%>/framework/sysMenuItem.action?parentItemId=0&menuId=${menu.menuId}',   
            onBeforeExpand:function(node,param){  
                $('#leftmenuTree${menu.menuId}').tree('options').url = "<%=basePath%>/framework/sysMenuItem.action?parentItemId="
                		+ node.id+ "&menuId=${menu.menuId}";
									},
									onClick : function(node) {
										var id = node.id;
										var href = node.url;
										var isLeaf = node.isLeaf;
										var title = node.text
										var target = node.attributes.target;
										var parentNode = $('#leftmenuTree${menu.menuId}').tree('getParent', node.target);
										if(href!==null&&href!=""){
										if (target == "_blank") {
											window.open(href);
										} else {
											if (parentNode == null) {
												addTab(title, "<%=basePath%>"+href);
											} else {
												addTab(parentNode.text + "-"+ title,  "<%=basePath%>"+href);
											}
										}
									}
									}

								});
								
								
			function todo(title,url){ 
            	addTab(title, url);
			} 	 				
			</script>
		</div>
	</c:forEach>
</div>
