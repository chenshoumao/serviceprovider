package com.solar.tech.bean;



public class ToDo {
	
	private String EnName;
	private String CnName;	
	private String Title;
	private String receiveTime;	
	private String PendingName;
	private String todoUrl;
	
	public String getEnName() {
		return EnName;
	}
	public void setEnName(String enName) {
		EnName = enName;
	}
	public String getCnName() {
		return CnName;
	}
	public void setCnName(String cnName) {
		CnName = cnName;
	}
	public String getTitle() {
		return Title;
	}
	public void setTitle(String title) {
		Title = title;
	}
	public String getReceiveTime() {
		return receiveTime;
	}
	public void setReceiveTime(String receiveTime) {
		this.receiveTime = receiveTime;
	}
	public String getPendingName() {
		return PendingName;
	}
	public void setPendingName(String pendingName) {
		PendingName = pendingName;
	}
	public String getTodoUrl() {
		return todoUrl;
	}
	public void setTodoUrl(String todoUrl) {
		this.todoUrl = todoUrl;
	}

}
