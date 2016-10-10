package ldap.bean;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

@Entity 
@Inheritance(strategy = InheritanceType.TABLE_PER_CLASS)
@Table(name = "ldap_tree")
public class Tree {
	@Id
	@GenericGenerator(name = "uuid", strategy = "uuid")
	@GeneratedValue(generator = "uuid")
	@Column(name = "id", length = 50)
	protected String id;
	
	  @Column(name = "name", length=50)
	protected String name;
	  
	  @Column(name = "parentId", length=50)
	  private String parentId;
	  
	  @Column(name = "childId", length=50)
	  private String childId;
	  
	  @Column(name = "virtualNode")
	  private boolean virtualNode;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getParentId() {
		return parentId;
	}

	public void setParentId(String parentId) {
		this.parentId = parentId;
	}

	public String getChildId() {
		return childId;
	}

	public void setChildId(String childId) {
		this.childId = childId;
	}

	public boolean isVirtualNode() {
		return virtualNode;
	}

	public void setVirtualNode(boolean virtualNode) {
		this.virtualNode = virtualNode;
	}
	
	
	  
	  
	 
}
