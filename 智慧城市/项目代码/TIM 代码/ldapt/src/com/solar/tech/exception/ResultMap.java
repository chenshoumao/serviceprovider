package com.solar.tech.exception;

import java.util.HashMap;

public class ResultMap {

   
    static HashMap<String, String> map;
    
    static{
		 map = new HashMap<String, String>();
	     map.put(ResultCode.SYS_NUMBERFORMATEEEPTION, "系统数据转换异常");
	     map.put(ResultCode.SYS_SQLEXCEPTION, "系统数据库操作异常");
	     map.put(ResultCode.SYS_EXCEPTION, "系统异常");
	     map.put(ResultCode.BUS_MODELREPEATEXCEPTION, "模型重复异常");
	     map.put(ResultCode.BUS_ATTRILENGTHBEYONDRANGEEXCEPTION, "属性长度超出范围异常");
    }

    public static String get(String key) {
        return map.get(key);
    }

    public void put(String key, String value) {
        map.put(key, value);
    }

}
