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
import com.ibm.itim.ws.model.WSOrganizationalContainer;
import com.ibm.itim.ws.model.WSPerson;
import com.ibm.itim.ws.model.WSRequest;
import com.ibm.itim.ws.model.WSRole;
import com.ibm.itim.ws.model.WSService;
import com.ibm.itim.ws.model.WSSession;

public class WSPersonServiceProxy{

    protected Descriptor _descriptor;

    public class Descriptor {
        private com.ibm.itim.ws.services.WSPersonServiceService _service = null;
        private com.ibm.itim.ws.services.WSPersonService _proxy = null;
        private Dispatch<Source> _dispatch = null;
        private boolean _useJNDIOnly = false;

        public Descriptor() {
            init();
        }

        public Descriptor(URL wsdlLocation, QName serviceName) {
            _service = new com.ibm.itim.ws.services.WSPersonServiceService(wsdlLocation, serviceName);
            initCommon();
        }

        public void init() {
            _service = null;
            _proxy = null;
            _dispatch = null;
            try
            {
                InitialContext ctx = new InitialContext();
                _service = (com.ibm.itim.ws.services.WSPersonServiceService)ctx.lookup("java:comp/env/service/WSPersonServiceService");
            }
            catch (NamingException e)
            {
                if ("true".equalsIgnoreCase(System.getProperty("DEBUG_PROXY"))) {
                    System.out.println("JNDI lookup failure: javax.naming.NamingException: " + e.getMessage());
                    e.printStackTrace(System.out);
                }
            }

            if (_service == null && !_useJNDIOnly)
                _service = new com.ibm.itim.ws.services.WSPersonServiceService();
            initCommon();
        }

        private void initCommon() {
            _proxy = _service.getWSPersonService();
        }

        public com.ibm.itim.ws.services.WSPersonService getProxy() {
            return _proxy;
        }

        public void useJNDIOnly(boolean useJNDIOnly) {
            _useJNDIOnly = useJNDIOnly;
            init();
        }

        public Dispatch<Source> getDispatch() {
            if (_dispatch == null ) {
                QName portQName = new QName("http://services.ws.itim.ibm.com", "WSPersonService");
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

    public WSPersonServiceProxy() {
        _descriptor = new Descriptor();
        _descriptor.setMTOMEnabled(false);
    }

    public WSPersonServiceProxy(URL wsdlLocation, QName serviceName) {
        _descriptor = new Descriptor(wsdlLocation, serviceName);
        _descriptor.setMTOMEnabled(false);
    }

    public Descriptor _getDescriptor() {
        return _descriptor;
    }

    public WSRequest addRole(WSSession session, String personDN, String roleDN, XMLGregorianCalendar date) throws WSApplicationException, WSLoginServiceException {
        return _getDescriptor().getProxy().addRole(session,personDN,roleDN,date);
    }

    public WSRequest addRolesToPerson(WSSession session, String personDN, List<String> roleDNs, XMLGregorianCalendar date) throws WSApplicationException, WSLoginServiceException {
        return _getDescriptor().getProxy().addRolesToPerson(session,personDN,roleDNs,date);
    }

    public WSRequest createPerson(WSSession session, WSOrganizationalContainer wsContainer, WSPerson wsPerson, XMLGregorianCalendar date) throws WSApplicationException, WSLoginServiceException {
        return _getDescriptor().getProxy().createPerson(session,wsContainer,wsPerson,date);
    }

    public WSRequest deletePerson(WSSession session, String personDN, XMLGregorianCalendar date) throws WSApplicationException, WSLoginServiceException {
        return _getDescriptor().getProxy().deletePerson(session,personDN,date);
    }

    public List<WSAccount> getAccountsByOwner(WSSession session, String personDN) throws WSApplicationException {
        return _getDescriptor().getProxy().getAccountsByOwner(session,personDN);
    }

    public List<String> getAuthorizedPersonProfilesForCreate(WSSession session, WSOrganizationalContainer wsContainer) throws WSApplicationException, WSLoginServiceException {
        return _getDescriptor().getProxy().getAuthorizedPersonProfilesForCreate(session,wsContainer);
    }

    public List<WSService> getAuthorizedServices(WSSession session, String personDN) throws WSApplicationException, WSLoginServiceException {
        return _getDescriptor().getProxy().getAuthorizedServices(session,personDN);
    }

    public List<WSAccount> getFilteredAccountsByOwner(WSSession session, String personDN, WSAttribute filterAttribute) throws WSApplicationException {
        return _getDescriptor().getProxy().getFilteredAccountsByOwner(session,personDN,filterAttribute);
    }

    public List<WSService> getFilteredAuthorizedServices(WSSession session, String personDN, WSAttribute filterAttribute) throws WSApplicationException, WSLoginServiceException {
        return _getDescriptor().getProxy().getFilteredAuthorizedServices(session,personDN,filterAttribute);
    }

    public List<WSRole> getPersonRoles(WSSession session, String personDN) throws WSApplicationException, WSLoginServiceException {
        return _getDescriptor().getProxy().getPersonRoles(session,personDN);
    }

    public WSPerson getPrincipalPerson(WSSession session) throws WSApplicationException, WSInvalidSessionException {
        return _getDescriptor().getProxy().getPrincipalPerson(session);
    }

    public boolean isCreatePersonAllowed(WSSession session) throws WSApplicationException, WSLoginServiceException, WSUnsupportedVersionException {
        return _getDescriptor().getProxy().isCreatePersonAllowed(session);
    }

    public boolean isMemberOfRole(WSSession session, String personDN, String roleDN) throws WSApplicationException, WSLoginServiceException {
        return _getDescriptor().getProxy().isMemberOfRole(session,personDN,roleDN);
    }

    public WSPerson lookupPerson(WSSession session, String personDN) throws WSApplicationException, WSInvalidSessionException {
        return _getDescriptor().getProxy().lookupPerson(session,personDN);
    }

    public WSRequest modifyPerson(WSSession session, String personDN, List<WSAttribute> wsAttrs, XMLGregorianCalendar date) throws WSApplicationException, WSLoginServiceException {
        return _getDescriptor().getProxy().modifyPerson(session,personDN,wsAttrs,date);
    }

    public WSRequest removeRole(WSSession session, String personDN, String roleDN, XMLGregorianCalendar date) throws WSApplicationException, WSLoginServiceException {
        return _getDescriptor().getProxy().removeRole(session,personDN,roleDN,date);
    }

    public WSRequest removeRolesFromPerson(WSSession session, String personDN, List<String> roleDNs, XMLGregorianCalendar date) throws WSApplicationException, WSLoginServiceException {
        return _getDescriptor().getProxy().removeRolesFromPerson(session,personDN,roleDNs,date);
    }

    public WSRequest restorePerson(WSSession session, String personDN, boolean restoreAccounts, String password, XMLGregorianCalendar date) throws WSApplicationException, WSInvalidSessionException {
        return _getDescriptor().getProxy().restorePerson(session,personDN,restoreAccounts,password,date);
    }

    public List<WSPerson> searchPersonsFromRoot(WSSession session, String filter, List<String> attrList) throws WSApplicationException, WSLoginServiceException {
        return _getDescriptor().getProxy().searchPersonsFromRoot(session,filter,attrList);
    }

    public List<WSPerson> searchPersonsWithITIMAccount(WSSession session, String filter, List<String> attrList) throws WSApplicationException, WSLoginServiceException {
        return _getDescriptor().getProxy().searchPersonsWithITIMAccount(session,filter,attrList);
    }

    public void selfRegister(WSPerson wsPerson, String tenantId) throws WSApplicationException {
        _getDescriptor().getProxy().selfRegister(wsPerson,tenantId);
    }

    public WSRequest suspendPerson(WSSession session, String personDN) throws WSApplicationException, WSLoginServiceException {
        return _getDescriptor().getProxy().suspendPerson(session,personDN);
    }

    public WSRequest suspendPersonAdvanced(WSSession session, String personDN, boolean includeAccounts, XMLGregorianCalendar date) throws WSApplicationException, WSLoginServiceException {
        return _getDescriptor().getProxy().suspendPersonAdvanced(session,personDN,includeAccounts,date);
    }

    public WSRequest synchGeneratedPassword(WSSession session, String personDN, XMLGregorianCalendar date) throws WSApplicationException, WSLoginServiceException {
        return _getDescriptor().getProxy().synchGeneratedPassword(session,personDN,date);
    }

    public WSRequest synchPasswords(WSSession session, String personDN, String password, XMLGregorianCalendar date, boolean notifyByMail) throws WSApplicationException, WSLoginServiceException {
        return _getDescriptor().getProxy().synchPasswords(session,personDN,password,date,notifyByMail);
    }

    public WSRequest transferPerson(WSSession session, String personDN, WSOrganizationalContainer targetContainer, XMLGregorianCalendar date) throws WSApplicationException, WSLoginServiceException {
        return _getDescriptor().getProxy().transferPerson(session,personDN,targetContainer,date);
    }

}