/******************************************************************************
* Licensed Materials - Property of IBM
*
* (C) Copyright IBM Corp. 2002, 2012 All Rights Reserved.
*
* US Government Users Restricted Rights - Use, duplication, or
* disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
*
*****************************************************************************/

/************************************************************************
 *                                                                       *
 *                         Copyright (c) 2002 by                         *
 *                         Access360, Irvine, CA                  		*
 *                          All rights reserved.                         *
 *                                                                       *
 ************************************************************************/

package ldap.dao.impl;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;

import com.ibm.itim.dataservices.model.DistinguishedName;
import com.ibm.itim.dataservices.model.ModelCommunicationException;
import com.ibm.itim.dataservices.model.ObjectNotFoundException;
import com.ibm.itim.dataservices.model.domain.Account;
import com.ibm.itim.dataservices.model.domain.AccountEntity;
import com.ibm.itim.dataservices.model.domain.AccountSearch;
import com.ibm.itim.dataservices.model.domain.Service;
import com.ibm.itim.dataservices.model.domain.ServiceEntity;

public class PrintAccounts {

	 
	public List printAccounts(String rawIdentityDN) {
		List list = new ArrayList();
		try {
			// Create compatible object from raw dn.
			DistinguishedName identityDN = new DistinguishedName(rawIdentityDN);

			System.out.println(identityDN);
			// lookup accounts
			Collection accounts = (new AccountSearch()).searchByOwner(identityDN);

			Iterator iter = accounts.iterator();
			// Loop through accounts and print user id and service name
			while (iter.hasNext()) {
				AccountEntity accountEnt = (AccountEntity) iter.next();
				Account account = (Account) accountEnt.getDirectoryObject();
				ServiceEntity serviceEnt = accountEnt.getService();
				Service service = (Service) serviceEnt.getDirectoryObject();

				System.out.println("*****Account*****");
				System.out.println("User Id: " + account.getUserId());
				System.out.println("Service: " + service.getName());
				list.add(service.getName());
				System.out.println();
			}
			 
		} catch (ModelCommunicationException mce) {
			System.err.println("Communication Exception: " + mce.toString());
		} catch (ObjectNotFoundException onfe) {
			System.err.println("Object Not Found Exception: " + onfe.toString());
		}
		return list;
	}
}
