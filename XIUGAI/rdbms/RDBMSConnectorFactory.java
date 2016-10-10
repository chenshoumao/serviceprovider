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

import com.ibm.itim.remoteservices.provider.ProviderConfigurationException;
import com.ibm.itim.remoteservices.provider.ServiceProvider;
import com.ibm.itim.remoteservices.provider.ServiceProviderFactory;
import com.ibm.itim.remoteservices.provider.ServiceProviderInformation;

/**
 * Factory class to create an instance of a RDBMSConnector class. TIM will call
 * the method getServiceProvider every time it needs to communicate to the
 * database for account management.
 */
public class RDBMSConnectorFactory implements ServiceProviderFactory {

	/**
	 * Instantiate and initialize a RDBMSConnector. The serviceProviderInfo
	 * should be used to determine the type of service instance.
	 * 
	 * @param serviceProviderInfo
	 *            Encapsulates information about the service instance
	 * @return a class implementing the ServiceProvider for the corresponding
	 *         service instance
	 * @throws ProviderConfigException
	 *             if there is a configuration or lookup problem
	 */
	 static{
                System.out.println("RDBMSConnectorFactory class 111111122222222222222");
        }
	public ServiceProvider getServiceProvider(
			ServiceProviderInformation serviceProviderInfo)
			throws ProviderConfigurationException {
		return new RDBMSConnector(serviceProviderInfo);
	}

}
