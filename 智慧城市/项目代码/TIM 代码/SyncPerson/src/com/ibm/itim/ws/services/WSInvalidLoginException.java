//
// Generated By:JAX-WS RI IBM 2.2.1-11/30/2010 12:42 PM(foreman)- (JAXB RI IBM 2.2.3-11/28/2011 06:21 AM(foreman)-)
//


package com.ibm.itim.ws.services;

import javax.xml.ws.WebFault;

@WebFault(name = "fault4", targetNamespace = "http://services.ws.itim.ibm.com")
public class WSInvalidLoginException
    extends Exception
{

    /**
     * Java type that goes as soapenv:Fault detail element.
     * 
     */
    private com.ibm.itim.ws.exceptions.WSInvalidLoginException faultInfo;

    /**
     * 
     * @param faultInfo
     * @param message
     */
    public WSInvalidLoginException(String message, com.ibm.itim.ws.exceptions.WSInvalidLoginException faultInfo) {
        super(message);
        this.faultInfo = faultInfo;
    }

    /**
     * 
     * @param faultInfo
     * @param message
     * @param cause
     */
    public WSInvalidLoginException(String message, com.ibm.itim.ws.exceptions.WSInvalidLoginException faultInfo, Throwable cause) {
        super(message, cause);
        this.faultInfo = faultInfo;
    }

    /**
     * 
     * @return
     *     returns fault bean: com.ibm.itim.ws.exceptions.WSInvalidLoginException
     */
    public com.ibm.itim.ws.exceptions.WSInvalidLoginException getFaultInfo() {
        return faultInfo;
    }

}
