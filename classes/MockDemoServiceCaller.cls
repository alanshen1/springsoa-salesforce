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
    public void sampleRoutine() {
        try {
            mockDemoService.toLower( new List<String> { 'John', 'Doe' } );
            mockDemoService.toUpper( new List<String> { 'Mark', 'Twain' } );
        } catch(Exception e) {
            throw new MockException('What\' up? ' + e.getStackTraceString() );
        }
    }


}