package ldap.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "Organization")
public class Organization extends Tree {
	 

	@Column(name = "organizeEncode")
	private String organizeEncode;

	@Column(name = "sn", length=55)
	private String sn; 
	
	@Column(name = "cn", length=55)
	private String cn;
	
	 
	@Column(name = "organizationShort")
	private String organizationShort;

	@Column(name = "description")
	private String description;

	@Column(name = "type")
	private String type;

	@Column(name = "state")
	private String state;

	@Column(name = "superiorEncode")
	private String superiorEncode;

	@Column(name = "organizationLevel")
	private String organizationLevel;

	@Column(name = "displayOrder")
	private String displayOrder;

	@Column(name = "address")
	private String address;

	@Column(name = "postalCode")
	private String postalCode;

	@Column(name = "mobile")
	private String mobile;

	@Column(name = "homeFax")
	private String homeFax;

	public Organization() {
	};

	public Organization(Organization org1, Organization org2) {

		this.id = org2.getId() == null ? org1.getId() : org2.getId();
		this.organizeEncode = org2.getOrganizeEncode() == null ? org1
				.getOrganizeEncode() : org2.getOrganizeEncode();
		name = org2.getName() == null ? org1.getName() : org2.getName();
		this.organizationShort = org2.getOrganizationShort() == null ? org1
				.getOrganizationShort() : org2.getOrganizationShort();
		this.organizationLevel = org2.getOrganizationLevel() == null ? org1
				.getOrganizationLevel() : org2.getOrganizationLevel();
		this.type = org2.getType() == null ? org1.getType() : org2.getType();
		this.state = org2.getState() == null ? org1.getState() : org2
				.getState();
		this.superiorEncode = org2.getSuperiorEncode() == null ? org1
				.getSuperiorEncode() : org2.getSuperiorEncode();
		this.displayOrder = org2.getDisplayOrder() == null ? org1
				.getDisplayOrder() : org2.getDisplayOrder();
		this.description = org2.getDescription() == null ? org1
				.getDescription() : org2.getDescription();
		this.address = org2.getAddress() == null ? org1.getAddress() : org2
				.getAddress();
		this.postalCode = org2.getPostalCode() == null ? org1.getPostalCode()
				: org2.getPostalCode();
		this.mobile = org2.getMobile() == null ? org1.getMobile() : org2
				.getMobile();
		this.homeFax = org2.getHomeFax() == null ? org1.getHomeFax() : org2
				.getHomeFax();

	}

	public String getOrganizeEncode() {
		return organizeEncode;
	}

	public void setOrganizeEncode(String organizeEncode) {
		this.organizeEncode = organizeEncode;
	}

	public String getOrganizationShort() {
		return organizationShort;
	}

	public void setOrganizationShort(String organizationShort) {
		this.organizationShort = organizationShort;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getSuperiorEncode() {
		return superiorEncode;
	}

	public void setSuperiorEncode(String superiorEncode) {
		this.superiorEncode = superiorEncode;
	}

	public String getOrganizationLevel() {
		return organizationLevel;
	}

	public void setOrganizationLevel(String organizationLevel) {
		this.organizationLevel = organizationLevel;
	}

	public String getDisplayOrder() {
		return displayOrder;
	}

	public void setDisplayOrder(String displayOrder) {
		this.displayOrder = displayOrder;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPostalCode() {
		return postalCode;
	}

	public void setPostalCode(String postalCode) {
		this.postalCode = postalCode;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getHomeFax() {
		return homeFax;
	}

	public void setHomeFax(String homeFax) {
		this.homeFax = homeFax;
	}

	 

	 
	public String getSn() {
		return sn;
	}

	public void setSn(String sn) {
		this.sn = sn;
	}

	

	public String getCn() {
		return cn;
	}

	public void setCn(String cn) {
		this.cn = cn;
	}

}
