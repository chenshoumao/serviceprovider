package com.solar.tech.pageadmin;
import java.util.Date;
/**
 * 
* @ClassName PageModel
* @Description 页面信息数据转换模型
* @Author wwd
*@copyRight 续日科技 solartech
* @Date 2015年6月17日
*@Version V1.0.1
 */
public class PageModel {
	private Integer pageId;
	private String pageName;
	private String pageNum;
	private String pageUrl;
	private Integer sortNum;
	private Integer moduleId;
	private String moduleName;
	private String description;
	private Date createTime;
	private String createBy;
	private Date updateTime;
	private String updateBy;
	private String needAclCtrl;
	private String pageType;
	public String getNeedAclCtrl() {
		return needAclCtrl;
	}
	public void setNeedAclCtrl(String needAclCtrl) {
		this.needAclCtrl = needAclCtrl;
	}
	public String getPageType() {
		return pageType;
	}
	public void setPageType(String pageType) {
		this.pageType = pageType;
	}
	public Integer getPageId() {
		return pageId;
	}
	public void setPageId(Integer pageId) {
		this.pageId = pageId;
	}
	public String getPageName() {
		return pageName;
	}
	public void setPageName(String pageName) {
		this.pageName = pageName;
	}
	public String getPageNum() {
		return pageNum;
	}
	public void setPageNum(String pageNum) {
		this.pageNum = pageNum;
	}
	public String getPageUrl() {
		return pageUrl;
	}
	public void setPageUrl(String pageUrl) {
		this.pageUrl = pageUrl;
	}
	public Integer getSortNum() {
		return sortNum;
	}
	public void setSortNum(Integer sortNum) {
		this.sortNum = sortNum;
	}
	public Integer getModuleId() {
		return moduleId;
	}
	public void setModuleId(Integer moduleId) {
		this.moduleId = moduleId;
	}

	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	public String getUpdateBy() {
		return updateBy;
	}
	public void setUpdateBy(String updateBy) {
		this.updateBy = updateBy;
	}
	public String getModuleName() {
		return moduleName;
	}
	public void setModuleName(String moduleName) {
		this.moduleName = moduleName;
	}
	
}
