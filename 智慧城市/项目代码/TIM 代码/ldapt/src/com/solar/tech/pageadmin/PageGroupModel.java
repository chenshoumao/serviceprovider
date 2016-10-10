package com.solar.tech.pageadmin;

import java.util.Date;


public class PageGroupModel{

	private Integer moduleId;

	private String moduleName;

	private Integer parentModuleId;
   private String parentModuleName;

	private Integer sortNum;

	private String moduleIcon;

	private String description;


	private Date createTime;


	private String createBy;


	private Date updateTime;


	private String updateBy;


	public Integer getModuleId(){
		return this.moduleId;
	}

	public void setModuleId(Integer moduleId){
		this.moduleId=moduleId;
	}

	public String getModuleName(){
		return this.moduleName;
	}

	public void setModuleName(String moduleName){
		this.moduleName=moduleName;
	}

	public Integer getParentModuleId(){
		return this.parentModuleId;
	}

	public void setParentModuleId(Integer parentModuleId){
		this.parentModuleId=parentModuleId;
	}

	public Integer getSortNum(){
		return this.sortNum;
	}

	public void setSortNum(Integer sortNum){
		this.sortNum=sortNum;
	}

	public String getModuleIcon(){
		return this.moduleIcon;
	}

	public void setModuleIcon(String moduleIcon){
		this.moduleIcon=moduleIcon;
	}

	public String getDescription(){
		return this.description;
	}

	public void setDescription(String description){
		this.description=description;
	}

	public Date getCreateTime(){
		return this.createTime;
	}

	public void setCreateTime(Date createTime){
		this.createTime=createTime;
	}

	public String getCreateBy(){
		return this.createBy;
	}

	public void setCreateBy(String createBy){
		this.createBy=createBy;
	}

	public Date getUpdateTime(){
		return this.updateTime;
	}

	public void setUpdateTime(Date updateTime){
		this.updateTime=updateTime;
	}

	public String getUpdateBy(){
		return this.updateBy;
	}

	public void setUpdateBy(String updateBy){
		this.updateBy=updateBy;
	}

	public String getParentModuleName() {
		return parentModuleName;
	}

	public void setParentModuleName(String parentModuleName) {
		this.parentModuleName = parentModuleName;
	}

}