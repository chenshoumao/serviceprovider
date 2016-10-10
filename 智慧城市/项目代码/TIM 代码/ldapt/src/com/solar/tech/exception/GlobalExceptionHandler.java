package com.solar.tech.exception;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.apache.shiro.authc.AuthenticationException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
/**
 * 
 * @GlobalExceptionHandler.java
 * 功能描述：负责系统全局异常的处理    如果是ajax方法访问异常   则将异常信息转换成json数据返回天台页面进行展现 
 * 版本号：V1.1 作者：xwj
 * © Copyright 续日科技 2015-04-30  版权所有 
 * 使用者必须经过许可
 *
 */
@ControllerAdvice
public class GlobalExceptionHandler {

	private static final Logger logger = Logger.getLogger(GlobalExceptionHandler.class);
	
	@ExceptionHandler(Exception.class)
	public @ResponseBody ExceptionMsg handleAuthenticationException(HttpServletRequest req, Exception ex){
		logger.debug("", ex);
		ExceptionMsg response = new ExceptionMsg();
		response.msg=ex.getMessage();
		System.out.println(ex.getMessage());
		return response;
	}
	
	
	/*
	@ResponseStatus(value=HttpStatus.NOT_FOUND, reason="IOException occured")
	@ExceptionHandler(IOException.class)
	public void handleIOException(){
		logger.error("IOException handler executed");
		//returning 404 error code
	}
	*/
	
	
	
	
	//删除关系违反约束异常
/*	@ExceptionHandler(value=NumberFormatException.class)
	public @ResponseBody ExceptionMsg handleNumberFormatException(HttpServletRequest request, Exception ex){
		ExceptionMsg response = new ExceptionMsg();
		response.code=ResultCode.SYS_NUMBERFORMATEEEPTION;
		response.name=ResultMap.get(response.code);
		response.msg=ex.getMessage();
		response.url=request.getRequestURI();
		logger.info(response.log());
		return response;
	}
	*/
	
	
	//删除关系违反约束异常
	/*@ExceptionHandler(value=Exception.class)
	public @ResponseBody ExceptionMsg handleException(HttpServletRequest request, Exception ex){
		ExceptionMsg response = new ExceptionMsg();
		response.code=ResultCode.SYS_NUMBERFORMATEEEPTION;
		response.name=ResultMap.get(response.code);
		response.msg=ex.getMessage();
		response.url=request.getRequestURI();
		logger.info(response.log());
		System.out.println("exception..........");
		return response;
	}*/
}
