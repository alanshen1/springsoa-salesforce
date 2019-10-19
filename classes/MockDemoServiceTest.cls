/**
 * Created by Chintan Shah on 10/18/2019.
 */

/**
 * test class for MockDemoService
 * this is a regular test class, nothing fancy.
 */

@isTest
public with sharing class MockDemoServiceTest {

    @testSetup
    public static void testSetup() {

    }

    @isTest
    public static void testToUpper() {
        List<String> inputs = new List<String> { 'John', 'Doe' };
        List<String> outputs = new MockDemoService().toUpper( inputs );
        System.assert( inputs.get(0).equals( outputs.get(0)) );
    }

    @isTest
    public static void testConcat() {

    }

}