/**
 * Test suite for the MockProviderBase class
 */
@IsTest
public with sharing class MockProviderBaseTests {

    @IsTest
    private static void ctorTests() {

        MockIStubProviderMethodCallList callList = new MockStubProviderMethodCallStaticList();
        MockProviderBase base1 = new MockProviderBase();
        MockProviderBase base2 = new MockProviderBase(callList);

        System.assertNotEquals(null, base1.methodCallList);
        System.assert(base1.methodCallList instanceof MockStubProviderMethodCallInstanceList);

        System.assertNotEquals(null, base2.methodCallList);
        System.assertEquals(callList, base2.methodCallList);
    }

    @IsTest
    private static void addReturnValueTests() {

        MockProviderBase base = new MockProviderBase();
        List<Object> returnValueList;
        List<Integer> intList;
        List<List<Object>> objList;

        List<Integer> returnValueList1a = new List<Integer> {
            1
        };
        List<List<Object>> returnValueList1b = new List<List<Object>> {
            new List<Object> { 1, 'abc' },
            new List<Object> { 2, 'def' }
        };

        System.assertEquals(0, base.returnValueListMap.size());

        // result list 1.1

        base.addReturnValue('method1', returnValueList1a);
        System.assertEquals(1, base.returnValueListMap.size());

        returnValueList = base.returnValueListMap.get(base.normalizeMethodName('method1'));
        System.assertEquals(1, returnValueList.size());
        intList = (List<Integer>)returnValueList[0];
        System.assertEquals(1, intList.size());

        // result list 1.2

        base.addReturnValue('METHOD1', returnValueList1b);
        System.assertEquals(1, base.returnValueListMap.size());

        returnValueList = base.returnValueListMap.get(base.normalizeMethodName('METHOD1'));
        System.assertEquals(2, returnValueList.size());
        intList = (List<Integer>)returnValueList[0];
        System.assertEquals(1, intList.size());
        objList = (List<List<Object>>)returnValueList[1];
        System.assertEquals(2, objList.size());

        // result list 2
        returnValueList = base.returnValueListMap.get(base.normalizeMethodName('method2'));
    }

    @IsTest
    private static void clearResultListTests() {

        MockProviderBase base = new MockProviderBase();

        List<Integer> returnValueList1a = new List<Integer> {
            1
        };
        List<List<Object>> returnValueList1b = new List<List<Object>> {
            new List<Object> { 1, 'abc' },
            new List<Object> { 2, 'def' }
        };

        base.addReturnValue('method1', returnValueList1a);
        base.addReturnValue('method1', returnValueList1b);
    }

    @IsTest
    private static void handleMethodCallTests() {

        MockProviderBase base = new MockProviderBase();
        List<Integer> intList;
        List<List<Object>> objList;

        List<Integer> returnValueList1a = new List<Integer> {
            1
        };
        List<List<Object>> returnValueList1b = new List<List<Object>> {
            new List<Object> { 1, 'abc' },
            new List<Object> { 2, 'def' }
        };

        base.addReturnValue('method1', returnValueList1a);
        base.addReturnValue('method1', returnValueList1b);

        // result list 1.1

        intList = (List<Integer>)base.handleMethodCall(
                'stubbedObject',
                'method1',
                Type.forName('MockProviderBase'),   // doesn't actually match, but not a problem
                new List<Type>(),
                new List<String>(),
                new List<Object>());
        System.assertEquals(1, intList.size());

        // result list 1.2

        objList = (List<List<Object>>)base.handleMethodCall(
                'stubbedObject',
                'method1',
                Type.forName('MockProviderBase'),   // doesn't actually match, but not a problem
                new List<Type>(),
                new List<String>(),
                new List<Object>());
        System.assertEquals(2, objList.size());

        // result list 2

    }
}