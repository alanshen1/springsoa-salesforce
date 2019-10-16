/**
 * Object to hold the information regarding a single call to a SOAP web service mock
 * object implementing the WebServiceMock interface.
 */
@IsTest
public with sharing class MockWebServiceMethodCall {

    public String               endpoint        { get; private set; }
    public String               certificateName { get; private set; }
    public Integer              timeout         { get; private set; }
    public String               requestName     { get; private set; }
    public Map<String, String>  requestHeaders  { get; private set; }
    public Object               request         { get; private set; }
    public Object               response        { get; private set; }

    /** ctor */
    public MockWebServiceMethodCall(
            String              endpoint,
            String              certificateName,
            Integer             timeout,
            String              requestName,
            Map<String, String> requestHeaders,
            Object              request) {

        this.endpoint        = endpoint;
        this.certificateName = certificateName;
        this.timeout         = timeout;
        this.requestName     = requestName;
        this.requestHeaders  = requestHeaders;
        this.request         = request;
    }

    /** set the method response */
    public void setResponse(Object response) {
        this.response = response;
    }
}