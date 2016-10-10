
package com.solar.tech.bean;
 
 import com.solar.tech.util.Current;
 import java.io.Serializable;
 import java.util.Date;
 import javax.persistence.Column;
 import javax.persistence.Entity;
 import javax.persistence.GeneratedValue;
 import javax.persistence.Id;
 import javax.persistence.Inheritance;
 import javax.persistence.InheritanceType;
 import javax.persistence.Table;
 import org.hibernate.annotations.GenericGenerator;
 
 @Entity
 @Inheritance(strategy=InheritanceType.TABLE_PER_CLASS)
 @Table(name="FW_User_1")
 public class AbstractUser
   implements Serializable
 {
   private static final long serialVersionUID = 7385879968620105827L;
 
   @Id
   @GenericGenerator(name="uuid", strategy="uuid")
   @GeneratedValue(generator="uuid")
   @Column(name="UserUID", length=50)
   private String userUID;
   public static final  String USERUID = "userUID";
 
   @Column(name="UserNum", length=50)
   private String userNum;
 
   @Column(name="UserName", length=50)
   private String userName;
   public static final String USERNAME = "userName";
 
   @Column(name="FullName", length=50)
   private String fullName;
   public static final String FULLNAME = "fullName";
 
   @Column(name="Email", length=50)
   private String email;
   public static final String EMAIL = "email";
 
   @Column(name="Password", length=200)
   private String password;
   public static final String PASSWORD = "password";
 
   @Column(name="UserType", length=10)
   private String userType;
   public static final String USERTYPE = "userType";
 
   @Column(name="UserLevel", length=10)
   private String userLevel;
   public static final String USERLEVEL = "userLevel";
 
   @Column(name="UserStatus")
   private Integer userStatus;
   public static final String USERSTATUS = "userStatus";
 
   @Column(name="HeadImg", length=100)
   private String headImg;
   public static final String HEADIMG = "headImg";
 
   @Column(name="Mobile", length=20)
   private String mobile;
   public static final String MOBILE = "mobile";
 
   @Column(name="UserExtProps")
   private String userExtProps;
   public static final String USEREXTPROPS = "userExtProps";
 
   @Column(name="CreateTime", updatable=false)
   private Date createTime;
 
   @Column(name="CreateBy", length=50, updatable=false)
   private String createBy;
 
   @Column(name="UpdateTime")
   private Date updateTime;
 
   @Column(name="UpdateBy", length=50)
   private String updateBy;
 
   @Column(name="Description", length=300)
   private String description;
   public static final String DESCRIPTION = "description";
 
   @Column(name="UserClass", length=10)
   private String userClass;
   public static final String USERCLASS = "userClass";
 
   public String getUserClass()
   {
     return this.userClass;
   }
 
   public void setUserClass(String userClass) {
     this.userClass = userClass;
   }
   public String getUserUID() {
     return this.userUID;
   }
 
   public void setUserUID(String userUID) {
     this.userUID = userUID;
   }
 
   public String getUserNum() {
     return this.userNum;
   }
 
   public void setUserNum(String userNum) {
     this.userNum = userNum;
   }
 
   public String getUserName() {
     return this.userName;
   }
 
   public void setUserName(String userName) {
     this.userName = userName;
   }
 
   public String getEmail() {
     return this.email;
   }
 
   public void setEmail(String email) {
     this.email = email;
   }
 
   public String getPassword() {
     return this.password;
   }
 
   public void setPassword(String password) {
     this.password = Current.md5(password);
   }
 
   public String getUserType() {
     return this.userType;
   }
 
   public void setUserType(String userType) {
     this.userType = userType;
   }
 
   public String getFullName() {
     return this.fullName;
   }
 
   public void setFullName(String fullName) {
     this.fullName = fullName;
   }
 
   public String getUserLevel() {
     return this.userLevel;
   }
 
   public void setUserLevel(String userLevel) {
     this.userLevel = userLevel;
   }
 
   public Integer getUserStatus() {
     return this.userStatus;
   }
 
   public void setUserStatus(Integer userStatus) {
     this.userStatus = userStatus;
   }
 
   public String getHeadImg() {
     return this.headImg;
   }
 
   public void setHeadImg(String headImg) {
     this.headImg = headImg;
   }
 
   public String getMobile() {
     return this.mobile;
   }
 
   public void setMobile(String mobile) {
     this.mobile = mobile;
   }
 
   public String getUserExtProps() {
     return this.userExtProps;
   }
 
   public void setUserExtProps(String userExtProps) {
     this.userExtProps = userExtProps;
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
 
   public static class UserStatus
   {
     public static final Integer ACT = Integer.valueOf(1);
     public static final Integer FRZ = Integer.valueOf(2);
   }
 
   public static class UserType
   {
     public static final String ADMIN = "ADMIN";
     public static final String USER = "USER";
   }
 }

