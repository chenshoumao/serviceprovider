 package com.solar.tech.bean;
 
 import javax.persistence.Column;
 import javax.persistence.Entity;
 import javax.persistence.GeneratedValue;
 import javax.persistence.Id;
 import javax.persistence.Table;
 import org.hibernate.annotations.GenericGenerator;
 
 @Entity
 @Table(name="FW_LdapConfig")
 public class AbstractLdapConfig
 {
 
   @Id
   @GenericGenerator(name="idgene", strategy="native")
   @GeneratedValue(generator="idgene")
   @Column(name="LDAPID")
   private Integer lDAPID;
 
   @Column(name="LDAPType", length=10)
   private String lDAPType;
 
   @Column(name="Host", length=50)
   private String host;
 
   @Column(name="Port")
   
   private Integer port;
 
   @Column(name="Username", length=50)
   private String username;
 
   @Column(name="Password", length=50)
   private String password;
 
   @Column(name="LoginProp", length=10)
   private String loginProp;
 
   @Column(name="GroupClass", length=20)
   private String groupClass;
 
   @Column(name="PersonClass", length=20)
   private String personClass;
 
   @Column(name="Freq")
   private Integer freq;
 
   public Integer getLDAPID()
   {
     return this.lDAPID;
   }
 
   public void setLDAPID(Integer lDAPID) {
     this.lDAPID = lDAPID;
   }
 
   public String getLDAPType() {
     return this.lDAPType;
   }
 
   public void setLDAPType(String lDAPType) {
     this.lDAPType = lDAPType;
   }
 
   public String getHost() {
     return this.host;
   }
 
   public void setHost(String host) {
     this.host = host;
   }
 
   public Integer getPort() {
     return this.port;
   }
 
   public void setPort(Integer port) {
     this.port = port;
   }
 
   public String getUsername() {
     return this.username;
   }
 
   public void setUsername(String username) {
     this.username = username;
   }
 
   public String getPassword() {
     return this.password;
   }
 
   public void setPassword(String password) {
     this.password = password;
   }
 
   public String getLoginProp() {
     return this.loginProp;
   }
 
   public void setLoginProp(String loginProp) {
     this.loginProp = loginProp;
   }
 
   public String getGroupClass() {
     return this.groupClass;
   }
 
   public void setGroupClass(String groupClass) {
     this.groupClass = groupClass;
   }
 
   public String getPersonClass() {
     return this.personClass;
   }
 
   public void setPersonClass(String personClass) {
     this.personClass = personClass;
   }
 
   public Integer getFreq() {
     return this.freq;
   }
 
   public void setFreq(Integer freq) {
     this.freq = freq;
   }
 }

