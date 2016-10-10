package com.solar.tech.bean;

import javax.persistence.Entity;
import javax.persistence.Table;


@Entity
@Table(name = "FW_User")
public class User extends AbstractUser{
	  public static class UserClass
	  {
	    public static final String SYSADMIN = "SYSADMIN";
	    public static final String SYSUSER = "SYSUSER";
	    public static final String WEBMEMB = "WEBMEMB";
	  }
	
}