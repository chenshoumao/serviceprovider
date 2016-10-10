package com.ibm.itim.ws.services;

import javax.naming.InitialContext;
import javax.naming.NamingException;

import java.net.URL;

import javax.xml.namespace.QName;
import javax.xml.transform.Source;
import javax.xml.ws.BindingProvider;
import javax.xml.ws.Dispatch;
import javax.xml.ws.Service;
import javax.xml.ws.soap.SOAPBinding;
import java.util.List;
import javax.xml.datatype.XMLGregorianCalendar;
import com.ibm.itim.ws.model.WSAccount;
import com.ibm.itim.ws.model.WSAttribute;
import com.ibm.itim.ws.model.WSRequest;
import com.ibm.itim.ws.model.WSSearchArguments;
import com.ibm.itim.ws.model.WSSession;

public class WSAccountServiceProxy{

    protected Descriptor _descriptor;

    public class Descriptor {
        private com.ibm.itim.ws.services.WSAccountServiceService _service = null;
        private com.ibm.itim.ws.services.WSAccountService _proxy = null;
        private Dispatch<Source> _dispatch = null;
        private boolean _useJNDIOnly = false;

        public Descriptor() {
            init();
        }

        public Descriptor(URL wsdlLocation, QName serviceName) {
            _service = new com.ibm.itim.ws.services.WSAccountServiceService(wsdlLocation, serviceName);
            initCommon();
        }

        public void init() {
            _service = null;
            _proxy = null;
            _dispatch = null;
            try
            {
                InitialContext ctx = new InitialContext();
                _service = (com.ibm.itim.ws.services.WSAccountServiceService)ctx.lookup("java:comp/env/service/WSAccountServiceService");
            }
            catch (NamingException e)
            {
                if ("true".equalsIgnoreCase(System.getProperty("DEBUG_PROXY"))) {
                    System.out.println("JNDI lookup failure: javax.naming.NamingException: " + e.getMessage());
                    e.printStackTrace(System.out);
                }
            }

            if (_service == null && !_useJNDIOnly)
                _service = new com.ibm.itim.ws.services.WSAccountServiceService();
            initCommon();
        }

        private void initCommon() {
            _proxy = _service.getWSAccountService();
        }

        public com.ibm.itim.ws.services.WSAccountService getProxy() {
            return _proxy;
        }

        public void useJNDIOnly(boolean useJNDIOnly) {
            _useJNDIOnly = useJNDIOnly;
            init();
        }

        public Dispatch<Source> getDispatch() {
            if (_dispatch == null ) {
                QName portQName = new QName("http://services.ws.itim.ibm.com", "WSAccountService");
                _dispatch = _service.createDispatch(portQName, Source.class, Service.Mode.MESSAGE);

                String proxyEndpointUrl = getEndpoint();
                BindingProvider bp = (BindingProvider) _dispatch;
                String dispatchEndpointUrl = (String) bp.getRequestContext().get(BindingProvider.ENDPOINT_ADDRESS_PROPERTY);
                if (!dispatchEndpointUrl.equals(proxyEndpointUrl))
                    bp.getRequestContext().put(BindingProvider.ENDPOINT_ADDRESS_PROPERTY, proxyEndpointUrl);
            }
            return _dispatch;
        }

        public String getEndpoint() {
            BindingProvider bp = (BindingProvider) _proxy;
            return (String) bp.getRequestContext().get(BindingProvider.ENDPOINT_ADDRESS_PROPERTY);
        }

        public void setEndpoint(String endpointUrl) {
            BindingProvider bp = (BindingProvider) _proxy;
            bp.getRequestContext().put(BindingProvider.ENDPOINT_ADDRESS_PROPERTY, endpointUrl);

            if (_dispatch != null ) {
                bp = (BindingProvider) _dispatch;
                bp.getRequestContext().put(BindingProvider.ENDPOINT_ADDRESS_PROPERTY, endpointUrl);
            }
        }

        public void setMTOMEnabled(boolean enable) {
            SOAPBinding binding = (SOAPBinding) ((BindingProvider) _proxy).getBinding();
            binding.setMTOMEnabled(enable);
        }
    }

    public WSAccountServiceProxy() {
        _descriptor = new Descriptor();
        _descriptor.setMTOMEnabled(false);
    }

    public WSAccountServiceProxy(URL wsdlLocation, QName serviceName) {
        _descriptor = new Descriptor(wsdlLocation, serviceName);
        _descriptor.setMTOMEnabled(false);
    }

    public Descriptor _getDescriptor() {
        return _descriptor;
    }

    public void adoptAccounts(WSSession session, String personDN, List<WSAccount> wsAccounts) throws WSApplicationException, WSLoginServiceException {
        _getDescriptor().getProxy().adoptAccounts(session,personDN,wsAccounts);
    }

    public void adoptSingleAccount(WSSession session, String accountDN, String ownerDN) throws WSApplicationException, WSLoginServiceException {
        _getDescriptor().getProxy().adoptSingleAccount(session,accountDN,ownerDN);
    }

    public WSRequest createAccount(WSSession session, String serviceDN, List<WSAttribute> wsAttrs, XMLGregorianCalendar date) throws WSApplicationException, WSLoginServiceException {
        return _getDescriptor().getProxy().createAccount(session,serviceDN,wsAttrs,date);
    }

    public WSRequest deprovisionAccount(WSSession session, String accountDN, XMLGregorianCalendar date) throws WSApplicationException, WSLoginServiceException {
        return _getDescriptor().getProxy().deprovisionAccount(session,accountDN,date);
    }

    public List<WSAttribute> getAccountAttributes(WSSession session, String accountDN) throws WSApplicationException, WSInvalidSessionException, WSLoginServiceException {
        return _getDescriptor().getProxy().getAccountAttributes(session,accountDN);
    }

    public String getAccountProfileForService(WSSession session, String serviceDN) throws WSApplicationException, WSLoginServiceException {
        return _getDescriptor().getProxy().getAccountProfileForService(session,serviceDN);
    }

    public List<WSAttribute> getDefaultAccountAttributes(WSSession session, String serviceDN) throws WSApplicationException, WSLoginServiceException {
        return _getDescriptor().getProxy().getDefaultAccountAttributes(session,serviceDN);
    }

    public List<WSAttribute> getDefaultAccountAttributesByPerson(WSSession session, String serviceDN, String personDN) throws WSApplicationException, WSLoginServiceException {
        return _getDescriptor().getProxy().getDefaultAccountAttributesByPerson(session,serviceDN,personDN);
    }

    public WSRequest modifyAccount(WSSession session, String accountDN, List<WSAttribute> wsAttrs, XMLGregorianCalendar date) throws WSApplicationException, WSLoginServiceException {
        return _getDescriptor().getProxy().modifyAccount(session,accountDN,wsAttrs,date);
    }

    public void orphanAccounts(WSSession session, String systemUserDN, List<WSAccount> wsAccounts) throws WSApplicationException, WSLoginServiceException {
        _getDescriptor().getProxy().orphanAccounts(session,systemUserDN,wsAccounts);
    }

    public void orphanSingleAccount(WSSession session, String accountDN) throws WSApplicationException, WSLoginServiceException {
        _getDescriptor().getProxy().orphanSingleAccount(session,accountDN);
    }

    public WSRequest restoreAccount(WSSession session, String accountDN, String newPassword, XMLGregorianCalendar date) throws WSApplicationException, WSLoginServiceException {
        return _getDescriptor().getProxy().restoreAccount(session,accountDN,newPassword,date);
    }

    public List<WSAccount> searchAccounts(WSSession session, WSSearchArguments searchArgs) throws WSApplicationException, WSLoginServiceException {
        return _getDescriptor().getProxy().searchAccounts(session,searchArgs);
    }

    public WSRequest suspendAccount(WSSession session, String accountDN, XMLGregorianCalendar date) throws WSApplicationException, WSLoginServiceException {
        return _getDescriptor().getProxy().suspendAccount(session,accountDN,date);
    }

    public WSRequest updateAccount(WSSession session, String accountDN, List<WSAttribute> wsAttrs, XMLGregorianCalendar date) {
        return _getDescriptor().getProxy().updateAccount(session,accountDN,wsAttrs,date);
    }

}