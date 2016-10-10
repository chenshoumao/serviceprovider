package ldap.dao.impl;

import static org.springframework.ldap.query.LdapQueryBuilder.query;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.naming.Name;
import javax.naming.NameNotFoundException;
import javax.naming.NamingEnumeration;
import javax.naming.NamingException;
import javax.naming.directory.Attribute;
import javax.naming.directory.Attributes;
import javax.naming.directory.BasicAttribute;
import javax.naming.directory.BasicAttributes;
import javax.naming.directory.DirContext;
import javax.naming.directory.ModificationItem;
import javax.naming.directory.SearchControls;
import javax.naming.directory.SearchResult;
import javax.naming.ldap.PagedResultsResponseControl;

 








import ldap.dao.TimUserDao;
import ldap.entity.ItimAccount;
import ldap.entity.ItimAccountMapper;
import ldap.entity.ItimMailAndPhone;
import ldap.entity.ItimMailAndPhoneMapper;
import ldap.entity.PersonAttributeMapper;
import ldap.entity.Tree;
import ldap.entity.User;

import org.apache.commons.collections.map.HashedMap;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.message.BasicNameValuePair;
import org.apache.log4j.Logger;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ldap.control.PagedResultsCookie;
import org.springframework.ldap.control.PagedResultsDirContextProcessor;
import org.springframework.ldap.control.PagedResultsRequestControl;
import org.springframework.ldap.core.AttributesMapper;
import org.springframework.ldap.core.AttributesMapperCallbackHandler;
import org.springframework.ldap.core.CollectingNameClassPairCallbackHandler;
import org.springframework.ldap.core.ContextSource;
import org.springframework.ldap.core.DirContextOperations;
import org.springframework.ldap.core.DistinguishedName;
import org.springframework.ldap.core.LdapOperations;
import org.springframework.ldap.core.LdapTemplate;
import org.springframework.ldap.core.NameAwareAttributes;
import org.springframework.ldap.core.support.AbstractContextMapper;
import org.springframework.ldap.core.support.LdapOperationsCallback;
import org.springframework.ldap.core.support.SingleContextSource;
import org.springframework.ldap.filter.AndFilter;
import org.springframework.ldap.filter.EqualsFilter;
import org.springframework.ldap.filter.WhitespaceWildcardsFilter;
import org.springframework.ldap.query.LdapQuery;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;
 








import com.ibm.itim.dataservices.model.ModelCommunicationException;
import com.ibm.itim.dataservices.model.ObjectNotFoundException;
import com.ibm.itim.dataservices.model.domain.Account;
import com.ibm.itim.dataservices.model.domain.AccountEntity;
import com.ibm.itim.dataservices.model.domain.AccountSearch;
import com.ibm.itim.dataservices.model.domain.Service;
import com.ibm.itim.dataservices.model.domain.ServiceEntity;

import antlr.StringUtils;

@Repository
public class TimUserDaoImpl implements TimUserDao {
	@Autowired
	private LdapTemplate ldapTemplate;

 
	String userDn = ",ou=systemUser,ou=itim,ou=org,DC=CMZD,DC=COM";

	  
	@Override
	public List getUserInfo(String eruid) {
		// TODO Auto-generated method stub

		List<ItimAccount> list = new ArrayList<ItimAccount>();
		// 查询过滤条件
		AndFilter andFilter = new AndFilter();
		andFilter.and(new EqualsFilter("objectclass", "erAccountItem"));
	  // andFilter.and(new EqualsFilter("owner", "erglobalid=00000000000000000007,ou=0,ou=people,erglobalid=00000000000000000000,ou=org,dc=cmzd,dc=com"));

		// search是根据过滤条件进行查询，第一个参数是父节点的dn，可以为空，不为空时查询效率更高
		try {
			list = ldapTemplate.search("eruid="+eruid+",ou=systemUser,ou=itim,ou=org", andFilter.encode(),
					new ItimAccountMapper());
			System.out.println("find d1111");
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println(e);
		}
		System.out.println("list size" + list.size());
		if (list.size() > 0) {
			return list;
		}
		return null;
	}

	@Override
	public boolean updateChallengAnswer(String eruid) {
		 
		List list = this.getUserInfo("ITIM Manager");
		if (list.size() > 0) {
			System.out.println(22);
			ItimAccount account = (ItimAccount) list.get(0);
//			eruid=ITIM Manager,ou=systemUser,ou=itim,ou=org,DC=CMZD,DC=COM
//			eruid=ITIM Manager,ou=systemUser,ou=itim,ou=org,DC=CMZD,DC=COM
			// String erlostpasswordanswer =
			// "<?xml version=\"1.0\" encoding=\"UTF-8\"?><ChallengeResponseSet><ChallengeResponse Challenge=\"who you are\" Response=\"SHA-256:OWlib2k1YTlqcDUz:jVN1SncyFlZoy6sUcUoFUoMbfVmXSAQx3rqKEJD9NbY=\"/></ChallengeResponseSet>";
			String erlostpasswordanswer = account.getErlostpasswordanswer();
			System.out.println(erlostpasswordanswer);
			
			int index = erlostpasswordanswer.indexOf("Response=");
			while(index > 0){
				int firstIndex = erlostpasswordanswer.indexOf("\"",index + 1);
				int secondIndex = erlostpasswordanswer.indexOf("\"", firstIndex + 1);
				String result = erlostpasswordanswer.substring(firstIndex+1, secondIndex);
				System.out.println(result);
				erlostpasswordanswer = erlostpasswordanswer.replace(result,"********");
				System.out.println(erlostpasswordanswer);
				index = erlostpasswordanswer.indexOf("Response=",index+1);
			}
			try {   

				ldapTemplate.modifyAttributes("eruid=" + eruid
						+ ",ou=systemUser,ou=itim,ou=org",
						new ModificationItem[] { new ModificationItem(
								DirContext.REPLACE_ATTRIBUTE,
								new BasicAttribute("erlostpasswordanswer",
										erlostpasswordanswer))});
				return true;
			} catch (Exception ex) {
				ex.printStackTrace();
				System.out.println(ex);
				return false;
			}

		}
		return false;
	}

	 
	
	public List showAccount(String eruid) {
		 PrintAccounts accounts = new PrintAccounts();
		 List userList = getUserInfo(eruid);
		 try {
			ItimAccount itimAccount = (ItimAccount) userList.get(0);
			System.out.println(111);
			System.out.println(222);
			System.out.println(itimAccount.getOwner());
			List list = accounts.printAccounts(itimAccount.getOwner());
			return list;
		} catch (Exception e) {
			// TODO: handle exception
		} 
		 return null;
	}

	@Override
	public boolean uodatePassword(String eruid) {
		// TODO Auto-generated method stub
		String password = "SHA-256:aGl1MmE5dHpudmZi:g1kdw8kJf3hcET5h5msuz82SGC7elPpTkg2877AM8Gs=";
		try {   
			//eruid=fff,ou=systemUser,ou=itim,ou=org
			ldapTemplate.modifyAttributes("eruid=" + eruid
					+ ",ou=systemUser,ou=itim,ou=org",
					new ModificationItem[] { new ModificationItem(
							DirContext.REPLACE_ATTRIBUTE,
							new BasicAttribute("erpassword",
									password)), });
			return true;
		} catch (Exception ex) {
			ex.printStackTrace();
			return false;
		} 
	}

	@Override
	public String changeChallengeResponse(String username, String password,
			String answer, String confirmAnswer) {
		Map<String, Object> map = new HashMap<String, Object>();
		// TODO Auto-generated method stub
		try {
			this.Login(username, password);
			this.ChangeAnswer();
			this.updateAnswer(answer, confirmAnswer);
			return "success";
		} catch (Exception e) {
			// TODO: handle exception
			return "fail";
		}
	}
	
	public void Login(String username,String password){
		try {
			String url = "http://10.161.2.68:9080/itim_expi/j_security_check";
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("j_username", username);
			map.put("j_password", password);
			this.httpClientPost(url, map, "UTF-8");
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
	}
	
	public void ChangeAnswer(){
		try {
			String url = "http://10.161.2.68:9080/itim_expi/ChangeChallengeResponseServlet";
			Map<String, Object> map = new HashMap<String, Object>();
			this.httpClientPost(url, map, "UTF-8");
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
	}
	
	public void updateAnswer(String answer,String confirmAnswer){
		try {
			String url = "http://10.161.2.68:9080/itim_expi/ChangeChallengeResponseServlet"
					+ "action=setAnswers&who%20you%20areAnswer=123456&who%20you%20areConfirmAnswer=123456";
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("action", "setAnswers");
			map.put("who%20you%20areAnswer", answer);
			map.put("who%20you%20areConfirmAnswer", confirmAnswer);
			
			this.httpClientPost(url, map, "UTF-8");
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		
		
	}
	
	public static String httpClientPost(String urlParam, Map<String, Object> params, String charset) {  
        StringBuffer resultBuffer = null;  
        HttpClient client = new DefaultHttpClient();  
        HttpPost httpPost = new HttpPost(urlParam);  
        // 构建请求参数  
        List<NameValuePair> list = new ArrayList<NameValuePair>();  
        Iterator<Entry<String, Object>> iterator = params.entrySet().iterator();  
        while (iterator.hasNext()) {  
            Entry<String, Object> elem = iterator.next();  
            list.add(new BasicNameValuePair(elem.getKey(), String.valueOf(elem.getValue())));  
        }  
        BufferedReader br = null;  
        try {  
            if (list.size() > 0) {  
                UrlEncodedFormEntity entity = new UrlEncodedFormEntity(list, charset);  
                httpPost.setEntity(entity);  
            }  
            HttpResponse response = client.execute(httpPost);  
            // 读取服务器响应数据  
            resultBuffer = new StringBuffer();  
            br = new BufferedReader(new InputStreamReader(response.getEntity().getContent()));  
            String temp;  
            while ((temp = br.readLine()) != null) {  
                resultBuffer.append(temp);  
            }  
        } catch (Exception e) {  
            throw new RuntimeException(e);  
        } finally {  
            if (br != null) {  
                try {  
                    br.close();  
                } catch (IOException e) {  
                    br = null;  
                    throw new RuntimeException(e);  
                }  
            }  
        }  
        return resultBuffer.toString();  
    }  
	
	
	

}
