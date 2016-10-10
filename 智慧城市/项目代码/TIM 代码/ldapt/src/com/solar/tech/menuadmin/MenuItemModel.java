package com.solar.tech.menuadmin;

import java.util.Date;

/**
 * 
* @ClassName MenuItemModel
* @Description  菜单项数据显示模型
* @Author wwd
*@copyRight 续日科技 solartech
* @Date 2015年6月16日
*@Version V1.0.1
 */
public class MenuItemModel{
	private Integer itemId;
	private String itemName;
	private Integer menuId;
	private Integer parentItemId;
	private String menuName;
	private String parentItemName;
	private String itemUrl;
	private String itemTarget;
	private Integer pageId;
	private String pageName;
	private String itemType;
	private Integer itemStatus;
	private Integer sortNum;
	private String itemIcon;
	private String description;
	private Date createTime;
	private String createBy;
	private Date updateTime;
	private String updateBy;
     private String iconCls;

	public Integer getItemId(){
		return this.itemId;
	}

	public void setItemId(Integer itemId){
		this.itemId=itemId;
	}

	public String getItemName(){
		return this.itemName;
	}

	public void setItemName(String itemName){
		this.itemName=itemName;
	}

	public Integer getMenuId(){
		return this.menuId;
	}

	public void setMenuId(Integer menuId){
		this.menuId=menuId;
	}

	public Integer getParentItemId(){
		return this.parentItemId;
	}

	public void setParentItemId(Integer parentItemId){
		this.parentItemId=parentItemId;
	}

	public String getItemUrl(){
		return this.itemUrl;
	}

	public void setItemUrl(String itemUrl){
		this.itemUrl=itemUrl;
	}

	public String getItemTarget(){
		return this.itemTarget;
	}

	public void setItemTarget(String itemTarget){
		this.itemTarget=itemTarget;
	}

	public Integer getPageId(){
		return this.pageId;
	}

	public void setPageId(Integer pageId){
		this.pageId=pageId;
	}

	public String getItemType(){
		return this.itemType;
	}

	public void setItemType(String itemType){
		this.itemType=itemType;
	}

	public Integer getItemStatus(){
		return this.itemStatus;
	}

	public void setItemStatus(Integer itemStatus){
		this.itemStatus=itemStatus;
	}

	public Integer getSortNum(){
		return this.sortNum;
	}

	public void setSortNum(Integer sortNum){
		this.sortNum=sortNum;
	}

	public String getItemIcon(){
		return this.itemIcon;
	}

	public void setItemIcon(String itemIcon){
		this.itemIcon=itemIcon;
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

	public String getMenuName() {
		return menuName;
	}

	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}

	public String getParentItemName() {
		return parentItemName;
	}

	public void setParentItemName(String parentItemName) {
		this.parentItemName = parentItemName;
	}

	public String getPageName() {
		return pageName;
	}

	public void setPageName(String pageName) {
		this.pageName = pageName;
	}

	public String getIconCls() {
		return itemIcon;
	}



}