/**
 * Test suite for the MockHttpCalloutBase class
 */
@IsTest
public with sharing class MockHttpCalloutBaseTests {

    @IsTest
    private static void ctorTests() {

        MockHttpCalloutBase base = new MockHttpCalloutBase();

        System.assertNotEquals(null, base.httpResponseListMap);
    }

    @IsTest
    private static void addHttpResponseTests() {

        MockHttpCalloutBase base = new MockHttpCalloutBase();
        List<HttpResponse> responseList;

        System.assertEquals(0, base.httpResponseListMap.size());

        // response 1.1

        base.addHttpResponse('http://endpoint1', new HttpResponse());
        System.assertEquals(1, base.httpResponseListMap.size());

        responseList = base.httpResponseListMap.get(base.normalizeEndpoint('http://EnDpOiNt1'));
        System.assertEquals(1, responseList.size());

        // response 1.2

        base.addHttpResponse('http://ENDPOINT1', new HttpResponse());
        System.assertEquals(1, base.httpResponseListMap.size());

        responseList = base.httpResponseListMap.get(base.normalizeEndpoint('http://eNdPoInT1'));
        System.assertEquals(2, responseList.size());

        // response 2

        base.addHttpResponse('http://endpoint2', new HttpResponse());
        System.assertEquals(2, base.httpResponseListMap.size());

        responseList = base.httpResponseListMap.get(base.normalizeEndpoint('http://endpoint2'));
        System.assertEquals(1, responseList.size());
    }

    @IsTest
    private static void clearHttpResponsesTests() {

        MockHttpCalloutBase base = new MockHttpCalloutBase();

        base.addHttpResponse('http://endpoint1', new HttpResponse());
        base.addHttpResponse('http://ENDPOINT1', new HttpResponse());
        base.addHttpResponse('http://endpoint2', new HttpResponse());
        System.assertEquals(2, base.httpResponseListMap.size());

        base.clearHttpResponses();
        System.assertEquals(0, base.httpResponseListMap.size());
    }

    @IsTest
    private static void respondTests() {

        MockHttpCalloutBase base = new MockHttpCalloutBase();
        HttpRequest req;
        HttpResponse rsp;

        base.addHttpResponse('http://endpoint1', new HttpResponse());
        base.addHttpResponse('http://ENDPOINT1', new HttpResponse());
        base.addHttpResponse('http://endpoint2', new HttpResponse());

        // response 0

        req = new HttpRequest();
        req.setEndpoint('http://endpoint0');
        rsp = base.respond(req);
        System.assertEquals(null, rsp);

        // response 1.1

        req = new HttpRequest();
        req.setEndpoint('http://EnDpOiNt1');
        rsp = base.respond(req);
        System.assertNotEquals(null, rsp);

        // response 1.2

        req = new HttpRequest();
        req.setEndpoint('http://eNdPoInT1');
        rsp = base.respond(req);
        System.assertNotEquals(null, rsp);

        // response 1.3

        req = new HttpRequest();
        req.setEndpoint('http://endpoint1');
        rsp = base.respond(req);
        System.assertEquals(null, rsp);

        // response 2.1

        req = new HttpRequest();
        req.setEndpoint('http://endpoint2');
        rsp = base.respond(req);
        System.assertNotEquals(null, rsp);

        // response 2.2

        req = new HttpRequest();
        req.setEndpoint('http://endpoint2');
        rsp = base.respond(req);
        System.assertEquals(null, rsp);
    }
}