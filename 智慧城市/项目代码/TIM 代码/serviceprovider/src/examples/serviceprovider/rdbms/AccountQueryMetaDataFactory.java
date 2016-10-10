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

import com.ibm.itim.dataservices.model.DistinguishedName;
import com.ibm.itim.dataservices.model.ProfileLocator;
import com.ibm.itim.dataservices.model.ServiceProfile;
import com.ibm.itim.dataservices.model.domain.Account;
import com.ibm.itim.logging.SystemLog;
import com.ibm.itim.remoteservices.exception.RemoteServicesException;
import com.ibm.itim.remoteservices.provider.ServiceProviderInformation;

/**
 * Gathers query metadata for searching for accounts.
 */
class AccountQueryMetaDataFactory {

	private static final String TENANT_ATTR_NAME = "com.ibm.itim.remoteservices.ResourceProperties.TENANT_DN";

	private static final String SEARCH_SQL_PROP_NAME = "erRDBMSSearchSQL";

	/**
	 * Constructs a QueryMetaData for searching for accounts in the database
	 * 
	 * @param serviceProviderInfo
	 * @return data for searching for accounts in the database
	 * @throws RemoteServicesException
	 *             if the meta data object could not be constructed
	 */
	QueryMetaData createQueryMetaData(
			ServiceProviderInformation serviceProviderInfo,
			RDBMSAttributeMap rdbmsAttributeMap) throws RemoteServicesException {

		SystemLog.getInstance().logInformation(
				this,
				"[createQueryMetaData] props: "
						+ serviceProviderInfo.getProperties());
		String searchSQL = (String) serviceProviderInfo.getProperties()
				.getProperty(SEARCH_SQL_PROP_NAME);
		String profileName = serviceProviderInfo.getServiceProfileName();
		String tenantDN = serviceProviderInfo.getProperties().getProperty(
				TENANT_ATTR_NAME);
		ServiceProfile serviceProfile = (ServiceProfile) ProfileLocator
				.getProfileByName(new DistinguishedName(tenantDN), profileName);
		String accountClassName = serviceProfile.getAccountClass();
		String namingAttribute = rdbmsAttributeMap
				.getRemoteAttributeName(Account.ACCOUNT_ATTR_USERID);
		return new QueryMetaData(searchSQL, namingAttribute, accountClassName);
	}

}
