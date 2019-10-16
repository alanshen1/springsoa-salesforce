/**
 * Test suite for the MockHttpCalloutObjectBase class.
 */
@IsTest
public with sharing class MockHttpCalloutObjectBaseTests {

    @IsTest
    private static void ctorTests() {

        MockHttpCalloutObjectBase base = new MockHttpCalloutObjectBase();

        System.assertNotEquals(null, base.endpointCallList);
    }

    @IsTest
    private static void getEndpointCallListSizeTests() {

        MockHttpCalloutObjectBase base = new MockHttpCalloutObjectBase();

        System.assertEquals(0, base.endpointCallList.size());
        System.assertEquals(0, base.getEndpointCallListSize());
        System.assertEquals(false, base.hasNextEndpointCall());

        base.addEndpointCall(new HttpRequest());

        System.assertEquals(1, base.endpointCallList.size());
        System.assertEquals(1, base.getEndpointCallListSize());
        System.assertEquals(true, base.hasNextEndpointCall());

        base.addEndpointCall(new HttpRequest());
        base.addEndpointCall(new HttpRequest());

        System.assertEquals(3, base.endpointCallList.size());
        System.assertEquals(3, base.getEndpointCallListSize());
        System.assertEquals(true, base.hasNextEndpointCall());
    }

    @IsTest
    private static void getNextEndpointCallTests() {

        MockHttpCalloutObjectBase base = new MockHttpCalloutObjectBase();
        MockHttpEndpointCall call;
        HttpRequest req;

        req = new HttpRequest();
        req.setEndpoint('http://endpoint1');
        base.addEndpointCall(req);

        req = new HttpRequest();
        req.setEndpoint('http://endpoint2');
        base.addEndpointCall(req);

        req = new HttpRequest();
        req.setEndpoint('http://endpoint3');
        base.addEndpointCall(req);

        System.assertEquals(3, base.getEndpointCallListSize());
        System.assertEquals(true, base.hasNextEndpointCall());

        // endpoint1

        call = base.getNextEndpointCall();
        System.assertEquals('http://endpoint1', call.request.getEndpoint());

        System.assertEquals(2, base.getEndpointCallListSize());
        System.assertEquals(true, base.hasNextEndpointCall());

        // endpoint2

        call = base.getNextEndpointCall();
        System.assertEquals('http://endpoint2', call.request.getEndpoint());

        System.assertEquals(1, base.getEndpointCallListSize());
        System.assertEquals(true, base.hasNextEndpointCall());

        // endpoint3

        call = base.getNextEndpointCall();
        System.assertEquals('http://endpoint3', call.request.getEndpoint());

        System.assertEquals(0, base.getEndpointCallListSize());
        System.assertEquals(false, base.hasNextEndpointCall());
    }

    @IsTest
    private static void clearEndpointCallListTests() {

        MockHttpCalloutObjectBase base = new MockHttpCalloutObjectBase();
        HttpRequest req;

        req = new HttpRequest();
        req.setEndpoint('http://endpoint1');
        base.addEndpointCall(req);

        req = new HttpRequest();
        req.setEndpoint('http://endpoint2');
        base.addEndpointCall(req);

        req = new HttpRequest();
        req.setEndpoint('http://endpoint3');
        base.addEndpointCall(req);

        System.assertEquals(3, base.getEndpointCallListSize());
        System.assertEquals(true, base.hasNextEndpointCall());

        base.clearEndpointCallList();

        System.assertEquals(0, base.getEndpointCallListSize());
        System.assertEquals(false, base.hasNextEndpointCall());
    }
}