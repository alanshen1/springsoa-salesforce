/**
 * Object to hold the information regarding a single call to an HTTP mock object
 * implementing the HttpCalloutMock interface.
 */
@IsTest
public with sharing class MockHttpEndpointCall {

    public HttpRequest  request     { get; private set; }
    public HttpResponse response    { get; private set; }

    public MockHttpEndpointCall(HttpRequest req) {
        request = req;
    }

    /** set the HTTP response */
    public void setHttpResponse(HttpResponse rsp) {
        response = rsp;
    }
}