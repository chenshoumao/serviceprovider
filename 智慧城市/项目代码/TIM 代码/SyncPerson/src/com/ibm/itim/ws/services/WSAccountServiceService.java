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

@WebServiceClient(name = "WSAccountServiceService", targetNamespace = "http://services.ws.itim.ibm.com", wsdlLocation = "WEB-INF/wsdl/WSAccountService.wsdl")
public class WSAccountServiceService
    extends Service
{

    private final static URL WSACCOUNTSERVICESERVICE_WSDL_LOCATION;
    private final static WebServiceException WSACCOUNTSERVICESERVICE_EXCEPTION;
    private final static QName WSACCOUNTSERVICESERVICE_QNAME = new QName("http://services.ws.itim.ibm.com", "WSAccountServiceService");

    static {
            WSACCOUNTSERVICESERVICE_WSDL_LOCATION = com.ibm.itim.ws.services.WSAccountServiceService.class.getResource("/WEB-INF/wsdl/WSAccountService.wsdl");
        WebServiceException e = null;
        if (WSACCOUNTSERVICESERVICE_WSDL_LOCATION == null) {
            e = new WebServiceException("Cannot find 'WEB-INF/wsdl/WSAccountService.wsdl' wsdl. Place the resource correctly in the classpath.");
        }
        WSACCOUNTSERVICESERVICE_EXCEPTION = e;
    }

    public WSAccountServiceService() {
        super(__getWsdlLocation(), WSACCOUNTSERVICESERVICE_QNAME);
    }

    public WSAccountServiceService(URL wsdlLocation, QName serviceName) {
        super(wsdlLocation, serviceName);
    }

    /**
     * 
     * @return
     *     returns WSAccountService
     */
    @WebEndpoint(name = "WSAccountService")
    public WSAccountService getWSAccountService() {
        return super.getPort(new QName("http://services.ws.itim.ibm.com", "WSAccountService"), WSAccountService.class);
    }

    private static URL __getWsdlLocation() {
        if (WSACCOUNTSERVICESERVICE_EXCEPTION!= null) {
            throw WSACCOUNTSERVICESERVICE_EXCEPTION;
        }
        return WSACCOUNTSERVICESERVICE_WSDL_LOCATION;
    }

}
