//
// Generated By:JAX-WS RI IBM 2.2.1-11/30/2010 12:42 PM(foreman)- (JAXB RI IBM 2.2.3-11/28/2011 06:21 AM(foreman)-)
//


package com.ibm.itim.ws.services;

import java.net.URL;
import javax.xml.namespace.QName;
import javax.xml.ws.Service;
import javax.xml.ws.WebEndpoint;
import javax.xml.ws.WebServiceClient;
import javax.xml.ws.WebServiceException;

@WebServiceClient(name = "WSServiceServiceService", targetNamespace = "http://services.ws.itim.ibm.com", wsdlLocation = "WEB-INF/wsdl/WSServiceService.wsdl")
public class WSServiceServiceService
    extends Service
{

    private final static URL WSSERVICESERVICESERVICE_WSDL_LOCATION;
    private final static WebServiceException WSSERVICESERVICESERVICE_EXCEPTION;
    private final static QName WSSERVICESERVICESERVICE_QNAME = new QName("http://services.ws.itim.ibm.com", "WSServiceServiceService");

    static {
            WSSERVICESERVICESERVICE_WSDL_LOCATION = com.ibm.itim.ws.services.WSServiceServiceService.class.getResource("/WEB-INF/wsdl/WSServiceService.wsdl");
        WebServiceException e = null;
        if (WSSERVICESERVICESERVICE_WSDL_LOCATION == null) {
            e = new WebServiceException("Cannot find 'WEB-INF/wsdl/WSServiceService.wsdl' wsdl. Place the resource correctly in the classpath.");
        }
        WSSERVICESERVICESERVICE_EXCEPTION = e;
    }

    public WSServiceServiceService() {
        super(__getWsdlLocation(), WSSERVICESERVICESERVICE_QNAME);
    }

    public WSServiceServiceService(URL wsdlLocation, QName serviceName) {
        super(wsdlLocation, serviceName);
    }

    /**
     * 
     * @return
     *     returns WSServiceService
     */
    @WebEndpoint(name = "WSServiceService")
    public WSServiceService getWSServiceService() {
        return super.getPort(new QName("http://services.ws.itim.ibm.com", "WSServiceService"), WSServiceService.class);
    }

    private static URL __getWsdlLocation() {
        if (WSSERVICESERVICESERVICE_EXCEPTION!= null) {
            throw WSSERVICESERVICESERVICE_EXCEPTION;
        }
        return WSSERVICESERVICESERVICE_WSDL_LOCATION;
    }

}
