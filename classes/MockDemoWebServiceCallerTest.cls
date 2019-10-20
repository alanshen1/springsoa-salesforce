/**
 * Created by Chintan Shah on 10/19/2019.
 */

@isTest
public with sharing class MockDemoWebServiceCallerTest {
    @testSetup
    public static void testSetup() {

    }

    @isTest
    public static void testGetAllEmployees() {
        MockHttpCallout mockHttpCallout = new MockHttpCallout();
        mockHttpCallout.setMock();
        mockHttpCallout.addJsonHttpResponse('https://basic-authentication-ws.herokuapp.com/hr/employees', '[{"ExternalId":"E-001","Name":"Chintan Shah","DisplayUrl":"https://external.com/E-001","EmployeeAccountKey":"Account-001"},{"ExternalId":"E-002","Name":"Chuck Summer","DisplayUrl":"https://external.com/E-002","EmployeeAccountKey":"Account-001"},{"ExternalId":"E-003","Name":"Chris Walker","DisplayUrl":"https://external.com/E-003","EmployeeAccountKey":"Account-001"},{"ExternalId":"E-004","Name":"Dan Topper","DisplayUrl":"https://external.com/E-004","EmployeeAccountKey":"Account-002"},{"ExternalId":"E-005","Name":"Drew Berry","DisplayUrl":"https://external.com/E-005","EmployeeAccountKey":"Account-002"},{"ExternalId":"E-006","Name":"Don Aiken","DisplayUrl":"https://external.com/E-006","EmployeeAccountKey":"Account-002"}]');
        System.assertEquals( 6, new MockDemoWebServiceCaller().getAllEmployees().size(), 'Should be 6');
    }

    @isTest
    public static void testGetEmployee() {
        //
        MockHttpCallout mockHttpCallout = new MockHttpCallout();
        mockHttpCallout.setMock();
        mockHttpCallout.addJsonHttpResponse('https://basic-authentication-ws.herokuapp.com/hr/employee/Name/Chintan', '[{"ExternalId":"E-001","Name":"Chintan Shah","DisplayUrl":"https://external.com/E-001","EmployeeAccountKey":"Account-001"}]');
        System.assertEquals( 1, new MockDemoWebServiceCaller().getEmployee('Name','Chintan').size() , 'Should be 1');
    }

    @isTest
    public static void testGetAllEmployees2() {
        MockHttpCallout mockHttpCallout = new MockHttpCallout();
        mockHttpCallout.setMock();
        mockHttpCallout.addErrorResponse('https://basic-authentication-ws.herokuapp.com/hr/employees', 401 );
        try {
            new MockDemoWebServiceCaller().getAllEmployees().size();
            System.assert( false, 'Exception was expected, success was not expected ');
        } catch(Exception e) {
            System.assert( true, 'Exception was expected. ');
        }
    }

    @isTest
    public static void testGetEmployee2() {
        //
        MockHttpCallout mockHttpCallout = new MockHttpCallout();
        mockHttpCallout.setMock();
        mockHttpCallout.addErrorResponse('https://basic-authentication-ws.herokuapp.com/hr/employee/Name/Chintan', 401);
        try {
            new MockDemoWebServiceCaller().getEmployee('Name','Chintan').size();
            System.assert( false, 'Exception was expected, success was not expected ');
        } catch(Exception e) {
            System.assert( true, 'Exception was expected. ');
        }
    }


}