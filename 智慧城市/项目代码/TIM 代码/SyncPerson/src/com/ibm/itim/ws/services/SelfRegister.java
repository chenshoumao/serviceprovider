//
// Generated By:JAX-WS RI IBM 2.2.1-11/30/2010 12:42 PM(foreman)- (JAXB RI IBM 2.2.3-11/28/2011 06:21 AM(foreman)-)
//


package com.ibm.itim.ws.services;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;
import com.ibm.itim.ws.model.WSPerson;


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
 *         &lt;element name="wsPerson" type="{http://model.ws.itim.ibm.com}WSPerson"/>
 *         &lt;element name="tenantId" type="{http://www.w3.org/2001/XMLSchema}string"/>
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
    "wsPerson",
    "tenantId"
})
@XmlRootElement(name = "selfRegister")
public class SelfRegister {

    @XmlElement(required = true)
    protected WSPerson wsPerson;
    @XmlElement(required = true)
    protected String tenantId;

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
     * Gets the value of the tenantId property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTenantId() {
        return tenantId;
    }

    /**
     * Sets the value of the tenantId property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTenantId(String value) {
        this.tenantId = value;
    }

}
