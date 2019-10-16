/**
 * Base object for our mock provider implementations.
 *
 * This object keeps a list of individual method calls to the provider. It also
 * privides accessors to retrieve the size of the list, to retrieve the next method
 * call, and to clear the list.
 *
 * This class is only used when defining mock providers for testing. Unfortunately
 * we cannot annotate it with @IsTest since test classes cannot be virtual.
 */
public virtual with sharing class MockObjectBase {

    /** holds information regarding calls to handleMethodCall */
    @TestVisible
    private MockIStubProviderMethodCallList methodCallList = null;

    /** ctor with default implementation of IStubProviderMethodCallList */
    @TestVisible
    protected MockObjectBase() {
        this( new MockStubProviderMethodCallInstanceList());
    }

    /** ctor with explicit implementation of IStubProviderMethodCallList */
    @TestVisible
    protected MockObjectBase(MockIStubProviderMethodCallList methodCallList) {
        this.methodCallList = methodCallList;
    }

    /** format the method call to the StubProvider */
    @TestVisible
    protected MockStubProviderMethodCall addMethodCall(
            String          stubbedMethodName,
            List<String>    listOfParamNames,
            List<Object>    listOfArgs) {

        return methodCallList.addMethodCall(
                    stubbedMethodName,
                    listOfParamNames,
                    listOfArgs);
    }

    /** return true iff the list still contains entries */
    public Boolean hasNextMethodCall() {
        return methodCallList.hasNext();
    }

    /** remove and return the next call from the call list */
    public MockStubProviderMethodCall getNextMethodCall() {
        return methodCallList.next();
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