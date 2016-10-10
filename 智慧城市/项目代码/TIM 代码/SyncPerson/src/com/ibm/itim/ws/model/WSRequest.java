//
// Generated By:JAX-WS RI IBM 2.2.1-11/30/2010 12:42 PM(foreman)- (JAXB RI IBM 2.2.3-11/28/2011 06:21 AM(foreman)-)
//


package com.ibm.itim.ws.model;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlSchemaType;
import javax.xml.bind.annotation.XmlType;
import javax.xml.datatype.XMLGregorianCalendar;


/**
 * <p>Java class for WSRequest complex type.
 * 
 * <p>The following schema fragment specifies the expected content contained within this class.
 * 
 * <pre>
 * &lt;complexType name="WSRequest">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="timeCompleted" type="{http://www.w3.org/2001/XMLSchema}dateTime"/>
 *         &lt;element name="subjectProfile" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="result" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="select" type="{http://www.w3.org/2001/XMLSchema}boolean"/>
 *         &lt;element name="description" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="processTypeString" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="title" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="owner" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="processStateString" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="status" type="{http://www.w3.org/2001/XMLSchema}int"/>
 *         &lt;element name="requestee" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="timeSubmitted" type="{http://www.w3.org/2001/XMLSchema}dateTime"/>
 *         &lt;element name="subject" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="requestId" type="{http://www.w3.org/2001/XMLSchema}long"/>
 *         &lt;element name="processType" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="subjectService" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="statusString" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="processState" type="{http://www.w3.org/2001/XMLSchema}string"/>
 *         &lt;element name="timeScheduled" type="{http://www.w3.org/2001/XMLSchema}dateTime"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "WSRequest", propOrder = {
    "timeCompleted",
    "subjectProfile",
    "result",
    "select",
    "description",
    "processTypeString",
    "title",
    "owner",
    "processStateString",
    "status",
    "requestee",
    "timeSubmitted",
    "subject",
    "requestId",
    "processType",
    "subjectService",
    "statusString",
    "processState",
    "timeScheduled"
})
public class WSRequest {

    @XmlElement(required = true, nillable = true)
    @XmlSchemaType(name = "dateTime")
    protected XMLGregorianCalendar timeCompleted;
    @XmlElement(required = true, nillable = true)
    protected String subjectProfile;
    @XmlElement(required = true, nillable = true)
    protected String result;
    protected boolean select;
    @XmlElement(required = true, nillable = true)
    protected String description;
    @XmlElement(required = true, nillable = true)
    protected String processTypeString;
    @XmlElement(required = true, nillable = true)
    protected String title;
    @XmlElement(required = true, nillable = true)
    protected String owner;
    @XmlElement(required = true, nillable = true)
    protected String processStateString;
    protected int status;
    @XmlElement(required = true, nillable = true)
    protected String requestee;
    @XmlElement(required = true, nillable = true)
    @XmlSchemaType(name = "dateTime")
    protected XMLGregorianCalendar timeSubmitted;
    @XmlElement(required = true, nillable = true)
    protected String subject;
    protected long requestId;
    @XmlElement(required = true, nillable = true)
    protected String processType;
    @XmlElement(required = true, nillable = true)
    protected String subjectService;
    @XmlElement(required = true, nillable = true)
    protected String statusString;
    @XmlElement(required = true, nillable = true)
    protected String processState;
    @XmlElement(required = true, nillable = true)
    @XmlSchemaType(name = "dateTime")
    protected XMLGregorianCalendar timeScheduled;

    /**
     * Gets the value of the timeCompleted property.
     * 
     * @return
     *     possible object is
     *     {@link XMLGregorianCalendar }
     *     
     */
    public XMLGregorianCalendar getTimeCompleted() {
        return timeCompleted;
    }

    /**
     * Sets the value of the timeCompleted property.
     * 
     * @param value
     *     allowed object is
     *     {@link XMLGregorianCalendar }
     *     
     */
    public void setTimeCompleted(XMLGregorianCalendar value) {
        this.timeCompleted = value;
    }

    /**
     * Gets the value of the subjectProfile property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSubjectProfile() {
        return subjectProfile;
    }

    /**
     * Sets the value of the subjectProfile property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSubjectProfile(String value) {
        this.subjectProfile = value;
    }

    /**
     * Gets the value of the result property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getResult() {
        return result;
    }

    /**
     * Sets the value of the result property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setResult(String value) {
        this.result = value;
    }

    /**
     * Gets the value of the select property.
     * 
     */
    public boolean isSelect() {
        return select;
    }

    /**
     * Sets the value of the select property.
     * 
     */
    public void setSelect(boolean value) {
        this.select = value;
    }

    /**
     * Gets the value of the description property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getDescription() {
        return description;
    }

    /**
     * Sets the value of the description property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setDescription(String value) {
        this.description = value;
    }

    /**
     * Gets the value of the processTypeString property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getProcessTypeString() {
        return processTypeString;
    }

    /**
     * Sets the value of the processTypeString property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setProcessTypeString(String value) {
        this.processTypeString = value;
    }

    /**
     * Gets the value of the title property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getTitle() {
        return title;
    }

    /**
     * Sets the value of the title property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setTitle(String value) {
        this.title = value;
    }

    /**
     * Gets the value of the owner property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getOwner() {
        return owner;
    }

    /**
     * Sets the value of the owner property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setOwner(String value) {
        this.owner = value;
    }

    /**
     * Gets the value of the processStateString property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getProcessStateString() {
        return processStateString;
    }

    /**
     * Sets the value of the processStateString property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setProcessStateString(String value) {
        this.processStateString = value;
    }

    /**
     * Gets the value of the status property.
     * 
     */
    public int getStatus() {
        return status;
    }

    /**
     * Sets the value of the status property.
     * 
     */
    public void setStatus(int value) {
        this.status = value;
    }

    /**
     * Gets the value of the requestee property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getRequestee() {
        return requestee;
    }

    /**
     * Sets the value of the requestee property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setRequestee(String value) {
        this.requestee = value;
    }

    /**
     * Gets the value of the timeSubmitted property.
     * 
     * @return
     *     possible object is
     *     {@link XMLGregorianCalendar }
     *     
     */
    public XMLGregorianCalendar getTimeSubmitted() {
        return timeSubmitted;
    }

    /**
     * Sets the value of the timeSubmitted property.
     * 
     * @param value
     *     allowed object is
     *     {@link XMLGregorianCalendar }
     *     
     */
    public void setTimeSubmitted(XMLGregorianCalendar value) {
        this.timeSubmitted = value;
    }

    /**
     * Gets the value of the subject property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSubject() {
        return subject;
    }

    /**
     * Sets the value of the subject property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSubject(String value) {
        this.subject = value;
    }

    /**
     * Gets the value of the requestId property.
     * 
     */
    public long getRequestId() {
        return requestId;
    }

    /**
     * Sets the value of the requestId property.
     * 
     */
    public void setRequestId(long value) {
        this.requestId = value;
    }

    /**
     * Gets the value of the processType property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getProcessType() {
        return processType;
    }

    /**
     * Sets the value of the processType property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setProcessType(String value) {
        this.processType = value;
    }

    /**
     * Gets the value of the subjectService property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getSubjectService() {
        return subjectService;
    }

    /**
     * Sets the value of the subjectService property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setSubjectService(String value) {
        this.subjectService = value;
    }

    /**
     * Gets the value of the statusString property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getStatusString() {
        return statusString;
    }

    /**
     * Sets the value of the statusString property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setStatusString(String value) {
        this.statusString = value;
    }

    /**
     * Gets the value of the processState property.
     * 
     * @return
     *     possible object is
     *     {@link String }
     *     
     */
    public String getProcessState() {
        return processState;
    }

    /**
     * Sets the value of the processState property.
     * 
     * @param value
     *     allowed object is
     *     {@link String }
     *     
     */
    public void setProcessState(String value) {
        this.processState = value;
    }

    /**
     * Gets the value of the timeScheduled property.
     * 
     * @return
     *     possible object is
     *     {@link XMLGregorianCalendar }
     *     
     */
    public XMLGregorianCalendar getTimeScheduled() {
        return timeScheduled;
    }

    /**
     * Sets the value of the timeScheduled property.
     * 
     * @param value
     *     allowed object is
     *     {@link XMLGregorianCalendar }
     *     
     */
    public void setTimeScheduled(XMLGregorianCalendar value) {
        this.timeScheduled = value;
    }

}
