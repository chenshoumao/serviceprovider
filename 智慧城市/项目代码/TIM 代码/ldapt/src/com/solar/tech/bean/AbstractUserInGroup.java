 package com.solar.tech.bean;
 
 import javax.persistence.Column;
 import javax.persistence.Entity;
 import javax.persistence.GeneratedValue;
 import javax.persistence.GenerationType;
 import javax.persistence.Id;
 import javax.persistence.Inheritance;
 import javax.persistence.InheritanceType;
 
 @Entity
 @Inheritance(strategy=InheritanceType.TABLE_PER_CLASS)
 public class AbstractUserInGroup
 {
 
   @Id
   @GeneratedValue(strategy=GenerationType.TABLE)
   @Column(name="UGID")
   private Integer uGID;
 
   @Column(name="USERUID", length=50)
   private String userUID;
 
   @Column(name="GroupId", length=50)
   private Integer groupId;
 
   public Integer getUGID()
   {
     return this.uGID;
   }
 
   public void setUGID(Integer uGID) {
     this.uGID = uGID;
   }
 
   public String getUserUID() {
     return this.userUID;
   }
 
   public void setUserUID(String userUID) {
     this.userUID = userUID;
   }
 
   public Integer getGroupId() {
     return this.groupId;
   }
 
   public void setGroupId(Integer groupId) {
     this.groupId = groupId;
   }
 }

