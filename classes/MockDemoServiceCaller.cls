/**
 * Created by Chintan Shah on 10/18/2019.
 */

/**
 * demo of how to use this framework.
 *
 * MockDemoServiceCaller -> MockDemoService
 *
 * During testing, we will just mock the entire MockDemoService
 *
 */
public with sharing class MockDemoServiceCaller {

    /**
     * instance of mockDemoService
     */
    public MockDemoService mockDemoService;

    /**
     * regular constructor
     */
    public MockDemoServiceCaller() {
        mockDemoService = new MockDemoService();
    }

    /**
     * entry point for fake service
     *
     * @param
     */
    public MockDemoServiceCaller(MockDemoService mockDemoService) {
        this.mockDemoService = mockDemoService;
    }


    /**
     * sample routine that we are going to test.
     */
    public String sampleRoutine(List<String> inputs) {
        try {
            System.debug(' MockDemoServiceCaller.sampleRoutine inputs ' + JSON.serialize(inputs) );
            List<String> outputs = mockDemoService.toUpper( new List<String> { 'John', 'Doe' } );
            System.debug(' MockDemoServiceCaller.sampleRoutine outputs ' + JSON.serialize(outputs) );
            String output = mockDemoService.concat( outputs );
            System.debug(' MockDemoServiceCaller.sampleRoutine output ' + output );
            return output;
        } catch(Exception e) {
            throw new MockException('What\' up? ' + e.getStackTraceString() );
        }
    }


}