package com.solar.tech.exception;

public class ExceptionMsg {
	public String code;     //异常 编码 
	public String name;     //异常 名字
	public String url;      //异常 请求url
	public String msg;      //异常 消息 
	
	
	
	public String log(){
		StringBuffer sb=new StringBuffer();
		sb.append("\n");
		sb.append("*************************************Exception**************************************\n");
		sb.append("***  异常编码:"+code+"\n");
		sb.append("***  异常名称:"+name+"\n");
		sb.append("***  请求连接:"+url+"\n");
		sb.append("***  异常信息:"+msg+"\n");
		sb.append("*************************************Exception**************************************\n");
		return sb.toString();
	}
}
