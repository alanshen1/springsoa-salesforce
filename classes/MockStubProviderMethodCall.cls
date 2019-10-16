/**
 * Object to hold the information regarding a single method call to a mock provider
 * implementing the System.StubProvider interface.
 */
@IsTest
public with sharing class MockStubProviderMethodCall {

    public String              methodName  { get; private set; }
    public Map<String, Object> parameters  { get; private set; }
    public List<String>        messages    { get; private set; }
    public Object              returnValue { get; private set; }

    /** ctor */
    public MockStubProviderMethodCall(
            String          stubbedMethodName,
            List<String>    listOfParamNames,
            List<Object>    listOfArgs) {

        methodName = stubbedMethodName;

        parameters = new Map<String, Object>();
        for (Integer ii = 0; ii < listOfParamNames.size(); ++ ii) {

            Object arg = listOfArgs[ii];

            // clone containers just in case someone clears the original
            if (arg instanceof List<Object>) {
                arg = ((List<Object>)arg).clone();
            }
            else if (arg instanceof Map<Object, Object>) {
                arg = ((Map<Object, Object>)arg).clone();
            }
            if (arg instanceof Set<Object>) {
                arg = ((Set<Object>)arg).clone();
            }

            parameters.put(listOfParamNames[ii], arg);
        }

        messages = new List<String>();
        returnValue = null;
    }

    /** add a message to the message list */
    public void addMessage(String message) {
        messages.add(message);
    }

    /** set the return value */
    public void setReturnValue(Object value) {
        returnValue = value;
    }
}