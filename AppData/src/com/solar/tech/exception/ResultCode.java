package com.solar.tech.exception;

//异常 编码 
//所有系统异常以 SYS_开头         编码 分布在 1到 10000
//所有自定义异常 以     BUS_+"模块名称"+"异常名"  编码 分布在 10000之后
public class ResultCode {

	public static final String SYS_NUMBERFORMATEEEPTION="1";
	public static final String SYS_SQLEXCEPTION="2";
	public static final String SYS_EXCEPTION="3";
	
	
	
	
	
	
	public static final String BUS_MODELREPEATEXCEPTION="20001";
	public static final String BUS_ATTRILENGTHBEYONDRANGEEXCEPTION="20002";
	
	
	
	
	
	
	
}
