//
// Generated By:JAX-WS RI IBM 2.2.1-11/30/2010 12:42 PM(foreman)- (JAXB RI IBM 2.2.3-11/28/2011 06:21 AM(foreman)-)
//


package com.ibm.itim.ws.model;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;


/**
 * <p>Java class for WSVersionInfo complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="WSVersionInfo">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="buildNumber" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="fixPackLevel" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="buildDate" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="buildTime" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="version" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "WSVersionInfo", propOrder = {
    "buildNumber",
    "fixPackLevel",
    "buildDate",
    "buildTime",
    "version"
})
public class WSVersionInfo {

    @XmlElement(required = true, nillable = true)
    protected String buildNumber;
    @XmlElement(required = true, nillable = true)
    protected String fixPackLevel;
    @XmlElement(required = true, nillable = true)
    protected String buildDate;
    @XmlElement(required = true, nillable = true)
    protected String buildTime;
    @XmlElement(required = true, nillable = true)
    protected String version;

    /**
     * Gets the value of the buildNumber property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBuildNumber() {
        return buildNumber;
    }

    /**
     * Sets the value of the buildNumber property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBuildNumber(String value) {
        this.buildNumber = value;
    }

    /**
     * Gets the value of the fixPackLevel property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getFixPackLevel() {
        return fixPackLevel;
    }

    /**
     * Sets the value of the fixPackLevel property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setFixPackLevel(String value) {
        this.fixPackLevel = value;
    }

    /**
     * Gets the value of the buildDate property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBuildDate() {
        return buildDate;
    }

    /**
     * Sets the value of the buildDate property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBuildDate(String value) {
        this.buildDate = value;
    }

    /**
     * Gets the value of the buildTime property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getBuildTime() {
        return buildTime;
    }

    /**
     * Sets the value of the buildTime property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setBuildTime(String value) {
        this.buildTime = value;
    }

    /**
     * Gets the value of the version property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getVersion() {
        return version;
    }

    /**
     * Sets the value of the version property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setVersion(String value) {
        this.version = value;
    }

}
