package ldap.control;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;

public class TestInterface {
	public static void main(String[] args) {
		String result = "";
        BufferedReader in = null;
        String dataurl="http://10.161.2.68:9080/TIMInterface/login/login.action?username=chenss&password=123456";
        try {
        URLConnection con=new URL(dataurl).openConnection();
        
        System.out.println("dataurl-----:"+dataurl);
        // 设置通用的请求属性
        con.setRequestProperty("accept", "*/*");
        con.setRequestProperty("connection", "Keep-Alive");
        con.setRequestProperty("Content-Type", "application/json;charset=UTF-8");
        // 建立实际的连接
       
       
        // 定义 BufferedReader输入流来读取URL的响应
       
        	con.connect();
			in = new BufferedReader(new InputStreamReader(
					con.getInputStream()));
			  String line;
		        while ((line = in.readLine()) != null) {
		            result += line;
		        }
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
      
	}
}
