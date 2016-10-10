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
import com.ibm.itim.remoteservices.provider.RequestStatus;
import com.ibm.itim.remoteservices.provider.SearchResult;
import com.ibm.itim.remoteservices.provider.SearchResults;

/**
 * In case an error occurred executing a select statement for a reconciliation,
 * this class encapsulates an empty set of results and the error that led to it.
 */
class NoSearchResults implements SearchResults {

	 static{
                System.out.println("NoSearchResults class777777777777777777");
        }
	private final RequestStatus status = new RequestStatus(
			RequestStatus.UNSUCCESSFUL);

	private final Exception e;

	NoSearchResults(Exception e) {
		this.e = e;
		status.setReasonMessage(e.getMessage());
	}

	/**
	 * Always unsuccessful. Encapsulates the original error.
	 * 
	 * @return Encapsulates the original error.
	 */
	public RequestStatus getRequestStatus() {
		return status;
	}

	/**
	 * Always returns throws a RemoteServicesException
	 * 
	 * @return never returns a result
	 * @throws RemoteServicesException
	 *             Encapsulates the original error.
	 */
	public boolean hasNext() throws RemoteServicesException {
		throw new RemoteServicesException(e.getMessage(), e);
	}

	/**
	 * Always returns throws a RemoteServicesException
	 * 
	 * @return never returns a result
	 * @throws RemoteServicesException
	 *             Encapsulates the original error.
	 */
	public SearchResult next() throws RemoteServicesException {
		throw new RemoteServicesException(e.getMessage(), e);
	}

	/**
	 * Always returns throws a RemoteServicesException
	 * 
	 * @throws RemoteServicesException
	 *             Encapsulates the original error.
	 */
	public void close() throws RemoteServicesException {
		throw new RemoteServicesException(e.getMessage(), e);
	}

}
