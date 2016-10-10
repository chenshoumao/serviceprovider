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

import com.ibm.itim.remoteservices.exception.RemoteServicesException;

/**
 * Encapsulates an exception generated because the SQL statement entered in the
 * service form.
 */
class RDBMSSQLException extends RemoteServicesException {

	private static final long serialVersionUID = -3065700843981082060L;

	/**
	 * Create a new RDBMSSQLException object.
	 * 
	 * @param message
	 *            the message to propogate up the stack
	 */
	RDBMSSQLException(String message) {
		super(message);
	}

	/**
	 * Create a new RDBMSSQLException object.
	 * 
	 * @param message
	 *            the message to propogate up the stack
	 * @param throwable
	 *            original exception
	 */
	RDBMSSQLException(String message, Throwable throwable) {
		super(message, throwable);
	}

}
