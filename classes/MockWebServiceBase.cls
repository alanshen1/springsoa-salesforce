/**
 * Base class for our mock web service implementations.
 *
 * This class provides the base implementation of WebServiceMock for our mock
 * web service implementation. The default implementation adds each individual call
 * to the list in the MockWebServiceObjectBase class.
 *
 * The implementation also provides the capability to load responses for individual
 * method calls into the mock. These return values are returned from doInvoke()
 * when the corresponding method is called. Methods may have more than one response;
 * the responses will be returned by successive calls to the method in the order
 * in which they were loaded.
 *
 * Derived mocks may override the doInvoke() implementation to implement
 * specific behavior. To remain compatible with other implementations, the override
 * should call addMethodCall() to add the calls to the method call list.
 *
 * This class is only used when defining mock objects for testing. Unfortunately
 * we cannot annotate it with @IsTest since test classes cannot be virtual.
 */
public virtual with sharing class MockWebServiceBase
        extends MockWebServiceObjectBase implements WebServiceMock {

    /** map of responses to be returned */
    @TestVisible
    protected Map<String, List<Object>> responseListMap = new Map<String, List<Object>>();

    /** ctor */
    @TestVisible
    protected MockWebServiceBase() {

    }

    /** add a response to the response list for the specified method */
    public void addResponse(String method, Object response) {
        String normalizedMethod = normalizeMethod(method);
        List<Object> responseList = responseListMap.get(normalizedMethod);

        if (responseList == null) {
            responseList = new List<Object>();
            responseListMap.put(normalizedMethod, responseList);
        }

        responseList.add(response);
    }

    /** remove any remaining entries from the map */
    public void clearResponseList() {
        responseListMap.clear();
    }

    /** default implementation of the WebServiceMock interface */
    public virtual void doInvoke(
            Object stub,
            Object soapRequest,
            Map<String, Object> responseMap,
            String endpoint,
            String soapAction,
            String requestName,
            String responseNamespace,
            String responseName,
            String responseType) {

        String responseMapKey = (new List<String>(responseMap.keySet()))[0];
        MockWebServiceMethodCall call =
                addMethodCall(
                    endpoint,
                    null,
                    null,
                    requestName,
                    null,
                    soapRequest);

        String normalizedMethod = normalizeMethod(requestName);
        List<Object> responseList = responseListMap.get(normalizedMethod);
        Object response = null;

        if ((responseList != null) && (!responseList.isEmpty())) {
            response = responseList.remove(0);
        }

        responseMap.put(responseMapKey, response);
        call.setResponse(response);
    }

    /** Normalize the method for use as the map key */
    @TestVisible
    private String normalizeMethod(String method) {
        return method.toLowerCase();
    }
}