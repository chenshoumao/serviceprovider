//
// Generated By:JAX-WS RI IBM 2.2.1-11/30/2010 12:42 PM(foreman)- (JAXB RI IBM 2.2.3-11/28/2011 06:21 AM(foreman)-)
//


package com.ibm.itim.ws.services;

import java.util.ArrayList;
import java.util.List;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlSchemaType;
import javax.xml.bind.annotation.XmlType;
import javax.xml.datatype.XMLGregorianCalendar;
import com.ibm.itim.ws.model.WSAttribute;
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
 *         &lt;element name="accountDN" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="wsAttrs" type="{http://model.ws.itim.ibm.com}WSAttribute" maxOccurs="unbounded"/>
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
    "accountDN",
    "wsAttrs",
    "date"
})
@XmlRootElement(name = "modifyAccount")
public class ModifyAccount {

    @XmlElement(required = true)
    protected WSSession session;
    @XmlElement(required = true)
    protected String accountDN;
    @XmlElement(required = true)
    protected List<WSAttribute> wsAttrs;
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
     * Gets the value of the accountDN property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getAccountDN() {
        return accountDN;
    }

    /**
     * Sets the value of the accountDN property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setAccountDN(String value) {
        this.accountDN = value;
    }

    /**
     * Gets the value of the wsAttrs property.
     * 
     * <p>
     * This accessor method returns a reference to the live list,
     * not a snapshot. Therefore any modification you make to the
     * returned list will be present inside the JAXB object.
     * This is why there is not a <CODE>set</CODE> method for the wsAttrs property.
     * 
     * <p>
     * For example, to add a new item, do as follows:
     * <pre>
     *    getWsAttrs().add(newItem);
     * </pre>
     * 
     * 
     * <p>
     * Objects of the following type(s) are allowed in the list
     * {@link WSAttribute }
     * 
     * 
     */
    public List<WSAttribute> getWsAttrs() {
        if (wsAttrs == null) {
            wsAttrs = new ArrayList<WSAttribute>();
        }
        return this.wsAttrs;
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
