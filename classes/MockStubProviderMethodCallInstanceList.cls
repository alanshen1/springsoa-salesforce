/**
 * Class to hold the calls to the handleMethodCall routine of the System.StubProvider
 * interface.
 *
 * Note: this class holds the list as a instance variable and is the preferred
 * object to use. See StubProviderMethodCallStaticList for an alternative
 * implementation.
 */
@IsTest
public with sharing class MockStubProviderMethodCallInstanceList
        implements MockIStubProviderMethodCallList {

    @TestVisible
    private List<MockStubProviderMethodCall> methodCallList =
        new List<MockStubProviderMethodCall>();

    /** add a call to the call list */
    public MockStubProviderMethodCall addMethodCall(
            String          stubbedMethodName,
            List<String>    listOfParamNames,
            List<Object>    listOfArgs) {

        MockStubProviderMethodCall methodCall =
                new MockStubProviderMethodCall(
                    stubbedMethodName,
                    listOfParamNames,
                    listOfArgs);

        methodCallList.add(methodCall);

        return methodCall;
    }

    /** return true iff the list still contains entries */
    public Boolean hasNext() {
        return (!methodCallList.isEmpty());
    }

    /** remove and return the next call from the call list */
    public MockStubProviderMethodCall next() {
        return (methodCallList.isEmpty() ? null : methodCallList.remove(0));
    }

    /** get the current size of the call list */
    public Integer size() {
        return methodCallList.size();
    }

    /** clear the call list */
    public void clear() {
        methodCallList.clear();
    }
}