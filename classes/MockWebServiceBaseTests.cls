/**
 * Test suite for the MockWebServiceBase class
 */
@IsTest
public with sharing class MockWebServiceBaseTests {

    @IsTest
    private static void ctorTests() {

        MockWebServiceBase base = new MockWebServiceBase();

        System.assertNotEquals(null, base.responseListMap);
    }

    @IsTest
    private static void addResponseTests() {

        MockWebServiceBase base = new MockWebServiceBase();
        List<Object> responseList;

        System.assertEquals(0, base.responseListMap.size());

        // method 1.1

        base.addResponse('MeThOd1', 'response1.1');
        System.assertEquals(1, base.responseListMap.size());

        responseList = base.responseListMap.get('method1');
        System.assertEquals(1, responseList.size());

        // method 1.2

        base.addResponse('mEtHoD1', 'response1.2');
        System.assertEquals(1, base.responseListMap.size());

        responseList = base.responseListMap.get('method1');
        System.assertEquals(2, responseList.size());

        // method 2

        base.addResponse('method2', 'response2');
        System.assertEquals(2, base.responseListMap.size());

        responseList = base.responseListMap.get(base.normalizeMethod('METHOD2'));
        System.assertEquals(1, responseList.size());
    }

    @IsTest
    private static void clearResponseListTests() {

        MockWebServiceBase base = new MockWebServiceBase();

        base.addResponse('method1', 'response1.1');
        base.addResponse('method1', 'response1.2');
        base.addResponse('method2', 'response2');
        System.assertEquals(2, base.responseListMap.size());

        base.clearResponseList();
        System.assertEquals(0, base.responseListMap.size());
    }

    @IsTest
    private static void doInvokeTests() {

        MockWebServiceBase base = new MockWebServiceBase();
        Map<String, Object> responseMap = new Map<String, Object> { 'response_x' => '' };


        base.addResponse('MeThOd1', 'response1.1');
        base.addResponse('mEtHoD1', 'response1.2');
        base.addResponse('METHOD2', 'response2');

    }
}