//
// Generated By:JAX-WS RI IBM 2.2.1-11/30/2010 12:42 PM(foreman)- (JAXB RI IBM 2.2.3-11/28/2011 06:21 AM(foreman)-)
//


package com.ibm.itim.ws.services;

import javax.xml.ws.WebFault;

@WebFault(name = "fault", targetNamespace = "http://services.ws.itim.ibm.com")
public class WSLoginServiceException
    extends Exception
{

    /**
     * Java type that goes as soapenv:Fault detail element.
     * 
     */
    private com.ibm.itim.ws.exceptions.WSLoginServiceException faultInfo;

    /**
     * 
     * @param faultInfo
     * @param message
     */
    public WSLoginServiceException(String message, com.ibm.itim.ws.exceptions.WSLoginServiceException faultInfo) {
        super(message);
        this.faultInfo = faultInfo;
    }

    /**
     * 
     * @param faultInfo
     * @param message
     * @param cause
     */
    public WSLoginServiceException(String message, com.ibm.itim.ws.exceptions.WSLoginServiceException faultInfo, Throwable cause) {
        super(message, cause);
        this.faultInfo = faultInfo;
    }

    /**
     * 
     * @return
     *     returns fault bean: com.ibm.itim.ws.exceptions.WSLoginServiceException
     */
    public com.ibm.itim.ws.exceptions.WSLoginServiceException getFaultInfo() {
        return faultInfo;
    }

}
