/**
 * Test suite for the MockWebServiceObjectBase class.
 */
@IsTest
public with sharing class MockWebServiceObjectBaseTests {

    @IsTest
    private static void ctorTests() {

        MockWebServiceObjectBase base = new MockWebServiceObjectBase();

        System.assertNotEquals(null, base.methodCallList);
    }

    @IsTest
    private static void getMethodCallListSizeTests() {

        MockWebServiceObjectBase base = new MockWebServiceObjectBase();

        System.assertEquals(0, base.methodCallList.size());
        System.assertEquals(0, base.getMethodCallListSize());
        System.assertEquals(false, base.hasNextMethodCall());

        base.addMethodCall('endpoint1', 'cert1', 1, 'method1', null, '<result>true</result>');

        System.assertEquals(1, base.methodCallList.size());
        System.assertEquals(1, base.getMethodCallListSize());
        System.assertEquals(true, base.hasNextMethodCall());

        base.addMethodCall('endpoint1', 'cert1', 2, 'method2', null, '<result>false</result>');
        base.addMethodCall('endpoint1', 'cert1', 3, 'method3', null, '<result>true</result>');

        System.assertEquals(3, base.methodCallList.size());
        System.assertEquals(3, base.getMethodCallListSize());
        System.assertEquals(true, base.hasNextMethodCall());
    }

    @IsTest
    private static void getNextMethodCallTests() {

        MockWebServiceObjectBase base = new MockWebServiceObjectBase();
        MockWebServiceMethodCall call;

        base.addMethodCall('endpoint1', 'cert1', 1, 'method1', null, '<result>true</result>');
        base.addMethodCall('endpoint1', 'cert1', 2, 'method2', null, '<result>false</result>');
        base.addMethodCall('endpoint1', 'cert1', 3, 'method3', null, '<result>true</result>');

        System.assertEquals(3, base.getMethodCallListSize());
        System.assertEquals(true, base.hasNextMethodCall());

        // method1

        call = base.getNextMethodCall();
        System.assertEquals('method1', call.requestName);

        System.assertEquals(2, base.getMethodCallListSize());
        System.assertEquals(true, base.hasNextMethodCall());

        // method2

        call = base.getNextMethodCall();
        System.assertEquals('method2', call.requestName);

        System.assertEquals(1, base.getMethodCallListSize());
        System.assertEquals(true, base.hasNextMethodCall());

        // method3

        call = base.getNextMethodCall();
        System.assertEquals('method3', call.requestName);

        System.assertEquals(0, base.getMethodCallListSize());
        System.assertEquals(false, base.hasNextMethodCall());
    }

    @IsTest
    private static void clearMethodCallListTests() {

        MockWebServiceObjectBase base = new MockWebServiceObjectBase();

        base.addMethodCall('endpoint1', 'cert1', 1, 'method1', null, '<result>true</result>');
        base.addMethodCall('endpoint1', 'cert1', 2, 'method2', null, '<result>false</result>');
        base.addMethodCall('endpoint1', 'cert1', 3, 'method3', null, '<result>true</result>');

        System.assertEquals(3, base.getMethodCallListSize());
        System.assertEquals(true, base.hasNextMethodCall());

        base.clearmethodCallList();

        System.assertEquals(0, base.getMethodCallListSize());
        System.assertEquals(false, base.hasNextMethodCall());
    }
}