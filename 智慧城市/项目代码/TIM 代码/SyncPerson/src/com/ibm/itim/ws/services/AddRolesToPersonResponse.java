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
 *         &lt;element name="addRolesToPersonReturn" type="{http://model.ws.itim.ibm.com}WSRequest"/>
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
    "addRolesToPersonReturn"
})
@XmlRootElement(name = "addRolesToPersonResponse")
public class AddRolesToPersonResponse {

    @XmlElement(required = true)
    protected WSRequest addRolesToPersonReturn;

    /**
     * Gets the value of the addRolesToPersonReturn property.
     * 
     * @return
     *     possible object is
     *     {@link WSRequest }
     *     
     */
    public WSRequest getAddRolesToPersonReturn() {
        return addRolesToPersonReturn;
    }

    /**
     * Sets the value of the addRolesToPersonReturn property.
     * 
     * @param value
     *     allowed object is
     *     {@link WSRequest }
     *     
     */
    public void setAddRolesToPersonReturn(WSRequest value) {
        this.addRolesToPersonReturn = value;
    }

}
