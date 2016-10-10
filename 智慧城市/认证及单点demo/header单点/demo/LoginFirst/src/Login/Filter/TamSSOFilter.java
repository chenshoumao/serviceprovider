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
		 * ��ȡwebseal�ķ��������ƣ����Ϊ�գ�������
		 */
		System.out.println(httprequest.getHeader("iv_server_name"));
		if (httprequest.getHeader("iv_server_name") == null) {
			chain.doFilter(httprequest, httpresponse);
			return;
		}
		/**
		 * ��ȡwebseal���͵���Աid�����Ϊ�գ�������
		 */

		userid = httprequest.getHeader("iv-user");
		System.out.println(userid);
		if (userid == null) {
			chain.doFilter(httprequest, httpresponse);
			return;
		}
		/**
		 * ��ȡ�ͻ��������IP�����δע�ᣬ������
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
		 * �����ͨ�������뽫����е���������ع�session����
		 * ��sesssion��ע����ز���������ҵ��ϵͳ�ļ��
		 */
		HttpSession session = httprequest.getSession();
		/**
		 * ��Ҫ������صĽӿڣ���ͬ��ҵ��ϵͳ��ʽ��һ��
		 */
		session.setAttribute("sync_is_login", Boolean.TRUE);
		session.setAttribute("sync_is_admin", Boolean.TRUE);
		chain.doFilter(httprequest, httpresponse);

	}

	// ��ȡ���ε�ַ
	public void init(FilterConfig config) throws ServletException {
		
		String trusthost = config.getInitParameter("TrustHost");

		// ��ȡ�����¼�ķ�ʽ
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
