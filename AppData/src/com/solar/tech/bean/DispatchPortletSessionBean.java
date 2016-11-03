package com.solar.tech.bean;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * A sample Java bean that stores portlet instance data in portlet session.
 *
 */
public class DispatchPortletSessionBean {
	
	/**
	 * Last text for the text form
	 */
	private String uid = "";
	private String viewPath = "";
	private String formText = "";
	private String name = ""; 
	private String tel = ""; 
	private String mobile = ""; 
	private String postalCode = "";//��������
	private String mail = "";//��������
	private String homePhone= "";//ͨѶ��ַ
	private String staffNumber="";//Ա������
	private String department = "";//��������
	private String profession = "";//ְҵ  duty
	private String title = "";//��λ����      tilte
	private String address = "";//      address
	private Integer totalPage=0;
	private String s_name="";
	
	private String imgurl="";//����ͷ��ͼƬ��ַ
	public String getImgurl() {
		return imgurl;
	}
	public void setImgurl(String imgurl) {
		this.imgurl = imgurl;
	}
	public String getS_name() {
		return s_name;
	}
	public void setS_name(String s_name) {
		this.s_name = s_name;
	}
	public String getS_mobile() {
		return s_mobile;
	}
	public void setS_mobile(String s_mobile) {
		this.s_mobile = s_mobile;
	}
	public String getS_mail() {
		return s_mail;
	}
	public void setS_mail(String s_mail) {
		this.s_mail = s_mail;
	}
	private String s_mobile="";
	private String s_mail="";
	
	
	public Integer getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(Integer totalPage) {
		this.totalPage = totalPage;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getViewPath() {
		return viewPath;
	}
	public void setViewPath(String viewPath) {
		this.viewPath = viewPath;
	}
	private List<UserInfo> listUser = new ArrayList<UserInfo>();
	public String getFormText() {
		return formText;
	}
	public void setFormText(String formText) {
		this.formText = formText;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public String getPostalCode() {
		return postalCode;
	}
	public void setPostalCode(String postalCode) {
		this.postalCode = postalCode;
	}
	public String getMail() {
		return mail;
	}
	public void setMail(String mail) {
		this.mail = mail;
	}
	public String getHomePhone() {
		return homePhone;
	}
	public void setHomePhone(String homePhone) {
		this.homePhone = homePhone;
	}
	public String getStaffNumber() {
		return staffNumber;
	}
	public void setStaffNumber(String staffNumber) {
		this.staffNumber = staffNumber;
	}
	public String getDepartment() {
		return department;
	}
	public void setDepartment(String department) {
		this.department = department;
	}
	public String getProfession() {
		return profession;
	}
	public void setProfession(String profession) {
		this.profession = profession;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public List<UserInfo> getListUser() {
		return listUser;
	}
	public void setListUser(List<UserInfo> listUser) {
		this.listUser = listUser;
	}
}
