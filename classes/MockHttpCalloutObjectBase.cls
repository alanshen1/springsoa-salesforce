/**
 * Base object for our mock HTTP callout implementations.
 *
 * This object keeps a list of individual endpoint calls to the mock. It also
 * privides accessors to retrieve the size of the list, to retrieve the next endpoint
 * call, and to clear the list.
 *
 * This class is only used when defining HTTP mock objects for testing. Unfortunately
 * we cannot annotate it with @IsTest since test classes cannot be virtual.
 */
public virtual with sharing class MockHttpCalloutObjectBase {

    /** holds information regarding calls to respond */
    @TestVisible
    private List<MockHttpEndpointCall> endpointCallList = new List<MockHttpEndpointCall>();

    /** ctor */
    @TestVisible
    protected MockHttpCalloutObjectBase() {
    }

    /** add the endpoint call to the mock object */
    @TestVisible
    protected MockHttpEndpointCall addEndpointCall(HttpRequest req) {

        MockHttpEndpointCall call = new MockHttpEndpointCall(req);

        endpointCallList.add(call);

        return call;
    }

    /** return true iff the list still contains entries */
    public Boolean hasNextEndpointCall() {
        return !endpointCallList.isEmpty();
    }

    /** remove and return the next call from the call list */
    public MockHttpEndpointCall getNextEndpointCall() {
        return endpointCallList.remove(0);
    }

    /** get the current size of the call list */
    public Integer getEndpointCallListSize() {
        return endpointCallList.size();
    }

    /** clear the call list */
    public void clearEndpointCallList() {
        endpointCallList.clear();
    }
}