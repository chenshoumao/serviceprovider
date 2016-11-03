 <%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
 
		 
		<!-- 右边内容 -->
		<div class="stations_right">
			<h1 class="wholeh1">
				<span class="blue">人员查找列表</span>
			</h1>
			
			<c:forEach items="${list}" var="list" varStatus="status">
				<div class="queryResult">
					<img src="<%=basePath%>images/information4.png">
					<p>&nbsp;<span> · 姓名：</span><span>${list.name }</span></p>
					<p>&nbsp;<span> · 电话：</span><span>${list.mobile}</span></p>
					<p>&nbsp;<span> · 邮箱：</span><span>${list.mail}</span></p>
					<p>&nbsp;<span> · 地址：</span><span>漳州招商大道招商局</span></p>
				</div>
			</c:forEach> 
		</div>
