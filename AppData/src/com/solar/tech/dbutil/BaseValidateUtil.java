package com.solar.tech.dbutil;

import java.text.SimpleDateFormat;

import com.solar.tech.exception.BaseValidateException;

/**
 * 
 * @ClassName BaseValidateUtil
 * @Description 基本类型的校验类
 * @Author xwj
 * @copyRight 续日科技 solartech
 * @Date 2015年07月11日
 * @Version V1.0.1
 */
public class BaseValidateUtil {
	
	
	/**
	 * 检查是否是int的值
	 * @param value
	 * @throws BaseValidateException 
	 */
	public static void checkInt(String value) throws BaseValidateException{
		try {
			
			Integer.parseInt(value);
		} catch (NumberFormatException e) {
			throw new  BaseValidateException("属性值为"+value+"转换成int时转换异常",e);
		}
	}
	
	/**
	 * 检查是否是double的值
	 * @param value
	 * @throws BaseValidateException 
	 */
	public static void checkDouble(String value) throws BaseValidateException{
		try {
			Double.parseDouble(value);
		} catch (NumberFormatException e) {
			throw new  BaseValidateException("属性值为"+value+"转换成double时转换异常",e);
		}
	}
	
	
	/**
	 * 检查是否是bool的值  bool类型的值 只能是true或则false
	 * @param value
	 * @throws BaseValidateException 
	 */
	public static void checkBoolean(String value) throws BaseValidateException{
		if(!"true".equals(value) ||"false".equals(value))
			throw new  BaseValidateException("属性值为"+value+"转换成bool时转换异常");
	}
	
	

	/**
	 * 检查是否是Date的值   日期格式只能是  XXXX-XX-XX的格式
	 * @param value
	 * @throws BaseValidateException 
	 */
	public static void checkDate(String value) throws BaseValidateException{
		try {
			SimpleDateFormat format = new SimpleDateFormat(
					"yyyy-MM-dd");
			format.parse(value);
		}catch (Exception e) {
			throw new  BaseValidateException("属性值为"+value+"转换成Date时转换异常",e);
		}
	}
	
	
	/**
	 * 检查是否是TimeStamp的值   时间戳格式只能是  XXXX-XX-XX HH:mm:ss的格式
	 * @param value
	 * @throws BaseValidateException 
	 */
	public static void checkTimeStamp(String value) throws BaseValidateException{
		try {
			SimpleDateFormat format = new SimpleDateFormat(
					"yyyy-MM-dd HH:mm:ss");
			format.parse(value);
		}catch (Exception e) {
			throw new  BaseValidateException("属性值为"+value+"转换成TimeStamp时转换异常",e);
		}
	}
	
}
