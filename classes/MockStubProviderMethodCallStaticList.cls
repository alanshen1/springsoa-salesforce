/**
 * Class to hold the calls to the handleMethodCall routine of the System.StubProvider
 * interface.
 *
 * Note: this class holds the list as a static variable. This object is provided
 * mainly for when we are testing async processes (e.g., submitting batch classes)
 * where the instance variables are not preserved.
 *
 * The preferred object is StubProviderMethodCallInstanceList.
 */
@IsTest
public with sharing class MockStubProviderMethodCallStaticList
        implements MockIStubProviderMethodCallList {

    @TestVisible
    private static List<MockStubProviderMethodCall> methodCallList =
        new List<MockStubProviderMethodCall>();

    /** add a call to the call list */
    public static MockStubProviderMethodCall addMethodCall(
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