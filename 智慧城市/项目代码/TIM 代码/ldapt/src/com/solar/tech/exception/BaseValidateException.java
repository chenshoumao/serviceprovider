package com.solar.tech.exception;
/**
 * 
 * @ClassName BaseValidateUtil
 * @Description 基本类型的校验 异常类
 * @Author xwj
 * @copyRight 续日科技 solartech
 * @Date 2015年07月11日
 * @Version V1.0.1
 */
public class BaseValidateException extends Exception{

	public BaseValidateException(String message, Throwable cause) {
		super(message, cause);
	}

	public BaseValidateException(String message) {
		super(message);
	}

	public BaseValidateException(Throwable cause) {
		super(cause);
	}
	
}
