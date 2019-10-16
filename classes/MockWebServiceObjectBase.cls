/**
 * Base object for our mock web service implementations.
 *
 * This object keeps a list of individual method calls to the mock. It also
 * privides accessors to retrieve the size of the list, to retrieve the next method
 * call, and to clear the list.
 *
 * This class is only used when defining web service mock objects for testing.
 * Unfortunately we cannot annotate it with @IsTest since test classes cannot be virtual.
 */
public virtual with sharing class MockWebServiceObjectBase {

    /** holds information regarding calls to doInvoke */
    @TestVisible
    private List<MockWebServiceMethodCall> methodCallList = new List<MockWebServiceMethodCall>();

    /** ctor */
    @TestVisible
    protected MockWebServiceObjectBase() {
    }

    /** add the endpoint call to the mock object */
    @TestVisible
    protected MockWebServiceMethodCall addMethodCall(
            String              endpoint,
            String              certificateName,
            Integer             timeout,
            String              method,
            Map<String, String> requestHeaders,
            Object              request) {

        MockWebServiceMethodCall call =
                new MockWebServiceMethodCall(
                    endpoint,
                    certificateName,
                    timeout,
                    method,
                    requestHeaders,
                    request);

        methodCallList.add(call);

        return call;
    }

    /** return true iff the list still contains entries */
    public Boolean hasNextMethodCall() {
        return !methodCallList.isEmpty();
    }

    /** remove and return the next call from the call list */
    public MockWebServiceMethodCall getNextMethodCall() {
        return methodCallList.remove(0);
    }

    /** get the current size of the call list */
    public Integer getMethodCallListSize() {
        return methodCallList.size();
    }

    /** clear the call list */
    public void clearMethodCallList() {
        methodCallList.clear();
    }
}