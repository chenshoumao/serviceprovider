package com.solar.tech.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "FW_Charge")
public class Charge {
	@Id
	@GenericGenerator(name = "idgene", strategy = "native")
	@GeneratedValue(generator = "idgene")
	@Column(name = "ChargeId")
	private Integer chargeId;

	@Column(name = "po_no")
	private String po_no;

	@Column(name = "proj_no")
	private String proj_no;

	// 序号
	@Column(name = "order")
	private int order;

	@Column(name = "ContractPrice")
	private double contractPrice;

	@Column(name = "FilePath")
	private String filePath;

	@Column(name = "OriginalPrice")
	private String originalPrice;

	@Column(name = "FinalPrice")
	private String finalPrice;

	@Column(name = "Construction", length = 50)
	private String construction;

	// 是否锁住 1是，0否
	@Column(name = "isLock")
	private int isLock;

	@Column(name = "submitter")
	private String submitter;

	@Column(name = "status")
	private String status;

	@Column(name = "inputTime")
	private String inputTime;

	@Column(name = "filename")
	private String filename;

	public Integer getChargeId() {
		return chargeId;
	}

	public void setChargeId(Integer chargeId) {
		this.chargeId = chargeId;
	}

	public String getOriginalPrice() {
		return originalPrice;
	}

	public void setOriginalPrice(String originalPrice) {
		this.originalPrice = originalPrice;
	}

	public String getFinalPrice() {
		return finalPrice;
	}

	public void setFinalPrice(String finalPrice) {
		this.finalPrice = finalPrice;
	}

	public String getConstruction() {
		return construction;
	}

	public void setConstruction(String construction) {
		this.construction = construction;
	}

	public double getContractPrice() {
		return contractPrice;
	}

	public void setContractPrice(double contractPrice) {
		this.contractPrice = contractPrice;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public String getPo_no() {
		return po_no;
	}

	public void setPo_no(String po_no) {
		this.po_no = po_no;
	}

	public String getProj_no() {
		return proj_no;
	}

	public void setProj_no(String proj_no) {
		this.proj_no = proj_no;
	}

	public int getOrder() {
		return order;
	}

	public void setOrder(int order) {
		this.order = order;
	}

	public int getIsLock() {
		return isLock;
	}

	public void setIsLock(int isLock) {
		this.isLock = isLock;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getSubmitter() {
		return submitter;
	}

	public void setSubmitter(String submitter) {
		this.submitter = submitter;
	}

	public String getInputTime() {
		return inputTime;
	}

	public void setInputTime(String inputTime) {
		this.inputTime = inputTime;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}
    
}
