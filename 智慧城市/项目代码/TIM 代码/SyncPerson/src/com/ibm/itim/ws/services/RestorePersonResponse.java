//
// Generated By:JAX-WS RI IBM 2.2.1-11/30/2010 12:42 PM(foreman)- (JAXB RI IBM 2.2.3-11/28/2011 06:21 AM(foreman)-)
//


package com.ibm.itim.ws.services;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;
import com.ibm.itim.ws.model.WSRequest;


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
 *         &lt;element name="restorePersonReturn" type="{http://model.ws.itim.ibm.com}WSRequest"/>
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
    "restorePersonReturn"
})
@XmlRootElement(name = "restorePersonResponse")
public class RestorePersonResponse {

    @XmlElement(required = true)
    protected WSRequest restorePersonReturn;

    /**
     * Gets the value of the restorePersonReturn property.
     * 
     * @return
     *     possible object is
     *     {@link WSRequest }
     *     
     */
    public WSRequest getRestorePersonReturn() {
        return restorePersonReturn;
    }

    /**
     * Sets the value of the restorePersonReturn property.
     * 
     * @param value
     *     allowed object is
     *     {@link WSRequest }
     *     
     */
    public void setRestorePersonReturn(WSRequest value) {
        this.restorePersonReturn = value;
    }

}
