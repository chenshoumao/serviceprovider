package com.solar.tech.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "FW_BizLog")
public class BizLog{
	@Id
	@GenericGenerator (name="idgene",strategy="native")
	@GeneratedValue(generator="idgene")
	@Column(name = "LogId")
	private Integer logId;

	@Column(name = "LogName", length=50)
	private String logName;

	@Column(name = "UserName", length=50)
	private String userName;

	@Column(name = "ClassName", length=50)
	private String className;

	@Column(name = "MethodName", length=50)
	private String methodName;

	@Column(name = "CreateTime")
	private Date createTime;

	@Column(name = "LogLevel", length=20)
	private String logLevel;

	@Column(name = "Msg", length=555)
	private String msg;

	@Column(name = "BizCode", length=25)
	private String bizCode;


	public Integer getLogId(){
		return this.logId;
	}

	public void setLogId(Integer logId){
		this.logId=logId;
	}

	public String getLogName(){
		return this.logName;
	}

	public void setLogName(String logName){
		this.logName=logName;
	}

	public String getUserName(){
		return this.userName;
	}

	public void setUserName(String userName){
		this.userName=userName;
	}

	public String getClassName(){
		return this.className;
	}

	public void setClassName(String className){
		this.className=className;
	}

	public String getMethodName(){
		return this.methodName;
	}

	public void setMethodName(String methodName){
		this.methodName=methodName;
	}

	public Date getCreateTime(){
		return this.createTime;
	}

	public void setCreateTime(Date createTime){
		this.createTime=createTime;
	}

	public String getLogLevel(){
		return this.logLevel;
	}

	public void setLogLevel(String logLevel){
		this.logLevel=logLevel;
	}

	public String getMsg(){
		return this.msg;
	}

	public void setMsg(String msg){
		this.msg=msg;
	}

	public String getBizCode(){
		return this.bizCode;
	}

	public void setBizCode(String bizCode){
		this.bizCode=bizCode;
	}

}