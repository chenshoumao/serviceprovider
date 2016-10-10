package ldap.control;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import ldap.bean.Organization;
import ldap.service.OrganizationService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/orgcont")
public class OrganizationCont {
	@Autowired
	private OrganizationService organizationService;
	
	// 同步组织
	@RequestMapping(value = "/updateOrg.action",method=RequestMethod.GET,
			produces = {"application/json;charset=UTF-8"})
	@ResponseBody
	public Map<String, Object> updateOrg(Organization organization) { 
		Map<String, Object> map = new HashMap<String, Object>();
		List list = this.organizationService.find("from Organization where id = '"
				+ organization.getId() + "'");
		try {
			if (list.size() == 0) {
				this.organizationService.save(organization);
			}
			// service.save(organization);
			else {
				Organization org1 = (Organization) list.get(0);
				Organization org = new Organization(org1, organization);
				this.organizationService.update(org);
			}
			map.put("state", true); 
		} catch (Exception e) {
			// TODO: handle exception
			map.put("state", false);
		} 
		return map;
	}
}
