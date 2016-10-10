/******************************************************************************
* Licensed Materials - Property of IBM
*
* (C) Copyright IBM Corp. 2005, 2012 All Rights Reserved.
*
* US Government Users Restricted Rights - Use, duplication, or
* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
*
*****************************************************************************/

package examples.serviceprovider.rdbms;

import java.io.StringReader;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;
import java.util.Map;  
import java.util.Map.Entry;  

import antlr.Token;
import antlr.TokenStreamException;

import com.ibm.itim.common.AttributeChangeIterator;
import com.ibm.itim.common.AttributeChangeOperation;
import com.ibm.itim.common.AttributeChanges;
import com.ibm.itim.common.AttributeValue;
import com.ibm.itim.common.AttributeValueIterator;
import com.ibm.itim.common.AttributeValues;
import com.ibm.itim.logging.SystemLog;

import examples.serviceprovider.rdbms.parser.SQLSubstitutionLexer;
import examples.serviceprovider.rdbms.parser.SQLSubstitutionLexerTokenTypes;
import java.security.MessageDigest;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;

/**
 * Encapsulates an SQL statement entered by the service owner. It is parsed to
 * determine the input parameters so at execution time the parameter values can
 * be substituted in. The parameters should be indicated with a '#' character,
 * for example,
 * 
 * <code>INSERT INTO ACCOUNTS (LOGIN) VALUES ('#eruid')</code>
 */
class SQLStatement {

	static{
		System.out.println("SQLStatement 9999999999999999999999999999");
	}
	private static final char COMMA = ',';

	private static final char EQUALS = '=';

	private static final char QUOTE = '\'';

	private static final String ALL_ATTRIBUTES = "#all_attributes";

	private static final String ALL_VALUES = "#all_values";

	private static final String ALL_CHANGES = "#all_changes";

	private final String sql;

	private List<String> timAttributeNames;

	/**
	 * Creates a SQLStatement object
	 * 
	 * @param sql
	 *            Before parsing
	 */
	SQLStatement(String sql) {
		System.out.println("this is sql " + sql);
		this.sql = sql;
	}

	/**
	 * Substitutes parameters from the service and account objects into the SQL
	 * statement entered by the service owner on the service form.
	 * 
	 * @param serviceInfoProps
	 *            properties from the service info object
	 * @param accountAttributes
	 *            the account attributes
	 * @return An SQL string that may be used in a Statement.execute() call.
	 * @throws RDBMSSQLException
	 *             if the parameters specified in the
	 */
	String substitute(Properties serviceInfoProps,
			AttributeValues accountAttributes) throws RDBMSSQLException {
		RDBMSAttributeMap map = new RDBMSAttributeMap();
		return substitute(serviceInfoProps, accountAttributes, map);
	}


	public  String toMD5(String plainText) {
		     try {
		        //生成实现指定摘要算法的 MessageDigest 对象。
		        MessageDigest md = MessageDigest.getInstance("MD5");  
		        //使用指定的字节数组更新摘要。
		        md.update(plainText.getBytes());
		        //通过执行诸如填充之类的最终操作完成哈希计算。
		        byte b[] = md.digest();
		        //生成具体的md5密码到buf数组
		        int i;
		        StringBuffer buf = new StringBuffer("");
		        for (int offset = 0; offset < b.length; offset++) {
		          i = b[offset];
		          if (i < 0)
		            i += 256;
		          if (i < 16)
		            buf.append("0");
		          buf.append(Integer.toHexString(i));
		        }
		      //  System.out.println("32位: " + buf.toString());// 32位的加密
		        return buf.toString();
		      //  System.out.println("16位: " + buf.toString().substring(8, 24));// 16位的加密，其实就是32位加密后的截取
		     } 
		     catch (Exception e) {
		       e.printStackTrace();
		       return "";
		     }
		   }
		   
		   
		   
	/**
	
	public String deleteHRID(String sql){
	int index = 0,index1 = 0,index2 = 0;
		String array1 = sql.substring(sql.indexOf("(")+1,sql.indexOf(")"));
		String array2 = sql.substring(sql.indexOf("(", sql.indexOf("(")+1)+1,sql.length()-1);
		System.out.println(array1 + "," + array2);
		
		System.out.println(sql);
		String[] list = array1.split(",");
		for(int i = 0;i < list.length;i++){
			if(list[i].equals("hrid")){
			   //  md5 = toMD5(list[i]);
				index = i;
			}
		}
		
		for(int i =0;i < index;i++){
			   index1 = array2.indexOf(",",index1+1);
	    	   index2 = array2.indexOf(",",index1+1);
    	}
		if(index2 == -1){
	    	   index2 = array2.length();
	    	   sql = sql.replace(",hrid", "");
	    	   sql = sql.replace(",'"+array2.substring(index1+2, index2-1)+"'",""); 
		}
		else if(index == 0){
			sql = sql.replace("'"+array2.substring(1, array2.indexOf("'", 1))+"',",""); 
		}
			//System.out.println(array2.substring(1, array2.indexOf("'", 1))); 
		else {
			sql = sql.replace("'"+array2.substring(index1+2, index2-1)+"',",""); 
		}
		sql = sql.replace("hrid,", "");
			//System.out.println(array2.substring(index1+2, index2-1));
			
		
		
		
		System.out.println(sql);
		return sql;
	}*/

	/**
	 * Substitutes parameters from the service and account objects into the SQL
	 * statement entered by the service owner on the service form.
	 * 
	 * @param serviceInfoProps
	 *            properties from the service info object
	 * @param accountAttributes
	 *            used for #all_attributes and #all_values macros
	 * @param rdbmsAttributeMap
	 *            map of itim attribtues to database field names
	 * @return An SQL string that may be used in a Statement.execute() call.
	 * @throws RDBMSSQLException
	 *             if the parameters specified in the
	 */
	String substitute(Properties serviceInfoProps,
			AttributeValues accountAttributes,
			RDBMSAttributeMap rdbmsAttributeMap) throws RDBMSSQLException {
		System.out.println("susususususususususususuususu");
		SystemLog.getInstance().logInformation(this,
				"[substitute]: " + "sql: " + sql);

		StringBuffer sb = new StringBuffer();
		StringReader reader = new StringReader(sql);

		SQLSubstitutionLexer lexer = new SQLSubstitutionLexer(reader);
		boolean isTrue = false;
		String jdbcDriver = "";
		try {
			Token token = lexer.nextToken();
			System.out.println("token   " + token);
			System.out.println("token type is " + token.getType() + "token getText  : " + token.getText());
			int index = 0,index1 = 0,index2 = 0;
			String md5 = "";
			while (token.getType() != SQLSubstitutionLexerTokenTypes.EOF) {
				if (token.getType() == SQLSubstitutionLexerTokenTypes.IGNORE) {
					sb.append(token.getText());
				} else if (token.getType() == SQLSubstitutionLexerTokenTypes.VAR) {
					if (token.getText().equalsIgnoreCase(ALL_ATTRIBUTES)) {
						String attr_list = getAttributeNames(accountAttributes,
								rdbmsAttributeMap);
						System.out.println("1 if " + attr_list);
						String[] list = attr_list.split(",");
		      				 for(int i = 0;i < list.length;i++){
						     if(list[i].equals("password")){
		    				   //  md5 = toMD5(list[i]);
						     index = i;
		    	   			}
		       }
						sb.append(attr_list);
					}else if (token.getText().equalsIgnoreCase("#ACCOUNTS")) {
					//	isTrue = true;
						String attr_values = "C##ZHANGZHOU.ACCOUNTS";
						System.out.println("2 if : " + attr_values);
						sb.append(attr_values);
					} 
					else if (token.getText().equalsIgnoreCase("#middle_user")) {
						isTrue = true;
						String attr_values = "middle_user";
						jdbcDriver = "noxasqlJndi";
						System.out.println("3 if : " + attr_values);
						sb.append(attr_values);
					}
					else if (token.getText().equalsIgnoreCase("#PL_USERS")) {
						isTrue = true;
						String attr_values = "PL_USERS";
						jdbcDriver = "educateJndi";
						System.out.println("3 if : " + attr_values);
						sb.append(attr_values);
					}
					
					else if (token.getText().equalsIgnoreCase(ALL_VALUES)) {
						String attr_values = getAttributeValues(accountAttributes);
						for(int i =0;i < index;i++){
		    					   index1 = attr_values.indexOf(",",index1+1);
						    	   index2 = attr_values.indexOf(",",index1+1);
					       	}
						if(index2 == -1){
						    	   index2 = attr_values.length();
					        }			
						System.out.println(attr_values.substring(index1+2, index2-1));
					        md5 = toMD5(attr_values.substring(index1+2, index2-1));
						attr_values = attr_values.replace(attr_values.substring(index1+1, index2), "'" + md5 + "'");
						System.out.println("2 if : " + attr_values);
						sb.append(attr_values);
					} else {
						String name = token.getText().substring(1,
								token.getText().length());
						System.out.println("3333333");
						System.out.println(name);
						if (serviceInfoProps.containsKey(name)) {
							System.out.println(serviceInfoProps.getProperty(name));
							sb.append(serviceInfoProps.getProperty(name));
						} else if (accountAttributes.containsKey(name)) {
							if(name.equals("erpassword")|| name == "erpassword"){
							String password = accountAttributes.get(name).getString();
							password = toMD5(password);
							System.out.println(accountAttributes.get(name).getString());
							System.out.println("password is : " + password);
							sb.append(password);
							}
							else
							  sb.append(accountAttributes.get(name).getString());
						} else {
							SystemLog.getInstance().logError(this,
									"U1nrecognized attribute: " + name);
							throw new RDBMSSQLException(
									"U1nrecognized attribute: " + name);
						}
					}
				}
				token = lexer.nextToken();
			}
		} catch (TokenStreamException e) {
			SystemLog.getInstance().logError(this, e.getMessage());
			throw new RDBMSSQLException(e.getMessage(), e);
		}
		System.out.println("llllllllllllllllllast" + sb.toString());
		
		String query = sb.toString();
		//query = deleteHRID(query);
		if(isTrue){
			String sql = sb.toString();
			sql = sql.replace(" ", "%20");
			System.out.println(sql);
			System.out.println(jdbcDriver + "....");
			SendGET("http://10.161.2.68:9080/jndiT/servlet/servletCon", "name="+jdbcDriver+"&sql="+sql);
			//httpClientPost(urlParam,map,"utf-8");
			return null;
		}
		else
			return query;
	}
	
	public static void SendGET(String url,String param){
	   String result="";//访问返回结果
	   BufferedReader read=null;//读取访问结果
	  
	   try {
	    //创建url
	    URL realurl=new URL(url+"?"+param);
	    //打开连接
	    URLConnection connection=realurl.openConnection();
	     // 设置通用的请求属性
	             connection.setRequestProperty("accept", "*/*");
	             connection.setRequestProperty("connection", "Keep-Alive");
	             connection.setRequestProperty("user-agent",
	                     "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
	             //建立连接
	             connection.connect();
	          // 获取所有响应头字段
	             Map<String, List<String>> map = connection.getHeaderFields();
	             // 遍历所有的响应头字段，获取到cookies等
	             for (String key : map.keySet()) {
	                 System.out.println(key + "--->" + map.get(key));
	             }
	             // 定义 BufferedReader输入流来读取URL的响应
	             read = new BufferedReader(new InputStreamReader(
	                     connection.getInputStream(),"UTF-8"));
	             String line;//循环读取
	             while ((line = read.readLine()) != null) {
	                 result += line;
	             }
	   } catch (IOException e) {
	    e.printStackTrace();
	   }finally{
	    if(read!=null){//关闭流
	     try {
	      read.close();
	     } catch (IOException e) {
	      e.printStackTrace();
	     }
	    }
	   }
	     
	   
	 }

	/**
	 * Substitutes parameters from the service and account objects into the SQL
	 * statement entered by the service owner on the service form.
	 * 
	 * @param serviceInfoProps
	 *            properties from the service info object
	 * @param accountAttributes
	 *            the account attributes
	 * @param rdbmsAttributeMap
	 *            map of itim attribtues to database field names
	 * @param attributeChanges
	 *            used for #all_attributes and #all_values macros
	 * @return An SQL string that may be used in a Statement.execute() call.
	 * @throws RDBMSSQLException
	 *             if the parameters specified in the
	 */
	String substitute(Properties serviceInfoProps,
			AttributeValues accountAttributes,
			RDBMSAttributeMap rdbmsAttributeMap,
			AttributeChanges attributeChanges) throws RDBMSSQLException {

		SystemLog.getInstance().logInformation(this,
				"[substitute]: " + "sql: " + sql);

		StringBuffer sb = new StringBuffer();
		StringReader reader = new StringReader(sql);
		boolean isTrue = false;
		SQLSubstitutionLexer lexer = new SQLSubstitutionLexer(reader);
		
		String jdbcDriver = "";
		try {
			Token token = lexer.nextToken();
			while (token.getType() != SQLSubstitutionLexerTokenTypes.EOF) {
				if (token.getType() == SQLSubstitutionLexerTokenTypes.IGNORE) {
					sb.append(token.getText());
				} else if (token.getType() == SQLSubstitutionLexerTokenTypes.VAR) {
					if (token.getText().equalsIgnoreCase(ALL_CHANGES)) {
						String attr_list = getAttributeChanges(
								attributeChanges, rdbmsAttributeMap);
						sb.append(attr_list);
					}
					else if (token.getText().equalsIgnoreCase("#ACCOUNTS")) {
                                           //     isTrue = true;
                                                String attr_values = "C##ZHANGZHOU.ACCOUNTS";
                                               // System.out.println("2 if : " + attr_values);
                                                sb.append(attr_values);
                    }
					else if (token.getText().equalsIgnoreCase("#middle_user")) {
                                                isTrue = true;
                                                String attr_values = "middle_user";
												jdbcDriver = "noxasqlJndi";
                                               // System.out.println("2 if : " + attr_values);
                                                sb.append(attr_values);
                    }
					else if (token.getText().equalsIgnoreCase("#PL_USERS")) {
                                                isTrue = true;
                                                String attr_values = "PL_USERS";
												jdbcDriver = "educateJndi";
                                               // System.out.println("2 if : " + attr_values);
                                                sb.append(attr_values);
                    }
					else {
						String name = token.getText().substring(1,
								token.getText().length());
						if (serviceInfoProps.containsKey(name)) {
							sb.append(serviceInfoProps.getProperty(name));
						} else if (accountAttributes.containsKey(name)) {
							sb.append(accountAttributes.get(name).getString());
						} else {
							SystemLog.getInstance().logError(this,
									"U2nrecognized attribute: " + name);
							throw new RDBMSSQLException(
									"U2nrecognized attribute: " + name);
						}
					}
				}
				token = lexer.nextToken();
			}
		} catch (TokenStreamException e) {
			SystemLog.getInstance().logError(this, e.getMessage());
			throw new RDBMSSQLException(e.getMessage(), e);
		}
		 System.out.println("llllllllllmodify sql:" + sb.toString());
		String query = sb.toString();
		//query = deleteHRID(query);
                if(isTrue){
                        String sql = sb.toString();
                        sql = sql.replace(" ", "%20");
                        System.out.println(sql);
                        SendGET("http://10.161.2.68:9080/jndiT/servlet/servletCon", "name="+jdbcDriver+"&sql="+sql);
                        //httpClientPost(urlParam,map,"utf-8");
                        return null;
                }
                else
                        return query;
	}

	/**
	 * Gives a list of all remote attribute names in the
	 * 
	 * @param accountAttributes
	 *            the account attributes to give the name for
	 * @param rdbmsAttributeMap
	 *            map of itim attribtues to database field names
	 * @return string for insertion into a
	 */
	private String getAttributeNames(AttributeValues accountAttributes,
			RDBMSAttributeMap rdbmsAttributeMap) {
		StringBuffer sb = new StringBuffer();
		List timNames = getITIMAttributeNames(accountAttributes);
		Iterator it = timNames.iterator();
		while (it.hasNext()) {
			String timName = (String) it.next();
			String name = rdbmsAttributeMap.getRemoteAttributeName(timName);
			sb.append(name);
			if (it.hasNext()) {
				sb.append(COMMA);
			}
		}
		System.out.println("getAttributeName  0s::::" + sb);
		return sb.toString();
	}

	/**
	 * Gives a list of all remote attribute names in the
	 * 
	 * @param accountAttributes
	 *            the account attributes to give the values for
	 * @return string for insertion into a
	 */
	private String getAttributeValues(AttributeValues accountAttributes) {
		StringBuffer sb = new StringBuffer();
		List timNames = getITIMAttributeNames(accountAttributes);
		Iterator it = timNames.iterator();
		while (it.hasNext()) {
			String timName = (String) it.next();
			String value = accountAttributes.get(timName).getString();
			sb.append(QUOTE);
			sb.append(value);
			sb.append(QUOTE);
			if (it.hasNext()) {
				sb.append(COMMA);
			}
		}
		System.out.println("getAttributeValues:    " + sb);
		return sb.toString();
	}

	/**
	 * Gives a list of all remote attribute names in the
	 * 
	 * @param attributeChanges
	 *            the account attributes to give the values for
	 * @return string for insertion into a
	 */
	private String getAttributeChanges(AttributeChanges attributeChanges,
			RDBMSAttributeMap rdbmsAttributeMap) {
		StringBuffer sb = new StringBuffer();
		AttributeChangeIterator it = attributeChanges.iterator();
		HashMap<String, String> changes = new HashMap<String, String>();
		while (it.hasNext()) {
			AttributeChangeOperation operation = it.next();
			Collection<AttributeValue> changeData = operation.getChangeData();

			Iterator<AttributeValue> changeDataIt = changeData.iterator();
			while (changeDataIt.hasNext()) {
				AttributeValue attribute = changeDataIt.next();
				String timName = attribute.getName();
				String remoteName = rdbmsAttributeMap
						.getRemoteAttributeName(timName);
				String value = "";
				if (attribute.getValues().size() > 0) {
					value = attribute.getString();
				}
				if (changes.containsKey("D:" + remoteName)) {
					changes.remove("D:" + remoteName);
					changes.put(remoteName, value);
				} else {
					if (operation.getModificationAction() == AttributeChangeOperation.REMOVE_ACTION) {
						changes.put("D:" + remoteName, value);
					} else {
						changes.put(remoteName, value);
					}
				}
				SystemLog.getInstance().logInformation(
						this,
						"[getAttributeChanges]: " + "timName: " + timName
								+ ", remoteName: " + remoteName + ", value: "
								+ value);
			}
		}
		Iterator<String> keys = changes.keySet().iterator();
		while (keys.hasNext()) {
			String remoteName = keys.next();
			String value = changes.get(remoteName);
			value = remoteName.startsWith("D:") ? "" : value;
			remoteName = remoteName.startsWith("D:") ? remoteName.replaceFirst(
					"D:", "") : remoteName;
			sb.append(remoteName);
			sb.append(EQUALS);
			sb.append(QUOTE);
			sb.append(value);
			sb.append(QUOTE);
			if (keys.hasNext()) {
				sb.append(COMMA);
			}
		}
		return sb.toString();
	}

	// Stores the names of the attributes in an ordered list
	private List getITIMAttributeNames(AttributeValues accountAttributes) {
		if (timAttributeNames != null) {
			return timAttributeNames;
		}
		timAttributeNames = new ArrayList<String>();
		AttributeValueIterator it = accountAttributes.iterator();
		while (it.hasNext()) {
			AttributeValue attribute = it.next();
			timAttributeNames.add(attribute.getName());
		}
		return timAttributeNames;
	}

}
