<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
        <%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
	<%-- <div id="topbar" style="width:100%;">
      <table id="toptab" style="width:100%">
            <tr style="width:100%">
                <th  style="width:75%">
                <img src="<%=basePath %>images/framework/logo.png" />
                <div id="usercbmenu">
                    	<ul>
	                   		<li></li>
	                   	</ul>
                    </div>
                </th>
    
                <th style="width:25%">
                
                    <span style="font-size:21px; color:#FFFFFF">
                   欢迎你登录：<%=com.solartech.framework.ldap.Current.user()%>&nbsp;<a href="#">退出</a>
              </span>
                </th>
            </tr>
        </table>
        <div style="float:left; width:80%;">dd</div>
        <div style="float:left; width:250px;;">    
        <div class="logonuser_txt">
           

                    </div></div>
        
    </div> --%>
    
    <style>
    body,div,dl,dt,dd,ul,ol,li,h1,h2,h3,h4,h5,h6,pre,
form,fieldset,input,textarea,p,blockquote,th,td,a{
	margin:0px;padding:0px;font-family:"微软雅黑";
}
a{text-decoration:none; color: #9D9C9C;}
ul li{list-style:none;}
.clear{clear:both;}

	#header{
		/* width: 100%; */
		height: 80px;
		background-color: rgb(57,110,165);
		background: url("<%=basePath %>images/framework/bg.jpg") repeat-x 0px 0px;
	}
	.logo{
		width:295px;
		height:60px;
		background: url("<%=basePath %>images/framework/logo.png") no-repeat 0px 0px;
		float: left;
		margin-left: 30px;
    	margin-top: 11px;
	}
	#header ul{
		margin-left: 1150px;

	}
	#header ul li{
		float: left;
		list-style: none;
		font-size: 16px;
		color: #fff;
		margin-top: 30px;
	}
	#header ul li a{
		
		color: #fff;

	}
</style>

	<div id="header">
		<div class="logo"></div>
		<ul>
			<li> Welcome：<%=com.solar.tech.util.Current.user().getUserName()%>&nbsp;&nbsp;		
			 <a href="/Dats/logout.action">Logout</a>
			</li>
			
		</ul>
	</div>
