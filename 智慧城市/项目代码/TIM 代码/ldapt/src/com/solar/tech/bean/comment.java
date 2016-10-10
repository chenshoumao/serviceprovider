package com.solar.tech.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "Comment")
public class comment {
	
	
	   @Id
	   @GenericGenerator(name="uuid", strategy="uuid")
	   @GeneratedValue(generator="uuid")
	   @Column(name="commentuuid", length=50)
	   private String commentuuid;	

		@Column(name = "file_no", length = 50)
		private String file_no;
		@Column(name = "proj_no", length=50)
		private String proj_no;
	   @Column(name="commTime", length=50)	   
	   private Date   commTime;
	   
	   @Column(name="userName", length=50)	   
	   private String userName;
	   
	   @Column(name="comment", length=50)	   
	   private String comment;
	
	public String getCommentuuid() {
		return commentuuid;
	}
	public void setCommentuuid(String commentuuid) {
		this.commentuuid = commentuuid;
	}
	public Date getCommTime() {
		return commTime;
	}
	public void setCommTime(Date commTime) {
		this.commTime = commTime;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
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
