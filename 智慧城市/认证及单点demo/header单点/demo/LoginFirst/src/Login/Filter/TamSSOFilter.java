package Login.Filter;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;

import javax.net.ssl.HostnameVerifier;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class TamSSOFilter implements Filter{
	private boolean CheckTrustHost = true;
	private ArrayList list = new ArrayList();

	public void destroy() {
	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		
		HttpServletRequest httprequest = (HttpServletRequest) request;
		HttpServletResponse httpresponse = (HttpServletResponse) response;
		String userid = null;
		/**
		 * 获取webseal的服务器名称，如果为空，不处理
		 */
		System.out.println(httprequest.getHeader("iv_server_name"));
		if (httprequest.getHeader("iv_server_name") == null) {
			chain.doFilter(httprequest, httpresponse);
			return;
		}
		/**
		 * 获取webseal发送的人员id，如果为空，不处理
		 */

		userid = httprequest.getHeader("iv-user");
		System.out.println(userid);
		if (userid == null) {
			chain.doFilter(httprequest, httpresponse);
			return;
		}
		/**
		 * 获取客户端请求的IP，如果未注册，不处理
		 */
		String remoteIp = request.getRemoteAddr();
		System.out.println(remoteIp);
		System.out.println(CheckTrustHost);
		System.out.println(list);
		System.out.println(list.size());
		System.out.println(!list.contains(remoteIp));
		if (CheckTrustHost && !list.contains(remoteIp)) {
			return;
		}
		/**
		 * 如果都通过，代码将会进行到这里，进行县官session操作
		 * 向sesssion中注入相关参数，跳过业务系统的检查
		 */
		HttpSession session = httprequest.getSession();
		/**
		 * 需要开发相关的接口，不同的业务系统方式不一样
		 */
		session.setAttribute("sync_is_login", Boolean.TRUE);
		session.setAttribute("sync_is_admin", Boolean.TRUE);
		chain.doFilter(httprequest, httpresponse);

	}

	// 获取信任地址
	public void init(FilterConfig config) throws ServletException {
		
		String trusthost = config.getInitParameter("TrustHost");

		// 获取单点登录的方式
		System.out.println(trusthost);
		String ssotype = config.getInitParameter("SSOType");
		if (null == trusthost || trusthost.equals("")
				|| trusthost.length() == 0) {
			CheckTrustHost = false;
			return;
		}
		else if (trusthost.indexOf(";") != -1) {
			String hostValue[] = trusthost.split(";");
			list.addAll(Arrays.asList(hostValue));
		}
		else{
			list.add(trusthost);
		}
		System.out.println(CheckTrustHost);
		
	}

}
