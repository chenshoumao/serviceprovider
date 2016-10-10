package com.solar.tech.ldap;

import java.io.Serializable;

public class LdapPerson implements Serializable{
	
	/**
	 *
	 */
	private static final long serialVersionUID = 9081527761576640803L;

	private String uid;
	private String cn;
	private String sn;
	private String givenName;
	private String userPassword;
	private String mail;
	private String mobile;

	/**
	 * @return the uid
	 */
	public synchronized final String getUid() {
		return uid;
	}

	/**
	 * @param uid
	 *            the uid to set
	 */
	public synchronized final void setUid(String uid) {
		this.uid = uid;
	}

	/**
	 * @return the cn
	 */
	public synchronized final String getCn() {
		return cn;
	}

	/**
	 * @param cn
	 *            the cn to set
	 */
	public synchronized final void setCn(String cn) {
		this.cn = cn;
	}

	/**
	 * @return the sn
	 */
	public synchronized final String getSn() {
		return sn;
	}

	/**
	 * @param sn
	 *            the sn to set
	 */
	public synchronized final void setSn(String sn) {
		this.sn = sn;
	}

	/**
	 * @return the userPassword
	 */
	public synchronized final String getUserPassword() {
		return userPassword;
	}

	/**
	 * @param userPassword
	 *            the  to set
	 */
	public synchronized final void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}

	/**
	 * @return the postalAddress
	 */
	public synchronized final String getMail() {
		return mail;
	}

	/**
	 * @param postalAddress
	 *            the  to set
	 */
	public synchronized final void setMail(String mail) {
		this.mail = mail;
	}

	/**
	 * @return the 
	 */
	public synchronized final String getMobile() {
		return mobile;
	}

	/**
	 * @param 
	 *            the  to set
	 */
	public synchronized final void setMobile(String mobile) {
		this.mobile = mobile;
	}
	
	
	
	public synchronized final String getGivenName() {
		return givenName;
	}

	public synchronized final void setGivenName(String givenName) {
		this.givenName = givenName;
	}
	/*
	 * (non-Javadoc)
	 *
	 * @see java.lang.Object#toString()
	 */
	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("User [");
		if (uid != null) {
			builder.append("uid=");
			builder.append(uid);
			builder.append(", ");
		}
		if (cn != null) {
			builder.append("cn=");
			builder.append(cn);
			builder.append(", ");
		}
		if (sn != null) {
			builder.append("sn=");
			builder.append(sn);
			builder.append(", ");
		}
		if (givenName != null) {
			builder.append("givenName=");
			builder.append(givenName);
			builder.append(", ");
		}
		if (userPassword != null) {
			builder.append("userPassword=");
			builder.append(userPassword);
			builder.append(", ");
		}
		if (mail != null) {
			builder.append("mail=");
			builder.append(mail);
			builder.append(", ");
		}
		if (mobile != null) {
			builder.append("mobile=");
			builder.append(mobile);
		}
		builder.append("]");
		return builder.toString();
	}
	
	
	

}
