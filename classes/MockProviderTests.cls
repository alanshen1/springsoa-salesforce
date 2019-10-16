/**
 * Test suite for the MockProvider class
 */
@IsTest
public with sharing class MockProviderTests {

    @IsTest
    private static void ctorTests() {

        MockIStubProviderMethodCallList callList = new MockStubProviderMethodCallStaticList();
        MockProvider provider1 = new MockProvider(MockStubProviderMethodCallInstanceList.class);
        MockProvider provider2 = new MockProvider(MockStubProviderMethodCallInstanceList.class, callList);

        System.assertNotEquals(null, provider1.methodCallList);
        System.assert(provider1.methodCallList instanceof MockStubProviderMethodCallInstanceList);

        System.assertNotEquals(null, provider1.parentType);
        System.assertEquals(MockStubProviderMethodCallInstanceList.class, provider1.parentType);

        System.assertNotEquals(null, provider2.methodCallList);
        System.assertEquals(callList, provider2.methodCallList);

        System.assertNotEquals(null, provider2.parentType);
        System.assertEquals(MockStubProviderMethodCallInstanceList.class, provider2.parentType);
    }

    @IsTest
    private static void getMockTests() {

        MockProvider provider = new MockProvider(MockStubProviderMethodCallInstanceList.class);
        Object mock = provider.getMock();

        System.assert(mock instanceof MockStubProviderMethodCallInstanceList);
    }

    @IsTest
    private static void handleMethodCallTests() {

        MockProvider provider = new MockProvider(MockProvider.class);
        MockProvider mock = (MockProvider)provider.getMock();
        Exception e = new MockException();

        provider.addReturnValue('getMock', '');
        System.assertEquals('', mock.getMock());

        try {
            provider.addReturnValue('getMock', e);
            mock.getMock();
            System.assert(false, 'missing exception');
        }
        catch (MockException ex) {
            System.assert(true, 'working as designed');
        }
        catch (Exception ex) {
            System.assert(false, 'unexpected exception: ' + ex);
        }
    }
}