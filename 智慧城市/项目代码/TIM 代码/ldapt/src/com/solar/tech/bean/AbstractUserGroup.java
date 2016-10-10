 package com.solar.tech.bean;
 
 import java.util.Date;
 import javax.persistence.Column;
 import javax.persistence.Entity;
 import javax.persistence.GeneratedValue;
 import javax.persistence.GenerationType;
 import javax.persistence.Id;
 import javax.persistence.Inheritance;
 import javax.persistence.InheritanceType;
 import javax.persistence.Table;
 
 @Entity
 @Inheritance(strategy=InheritanceType.TABLE_PER_CLASS)
 @Table(name="FW_UserGroup_1")
 public class AbstractUserGroup
 {
 
   @Id
   @GeneratedValue(strategy=GenerationType.TABLE)
   @Column(name="GroupId")
   private Integer groupId;
 
   @Column(name="GroupName", length=50)
   private String groupName;
 
   @Column(name="CreateTime")
   private Date createTime;
 
   @Column(name="CreateBy", length=50)
   private String createBy;
 
   @Column(name="UpdateTime")
   private Date updateTime;
 
   @Column(name="UpdateBy", length=50)
   private String updateBy;
 
   @Column(name="Description", length=300)
   private String description;
 
   public Integer getGroupId()
   {
     return this.groupId;
   }
 
   public void setGroupId(Integer groupId) {
     this.groupId = groupId;
   }
 
   public String getGroupName() {
     return this.groupName;
   }
 
   public void setGroupName(String groupName) {
     this.groupName = groupName;
   }
 
   public Date getCreateTime() {
     return this.createTime;
   }
 
   public void setCreateTime(Date createTime) {
     this.createTime = createTime;
   }
 
   public String getCreateBy() {
     return this.createBy;
   }
 
   public void setCreateBy(String createBy) {
     this.createBy = createBy;
   }
 
   public Date getUpdateTime() {
     return this.updateTime;
   }
 
   public void setUpdateTime(Date updateTime) {
     this.updateTime = updateTime;
   }
 
   public String getUpdateBy() {
     return this.updateBy;
   }
 
   public void setUpdateBy(String updateBy) {
     this.updateBy = updateBy;
   }
 
   public String getDescription() {
     return this.description;
   }
 
   public void setDescription(String description) {
     this.description = description;
   }
 }

