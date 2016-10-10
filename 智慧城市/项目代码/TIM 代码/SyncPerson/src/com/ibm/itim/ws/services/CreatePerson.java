//
// Generated By:JAX-WS RI IBM 2.2.1-11/30/2010 12:42 PM(foreman)- (JAXB RI IBM 2.2.3-11/28/2011 06:21 AM(foreman)-)
//


package com.ibm.itim.ws.services;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlSchemaType;
import javax.xml.bind.annotation.XmlType;
import javax.xml.datatype.XMLGregorianCalendar;
import com.ibm.itim.ws.model.WSOrganizationalContainer;
import com.ibm.itim.ws.model.WSPerson;
import com.ibm.itim.ws.model.WSSession;


/**
 * <p>Java class for anonymous complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType>
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="session" type="{http://model.ws.itim.ibm.com}WSSession"/>
 *         &lt;element name="wsContainer" type="{http://model.ws.itim.ibm.com}WSOrganizationalContainer"/>
 *         &lt;element name="wsPerson" type="{http://model.ws.itim.ibm.com}WSPerson"/>
 *         &lt;element name="date" type="{http://www.w3.org/2001/XMLSchema}dateTime"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = {
    "session",
    "wsContainer",
    "wsPerson",
    "date"
})
@XmlRootElement(name = "createPerson")
public class CreatePerson {

    @XmlElement(required = true)
    protected WSSession session;
    @XmlElement(required = true)
    protected WSOrganizationalContainer wsContainer;
    @XmlElement(required = true)
    protected WSPerson wsPerson;
    @XmlElement(required = true)
    @XmlSchemaType(name = "dateTime")
    protected XMLGregorianCalendar date;

    /**
     * Gets the value of the session property.
     * 
     * @return
     *     possible object is
     *     {@link WSSession }
     *     
     */
    public WSSession getSession() {
        return session;
    }

    /**
     * Sets the value of the session property.
     * 
     * @param value
     *     allowed object is
     *     {@link WSSession }
     *     
     */
    public void setSession(WSSession value) {
        this.session = value;
    }

    /**
     * Gets the value of the wsContainer property.
     * 
     * @return
     *     possible object is
     *     {@link WSOrganizationalContainer }
     *     
     */
    public WSOrganizationalContainer getWsContainer() {
        return wsContainer;
    }

    /**
     * Sets the value of the wsContainer property.
     * 
     * @param value
     *     allowed object is
     *     {@link WSOrganizationalContainer }
     *     
     */
    public void setWsContainer(WSOrganizationalContainer value) {
        this.wsContainer = value;
    }

    /**
     * Gets the value of the wsPerson property.
     * 
     * @return
     *     possible object is
     *     {@link WSPerson }
     *     
     */
    public WSPerson getWsPerson() {
        return wsPerson;
    }

    /**
     * Sets the value of the wsPerson property.
     * 
     * @param value
     *     allowed object is
     *     {@link WSPerson }
     *     
     */
    public void setWsPerson(WSPerson value) {
        this.wsPerson = value;
    }

    /**
     * Gets the value of the date property.
     * 
     * @return
     *     possible object is
     *     {@link XMLGregorianCalendar }
     *     
     */
    public XMLGregorianCalendar getDate() {
        return date;
    }

    /**
     * Sets the value of the date property.
     * 
     * @param value
     *     allowed object is
     *     {@link XMLGregorianCalendar }
     *     
     */
    public void setDate(XMLGregorianCalendar value) {
        this.date = value;
    }

}
