//
// Generated By:JAX-WS RI IBM 2.2.1-11/30/2010 12:42 PM(foreman)- (JAXB RI IBM 2.2.3-11/28/2011 06:21 AM(foreman)-)
//


package com.ibm.itim.ws.model;

import javax.xml.bind.annotation.XmlRegistry;


/**
 * This object contains factory methods for each 
 * Java content interface and Java element interface 
 * generated in the com.ibm.itim.ws.model package. 
 * <p>An ObjectFactory allows you to programatically 
 * construct new instances of the Java representation 
 * for XML content. The Java representation of XML 
 * content can consist of schema derived interfaces 
 * and classes representing the binding of schema 
 * type definitions, element declarations and model 
 * groups.  Factory methods for each of these are 
 * provided in this class.
 * 
 */
@XmlRegistry
public class ObjectFactory {


    /**
     * Create a new ObjectFactory that can be used to create new instances of schema derived classes for package: com.ibm.itim.ws.model
     * 
     */
    public ObjectFactory() {
    }

    /**
     * Create an instance of {@link WSRequest }
     * 
     */
    public WSRequest createWSRequest() {
        return new WSRequest();
    }

    /**
     * Create an instance of {@link WSSession }
     * 
     */
    public WSSession createWSSession() {
        return new WSSession();
    }

    /**
     * Create an instance of {@link WSAccount }
     * 
     */
    public WSAccount createWSAccount() {
        return new WSAccount();
    }

    /**
     * Create an instance of {@link WSAttribute }
     * 
     */
    public WSAttribute createWSAttribute() {
        return new WSAttribute();
    }

    /**
     * Create an instance of {@link WSSearchArguments }
     * 
     */
    public WSSearchArguments createWSSearchArguments() {
        return new WSSearchArguments();
    }

    /**
     * Create an instance of {@link WSLocale }
     * 
     */
    public WSLocale createWSLocale() {
        return new WSLocale();
    }

    /**
     * Create an instance of {@link WSObject }
     * 
     */
    public WSObject createWSObject() {
        return new WSObject();
    }

}
