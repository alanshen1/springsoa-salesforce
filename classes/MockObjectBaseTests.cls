/**
 * Test suite for the MockObjectBase class
 */
@IsTest
public with sharing class MockObjectBaseTests {

    @IsTest
    private static void ctorTests() {

        MockIStubProviderMethodCallList callList = new MockStubProviderMethodCallStaticList();
        MockObjectBase base1 = new MockObjectBase();
        MockObjectBase base2 = new MockObjectBase(callList);

        System.assertNotEquals(null, base1.methodCallList);
        System.assert(base1.methodCallList instanceof MockStubProviderMethodCallInstanceList);

        System.assertNotEquals(null, base2.methodCallList);
        System.assertEquals(callList, base2.methodCallList);
    }

    @IsTest
    private static void getMethodCallListSizeTests() {

        MockObjectBase base = new MockObjectBase();

        System.assertEquals(0, base.methodCallList.size());
        System.assertEquals(0, base.getMethodCallListSize());
        System.assertEquals(false, base.hasNextMethodCall());

        base.addMethodCall(
            'method1',
            new List<String> { 'param1' },
            new List<Object> { 'value1' });

        System.assertEquals(1, base.methodCallList.size());
        System.assertEquals(1, base.getMethodCallListSize());
        System.assertEquals(true, base.hasNextMethodCall());

        base.addMethodCall(
            'method2',
            new List<String> { 'param1', 'param2' },
            new List<Object> { 'value2', 2 });

        base.addMethodCall(
            'method3',
            new List<String> { 'param1', 'param2', 'param3' },
            new List<Object> { 'value3', 3, Datetime.newInstance(3, 3, 2003) });

        System.assertEquals(3, base.methodCallList.size());
        System.assertEquals(3, base.getMethodCallListSize());
        System.assertEquals(true, base.hasNextMethodCall());
    }

    @IsTest
    private static void getNextMethodCallTests() {

        MockObjectBase base = new MockObjectBase();
        MockStubProviderMethodCall call;
        Datetime testDate = Datetime.newInstance(3, 3, 2003);

        base.addMethodCall(
            'method1',
            new List<String> { 'param1' },
            new List<Object> { 'value1' });

        base.addMethodCall(
            'method2',
            new List<String> { 'param1', 'param2' },
            new List<Object> { 'value2', 2 });

        base.addMethodCall(
            'method3',
            new List<String> { 'param1', 'param2', 'param3' },
            new List<Object> { 'value3', 3, testDate });

        System.assertEquals(3, base.getMethodCallListSize());
        System.assertEquals(true, base.hasNextMethodCall());

        // method1

        call = base.getNextMethodCall();
        System.assertEquals('method1', call.methodName);
        System.assertEquals(1, call.parameters.size());
        System.assertNotEquals(null, call.parameters.get('param1'));
        System.assertEquals('value1', call.parameters.get('param1'));

        System.assertEquals(2, base.getMethodCallListSize());
        System.assertEquals(true, base.hasNextMethodCall());

        // method2

        call = base.getNextMethodCall();
        System.assertEquals('method2', call.methodName);
        System.assertEquals(2, call.parameters.size());
        System.assertNotEquals(null, call.parameters.get('param1'));
        System.assertEquals('value2', call.parameters.get('param1'));
        System.assertNotEquals(null, call.parameters.get('param2'));
        System.assertEquals(2, call.parameters.get('param2'));

        System.assertEquals(1, base.getMethodCallListSize());
        System.assertEquals(true, base.hasNextMethodCall());

        // method3

        call = base.getNextMethodCall();
        System.assertEquals('method3', call.methodName);
        System.assertEquals(3, call.parameters.size());
        System.assertNotEquals(null, call.parameters.get('param1'));
        System.assertEquals('value3', call.parameters.get('param1'));
        System.assertNotEquals(null, call.parameters.get('param2'));
        System.assertEquals(3, call.parameters.get('param2'));
        System.assertNotEquals(null, call.parameters.get('param3'));
        System.assertEquals(testDate, call.parameters.get('param3'));

        System.assertEquals(0, base.getMethodCallListSize());
        System.assertEquals(false, base.hasNextMethodCall());
    }

    @IsTest
    private static void clearMethodCallListTests() {

        MockObjectBase base = new MockObjectBase();
        MockStubProviderMethodCall call;
        Datetime testDate = Datetime.newInstance(3, 3, 2003);

        base.addMethodCall(
            'method1',
            new List<String> { 'param1' },
            new List<Object> { 'value1' });

        base.addMethodCall(
            'method2',
            new List<String> { 'param1', 'param2' },
            new List<Object> { 'value2', 2 });

        base.addMethodCall(
            'method3',
            new List<String> { 'param1', 'param2', 'param3' },
            new List<Object> { 'value3', 3, testDate });

        System.assertEquals(3, base.getMethodCallListSize());
        System.assertEquals(true, base.hasNextMethodCall());

        base.clearMethodCallList();

        System.assertEquals(0, base.getMethodCallListSize());
        System.assertEquals(false, base.hasNextMethodCall());
    }
}