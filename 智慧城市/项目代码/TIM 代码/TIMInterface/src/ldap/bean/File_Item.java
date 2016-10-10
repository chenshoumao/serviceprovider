package ldap.bean;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name = "File_Item")
public class File_Item {
	@Id
	@GenericGenerator(name = "uuid", strategy = "uuid")
	@GeneratedValue(generator = "uuid")
	@Column(name = "id_file_item", length = 50)
	private String id_file_item;
	public static final String ID_FILE_ITEM = "id_file_item";

	@Column(name = "from", length = 50)
	private String from;
	public static final String From = "from";

	@Column(name = "file_no", length = 50)
	private String file_no;
	public static final String File_no = "file_no";

	@Column(name = "type", length = 50)
	private String type;
	public static final String Type = "type";

	@Column(name = "standard", length = 50)
	private String standard;
	public static final String Standard = "standard";

	@Column(name = "nast_proj_no", length = 50)
	private String nast_proj_no;
	public static final String Nast_proj_no = "nast_proj_no";

	@Column(name = "nast_rep_no", length = 50)
	private String nast_rep_no;
	public static final String Nast_rep_no = "nast_rep_no";

	@Column(name = "idi_rep_no", length = 50)
	private String idi_rep_no;
	public static final String Idi_rep_no = "idi_rep_no";

	@Column(name = "hest_or_no", length = 50)
	private String hest_or_no;
	public static final String Hest_or_no = "hest_or_no";

	@Column(name = "hest_rep_no", length = 50)
	private String hest_rep_no;
	public static final String Hest_rep_no = "hest_rep_no";

	@Column(name = "cert_no", length = 50)
	private String cert_no;
	public static final String Cert_no = "cert_no";

	@Column(name = "file_type", length = 100)
	private String file_type;
	public static final String File_type = "file_type";

	@Column(name = "rev_ext", length = 50)
	private String rev_ext;
	public static final String Rev_ext = "rev_ext";

	@Column(name = "status", length = 50)
	private String status;
	public static final String Status = "status";

	@Column(name = "category", length = 100)
	private String category;
	public static final String Category = "category";

	@Column(name = "engineer", length = 100)
	private String engineer;
	public static final String Engineer = "engineer";

	@Column(name = "manage", length = 50)
	private String manage;
	public static final String Manage = "manage";

	@Column(name = "Coordinator", length = 50)
	private String Coordinator;
	public static final String COordinator = "Coordinator";

	@Column(name = "deadline", length = 50)
	private String deadline;
	public static final String Deadline = "deadline";

	@Column(name = "create_time", length = 50)
	private Date create_time;
	public static final String Create_time = "create_time";
	
	@Column(name = "endtime", length = 50)
	private Date endtime;
	public static final String Endtime = "endtime";

	@Column(name = "proj_no", length = 50)
	private String proj_no;
	public static final String Proj_no = "proj_no";
	
	@Column(name = "po_no", length = 50)
	private String po_no;
	public static final String Po_no = "po_no";
	
	@Column(name = "po_close", length = 50)
	private String po_close;
	public static final String Po_close = "po_close";
	
	@Column(name = "po_approve", length = 50)
	private String po_approve;
	public static final String Po_approve = "po_approve";

	@Column(name = "CreateBy", length = 50)
	private String createBy;
	public static final String CreateBy = "createBy";

	@Column(name = "UpdateTime")
	private Date updateTime;
	public static final String UpdateTiime = "updateTime";

	@Column(name = "UpdateBy", length = 50)
	private String updateBy;
	public static final String UpdateBy = "updateBy";
	
	@Column(name = "draft", length = 50)
	private String draft;
	
	@Column(name = "itemurl", length = 250)
	private String itemurl;
	
	@Column(name = "fileApprove")
	private int fileApprove;//0为审核  1审核中  2审核结束
    

		

	public String getId_file_item() {
		return id_file_item;
	}

	public void setId_file_item(String id_file_item) {
		this.id_file_item = id_file_item;
	}

	public String getFrom() {
		return from;
	}

	public void setFrom(String from) {
		this.from = from;
	}

	public String getFile_no() {
		return file_no;
	}

	public void setFile_no(String file_no) {
		this.file_no = file_no;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getStandard() {
		return standard;
	}

	public void setStandard(String standard) {
		this.standard = standard;
	}

	public String getNast_proj_no() {
		return nast_proj_no;
	}

	public void setNast_proj_no(String nast_proj_no) {
		this.nast_proj_no = nast_proj_no;
	}
	
	

	public String getNast_rep_no() {
		return nast_rep_no;
	}

	public void setNast_rep_no(String nast_rep_no) {
		this.nast_rep_no = nast_rep_no;
	}

	public String getIdi_rep_no() {
		return idi_rep_no;
	}

	public void setIdi_rep_no(String idi_rep_no) {
		this.idi_rep_no = idi_rep_no;
	}

	public String getHest_or_no() {
		return hest_or_no;
	}

	public void setHest_or_no(String hest_or_no) {
		this.hest_or_no = hest_or_no;
	}

	public String getHest_rep_no() {
		return hest_rep_no;
	}

	public void setHest_rep_no(String hest_rep_no) {
		this.hest_rep_no = hest_rep_no;
	}

	public String getCert_no() {
		return cert_no;
	}

	public void setCert_no(String cert_no) {
		this.cert_no = cert_no;
	}

	public String getFile_type() {
		return file_type;
	}

	public void setFile_type(String file_type) {
		this.file_type = file_type;
	}

	public String getRev_ext() {
		return rev_ext;
	}

	public void setRev_ext(String rev_ext) {
		this.rev_ext = rev_ext;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getEngineer() {
		return engineer;
	}

	public void setEngineer(String engineer) {
		this.engineer = engineer;
	}

	public String getManage() {
		return manage;
	}

	public void setManage(String manage) {
		this.manage = manage;
	}

	public String getCoordinator() {
		return Coordinator;
	}

	public void setCoordinator(String coordinator) {
		Coordinator = coordinator;
	}

	public String getDeadline() {
		return deadline;
	}

	public void setDeadline(String deadline) {
		this.deadline = deadline;
	}

	public Date getCreate_time() {
		return create_time;
	}

	public void setCreate_time(Date create_time) {
		this.create_time = create_time;
	}

	public String getProj_no() {
		return proj_no;
	}

	public void setProj_no(String proj_no) {
		this.proj_no = proj_no;
	}
	public String getPo_no() {
		return po_no;
	}

	public void setPo_no(String po_no) {
		this.po_no = po_no;
	}
	
	
	
	public String getPo_close() {
		return po_close;
	}

	public void setPo_close(String po_close) {
		this.po_close = po_close;
	}
	
	
	public String getPo_approve() {
		return po_approve;
	}

	public void setPo_approve(String po_approve) {
		this.po_approve = po_approve;
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

	
	
	public Date getEndtime() {
		return endtime;
	}

	public void setEndtime(Date endtime) {
		this.endtime = endtime;
	}

	public String getDraft() {
		return draft;
	}

	public void setDraft(String draft) {
		this.draft = draft;
	}

	public String getItemurl() {
		return itemurl;
	}

	public void setItemurl(String itemurl) {
		this.itemurl = itemurl;
	}

	public int getFileApprove() {
		return fileApprove;
	}

	public void setFileApprove(int fileApprove) {
		this.fileApprove = fileApprove;
	}
	
	
}
