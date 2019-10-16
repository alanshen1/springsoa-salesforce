/**
 * Base class for our mock providers.
 *
 * This class provides the base implementation of System.StubProvider for our mock
 * providers. The default implementation adds each individual method call to the list
 * in the MockObjectBase class.
 *
 * The implementation also provides the capability to load return values for individual
 * method calls into the provider. These return values are returned from handleMethodCall()
 * when the corresponding method was called. Methods may have more than one return
 * value; the values will be returned by successive calls to the method in the order
 * in which they were loaded.
 *
 * Derived providers may override the handleMethodCall() implementation to implement
 * specific behavior. To remain compatible with other implementations, the override
 * should call addMethodCall() to add the calls to the method call list.
 *
 * This class is only used when defining mock providers for testing. Unfortunately
 * we cannot annotate it with @IsTest since test classes cannot be virtual.
 */
public virtual with sharing class MockProviderBase extends MockObjectBase implements System.StubProvider {

    /** map of return value lists by stubbed method name */
    @TestVisible
    protected Map<String, List<Object>> returnValueListMap =
            new Map<String, List<Object>>();

    /** default ctor */
    @TestVisible
    protected MockProviderBase() {
        super();
    }

    /** IStubProviderMethodCallList ctor */
    @TestVisible
    protected MockProviderBase(MockIStubProviderMethodCallList methodCallList) {
        super(methodCallList);
    }

    /** add a return value to the return value list for the specified method */
    public void addReturnValue(String methodName, Object returnValue) {
        String normalizedName = normalizeMethodName(methodName);
        List<Object> returnValueList = returnValueListMap.get(normalizedName);

        if (returnValueList == null) {
            returnValueList = new List<Object>();
            returnValueListMap.put(normalizedName, returnValueList);
        }

        returnValueList.add(returnValue);
    }

    /** remove any remaining entries from the map */
    public void clearReturnValues() {
        returnValueListMap.clear();
    }

    /** default implementation of the StubProvider interface */
    public virtual Object handleMethodCall(
            Object          stubbedObject,
            String          stubbedMethodName,
            Type            returnType,
            List<Type>      listOfParamTypes,
            List<String>    listOfParamNames,
            List<Object>    listOfArgs) {

        MockStubProviderMethodCall methodCall =
                addMethodCall(stubbedMethodName, listOfParamNames, listOfArgs);

        String normalizedName = normalizeMethodName(stubbedMethodName);
        List<Object> returnValueList = returnValueListMap.get(normalizedName);
        Object returnValue = null;

        if ((returnValueList != null) && (!returnValueList.isEmpty())) {
            returnValue = returnValueList.remove(0);
        }

        methodCall.setReturnValue(returnValue);

        return methodCall.returnValue;
    }

    /** Normalize the method name for use as the map key */
    @TestVisible
    private String normalizeMethodName(String methodName) {
        return methodName.toLowerCase();
    }
}