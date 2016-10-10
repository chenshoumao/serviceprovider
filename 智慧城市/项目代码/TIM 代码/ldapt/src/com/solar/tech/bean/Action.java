package com.solar.tech.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "Action")
public class Action {

	@Id
	@GenericGenerator(name = "uuid", strategy = "uuid")
	@GeneratedValue(generator = "uuid")
	@Column(name = "actuuid", length = 50)
	private String actuuid;
	@Column(name = "file_no", length = 50)
	private String file_no;
	@Column(name = "proj_no", length = 50)
	private String proj_no;
	@Column(name = "ActionTime", length = 20)
	private Date ActionTime;
	@Column(name = "userName", length = 50)
	private String userName;
	@Column(name = "Actions", length = 50)
	private String Actions;
	@Column(name = "infonmation", length = 50)
	private String infonmation;
	@Column(name = "Reason", length = 50)
	private String Reason;
	@Column(name = "Type", length = 50)
	private String Type;
	@Column(name = "docinfo", length = 50)
	private String docinfo;

	public String getActuuid() {
		return actuuid;
	}

	public void setActuuid(String actuuid) {
		this.actuuid = actuuid;
	}

	public Date getActionTime() {
		return ActionTime;
	}

	public void setActionTime(Date actionTime) {
		ActionTime = actionTime;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getActions() {
		return Actions;
	}

	public void setActions(String actions) {
		Actions = actions;
	}

	public String getInfonmation() {
		return infonmation;
	}

	public void setInfonmation(String infonmation) {
		this.infonmation = infonmation;
	}

	public String getReason() {
		return Reason;
	}

	public void setReason(String reason) {
		Reason = reason;
	}

	public String getType() {
		return Type;
	}

	public void setType(String type) {
		Type = type;
	}

	public String getDocinfo() {
		return docinfo;
	}

	public void setDocinfo(String docinfo) {
		this.docinfo = docinfo;
	}

	public String getFile_no() {
		return file_no;
	}

	public void setFile_no(String file_no) {
		this.file_no = file_no;
	}

	public String getProj_no() {
		return proj_no;
	}

	public void setProj_no(String proj_no) {
		this.proj_no = proj_no;
	}
	
}
