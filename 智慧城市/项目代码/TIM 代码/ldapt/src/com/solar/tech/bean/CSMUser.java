package com.solar.tech.bean;

import java.util.Date;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "CSMUser")
public class CSMUser {

	
	   @Id
	   @GenericGenerator(name="uuid", strategy="uuid")
	   @GeneratedValue(generator="uuid")
	   @Column(name="id", length=50)
	   private String id;
	  
	
	@Column(name = "address", length=50)
	private String address;
	 
	
	@Column(name = "description", length=55)
	private String description;
	
	@Column(name = "sn", length=55)
	private String sn;
	
	@Column(name = "uuufid", length=55)
	private String uid;
	
	@Column(name = "cn", length=55)
	private String cn;
	
	public  CSMUser(){}
	public  CSMUser(CSMUser user1,CSMUser user2){
		this.id = user1.getId();
		this.uid = user1.getUid();
		this.cn = user2.getCn() == null ? user1.getCn():user2.getCn();
		this.sn = user2.getSn() == null ? user1.getSn():user2.getSn();
		this.description = user2.getDescription() == null ? user1.getDescription():user2.getDescription();
		this.address = user2.getAddress() == null ? user1.getAddress():user2.getAddress();
		
	}

	public String getId() {
		return id;
	}


	public void setId(String id) {
		this.id = id;
	}


	public String getAddress() {
		return address;
	}


	public void setAddress(String address) {
		this.address = address;
	}


	public String getDescription() {
		return description;
	}


	public void setDescription(String description) {
		this.description = description;
	}


	public String getSn() {
		return sn;
	}


	public void setSn(String sn) {
		this.sn = sn;
	}


	public String getUid() {
		return uid;
	}


	public void setUid(String uid) {
		this.uid = uid;
	}


	public String getCn() {
		return cn;
	}


	public void setCn(String cn) {
		this.cn = cn;
	}
	 
	
	 
	
}
