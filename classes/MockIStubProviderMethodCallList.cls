/**
 * Interface for classes holding the method call information for mock classes
 * implementing System.StubProvider
 */
public interface MockIStubProviderMethodCallList {

    /** add a call to the call list */
    MockStubProviderMethodCall addMethodCall(
            String          stubbedMethodName,
            List<String>    listOfParamNames,
            List<Object>    listOfArgs);

    /** return true iff the list still contains entries */
    Boolean hasNext();

    /** remove and return the next call from the call list */
    MockStubProviderMethodCall next();

    /** get the current size of the call list */
    Integer size();

    /** clear the call list */
    void clear();
}