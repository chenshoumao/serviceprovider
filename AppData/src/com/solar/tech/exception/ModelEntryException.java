package com.solar.tech.exception;
/**
 * 
 * @ClassName ModelEntryException
 * @Description 模型的实例数据异常类
 * @Author xwj
 * @copyRight 续日科技 solartech
 * @Date 2015年07月11日
 * @Version V1.0.1
 */
public class ModelEntryException extends Exception{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public ModelEntryException(String message, Throwable cause) {
		super(message, cause);
	}

	public ModelEntryException(String message) {
		super(message);
	}

	public ModelEntryException(Throwable cause) {
		super(cause);
	}
	
}
