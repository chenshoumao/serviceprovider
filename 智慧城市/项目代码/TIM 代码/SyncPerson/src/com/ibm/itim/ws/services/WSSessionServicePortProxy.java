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
import com.ibm.itim.ws.model.WSChallengeResponseInfo;
import com.ibm.itim.ws.model.WSLocale;
import com.ibm.itim.ws.model.WSSession;
import com.ibm.itim.ws.model.WSVersionInfo;

public class WSSessionServicePortProxy{

    protected Descriptor _descriptor;

    public class Descriptor {
        private com.ibm.itim.ws.services.WSSessionService_Service _service = null;
        private com.ibm.itim.ws.services.WSSessionService _proxy = null;
        private Dispatch<Source> _dispatch = null;
        private boolean _useJNDIOnly = false;

        public Descriptor() {
            init();
        }

        public Descriptor(URL wsdlLocation, QName serviceName) {
            _service = new com.ibm.itim.ws.services.WSSessionService_Service(wsdlLocation, serviceName);
            initCommon();
        }

        public void init() {
            _service = null;
            _proxy = null;
            _dispatch = null;
            try
            {
                InitialContext ctx = new InitialContext();
                _service = (com.ibm.itim.ws.services.WSSessionService_Service)ctx.lookup("java:comp/env/service/WSSessionService");
            }
            catch (NamingException e)
            {
                if ("true".equalsIgnoreCase(System.getProperty("DEBUG_PROXY"))) {
                    System.out.println("JNDI lookup failure: javax.naming.NamingException: " + e.getMessage());
                    e.printStackTrace(System.out);
                }
            }

            if (_service == null && !_useJNDIOnly)
                _service = new com.ibm.itim.ws.services.WSSessionService_Service();
            initCommon();
        }

        private void initCommon() {
            _proxy = _service.getWSSessionServicePort();
        }

        public com.ibm.itim.ws.services.WSSessionService getProxy() {
            return _proxy;
        }

        public void useJNDIOnly(boolean useJNDIOnly) {
            _useJNDIOnly = useJNDIOnly;
            init();
        }

        public Dispatch<Source> getDispatch() {
            if (_dispatch == null ) {
                QName portQName = new QName("http://services.ws.itim.ibm.com", "WSSessionServicePort");
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

    public WSSessionServicePortProxy() {
        _descriptor = new Descriptor();
        _descriptor.setMTOMEnabled(false);
    }

    public WSSessionServicePortProxy(URL wsdlLocation, QName serviceName) {
        _descriptor = new Descriptor(wsdlLocation, serviceName);
        _descriptor.setMTOMEnabled(false);
    }

    public Descriptor _getDescriptor() {
        return _descriptor;
    }

    public List<String> getChallengeQuestions(String principle, WSLocale wsLocale) throws WSApplicationException {
        return _getDescriptor().getProxy().getChallengeQuestions(principle,wsLocale);
    }

    public int getItimFixpackLevel() throws WSApplicationException {
        return _getDescriptor().getProxy().getItimFixpackLevel();
    }

    public float getItimVersion() throws WSApplicationException {
        return _getDescriptor().getProxy().getItimVersion();
    }

    public WSVersionInfo getItimVersionInfo() throws WSUnsupportedVersionException {
        return _getDescriptor().getProxy().getItimVersionInfo();
    }

    public int getWebServicesBuildNumber() throws WSApplicationException {
        return _getDescriptor().getProxy().getWebServicesBuildNumber();
    }

    public String getWebServicesTargetType() throws WSApplicationException {
        return _getDescriptor().getProxy().getWebServicesTargetType();
    }

    public float getWebServicesVersion() throws WSApplicationException {
        return _getDescriptor().getProxy().getWebServicesVersion();
    }

    public boolean isPasswordEditingAllowed(WSSession session) throws WSApplicationException, WSInvalidSessionException {
        return _getDescriptor().getProxy().isPasswordEditingAllowed(session);
    }

    public WSSession login(String principal, String credential) throws WSInvalidLoginException, WSLoginServiceException {
        return _getDescriptor().getProxy().login(principal,credential);
    }

    public WSSession lostPasswordLoginDirectEntry(String principle, List<WSChallengeResponseInfo> challengeInfo, String newPassword, WSLocale wsLocale) throws WSLoginServiceException {
        return _getDescriptor().getProxy().lostPasswordLoginDirectEntry(principle,challengeInfo,newPassword,wsLocale);
    }

    public String lostPasswordLoginResetPassword(String principle, List<WSChallengeResponseInfo> challengeInfo, WSLocale wsLocale) throws WSLoginServiceException {
        return _getDescriptor().getProxy().lostPasswordLoginResetPassword(principle,challengeInfo,wsLocale);
    }

    public void logout(WSSession session) throws WSLoginServiceException {
        _getDescriptor().getProxy().logout(session);
    }

}