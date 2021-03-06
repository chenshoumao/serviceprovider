//
// Generated By:JAX-WS RI IBM 2.2.1-11/30/2010 12:42 PM(foreman)- (JAXB RI IBM 2.2.3-11/28/2011 06:21 AM(foreman)-)
//


package com.ibm.itim.ws.model;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for WSSearchArguments complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="WSSearchArguments">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="category" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="profile" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="objectclass" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="contextDN" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="returnedAttributeName" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="filter" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="base" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "WSSearchArguments", propOrder = {
    "category",
    "profile",
    "objectclass",
    "contextDN",
    "returnedAttributeName",
    "filter",
    "base"
})
public class WSSearchArguments {

    @XmlElement(required = true, nillable = true)
    protected String category;
    @XmlElement(required = true, nillable = true)
    protected String profile;
    @XmlElement(required = true, nillable = true)
    protected String objectclass;
    @XmlElement(required = true, nillable = true)
    protected String contextDN;
    @XmlElement(required = true, nillable = true)
    protected String returnedAttributeName;
    @XmlElement(required = true, nillable = true)
    protected String filter;
    @XmlElement(required = true, nillable = true)
    protected String base;

    /**
     * Gets the value of the category property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getCategory() {
        return category;
    }

    /**
     * Sets the value of the category property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setCategory(String value) {
        this.category = value;
    }

    /**
     * Gets the value of the profile property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getProfile() {
        return profile;
    }

    /**
     * Sets the value of the profile property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setProfile(String value) {
        this.profile = value;
    }

    /**
     * Gets the value of the objectclass property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getObjectclass() {
        return objectclass;
    }

    /**
     * Sets the value of the objectclass property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setObjectclass(String value) {
        this.objectclass = value;
    }

    /**
     * Gets the value of the contextDN property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getContextDN() {
        return contextDN;
    }

    /**
     * Sets the value of the contextDN property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setContextDN(String value) {
        this.contextDN = value;
    }

    /**
     * Gets the value of the returnedAttributeName property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getReturnedAttributeName() {
        return returnedAttributeName;
    }

    /**
     * Sets the value of the returnedAttributeName property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setReturnedAttributeName(String value) {
        this.returnedAttributeName = value;
    }

    /**
     * Gets the value of the filter property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getFilter() {
        return filter;
    }

    /**
     * Sets the value of the filter property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setFilter(String value) {
        this.filter = value;
    }

    /**
     * Gets the value of the base property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBase() {
        return base;
    }

    /**
     * Sets the value of the base property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBase(String value) {
        this.base = value;
    }

}
