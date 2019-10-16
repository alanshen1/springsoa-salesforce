/**
 * Base class for our mock HTTP callout implementations.
 *
 * This class provides the base implementation of HttpCalloutMock for our mock
 * HTTP callout implementation. The default implementation adds each individual call
 * to the list in the MockHttpCalloutObjectBase class.
 *
 * The implementation also provides the capability to load responses for individual
 * endpoint calls into the mock. These return values are returned from respond()
 * when the corresponding endpoint is called. Endpoints may have more than one response;
 * the responses will be returned by successive calls to the endpoint in the order
 * in which they were loaded.
 *
 * Derived mocks may override the respond() implementation to implement
 * specific behavior. To remain compatible with other implementations, the override
 * should call addEndpointCall() to add the calls to the endpoint call list.
 *
 * This class is only used when defining mock objects for testing. Unfortunately
 * we cannot annotate it with @IsTest since test classes cannot be virtual.
 */
public virtual with sharing class MockHttpCalloutBase
        extends MockHttpCalloutObjectBase implements HttpCalloutMock {

    /** map of responses to be returned */
    @TestVisible
    protected Map<String, List<HttpResponse>> httpResponseListMap =
            new Map<String, List<HttpResponse>>();

    /** ctor */
    @TestVisible
    protected MockHttpCalloutBase() {

    }

    /** add an HTTP response to the response list for the specified endpoint */
    public void addHttpResponse(String endpoint, HttpResponse response) {
        String normalizedEndpoint = normalizeEndpoint(endpoint);
        List<HttpResponse> httpResponseList = httpResponseListMap.get(normalizedEndpoint);

        if (httpResponseList == null) {
            httpResponseList = new List<HttpResponse>();
            httpResponseListMap.put(normalizedEndpoint, httpResponseList);
        }

        httpResponseList.add(response);
    }

    /** remove any remaining entries from the map */
    public void clearHttpResponses() {
        httpResponseListMap.clear();
    }

    /** default implementation of the HttpCalloutMock interface */
    public virtual HttpResponse respond(HttpRequest request) {

        MockHttpEndpointCall call = addEndpointCall(request);

        String normalizedEndpoint = normalizeEndpoint(request.getEndpoint());
        List<HttpResponse> httpResponseList = httpResponseListMap.get(normalizedEndpoint);
        HttpResponse response = null;

        if ((httpResponseList != null) && (!httpResponseList.isEmpty())) {
            response = httpResponseList.remove(0);
        }

        call.setHttpResponse(response);

        return call.response;
    }

    /** Normalize the endpoint for use as the map key */
    @TestVisible
    private String normalizeEndpoint(String endpoint) {
        return endpoint.toLowerCase();
    }
}