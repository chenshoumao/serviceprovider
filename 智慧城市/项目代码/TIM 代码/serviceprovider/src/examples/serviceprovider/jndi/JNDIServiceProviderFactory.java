/******************************************************************************
* Licensed Materials - Property of IBM
*
* (C) Copyright IBM Corp. 2005, 2012 All Rights Reserved.
*
* US Government Users Restricted Rights - Use, duplication, or
* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
*
*****************************************************************************/

package examples.serviceprovider.jndi;

import java.util.Properties;

import com.ibm.itim.dataservices.model.DistinguishedName;
import com.ibm.itim.remoteservices.provider.ProviderConfigurationException;
import com.ibm.itim.remoteservices.provider.ServiceProvider;
import com.ibm.itim.remoteservices.provider.ServiceProviderFactory;
import com.ibm.itim.remoteservices.provider.ServiceProviderInformation;

public class JNDIServiceProviderFactory implements ServiceProviderFactory {
	private static final String PROVIDER_URL_PROP = "erjndiproviderurl";

	private static final String FACTORY_PROP = "erjndifactory";

	private static final String PRINCIPAL_PROP = "erjndiprincipal";

	private static final String CREDENTIALS_PROP = "erjndicredentials";

	private static final String ROOT_PROP = "erjndiroot";

	public JNDIServiceProviderFactory() {
	}

	public ServiceProvider getServiceProvider(
			ServiceProviderInformation contextInformation)
			throws ProviderConfigurationException {
		Properties props = contextInformation.getProperties();

		String providerURL = props.getProperty(PROVIDER_URL_PROP);
		if (providerURL == null)
			throw new ProviderConfigurationException("URL is required");

		String factory = props.getProperty(FACTORY_PROP);
		if (factory == null)
			throw new ProviderConfigurationException("JNDI factory is required");

		String principal = props.getProperty(PRINCIPAL_PROP);
		String credentials = props.getProperty(CREDENTIALS_PROP);

		String rootDNString = props.getProperty(ROOT_PROP);
		DistinguishedName rootDN;
		if (rootDNString == null)
			rootDN = new DistinguishedName("");
		else
			rootDN = new DistinguishedName(rootDNString);

		return new JNDIServiceProvider(contextInformation, providerURL,
				factory, principal, credentials, rootDN);
	}
}
