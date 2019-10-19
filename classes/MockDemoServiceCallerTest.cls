/**
 * Created by Chintan Shah on 10/18/2019.
 */

/**
 * test class for MockDemoServiceCaller
 */

@isTest
public with sharing class MockDemoServiceCallerTest {

    @testSetup
    public static void testSetup() {

    }

    @isTest
    public static void testSampleRoutine1() {
        MockProvider mockDeMockServiceProvider = new MockProvider( MockDemoService.class );
        MockDemoService mockDemoService = (MockDemoService) mockDeMockServiceProvider.getMock();
        mockDeMockServiceProvider.addReturnValue( 'toUpper',  new List<String> { 'HELLO', 'WORLD' } );
        mockDeMockServiceProvider.addReturnValue( 'concat',  'HELLO TEST' );
        // initialize MockDemoServiceCaller with mock MockDemoService
        MockDemoServiceCaller mockDemoServiceCaller = new MockDemoServiceCaller( mockDemoService );
        String output = mockDemoServiceCaller.sampleRoutine( new List<String> { 'John', 'Doe'} );
        System.assertEquals( output, 'HELLO TEST', 'It should be HELLO TEST based on mock ');
    }

    @isTest
    public static void testSampleRoutine2() {
        MockProvider mockDeMockServiceProvider = new MockProvider( MockDemoService.class );
        MockDemoService mockDemoService = (MockDemoService) mockDeMockServiceProvider.getMock();
        mockDeMockServiceProvider.addReturnValue( 'toUpper',  new List<String> { 'HELLO', 'WORLD' } );
        mockDeMockServiceProvider.addReturnValue( 'concat',  new MockException('Test Exception') );
        // initialize MockDemoServiceCaller with mock MockDemoService
        MockDemoServiceCaller mockDemoServiceCaller = new MockDemoServiceCaller( mockDemoService );
        try {
            String output = mockDemoServiceCaller.sampleRoutine( new List<String> { 'John', 'Doe'} );
            System.assert( false, 'Exception was expected. ');
        } catch(Exception e) {
            System.assert( true, 'Exception was expected. ');
        }
    }


}