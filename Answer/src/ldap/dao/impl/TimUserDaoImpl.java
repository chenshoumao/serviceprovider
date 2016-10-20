package ldap.dao.impl;

import static org.springframework.ldap.query.LdapQueryBuilder.query;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
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
	public String getChallengAnswer(String username) {
		// TODO Auto-generated method stub
		List list = this.getUserInfo(username);
		if (list.size() > 0) {
			ItimAccount account = (ItimAccount) list.get(0);
			String erlostpasswordanswer = account.getErlostpasswordanswer();
			if(erlostpasswordanswer == null){
				return "false";
			}
			else if(erlostpasswordanswer.length() > 0){
				return "true";
			}
		}
		return "false";
	} 
	
	public String doGetMethod(String updataUrl){
		String result = "";
		BufferedReader in = null;  
		
		System.out.println(updataUrl);
		URLConnection con;
		
		try {
			con = new URL(updataUrl).openConnection();

			System.out.println("dataurl-----:" + updataUrl);

			 con.setRequestProperty("accept", "*/*");  
	            con.setRequestProperty("connection", "Keep-Alive");  
	            con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");  
	            con.setRequestProperty("user-agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");  
	            // 发送POST请求必须设置如下两行  
	          //  con.setDoOutput(true);  
	          //  con.setDoInput(true);  
			System.out.println(11111);
			con.connect();
			System.out.println(22222);
			in = new BufferedReader(new InputStreamReader(con.getInputStream()));
			String line;
			while ((line = in.readLine()) != null) {
				result += line;
			}
			System.out.println(result);
			return result;
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
      
	}
	
	 
	

	@Override
	public boolean updateChallengAnswer(String username,String question, String answer) {
		 
		//List list = this.getUserInfo("ITIM Manager");
		 
			System.out.println(22); 
			
			
		    String erlostpasswordanswer =
			 "<?xml version=\"1.0\" encoding=\"UTF-8\"?><ChallengeResponseSet><ChallengeResponse Challenge=\""+ question +"\" Response=\"********\"/></ChallengeResponseSet>";
			 
			try {   
				String password = doGetMethod("http://10.161.2.67:9080/UsersManagement/UsersServlet?param=getUserPassword&uid="+username);
				 
				password = password.split(",")[1];
				//想设置密保问题
				ldapTemplate.modifyAttributes("eruid=" + username
						+ ",ou=systemUser,ou=itim,ou=org",
						new ModificationItem[] { new ModificationItem(
								DirContext.REPLACE_ATTRIBUTE,
								new BasicAttribute("erlostpasswordanswer",
										erlostpasswordanswer))});
				//设置密保答案
				String updataUrl = "http://10.161.2.68:9080/itim_expi/j_security_check?" 
						+ "j_username="+username+"&j_password="+password+"&action=updateAnswer&question="
						+ question + "&"+question+"Answer="+answer+"&"+question+"ConfirmAnswer="+answer;
				doGetMethod(updataUrl);
				return true;
			} catch (Exception ex) {
				ex.printStackTrace();
				System.out.println(ex);
				return false;
			}

		 
		 
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

	@Override
	public void editUser(User user) {
		System.out.println(333);
		String givenName = user.getGivenName();
		String title = user.getTitle();
		String mail = user.getMail();
		String homePostalAddress = user.getHomePostalAddress();
		String mobile = user.getMobile();
		String homePhone = user.getHomePhone();
		String postalAddress = user.getPostalAddress();
		String description = user.getDescription();
		String uid = user.getUid();
		String ixml="<?xml version=\"1.0\" encoding=\"UTF-8\"?>" +
				"<Document><ITEM><ID>1002</ID>";
		if(givenName != null && givenName !=""){
			ixml += "<GIVENNAME>" + givenName + "</GIVENNAME>";
		}
		if(title  != null && title !=""){
			ixml += "<TITLE>" + title + "</TITLE>";
		}
		if(mail != null && mail !=""){
			ixml += "<MAIL>" + mail + "</MAIL>";
		}
		if(homePostalAddress != null && homePostalAddress != ""){
			ixml += "<HOMEPOSTALADDRESS>" + homePostalAddress + "</HOMEPOSTALADDRESS>";
		}
		if(mobile != null && mobile != ""){
			ixml += "<MOBILE>" + mobile + "</MOBILE>";
		}
		if(homePhone != null && homePhone != ""){
			ixml += "<HOMEPHONE>" + homePhone + "</HOMEPHONE>";
		}
		if(postalAddress != null && postalAddress != ""){
			ixml += "<POSTALADDRESS>" + postalAddress + "</POSTALADDRESS>";
		}
		if(description != null && description != ""){
			ixml += "<DESCRIPTION>" + description + "</DESCRIPTINO>";
		}
		if(uid != null && uid != ""){
			ixml += "<UID>" + uid + "</UID>";
		}
		
		ixml += "<STATUS>2</STATUS></ITEM></Document>"; 
		
		// TODO Auto-generated method stub
		String url = "http://10.161.2.68:9081/EditUser/servlet/UserServlet";
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("ixml", ixml);
		this.httpClientPost(url, map, "UTF-8");
	}

	@Override
	public String getQuestion(String username) {
		// TODO Auto-generated method stub
		List list = this.getUserInfo(username);
		ItimAccount itimAccount = new ItimAccount();
		String answer = "";
		if(list.size() > 0){
			itimAccount = (ItimAccount) list.get(0);
			String erlostpasswordanswer = itimAccount.getErlostpasswordanswer();
			int index = 0;
			while(index >= 0){ 
			index = erlostpasswordanswer.indexOf("Challenge=",index);
			int lastIndex = erlostpasswordanswer.indexOf("\"", index+12);
			answer +=erlostpasswordanswer.substring(index+11, lastIndex) + ","; 
			index = erlostpasswordanswer.indexOf("Challenge=",lastIndex + 1);
			}
		}
		return answer;
	}

	
	
	
	

}
