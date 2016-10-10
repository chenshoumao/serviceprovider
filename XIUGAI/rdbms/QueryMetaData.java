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

/**
 * Encapsulates meta data about the SQL query and the rows in the associated
 * data set. This meta data is used to translate the rows into search result
 * entries that can be processed by TIM as either accounts or supporting data.
 */
class QueryMetaData {

	 static{
                System.out.println("QueryMetaData class 10101001010100101010");
        }
	// SQL query before substitution of variables
	private final String rawSQLQuery;

	private final String namingAttribute;

	private final String objectClass;

	QueryMetaData(String rawSQLQuery, String namingAttribute, String objectClass) {
		this.rawSQLQuery = rawSQLQuery;
		this.namingAttribute = namingAttribute;
		this.objectClass = objectClass;
	}

	String getNamingAttribute() {
		return namingAttribute;
	}

	String getObjectClass() {
		return objectClass;
	}

	String getRawSQLQuery() {
		return rawSQLQuery;
	}
}
