/**
 * Generic mock provider implementation
 */
@IsTest
public with sharing class MockProvider extends MockProviderBase {

    /** holds the type of object we are mocking */
    @TestVisible private System.Type parentType = null;

    /** ctor */
    public MockProvider(System.Type parentType) {
        super();
        this.parentType = parentType;
    }

    /** IStubProviderMethodCallList ctor */
    public MockProvider(
            System.Type parentType,
            MockIStubProviderMethodCallList methodCallList) {

        super(methodCallList);
        this.parentType = parentType;
    }

    /** method to retrieve the mocked object */
    public Object getMock() {
        return Test.createStub(parentType, this);
    }

    /**
     * Default implementation for our mock providers
     *
     * If the returned value is an instance of Exception, we throw it instead of
     * returning it. If we ever test a class where methods return exception instances,
     * we'll need a special provider.
     */
    public override Object handleMethodCall(
            Object          stubbedObject,
            String          stubbedMethodName,
            Type            returnType,
            List<Type>      listOfParamTypes,
            List<String>    listOfParamNames,
            List<Object>    listOfArgs) {

        Object returnValue = super.handleMethodCall(
                stubbedObject,
                stubbedMethodName,
                returnType,
                listOfParamTypes,
                listOfParamNames,
                listOfArgs);

        // if the return value is an Exception, throw it
        // (we'll need a different mock provider for nothrow)
        if (returnValue instanceof Exception) {
            throw (Exception)returnValue;
        }

        return returnValue;
    }
}