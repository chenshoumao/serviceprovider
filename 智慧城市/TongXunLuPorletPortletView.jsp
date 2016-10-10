<%@page session="false" contentType="text/html" pageEncoding="UTF-8" import="java.util.*,javax.portlet.*,com.ibm.tongxunluporlet.*" %>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet"%>        
<%@taglib uri="http://www.ibm.com/xmlns/prod/websphere/portal/v6.1/portlet-client-model" prefix="portlet-client-model" %>        
<portlet:defineObjects/>
<portlet-client-model:init>
      <portlet-client-model:require module="ibm.portal.xml.*"/>
      <portlet-client-model:require module="ibm.portal.portlet.*"/>   
</portlet-client-model:init> 
<%
	com.ibm.tongxunluporlet.TongXunLuPorletPortletSessionBean sessionBean = (com.ibm.tongxunluporlet.TongXunLuPorletPortletSessionBean)renderRequest.getPortletSession().getAttribute(com.ibm.tongxunluporlet.TongXunLuPorletPortlet.SESSION_BEAN);
%>
 

<DIV style="margin: 6px">

<H3 style="margin-bottom: 3px">Welcome!</H3>
This is a sample view mode page.  You have to edit this page to customize it for your own use.<BR>
<H3 style="margin-bottom: 3px">Order entry</H3>
This is a sample form to test action handling.

<DIV style="margin: 12px; margin-bottom: 36px">
<% /******** Start of sample code ********/ %>
<%
	String formText = sessionBean.getFormText();
/*	String name = sessionBean.getName();
	String department = sessionBean.getDepartment();
	String title = sessionBean.getTitle();
	String mobile = sessionBean.getMobile();
	String mail = sessionBean.getMail();
	String uid = sessionBean.getUid();*/
	
	List<Map<String, Object>> list = sessionBean.getList();	
	
	System.out.println(list.size());	
	for(int i = 0;i < list.size();i++){
		Map<String,Object> map = list.get(i);
		
		String name = map.get("name").toString();
	System.out.println(name);	
		String mobile = map.get("mobile").toString();
	System.out.println(mobile);
		String title =  map.get("title").toString();
	System.out.println(title);
		String department =  map.get("department").toString();
	System.out.println(department);
		String mail =  map.get("mail").toString();
	System.out.println(mail);
	if(name.length() > 0){
			%>
			name is: "<%=name %>"<br>
			<%
		}
		if(title.length() > 0){
			%>
			title is: "<%=title %>"<br>
			<%
		}
		if(mail.length() > 0){
			%>
			mail is: "<%=mail %>"<br>
			<%
		}
		if(mobile.length() > 0){
			%>
			mobile is: "<%=mobile %>"<br>
			<%
		}
		if(department.length() > 0){
			%>
			department is: "<%=department %>"<br>
			<%
		}
	}	
	
	%>
	<FORM method="POST" action="<portlet:actionURL/>">
		<LABEL  for="<%=com.ibm.tongxunluporlet.TongXunLuPorletPortlet.FORM_TEXT%>">Enter Order id:</LABEL><BR>
		<INPUT name="<%=com.ibm.tongxunluporlet.TongXunLuPorletPortlet.FORM_TEXT%>" type="text"/>
		<INPUT name="GOVIEW" value="<%=com.ibm.tongxunluporlet.TongXunLuPorletPortlet.VIEW_JSP%>" type="hidden" value="FORWARD_VIEW"/>
		<INPUT name="<%=com.ibm.tongxunluporlet.TongXunLuPorletPortlet.FORM_SUBMIT%>" type="submit" value="Submit"/>
	</FORM>
	
	<FORM method="POST" action="<portlet:actionURL/>"> 
		<INPUT name="GOVIEW" value="<%=com.ibm.tongxunluporlet.TongXunLuPorletPortlet.NEWFILE%>" type="submit"/>
	</FORM>
<% /******** End of sample code *********/ %>
</DIV>

</DIV>
