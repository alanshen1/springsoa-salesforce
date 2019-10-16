/**
 * Default implementation of our HTTP callout mock object.
 */
@IsTest
public with sharing class MockHttpCallout extends MockHttpCalloutBase {

    /** set our class as the HTTP callout mock object */
    public void setMock() {
        Test.setMock(HttpCalloutMock.class, this);
    }
}